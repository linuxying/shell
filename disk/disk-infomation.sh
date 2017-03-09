#!/bin/bash
#**********************************************************************************
# Author : Linuxliu
# Email : 512331228@qq.com
# Last modified :2017-03-09 17:25
# Filename :disk-infomation.sh
# Description :查看硬盘使用量及inode使用量(可以结合定时任务使用，没小时执行一次)
#**********************************************************************************


diskinfo="/tmp/diskinfo.txt"

for i in `df -P |grep dev|awk '{print $5}'|sed 's/%//g'`
do
    if [ $i -gt 80 ];then
        df -h>>${diskinfo}
        #sendmail
        mutt -s "disk warning!" 512331228@qq.com <${diskinfo}
        exit 0
    fi
done
