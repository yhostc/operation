实时文件备份
===================================
主要工具：inotify-tool + rsync， 本文档以Ubuntu为例进行


## Install inotify-tools ##
>apt-get install inotify-tools

更多安装方式请参见：https://github.com/rvoicilas/inotify-tools/wiki



## 安装 Rsync ##
Rsync 是一个远程数据同步工具。Rsync server的机器也叫backup server,一个Rsync server可同时备份多个client的数据;也可以多个Rsync server 备份一个 client 的数据。
# 创建配置文件
>vim /etc/rsyncd.conf
文件内容如下：
```sh
uid=root 
gid=root 
max connections=40 
log file=/var/log/rsyncd.log 
pid file=/var/run/rsyncd.pid 
lock file=/var/run/rsyncd.lock 
```

# 启动
>/usr/bin/rsync --daemon -config=/etc/rsyncd.conf 

# 测试
```sh
# 从本端到备份服务器
rsync -avz /mnt/ root@10.2.3.XXX:/backup/

# 从远程服务器到本端, 若远程服务器为默认22端口，可去掉e参数及 'ssh -p 12345'
rsync -avze 'ssh -p 12345' root@10.2.3.XXX:/backup/ /mnt/ 

# 以上过程需输入root密码, 可将对方服务器加入本地authorized_keys文件。
```

更多Rsync配置及使用技巧，请参加 http://rsync.samba.org/


## 开始备份 ##
下载目录中inotify_monitor.sh脚本，并修改其中配置部分

```sh
# 授权
chmod a+x inotify_monitor.sh

# 启动
./inotify_monitor.sh

# 随系统启动

cat "/opt/shell/inotify_monitor.sh" >> /etc/rc.local

```

