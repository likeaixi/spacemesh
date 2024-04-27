#!/bin/bash

apt-get install -y \
        gcc \
        cmake

echo "blacklist nouveau" >> /etc/modprobe.d/blacklist-nouveau.conf
echo "options nouveau modeset=0" >> /etc/modprobe.d/blacklist-nouveau.conf

update-initramfs -u

wget https://cn.download.nvidia.com/XFree86/Linux-x86_64/550.78/NVIDIA-Linux-x86_64-550.78.run

chmod +x ./NVIDIA-Linux-x86_64-550.78.run

sh ./NVIDIA-Linux-x86_64-550.78.run

