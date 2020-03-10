#!/bin/bash

dd if=/dev/zero of=/swapfile-additional bs=1M count=1024
mkswap /swapfile-additional
chmod 600 /swapfile-additional
echo "/swapfile-additional swap swap    0   0" >> /etc/fstab
mount -a
swapon -a

#check
swapon -s
free -m