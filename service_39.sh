#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

for i in $(seq 1 10)
do
nohup /root/service --address=http://192.168.111.39:9094/ --operator-address=127.0.0.1:505$((i)) --dir=/data$((i))/spacemesh/post_data --threads=3 --nonces=128 --randomx-mode=fast >>./service$((i))-`date +%Y-%m-%d`.log  2>&1 &
echo "[`date '+%Y-%m-%d %H:%M:%s'`] service$((i)) started"
done

echo "[`date '+%Y-%m-%d %H:%M:%s'`] all service started"
