#!/bin/bash
:<<tinywan
	[1]author: Tinywan
	[2]date: 2016-11-04 10:23:10 [date '+%Y-%m-%d %H:%M:%S']
	[3]实际应用: shell+定时任务+nginx信号管理,完成日志按日期存储
	[4]分析思路: 凌晨00:00:01,把昨天的日志重命名,放在相应的目录下,再USR1信息号控制nginx重新生成新的日志文件
tinywan
base_path='/usr/local/nginx/logs'
log_path=$(date -d yesterday +"%Y%m")
day=$(date -d yesterday +"%d")
mkdir -p $base_path/$log_path
mv $base_path/access.log $base_path/$log_path/access_$day.log
#echo $base_path/$log_path/access_$day.log
kill -USR1 `cat /usr/local/nginx/logs/nginx.pid`

