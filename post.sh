#!/bin/bash

nodeName=spacemesh
desiredSizeGiB=8000
maxFileSizeGiB=4
datadir=/data1/sapcemesh


nodeId=`cat ${datadir}/postdata_metadata.json | jq -r '.NodeId' |  base64 -d | xxd -p -c 32`


commitmentAtxId=0c545ed3ec10d97f1da60ca0197c69abcd46f259833a1bd5c5a71c2dac3cafbf


## Automatic Values
desiredSizeGiB=$((desiredSizeGiB + 0))
maxFileSizeGiB=$((maxFileSizeGiB + 0))
numGpus=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
numGpus=$((numGpus + 0)) # convert to int
numUnits=$((desiredSizeGiB / 64))           # 64 GiB per unit
numUnits=$((numUnits + 0))                  # convert to int
maxFileSize=$((maxFileSizeGiB * 1024 * 1024 * 1024))

if [[ $desiredSizeGiB%64 -ne 0 ]];then
  echo "所选总空间无法被64整除";
  exit 1;
fi

if [[ $desiredSizeGiB%$maxFileSizeGiB -ne 0 ]];then
  echo "所选总空间无法被文件大小整除";
  exit 1;
fi

totalFiles=$((desiredSizeGiB/maxFileSizeGiB))
if [[ $totalFiles -le 0 ]];then
  echo "总文件数需要大于0";
  exit 1;
fi

avgGpuNum=$((totalFiles / numGpus))
extentGpuNum=$((totalFiles % numGpus))
maxFileSize=$((maxFileSizeGiB*1024*1024*1024))


echo "节点名称：""$nodeName"
echo "数据存储位置：""$datadir"
echo "nodeId：""$nodeId"
echo "commitmentAtxId：""$commitmentAtxId"
echo "总空间(GB)："$desiredSizeGiB
echo "单文件大小(GB)："$maxFileSizeGiB
echo "单文件大小(bit)："$maxFileSize
echo "GPU总数："$numGpus
echo "总单元数："$numUnits
echo "总文件数："$totalFiles
echo "默认平均每台GPU分配的文件数："$avgGpuNum
echo "未能平均分配到GPU的文件数："$extentGpuNum


# 如果文件无法平均分配到每台显卡，则平均值加1
if [[ $extentGpuNum -gt 0 ]];then
    avgGpuNum=$((avgGpuNum+1))
fi

# Script to run postcli for each GPU
# 当extentGpuNum为0和不为0时候的处理方式
for ((gpuIndex=0; gpuIndex<numGpus; gpuIndex++)); do
  if [[ extentGpuNum -le 0 ]] || [[ gpuIndex+1 -le extentGpuNum ]];then
    fromFile=$((gpuIndex * avgGpuNum))
    toFile=$(( (gpuIndex + 1) * avgGpuNum - 1 ))
  else
    # 未能平均分配，则除了前面每台多分配一个后，剩余的均少分配一个
    fromFile=$((gpuIndex * avgGpuNum-(gpuIndex+1-extentGpuNum-1)))
    toFile=$(( (gpuIndex + 1) * avgGpuNum - 1 -(gpuIndex+1-extentGpuNum)))
  fi
  nohup ./postcli -provider=$((gpuIndex)) -commitmentAtxId="$commitmentAtxId" -id="$nodeId" -numUnits=$numUnits -maxFileSize=$maxFileSize -datadir="$datadir" -fromFile=$fromFile -toFile=$toFile >"$nodeName""_""$gpuIndex"".log" &
done
