#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

POST_DATA=/root/spacemesh/post_data
NODE_DATA=/root/spacemesh/node_data

# 安装环境
snap install go --classic
apt update && apt install -y jq git git-lfs make curl build-essential unzip wget ocl-icd-opencl-dev unzip libudev-dev

# 下载grpc
wget -c https://github.com/fullstorydev/grpcurl/releases/download/v1.8.7/grpcurl_1.8.7_linux_x86_64.tar.gz && tar -zxvf ./grpcurl_1.8.7_linux_x86_64.tar.gz

# 下载节点
rm -rf ./go-spacemesh && wget https://github.com/likeaixi/spacemesh/raw/master/go-spacemesh && chmod +x ./go-spacemesh

# 下载配置文件
wget https://smapp.spacemesh.network/config.mainnet.json

#  初始化
nohup ./go-spacemesh --config config.mainnet.json --smeshing-start --smeshing-coinbase sm1qqqqqqywuum422ejvng5nkqwfk6r6ljls2cuzdcfa2utf --smeshing-opts-numunits 5 --smeshing-opts-provider 4294967295 --smeshing-opts-datadir ${POST_DATA} --data-folder ${NODE_DATA}  >>./spacemesh-`date +%Y-%m-%d`.log  2>&1 &

echo "[`date '+%Y-%m-%d %H:%M:%s'`] spacemesh started"
