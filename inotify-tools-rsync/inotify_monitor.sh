#!/bin/sh
# 文件实时备份脚本
# 

# 源服务器配置
SOURCE_PATH='/mnt/uploads/'

# 备份服务器配置
BACKUP_IP='192.168.1.xx'
BACKUP_PORT='22'
BACKUP_USER='root'
BACKUP_PATH='/backup/uploads/'

# 脚本配置
RSYNC_BIN=/usr/bin/rsync
INOTIFY_BIN=/usr/bin/inotifywait


# 是否允许自动删除，缺省不允许
ALLOW_DELETE=false
# 忽略 vim 创建的临时文件，这里可以自定义忽略正则
INOTIFY_IGNORE_PATTERN="^(.+(\~|\.sw.?)|4913)$"
# inotifywait 可执行命令所在路径
INOTIFY_BIN=/usr/bin/inotifywait
INOTIFY_EVENTS="moved_to,create,delete,close_write,close"
INOTIFY_TIME_FMT="%d/%m/%y %H:%M"
INOTIFY_FORMAT="%T %e %w%f"

#
# 执行实时增量备份
# 

$INOTIFY_BIN --exclude "$INOTIFY_IGNORE_PATTERN" -mre "$INOTIFY_EVENTS" --timefmt "$INOTIFY_TIME_FMT" --format "$INOTIFY_FORMAT" $SOURCE_PATH | while read date time event file
do
    case "$event" in
        CLOSE_WRITE,CLOSE | MOVED_TO)
            echo "-> start uploading ${file}"
            $RSYNC_BIN -avz --port $BACKUP_PORT $SOURCE_PATH $BACKUP_USER@$BACKUP_IP:$BACKUP_PATH  > /dev/null
            echo "-> successfully uploaded ${file}"
            ;;
        DELETE)
            echo "-> deleting file: ${file}"
            if $ALLOW_DELETE; then
                $RSYNC_BIN -avz --delete --port $BACKUP_PORT $SOURCE_PATH $BACKUP_USER@$BACKUP_IP:$BACKUP_PATH  > /dev/null
                echo "-> successfully deleted ${file}"
            else
                echo "-> ${date} ${time} ${file} ${event}"
                echo "-> ${file} will not be deleted."
            fi
            ;;
        *)
            echo "${date} ${time} ${file} ${event}"
            ;;
    esac
done
