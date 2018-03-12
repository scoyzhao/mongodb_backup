#!/bin/bash

BACKUP_DIR=/root/test
BACKUP_NAME=backup
BAK_SCRIPT_DIR=/root/crontab

# numbers of errors
# keyword 'not' for 'not connected'

E426="Data connection closed, error decompressing data stream"
E452="Sorry, insufficient disk quota"
E530="Not logged in"

cd ${BAK_SCRIPT_DIR}
./mongod_bak.sh 1 > log.txt

grep -Eiwq "not|${E426}|${E452}|${E530}" log.txt

if [ "$?" != "0" ]; then
    cd ${BACKUP_DIR}
    rm -rf *
else
    cd ${BACKUP_DIR}
    rm -rf ${BACKUP_NAME}
fi
