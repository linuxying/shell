#!/bin/bash
# Author : Linuxliu
# Email : 512331228@qq.com
# Last modified :2017-03-08 21:38
# Filename :cpu-monitor.sh
# Description :整合了可以查看cpu信息的命令


DATE=`date +%F-%H:%M`

#查看物理cpu个数
phy_cpu=`grep 'physical id' /proc/cpuinfo|sort|uniq|wc -l`

#查看每个物理cpu的核数
cores_cpu=`grep 'cpu cores' /proc/cpuinfo |uniq|awk '{print $NF}'`

#查看逻辑cpu个数
logical_cpu=`grep 'processor' /proc/cpuinfo |wc -l`

#cpu型号和主频信息
model_cpu=`grep 'model name' /proc/cpuinfo |uniq|awk -F ":" '{print $2}'`

#cpu负载信息
cpuload=`uptime |awk -F ": " '{print $2}'`

echo 
echo -e "\033[32mCpu  information:\033[0m"
echo -e "\033[32m    check time:   =  $DATE                   \033[0m" 
echo -e "\033[32m    Physical cpu: =  ${phy_cpu}              \033[0m" 
echo -e "\033[32m    cpu cores:    =  ${cores_cpu}            \033[0m"
echo -e "\033[32m    locical cpu:  =  ${logical_cpu}          \033[0m"
echo -e "\033[32m    model cpu:    = ${model_cpu}             \033[0m"
echo -e "\033[32m    cpu load:     =  ${cpuload}              \033[0m"
echo 
