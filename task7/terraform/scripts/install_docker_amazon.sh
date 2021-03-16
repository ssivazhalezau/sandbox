#!/bin/bash

function install_packages ()
{
  yum -y update

  echo "Install Docker engine"
  amazon-linux-extras install docker
  usermod -a -G docker ec2-user

  yum install -y git nc
  systemctl enable docker
  systemctl start docker

  curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

  sleep 5

}

### script begins here ###

install_packages

echo "Done"
exit 0