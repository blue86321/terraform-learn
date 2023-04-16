# store state on S3
terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "myapp-bucket-blue"
    key = "myapp/state.tfstate"
    region = "us-west-1"
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

# module from teraform registry
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.vpc_cidr_block

  azs             = [var.availability_zone]
  public_subnets  = [var.subnet_cidr_block]
  public_subnet_tags = {
    Name = "${var.env_prefix}-subnet-1"
  }

  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

# self-defined module
module "myapp-server" {
  source = "./modules/webserver"
  # variables
  env_prefix = var.env_prefix
  availability_zone = var.availability_zone
  subnet_id = module.vpc.public_subnets[0]
  vpc_id = module.vpc.vpc_id
  my_ip = var.my_ip
  ec2_instance_type = var.ec2_instance_type
  ec2_public_key_file = var.ec2_public_key_file
  ec2_private_key_file = var.ec2_private_key_file
}