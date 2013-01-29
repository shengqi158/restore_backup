#!/bin/bash
# 
# Author:       liaoxinxi@nsfocus.com
# 
# Created Time: 2012年10月15日 星期一 19时10分02秒
# 
# FileName:     restore.sh
# 
# Description:  
# 
# ChangeLog:
#用于还原数据库
PG_RESTORE=/usr/local/pgsql/bin/pg_restore
HOST='localhost'
BACKUP_DIR=/home/backup/pgsql
DB_NAME=tbase
DB_USER=tbaseuser
DB_PASSWD=''

cd $BACKUP_DIR
TARGET_FILE=$BACKUP_DIR/$(ls|grep -v bak|grep sql|tail -n 1)
if [ -f $TARGET_FILE ] 
then
    $PG_RESTORE -U $DB_USER -c -d $DB_NAME $TARGET_FILE
else
    echo 'backupfile is not exist'
    exit 1
fi
if [ $? -ne 0 ]
then
    echo 'failed to restore'
    exit 1
fi

#local_dir="/home/liaoxinxi/"
#target_dir="/tmp/"
#user="liaoxinxi"
#host="10.16.105.2"
#password=""
#lftp -u ${user},${password} sftp://${host} << EOF
#lcd ${local_dir}
#cd ${target_dir}
#put "ipv6.py"
#bye
#EOF
#
#exit
#[ -f /usr/local/pgsql/bin/pg_restore ] && [ -f /home/liaoxinxi/tbase.bak ]\
#    && [ /usr/local/pgsql/bin/pg_restore -h "10.16.0.246" -p 5432 -U tbaseuser -d tbase /home/liaoxinxi/tbase.bak ]
