#!/bin/bash  
  
# 服务器列表，IP从192.168.111.3到192.168.111.30  
#NodeIP=("31" "37" "39" "40")
#for ip in "${NodeIP[@]}";do
for ip in {5..24};do
#for ip in {51..68};do
#for ip in {60..70};do
    full_ip="192.168.2.$ip"

    scp -r /root/SMH-H9/sp-h9-miner/ "$full_ip:/root"
    ssh "$full_ip" "sed -i "s/TSJ-/TSJ-0$ip/g" /root/sp-h9-miner/config.yaml"
   #ssh "$full_ip" "rm -rf h9-miner-sp"
    echo "文件已上传至服务器： $full_ip"  

    if [ $? -ne 0 ]; then
        echo "服务器： $full_ip 上传失败!!!!!"  
    fi
done
