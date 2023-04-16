# Terraform Nginx Demo

## Prerequisites
<!-- - Create EC2 key pair on AWS console
- Move private key `.pem` to `~/.ssh/`
- Configure file name in variables `ec2_key_pair_name` (without file extension)
- Modify permissions
  ```sh
  cd ~/.ssh/
  chmod 400 [key_name].pem
  ``` -->
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
terraform apply -auto-approve
```

## SSH check
```sh
ssh -i ~/.ssh/id_rsa ec2-user@[public_ip]
# ~/.ssh/id_rsa is default, so can simply use this command
ssh ec2-user@[public_ip]
# e.g.
#   ssh ec2-user@13.57.255.153
```

## Destroy
```sh
terraform destroy -auto-approve
```