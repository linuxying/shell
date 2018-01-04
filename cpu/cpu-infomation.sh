#!/bin/bash
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
echo -e "\033[32mCpu 信息:\033[0m"
echo -e "\033[32m    检查时间:    =  $DATE                   \033[0m" 
echo -e "\033[32m    物理cpu数:   =  ${phy_cpu}              \033[0m" 
echo -e "\033[32m    每个cpu核数: =  ${cores_cpu}            \033[0m"
echo -e "\033[32m    逻辑cpu数:   =  ${logical_cpu}          \033[0m"
echo -e "\033[32m    cpu型号:     = ${model_cpu}             \033[0m"
echo -e "\033[32m    cpu负载:     =  ${cpuload}              \033[0m"
echo 
