MySQL 定时自动备份
===================================


## Crontab 定时自动备份 ##
利用系统crontab来定时执行备份文件，按日期对备份结果进行保存，达到备份的目的，同时为了避免备份文件较多，仅保留7天的备份。

1、创建备份脚本 
请参见同目录backup.sh

2、添加执行权限
>chmod +x /opt/shell/mysql/backup.sh

3、重启
>cat "00 3  *  *  * root /mnt/backup/mysql/bakmysql.sh" >> /etc/crontab
>service crond restart
