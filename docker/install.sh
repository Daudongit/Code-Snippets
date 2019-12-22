#!/bin/bash

#install docker on centos
sudo yum check-update

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install docker

sudo systemctl start docker

sudo systemctl enable docker

sudo systemctl status docker

#choose a specific version of Docker to install

#sudo yum list docker-ce --showduplicates | sort –r

#Install the selected Docker version

#sudo yum install docker-ce-<VERSION STRING>