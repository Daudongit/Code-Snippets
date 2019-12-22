#!/bin/bash

#create EBS volume and run
lsblk

sudo mkswap /dev/xvdf

sudo swapon /dev/xvdf

# sudo vi /etc/fstab #open this file and add
echo "/dev/xvdf none swap sw 0 0">> /etc/fstab #add this to the file

sudo swapon --show