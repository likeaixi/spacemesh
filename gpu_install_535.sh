#!/bin/bash

apt-get update && apt-get upgrade && apt-get install -y \
        gcc \
        cmake

echo "blacklist nouveau" >> /etc/modprobe.d/blacklist-nouveau.conf
echo "options nouveau modeset=0" >> /etc/modprobe.d/blacklist-nouveau.conf

update-initramfs -u

apt install nvidia-driver-535-server -y
