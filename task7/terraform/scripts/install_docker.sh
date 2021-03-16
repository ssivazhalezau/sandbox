#!/bin/bash

function install_packages ()
{
  echo "Install Docker engine"
  yum install -y yum-utils
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  yum install -y docker-ce docker-ce-cli containerd.io java-1.8.0-openjdk-devel git

  usermod -a -G docker jenkins
  systemctl enable docker
  systemctl start docker

  # https://docs.docker.com/compose/install/
  curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

  sleep 5

}

### script begins here ###

install_packages

echo "Done"
exit 0