#!/bin/bash
:<<tinywan
	[1]author:Tinywan
	[2]function:凌晨00:00:01,把昨天的日志重命名,放在该日期的月份目录下面,同时以昨天的时间为后缀名
	[3]date:2016-11-04 10:23:10 [date '+%Y-%m-%d %H:%M:%S']
tinywan
TIME=`date '+%Y-%m-%d %H:%M:%S'`
BASE_PATH="/home/www/logs"
########## 获取当月日期：201611
LOG_PATH=$(date -d yesterday +"%Y%m")
########## 获取昨天日期：03
DAY=$(date -d yesterday +"%d")
########## 在根日志目录下面创建该月份目录
mkdir -p $BASE_PATH/$LOG_PATH
########## 移动昨天的日志文件到指定日期下面 
mv $BASE_PATH/amai_live_comment.log $BASE_PATH/$LOG_PATH/amai_live_comment_$DAY.log
mv $BASE_PATH/financial_comment.log $BASE_PATH/$LOG_PATH/financial_comment_$DAY.log

########## Check Disk Auto Delete ####
PERCENT_USED=`df -h | awk '{print $5}' | head -2 | tail | grep -oP '\d+'`
########## 检查磁盘容量大于80%，删除所有日志
if [ ${PERCENT_USED} -gt 80 ]
then
	echo "[$TIME]-[Disk Percentage Used:${PERCENT_USED}]" >> $BASE_PATH/$LOG_PATH/disk_percent_used_$DAY.log
	find $BASE_PATH  -mmin +1 -name "*.log" -exec rm -rf {} \;
fi
