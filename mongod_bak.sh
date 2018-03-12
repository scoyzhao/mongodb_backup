#!/bin/bash

DATABASE_DIR=/root/test/backup
BACKUP_DIR=/root/test
BACKUP_NAME=backup
DATABASE_NAME=local
OUT_DIR=/test
DUMP=/root/mongodb/bin/mongodump
DATE=$(date +%Y-%m-%d_%H)
IP=121.40.77.208

$DUMP -d $DATABASE_NAME -o $DATABASE_DIR/
cd $BACKUP_DIR
tar -cvf $DATE.tar $BACKUP_NAME/$DATABASE_NAME

ftp -n -v  << -EOF
open $IP
user anonymous 123456
bin
prompt off
cd $OUT_DIR
lcd $BACKUP_DIR
mput *.tar
bye
EOF
