#!/bin/bash

lsblk

sudo mkswap /dev/xvdf

sudo swapon /dev/xvdf

sudo vi /etc/fstab
echo /dev/xvdf none swap sw 0 0 #add this to the file

sudo swapon --show