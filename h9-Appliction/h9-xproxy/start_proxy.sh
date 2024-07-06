#!/bin/bash
nohup /root/SMH-H9/h9-xproxy/x-proxy >> /root/SMH-H9/h9-xproxy/x-proxy-$(date +%Y%m%d).log 2>&1 &
