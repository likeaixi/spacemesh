#!/bin/bash

datadir="/data$1/spacemesh/post_data"
avgFile=250
nodeId=`cat ${datadir}/postdata_metadata.json | jq -r '.NodeId' |  base64 -d | xxd -p -c 32`
commitmentAtxId=0c545ed3ec10d97f1da60ca0197c69abcd46f259833a1bd5c5a71c2dac3cafbf

for((i=0;i<8;i++));
do
  fromFile=$((i*avgFile))
  toFile=$(($((i+1))*avgFile-1))

  nohup ./postcli -provider=$((i)) -commitmentAtxId="$commitmentAtxId" -id="$nodeId" -numUnits=125 -datadir="$datadir" -fromFile=$fromFile -toFile=$toFile >"postcli""_""$((i))"".log" &
done
