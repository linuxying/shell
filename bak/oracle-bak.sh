#!/bin/bash
#**********************************************************************************
# Author : Linuxliu
# Email : 512331228@qq.com
# Last modified :2017-03-09 22:12
# Filename :oracle-bak.sh
# Description :数据库备份脚本，备份打包推送到ftp，本地数据保存5天
#**********************************************************************************

#定义变量
BACKDIR=/home/oracle/backup
DATE=`date +%Y-%m-%d`

#数据保存多少天这里就改为多少天，这里不同版本linux系统会不一样
#要改成相应的命令。
OLDDATE=`date -d "5 days ago" +%Y-%m-%d` 
DATANAME=databackup_`date +%Y-%m-%d`.tar.gz
LOGNAME=logbackup_`date +%Y-%m-%d`.tar.gz

#判断当前日期名的目录是否存在，不存在则创建
if [ ! -d ${BACKDIR}/${DATE} ];then
    mkdir -p ${BACKDIR}/${DATE}
fi

#判断5天前日期名的目录是否存在，存在则删除
if [ -d ${BACKDIR}/${OLDDATE} ]; then
    rm -rf  ${BACKDIR}/${OLDDATE}
fi

#导出数据库,一个数据库一个压缩文件
export ORACLE_BASE=/home/oracle
export ORACLE_HOME=$ORACLE_BASE/app/oracle/product/11.2.0/dbhome_1
export ORACLE_SID=orcl
export PATH=$PATH:$HOME/bin:$ORACLE_HOME/bin

exp 账号/密码@实例名 file=${BACKDIR}/${DATE}/${DATE}.dmp log=${BACKDIR}/${DATE}/${DATE}.log

#进入备份目录将备份文件打包压缩,压缩完删除未打包文件
cd ${BACKDIR}/${DATE}
tar zcvf ${DATANAME} ${BACKDIR}/${DATE}/${DATE}.dmp
rm -f ${BACKDIR}/${DATE}/${DATE}.dmp

tar zcvf ${LOGNAME} ${BACKDIR}/${DATE}/${DATE}.log
rm -f ${BACKDIR}/${DATE}/${DATE}.log


#上传到FTP空间
FTP_SERVER=FTP的ip地址
FTP_USER=用户
FTP_PWD=密码

cd ${BACKDIR}/${DATE}

ftp -i -n -v<< !
open $FTP_SERVER
user $FTP_USER $FTP_PWD
binary
put ${DATANAME}
bye
!
