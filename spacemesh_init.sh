#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

# 安装环境
snap install go --classic
apt update && apt install -y jq git git-lfs make curl build-essential unzip wget ocl-icd-opencl-dev unzip libudev-dev

# 下载grpc
wget -c https://github.com/fullstorydev/grpcurl/releases/download/v1.8.7/grpcurl_1.8.7_linux_x86_64.tar.gz && tar -zxvf ./grpcurl_1.8.7_linux_x86_64.tar.gz

# 下载节点
rm -rf ./go-spacemesh && wget https://github.com/likeaixi/spacemesh/raw/master/go-spacemesh && chmod +x ./go-spacemesh
rm -rf ./spacemesh && wget https://github.com/likeaixi/spacemesh/raw/master/spacemesh.sh && chmod +x spacemesh.sh

# 下载节点库文件
rm -rf ./libpost.so && wget https://github.com/likeaixi/spacemesh/raw/master/libpost.so

# 下载配置文件
wget https://smapp.spacemesh.network/config.mainnet.json

# 下载P盘
rm -rf ./postcli && wget https://github.com/likeaixi/spacemesh/raw/master/postcli && chmod +x ./postcli
rm -rf ./post.sh && wget https://github.com/likeaixi/spacemesh/raw/master/post.sh

# 下载扫盘
rm -rf ./service && wget https://github.com/likeaixi/spacemesh/raw/master/service && chmod +x ./service

echo "[`date '+%Y-%m-%d %H:%M:%s'`] spacemesh init"
