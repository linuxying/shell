#!/bin/bash
#**********************************************************************************
# Author : Linuxliu
# Email : 512331228@qq.com
# Last modified :2017-03-09 17:25
# Filename :disk-infomation.sh
# Description :查看硬盘使用量及inode使用量(可以结合定时任务使用，每小时执行一次)
#**********************************************************************************

#发生问题后写入文件
diskinfo="/tmp/diskinfo.txt"

#定义时间
begintime=`date +%F-%H:%M:%S`
endtime=`date +%F-%H:%M:%S`

#for循环调用命令取到的数值，与阈值做对比，如果超过阈值则记录到文件中
for d in `df -P |grep dev|awk '{print $5}'|sed 's/%//g'`
do
    for i in `df -i|grep /dev|awk '{print $5}'|sed 's/%//g'`
    do
        echo "">>${diskinfo} 
        echo "Begin time:${begintime}**************************">>${diskinfo}
        
        #获取的结果与阈值进行比对，超过阈值记录，未超过不记录
        if [ $d -gt 0 -o $i -gt 0 ];then
            df -h>>${diskinfo}
            echo "">>${diskinfo}
            df -i>>${diskinfo}
            #sendmail
            #mutt -s "disk warning!" 512331228@qq.com <${diskinfo}
            echo "End time:${endtime}****************************">>${diskinfo}
            echo "">>${diskinfo}
            exit 0
        fi
    done
done
