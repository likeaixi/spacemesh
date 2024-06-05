#!/bin/bash
echo "启动miner"
nohup /root/h9-miner/h9-miner-spacemesh-linux-amd64 -license yes >>h9-miner.log 2>&1 &
