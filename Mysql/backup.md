MySQL 定时自动备份
===================================


## Crontab 定时自动备份 ##
利用系统crontab来定时执行备份文件，按日期对备份结果进行保存，达到备份的目的。

1、创建备份脚本 
添加执行权限
>vim /mnt/backup/shell/mysql.sh

mysql.sh 内容如下，可修改backupdir配置及数据库账号信息配置:
```sh
#!/bin/bash
# Name:mysql.sh
# This is a ShellScript For Auto DB Backup and Delete old Backup
#
backupdir=/mnt/backup/mysql
time=` date +%Y%m%d%H `
/usr/bin/mysqldump -u wecook -p123456 wecook | gzip > $backupdir/wecook$time.sql.gz
# only remain 7 day
find $backupdir -name "wecook_*.sql.gz" -type f -mtime +7 -exec rm {} \; > /dev/null 2>&1
```

2、添加执行权限
>chmod +x /opt/shell/mysql.sh

3、重启
>service crond restart  


原文来源： http://my.oschina.net/u/231017/blog/186447
