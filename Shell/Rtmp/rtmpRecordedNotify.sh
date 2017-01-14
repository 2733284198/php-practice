#!/bin/bash
:<<tinywan
        [1]author:Tinywan
        [2]function:Nginx RTMP录像自动上传到阿里云oss存储
        [3]date:2016-11-04 10:23:10 [date '+%Y-%m-%d %H:%M:%S']
tinywan
CT=`date +%s`

PATH=/usr/local/bin:/usr/bin:/bin
YM=`date +%Y%m`
FLOG=/home/www/bin/Oss_${YM}.log
#touch $FLOG
TIME=`date '+%Y-%m-%d %H:%M:%S'`

echo $TIME >> $FLOG

MIN_DURATION=20
ROOT_PATH=/home/www/recorded_data

########################### Redis record file url notice ##############
REDIS_HOST='127.1.0.1'
REDIS_PORT='63789'
REDIS_AUTH='tinywanredis'
REDIS_DB=12
######################################################################
RAWID=$1
DEVID=$1
fullname=$2
filename=$3
basename=$4
dirname=$5

echo $DEVID "======" $fullname >> $FLOG

echo -e "\n\n------------------"  >>$FLOG
echo $@ >>$FLOG

if [ -z "$RAWID" ]; then
	echo "xxxxxxxxxxx[ERROR][$TIME] device id is null" >> $FLOG
	exit 1
fi

if [ -z "$fullname" ]; then
	echo "xxxxxxxxxxxxx[ERROR][$TIME] fullname is null. RAWID=$RAWID" >> $FLOG
	exit 1
fi

# 检测文件是否存在并且大小不为0
if [ ! -s $fullname ]; then
	echo "xxxxxxxxxxxxxxx[ERROR][$TIME] File not exists or zero size. RAWID=$RAWID, fullname=$fullname" >> $FLOG
	rm -f $fullname
	exit 1
fi

# 检测视频时长，小于 MIN_DURATION 的文件将被丢弃
duration=`ffmpeg -i $fullname 2>&1 | awk '/Duration/ {split($2,a,":");print a[1]*3600+a[2]*60+a[3]}'`
if [ $(echo "$duration < $MIN_DURATION"|bc) = 1 ]; then
	echo "xxxxxxxxxx[ERROR][$TIME] Duration too short. RAWID=$RAWID, fullname=$fullname, duration=$duration" >> $FLOG
	rm -f $fullname
	exit 1
fi

echo "[DEBUG][$TIME] Video Record : RAWID=$RAWID, DEVID=$DEVID, fullname=$fullname" >> $FLOG


# 创建对应的本地存储目录
VIDEO_PATH=$ROOT_PATH/$DEVID/video
mkdir -p $VIDEO_PATH

# 自动截取封面图片
ffmpeg -y -ss 00:00:10 -i $fullname -vframes 1 $VIDEO_PATH/$basename.jpg

# 转码成MP4
ffmpeg -y -i $fullname -vcodec copy -acodec copy $VIDEO_PATH/$basename.mp4

#me 获取文件大小
FILESIZE=`stat -c "%s" $VIDEO_PATH/$basename.mp4`
#FILESIZE=0

# 获取视频录制时间
FILETIME=`stat -c "%Y" $fullname`

if [ $RESULT -ne "OK"]; then
   echo "[ERROR][$TIME] Insert Video Error :RAWID=$RAWID, STREANM_NAME=$DEVID, fullname=$fullname" >> $FLOG
   # exit 1
fi

# 上传至阿里云OSS

commandJPG="osscmd put $VIDEO_PATH/$basename.jpg oss://amaitest/data/$DEVID/video/$basename.jpg"
commandMP4="osscmd put $VIDEO_PATH/$basename.mp4 oss://amaitest/data/$DEVID/video/$basename.mp4"

echo "[DEBUG][$TIME] $commandJPG" >> $FLOG
$commandJPG 1>>$FLOG 2>>$FLOG

echo "[DEBUG][$TIME] $commandMP4" >> $FLOG
$commandMP4 1>>$FLOG  2>>$FLOG

#before auto slice 
RESULT=`curl "http://sewise.amai8.com/openapi/createStreamVideo?streamName=$DEVID&channelId=$DEVID&baseName=$basename&duration=$duration&fileSize=$FILESIZE&fileTime=$FILETIME" 2>/dev/null`
##################################### AUTO_RECORD_MANAGE ###################################################
StopRecordingMode=$(redis-cli -h ${REDIS_HOST} -p ${REDIS_PORT} -a ${REDIS_AUTH} -n REDIS_DB hget GlobalTracking:$DEVID StopRecordingMode)
if [ "$StopRecordingMode" != 'manual' ];then
	$(curl -s "http://sewise.amai8.com/openapi/shellChangeRecordStatus?&streamName=$DEVID&baseName=$basename&fileTime=$FILETIME" 2>/dev/null)
	#$(redis-cli -h $REDIS_HOST -p $REDIS_PORT -a $REDIS_PASS -n $REDIS_DB hset $DEVID record_status "STOPPING")
fi
##########################################################################################
#delete mp4 after 7*24*60  hours
cd /data/recorded_data/
#find $VIDEO_PATH  -mindepth 1 -maxdepth 3 -type f  -mmin +240   | xargs rm -rf
find ./  -mindepth 1 -maxdepth 3 -type f  -mmin +10080   | xargs rm -rf

# -mmin n 查找n分钟 -mtime n 查找n天
find ./  -mindepth 1 -maxdepth 3 -type f  -mmin +10080-type -f   -mmin_ATH
