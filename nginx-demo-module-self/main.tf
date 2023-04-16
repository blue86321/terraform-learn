provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source = "./modules/subnet"
  # variables
  env_prefix = var.env_prefix
  vpc_cidr_block = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  availability_zone = var.availability_zone
  vpc_id = aws_vpc.myapp-vpc.id
}

module "myapp-server" {
  source = "./modules/webserver"
  # variables
  env_prefix = var.env_prefix
  availability_zone = var.availability_zone
  subnet_id = module.myapp-subnet.subnet.id
  vpc_id = aws_vpc.myapp-vpc.id
  my_ip = var.my_ip
  ec2_instance_type = var.ec2_instance_type
  ec2_public_key_file = var.ec2_public_key_file
  ec2_private_key_file = var.ec2_private_key_file
}