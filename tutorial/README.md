# Terraform Tutorial

## Concept in terraform file (`.tf`)
- `provider`: service provider. e.g. AWS, GCP, etc
- `resource`: actual resource. e.g. EC2, VPC, etc
- `data`: data from existing resource.
- `variable`: argument to reuse.
- `output`: output info after `terraform apply`

## Basic CLI operations
### Init
```sh
# init project and install provider
terraform init
```

### Apply
```sh
# apply configuration
terraform apply
terraform apply -auto-approve  # without confirming
```

### Destroy
- Destroy specific resources
  - Delete / Comment in config file (**RECOMMENDED**)
  - CLI
    ```sh
    ### format: terraform destroy -target [rsc_type].[rsc_name]
    terraform destroy -target aws_subnet.rf-dev-subnet-2
    ```

- Destroy all resources
  ```sh
  terraform destroy
  ```

### Show info
```sh
# 1. see the difference between current state and desired state
terraform plan

# 2. see current state info
terraform state
# e.g.
#   terraform state list
#   terraform state show aws_vpc.rf-dev-vpc
```



## Variables
- Set in CLI prompt
  ```sh
  # prompt will show up
  terraform apply
  ```
- Set in CLI arguments
  ```sh
  terraform apply -var "[name]=[value]"
  ```
- Variable file `.tfvars` (**RECOMMENDED**)
  - Default file name: `terraform.tfvars`
  - Assign file name in CLI
    ```sh
    terraform apply -var-file [filename]
    ```
- Environment variables
  - General ([source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables)) (**RECOMMENDED**)
    ```sh
    export AWS_ACCESS_KEY_ID="anaccesskey"
    export AWS_SECRET_ACCESS_KEY="asecretkey"
    ```
  - Custom env variables
    ```sh
    # set in environment
    export TF_VAR_[name]="var-name"

    # access in terraform file
    var.[name]
    ```
  - AWS CLI (**RECOMMENDED**)
    ```sh
    aws configure 
    ```