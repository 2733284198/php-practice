:<<tinywan
        [1]author:Tinywan
        [2]function:根据每次的直播结束后，传递一个流Id，把该直播所有的.ts文件上传到阿里云去
        [3]date:2016-11-21 10:23:10 [date '+%Y-%m-%d %H:%M:%S']
tinywan
PATH=/usr/local/bin:/usr/bin:/bin
FLOG=/home/www/bin/auto_slice_oss.log
TIME=`date '+%Y-%m-%d %H:%M:%S'`
HLS_DIR_PATH=/tmp/hls
SAVE_ROOT_DIR=/data/hls

STREAM_ID=$1
echo -e "\n\n------publish  new record begin------------"  >>$FLOG
echo $@ >>$FLOG

if [ -z "$STREAM_ID" ]; then
        echo "xxxxxxxxxxx[ERROR][$TIME] stream id is null" >> $FLOG
        exit 1
fi

LIVEID='L02533'

SAVE_HLS_DIR=$SAVE_ROOT_DIR/$STREAM_ID
#创建对应的本地存储目录
mkdir -p $SAVE_HLS_DIR

echo "[DEBUG][$TIME] SAVE_HLS_DIR : $SAVE_HLS_DIR STREAM_ID=$STREAM_ID, LIVEID=$LIVEID" >> $FLOG

cd $HLS_DIR_PATH 
for hls in `ls -rt $STREAM_ID-*.ts`
do
	mv $hls $SAVE_HLS_DIR
done

mv $STREAM_ID'.m3u8' $SAVE_HLS_DIR
# 上传至阿里云OSS amai 
osscmd uploadfromdir $SAVE_HLS_DIR oss://amaitest/data/$LIVEID/video/$STREAM_ID --replace=true
echo "Upload to OSS: oss://amai/data/$LIVEID/video/$BASE_NAME"
