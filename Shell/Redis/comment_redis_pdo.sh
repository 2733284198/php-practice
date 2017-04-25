#!/bin/bash
:<<tinywan
        [1]author:Tinywan
        [2]function:每隔10分钟把每个活动对应的评论和礼物数量同步到MySQL数据库中去
        [3]date:2016-11-04 10:23:10 [date '+%Y-%m-%d %H:%M:%S']
tinywan
PATH=/usr/local/bin:/usr/bin:/bin
TIME=`date '+%Y-%m-%d %H:%M:%S'`
YMD=`date +%Y%m%d`
S_TIME=`date +%S`
FLOG=/home/www/logs/amai_live_comment.log

REDIS_HOST='127.0.01'
REDIS_PORT='6379'
REDIS_PASS='1234567'
REDIS_DB=0
#echo $TIME $INSERT_CURL >> $FLOG
ALLKEY=$(redis-cli -h $REDIS_HOST -p $REDIS_PORT  keys 'L*Comments')
if [ -z "${ALLKEY}" ]; then
        echo "[$TIME]-[WARNING]: redis data is nil" >> $FLOG
        exit 1
fi

#echo $ALLKEY

for KEY_ELEMINT in $ALLKEY



                do
                        if [ -n "$KEY_ELEMINT" ];then
			#	echo -e "http://console.amailive.com/api/commentRedisToMysql?live_key=${KEY_ELEMINT}\n"
				echo "[$TIME]-[BeginTime]:${S_TIME}" >> $FLOG
				RESPONSE_RESULT=$(curl -s "http://console.amailive.com/api/commentRedisToMysqlPdo?live_key=${KEY_ELEMINT}")
	                        echo "[$TIME]-[SUCCESS]:[$RESPONSE_RESULT]" >> $FLOG
				echo "[$TIME]-[EndTime]:${S_TIME}" >> $FLOG
			fi
                done

