#!/bin/bash
# This is a ShellScript For Auto DB Backup and Delete old Backup
#

DB="test"
DB_USER="test"
DB_PWD="123456"
BACKUP_DIR=/mnt/backup/mysql
TIME=` date +%Y%m%d%H `

# backup
/usr/bin/mysqldump -u $DB_USER -p$DB_PWD $DB | gzip > $BACKUP_DIR/wecook$TIME.sql.gz

# only remain 7 day
find $BACKUP_DIR -name "$DB_*.sql.gz" -type f -mtime +7 -exec rm {} \; > /dev/null 2>&1
