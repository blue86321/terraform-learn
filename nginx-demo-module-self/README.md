# Terraform Nginx Demo Module

## Prerequisites
- Create a ssh key on local machine if you don't have one
  ```sh
  # output ssh public key
  cat ~/.ssh/id_rsa.pub
  # if the file is not exists, create it with the following command
  ssh-keygen
  ```
- Copy and paste public key location to terraform variable `ec2_public_key_file`

## Launch
```sh
terraform init
terraform apply -auto-approve
```

## Check
- SSH
  ```sh
  ssh -i ~/.ssh/id_rsa ec2-user@[public_ip]
  # ~/.ssh/id_rsa is default, so can simply use this command
  ssh ec2-user@[public_ip]
  # e.g.
  #   ssh ec2-user@13.57.255.153
  ```
- Browser (Nginx)
  `http://[public_ip]:8080/`

## Destroy
```sh
terraform destroy -auto-approve
```

## Module
- Define in `modules` directory
- in root directory, use `modules` by `module` keyword
  ```sh
  module "myapp-subnet" {
    source = "./modules/subnet"
    # variables
    env_prefix = var.env_prefix
    vpc_cidr_block = var.vpc_cidr_block
    subnet_cidr_block = var.subnet_cidr_block
    availability_zone = var.availability_zone
    vpc_id = aws_vpc.myapp-vpc.id
  }
  ```
- use outputs of module
  ```sh
  module.[module-name].[output-key]
  # e.g.
  #   module.myapp-subnet.subnet.id
  ```
