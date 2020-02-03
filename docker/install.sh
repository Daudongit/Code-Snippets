#!/bin/bash

#install docker on centos
yum check-update

yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install docker

systemctl start docker

systemctl enable docker

systemctl status docker

#choose a specific version of Docker to install

#sudo yum list docker-ce --showduplicates | sort –r

#Install the selected Docker version

#sudo yum install docker-ce-<VERSION STRING>