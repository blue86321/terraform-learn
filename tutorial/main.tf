provider "aws" {
  region     = "us-west-1"
  # read key from variable
  access_key = var.access_key
  secret_key = var.secret_key
}

# setup aws vpc
resource "aws_vpc" "rf-dev-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "rf-dev"
    my_tag = "rf-dev-tag"
  }
}

resource "aws_subnet" "rf-dev-subnet-1" {
  # reference attributes of another resources (here is `aws_vpc.rf-dev-vpc`)
  vpc_id = aws_vpc.rf-dev-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "rf-dev-subnet-1"
  }
}

# get data from existing resource
data "aws_vpc" "existing_vpc" {
  # get default vpc
  default = true
}

resource "aws_subnet" "rf-dev-subnet-2" {
  # reference `data`
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.32.0/20"
  availability_zone = "us-west-1b"

  tags = {
    Name = "rf-dev-default-subnet-2"
  }
}


output "vpc-dev-id" {
  value = aws_vpc.rf-dev-vpc.id
}

output "vpc-dev-arn" {
  value = aws_vpc.rf-dev-vpc.arn
}

output "rf-dev-subnet-1-id" {
  value = aws_subnet.rf-dev-subnet-1.id
}