#!/bin/bash
# 定时清理日志脚本

# 要清理日志的路径,修改为你的日志路径
clean_dir=/var/log/

# 清理的文件名,请准确填写名称，以免造成误删除
clean_filename="messages-*"

# 时间
time=$(date +%Y-%m-%d" "%H:%M:%S)


if [ -d ${clean_dir} ];then
    echo -n $time>>clean_log.txt
    echo "删除的内容如下：">>clean_log.txt
    find ${clean_dir} -type f -mtime +7 -name ${clean_filename}>>clean_log.txt
    find ${clean_dir} -type f -mtime +7 -name ${clean_filename} -print0 |xargs -0 rm -f >>clean_log.txt
else
    echo -n $time>>clean_log.txt
    echo "Error: 目录不存在"
    echo "$clean_dir 不存在">>clean_log.txt
fi
