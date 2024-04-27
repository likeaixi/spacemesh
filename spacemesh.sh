#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

POST_DATA=/root/spacemesh/post_data
NODE_DATA=/root/spacemesh/node_data

# 扫盘
nohup ./go-spacemesh --config config.mainnet.json --smeshing-start --smeshing-coinbase sm1qqqqqqp9g6xxnw0w3darwfwuk39vlw3dd6smdgcang3uf --smeshing-opts-numunits 125 --smeshing-opts-provider 4294967295 --smeshing-opts-datadir ${POST_DATA} --data-folder ${NODE_DATA}  >>./spacemesh-`date +%Y-%m-%d`.log  2>&1 &

echo "[`date '+%Y-%m-%d %H:%M:%s'`] spacemesh started"
