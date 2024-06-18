#!/bin/bash
nohup /root/sp-h9-miner/sp-miner -license yes >> /root/sp-h9-miner/h9-miner-$(date +%Y%m%d).log 2>&1 &
