#!/bin/bash
:<<tinywan
        [1]author:Tinywan
        [2]function:Nginx RTMP 模块的分发服务器分发本地流到各个节点服务器上去
        [3]date:2016-11-04 10:23:10 [date '+%Y-%m-%d %H:%M:%S']
tinywan
##########  Reids 连接信息 第一个参数代表流信息 ################################################################
STREAM_ID=$1
stream=${STREAM_ID:0:10}
host="121"
port="639"
pass='tinywanredis'
db=1
TIME=`date '+%Y-%m-%d %H:%M:%S'`
FLOG=/home/tinywan/log/rtmpDispatch.log
##############################  判断当前流参数是否为空 #########################################################
if [ -z "${stream}" ]; then
	echo "[$TIME]-[ERROR]: stream_id is null" #>> $FLOG
	exit 1
fi
################### 需要分发的服务器的推流ID 通过该ID直接在节点服务器可以直接观看 #############################
NODE_STREAM_ID=$(redis-cli -h $host -p $port -a $pass -n $db hget ${stream} node_stream_id)
if [ -z "${NODE_STREAM_ID}" ]; then
        echo "[$TIME]-[ERROR]: NODE_STREAM_ID is null" #>> $FLOG
        exit 1
fi

################### 需要分发的节点服务器IP ####################################################################
GET_ALL_NODE_IP(){
	ALL_NODE_IP=$(redis-cli -h $host -p $port -a $pass -n ${db} hget ${stream} node_ip)
	if [ -z "${ALL_NODE_IP}" ]; then
        	echo "[$TIME]-[ERROR]: ALL_NODE_IP is null" >> $FLOG
        	exit 1
	fi
	echo "[$TIME]-[SUCCESS]: ALL_NODE_IP:$ALL_NODE_IP" >> $FLOG
	###################分割IP地址#################
	CUT_NODE_IP=${ALL_NODE_IP//|/ } #将得到的节点中的|替换为空格
                for IP_ELEMINT in $CUT_NODE_IP
                do
                        echo "[$time] 分发的节点IP地址: >>>>> $IP_ELEMINT " >> $FLOG
                        FFMPEG_NODE $IP_ELEMINT
                done

}

###########################FFMPEG_NODE FUNCTION#####################################
FFMPEG_NODE(){
	NODE_IP=$1
	ffmpeg -r 25 -i rtmp://localhost/live/$STREAM_ID -c copy -f flv rtmp://$NODE_IP/live/$NODE_STREAM_ID &
}
################### 分发服务器分发流到节点服务器 这里需要分发到多个服务器？待解决？？？########################
on_die ()
{
    # kill all children
    pkill -KILL -P $$
}

trap 'on_die' TERM
GET_ALL_NODE_IP
#ffmpeg -r 25 -i rtmp://localhost/live/${STREAM_ID} -c copy -f flv rtmp://10.117.19.148/live/${NODE_STREAM_ID} &
#ffmpeg -i $FILE -c:v libx264 -b:v 300k -c:a libfdk_aac -b:a 64k  -f flv rtmp://10.1/live/${NODE_STREAM_ID} &
#ffmpeg -i $FILE -c:v libx264 -b:v 500k -c:a libfdk_aac -b:a 64k  -f flv rtmp://10.117./hls/${NODE_STREAM_ID}_hi &
#ffmpeg -i $FILE -c:v libx264 -b:v 100k -c:a libfdk_aac -b:a 64k  -f flv rtmp://10.117./hls/${NODE_STREAM_ID}_low &
#ffmpeg -i rtmp://localhost/live/$RAWID -c copy -f flv rtmp://$NODE/live/$RAWID &
wait
