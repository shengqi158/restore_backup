#!/bin/bash
# 

# 
# Created Time: 2012年10月24日 星期三 23时26分25秒
# 
# FileName:     backup.sh
# 
# Description:  
# 
# ChangeLog:
#
#用于本地备份,在/home/backup/pgsql目录下生成20121024.sql这样的备份文件，同时删除以前的备份

PG_DUMP=/usr/local/pgsql/bin/pg_dump
HOST='localhost'
BACKUP_DIR=/home/backup/pgsql
DB_NAME=tbase
DB_USER=tbaseuser 

DB_PASSWD=''
OUT_FILE="$(date +%Y%m%d)".sql
cd $BACKUP_DIR
if [ -f $OUT_FILE ]
then
    mv "$OUT_FILE" "$OUT_FILE".bak
else
    $PG_DUMP -h $HOST -U $DB_USER $DB_NAME -F c -b -v -f $OUT_FILE
    if [ $? -ne 0 ]
    then
        echo 'failed to pg_dump'
        exit 1
    fi
fi

for name in `ls $BACKUP_DIR|grep sql|cut -d"." -f1`
do
    echo "$name"
    if [ "$name" -lt $(date +%Y%m%d) ]
    then
        rm -f "$name".sql
        [ -f "$name".sql.bak ] && rm -f "$name".sql.bak
    fi
done

