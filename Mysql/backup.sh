#!/bin/bash
# Name:mysql.sh
# This is a ShellScript For Auto DB Backup and Delete old Backup
#
backupdir=/backup/mysql
time=` date +%Y%m%d%H `
/usr/bin/mysqldump -u wecook -p123456 wecook | gzip > $backupdir/wecook$time.sql.gz
# only remain 7 day
find $backupdir -name "wecook_*.sql.gz" -type f -mtime +7 -exec rm {} \; > /dev/null 2>&1
