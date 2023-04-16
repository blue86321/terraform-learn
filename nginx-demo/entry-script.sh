#!/bin/bash
# update yum and install docker
sudo yum update -y && sudo yum install -y docker
# start docker service
sudo systemctl start docker
# add ec2-user to docker user group, so we can run docker command wihout `sudo`
sudo usermod -aG docker ec2-user
# run nginx docker service
docker run -p 8080:80 nginx
