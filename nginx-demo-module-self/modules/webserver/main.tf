
# security group (firewall)
resource "aws_security_group" "myapp-sg" {
  name = "myapp-sg"
  vpc_id = var.vpc_id

  # imcoming traffic from outside to vpc, and then go into EC2 instance
  ## SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    # who can access the resoure on port 22
    # should be your public ip address
    cidr_blocks = ["${var.my_ip}/32"]
  }

  ## browser
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    # everyone can access through browser
    cidr_blocks = ["0.0.0.0/0"]
  }

  # exiting traffic from EC2 instance to outside
  # every traffic can go out from the instance
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    "Name" = "${var.env_prefix}-sg"
  }
}

# instance
data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name = "tf-nginx-demo"
  # read public key from a file
  public_key = file(var.ec2_public_key_file)
}

resource "aws_instance" "myapp-server" {
  # Amazon Machine Image (OS image)
  # ami id might change depends on region, it's better to parameterize
  ami = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.ec2_instance_type

  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone = var.availability_zone

  # the server is open to public. so we need public ip address
  associate_public_ip_address = true
  # ssh key pair
  key_name = aws_key_pair.ssh-key.key_name

  # entrypoint, run the command when ec2 is instantiated
  user_data = file("entry-script.sh")

  tags = {
    "Name" = "${var.env_prefix}-server"
  }
}
