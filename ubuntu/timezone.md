时间同步
=================
Linux默认情况下使用UTC格式作为标准时间格式，如果在Linux下运行程序，且在程 序中指定了与系统不一样的时区的时候，可能会造成时间错误。如果是Ubuntu的桌面版，则可以直接在图形模式下修改时区信息，但如果是在Server版 呢，则需要通过tzconfig来修改时区信息了。使用方式(如将时区设置成Asia/Chongqing)：


```sh
// UI选择时区
dpkg-reconfigure tzdata
// 2、防止系统重启时时区修改无法生效
sudo cp /usr/share/zoneinfo/Asia/ShangHai /etc/localtime  

// 3、设置系统时间与网络时间同步
ntpdate cn.pool.ntp.org

// 4、将系统时间写入硬件时间
hwclock –systohc


```


