# Terraform Learn
This repo is a note to learn terraform.
Four demos to make you familiar with terraform.

**Prerequisites**: basic knowledge of cloud ecosystem. e.g. VPC, Subnet, Internet Gateway, etc.

## Intro
[Terraform](https://www.terraform.io/) is a tool to automate infrastructure operations for cloud, data center services.
We only need to configure the desired state of the infrastructure, Terraform will generate the execution plan in order and execute it.



### [Tutorial](tutorial/)
For those who are totally new to terraform, learn basic concept of terraform and how to write simple terraform config in this tutorial.

Concepts covered:
- terraform file (`.tf`)
  - provider
  - resource
  - data
  - variable
  - output
- CLI operations
  - `terraform init`
  - `terraform apply`
  - `terraform destroy`
- Set variables
  - `.tfvars`
  - environment variables

### [Nginx Demo](nginx-demo/)
For those who have basic knowledge of terraform, and want to know how to run an actual project on AWS.

Resources covered:
- VPC
- Subnet
- Route Table and Internet Gateway
- Security Group (SSH, browser. traffic in and out of EC2 instance)
- EC2 instances (nginx)

### [Nginx Demo Module (self)](nginx-demo-module-self/)
The same as Nginx Demo, but **modularize** the configuration to make the structure much clear.

Typical project structure:
```bash
.
├── modules
│   └── [module-name]
│       ├── main.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── variables.tf
├── main.tf
├── outputs.tf
├── providers.tf
└── variables.tf
```

### [Nginx Demo Module (registry)](nginx-demo-module-registry/)
The same as Nginx Demo Module, but not only modularize it, we also use existing modules from [Terraform Registry](https://registry.terraform.io/).
In addition, we **store terraform state on S3** to make sure all related repositories are using the same terraform state.