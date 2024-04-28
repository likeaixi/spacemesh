#!/bin/bash

i=1
while [ $i -le 11 ]
do
/root/postcli -provider=0 -commitmentAtxId=0c545ed3ec10d97f1da60ca0197c69abcd46f259833a1bd5c5a71c2dac3cafbf -numUnits=125  -datadir=/data${i}/spacemesh/post_data
killall postcli

i=$(($i+1))
done