#!/bin/bash
TIME=`date '+%Y-%m-%d %H:%M:%S'`
REDIS_HOST='121.41.88.209'
REDIS_PORT='63789'
REDIS_PASS='tinywanredis'
REDIS_DB=1
LOG_PATH="/home/www/logs"
LOG_CMD=`du -b $LOG_PATH`
LOG_SIZE=`echo $LOG_CMD | awk '{print $1}'`

############################ Service Disk Info ###############################
#df -h
#文件系统        容量  已用  可用 已用% 挂载点
#/dev/sda5        46G   25G   19G   58% /
#none            4.0K     0  4.0K    0% /sys/fs/cgroup
#udev            1.9G  4.0K  1.9G    1% /dev
#tmpfs           385M  1.5M  383M    1% /run
#none            5.0M     0  5.0M    0% /run/lock
#none            1.9G  976K  1.9G    1% /run/shm
#none            100M   32K  100M    1% /run/user
#下面这一句，得到第5列第2行中的58％的58
PERCENT_USED=`df -h | awk '{print $5}' | head -2 | tail | grep -oP '\d+'`
echo "[$TIME]-[Disk Percentage Used:${PERCENT_USED}]" >> $LOG_PATH"/disk_percent_used".log
if [ ${PERCENT_USED} -gt 10 ]
then
    echo "大于8%"
    find $LOG_PATH  -mtime +10 -name "*.log" -exec rm -rf {} \;	
fi

########################### Redis Disk Info ######################################
used_memory_redis_size=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS info | grep -e "used_memory_human" | cut -d : -f 2 |cut -d . -f 1)
echo "[$TIME]-[used_memory_redis_size:${used_memory_redis_size}M]" >> $LOG_PATH"/redis_disk_used".log
if [ ${used_memory_redis_size} -gt 30 ]
then
	$(curl -s "http://sewise.amai8.com/authcheck/redisMemoryNotice?size=$used_memory_redis_size")
	echo "[$TIME]-[used_memory_redis_size:${used_memory_redis_size}M]" >> $LOG_PATH"/redis_disk_used".log
fi
exit 1;
### [10] notice [80] delete file
CONDITION=1
case $CONDITION in
	1)  
	echo '你选择了 1'
	Response=$(curl -s "http://sewise.amai8.com/redistest/redisToRedis")
	echo $Response
	;;
	
	9)  
	echo '你选择了 9'
	;;
        
	80)
        echo '你选择了 80'
	;;
	
	100)  
	echo '你选择了 100'
	;;
esac

exit 1
if [ ${PERCENT_USED} -gt 80 ]
then
    echo "大于8%"
    #rm -rf /home/fan/shell/localhost_access_log.${preYY}-${preMM}*
fi
exit 1
# -mmin n 查找n分钟 -mtime n 查找n天
find $LOG_PATH  -mmin +1 -name "*.log" -exec rm -rf {} \;
