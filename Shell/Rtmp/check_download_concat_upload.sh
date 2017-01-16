#!/bin/bash


if [ $# -lt 4 ] ; then
	echo "-9";
	echo -e Please use\\n $0  new_name video_filename1 ... video_filenamen ;
	echo -e such as: concated_video L00006 video1 vide2 ...  \\n$0;
	echo -e !!! Please create the concated video when finished!;
	exit -9;
fi 



datapath="/var/www/videoedit/data/";
liveId=$2;

tempfile=`date +%s`.tmp.mp4;
outputvideo=$1.mp4;
outputimage=$1.jpg


if [ ! -d $datapath ]; then
 mkdir -p $datapath;
fi

cd $datapath;
#echo `pwd`;

#echo $(expr $# - 2);
FILES='';
for ((k=2; k<=$(expr $# - 1); k=k+2));do 
	eval LIVEID=\$$k;
	eval ORIG_NAME=\$$(expr $k + 1 );
#	echo $LIVEID;
#	echo $ORIG_FILE;

	ORIG_PATH_FILE=$ORIG_NAME.mp4;
#	echo -e '11111111111 check download-----'$LIVEID $ORIG_PATH_FILE;
	if [ ! -f $ORIG_PATH_FILE ];then
 		##osscmd get  oss://amaitest/data/$LIVEID/video/$ORIG_NAME.mp4  $ORIG_PATH_FILE >/dev/null 2>/dev/null; 
 		osscmd get  oss://amai/data/$LIVEID/video/$ORIG_NAME.mp4  $ORIG_PATH_FILE >/dev/null 2>/dev/null; 
#>>/var/www/videoedit/jwphp/log/conosscmd.log 2>>/var/www/videoedit/jwphp/log/conosscmd_error.log ; #>>/dev/null 2>>/dev/null;
	fi
	
#	echo $ORIG_PATH_FILE;

	if [ ! -f $ORIG_PATH_FILE ];then
		echo "-8";#oss download file failed";
		exit -8;
	fi

	FILES=$FILES' '$ORIG_PATH_FILE;

#	echo $FILES;
done

#echo -e '\n\n------------will concat------------------------------'$FILES $tempfile ;


####################################################
#/var/www/videoedit/concat/jwphp/concat.sh $FILES $tempfile; 

########create ts files
#echo -e '\n create ts files \n';

prefix=$datapth`date +%F-%H-%M-%S`;
concat='concat:';
let "index = 0";

#echo $prefix;

let "tsfile_count = 0 ";


for i in $FILES
do
 #echo 'index:' $index;
 #echo $i
if [ ! -f $i ] ;then
 echo "file not exist";
 exit 2001;
else
        #echo "this is a file";
        tempname=${prefix}_${index}".ts" ;
        /opt/ffmpeg20150711/ffmpeg-20150710-git-033dc39/ffmpeg  -i $i -acodec copy -vcodec copy -bsf:v h264_mp4toannexb  $tempname  ;
        if [ $index -eq 0 ]; then concat=$concat${tempname};
        else concat=$concat"|"$tempname;
        fi
        #echo $concat;
fi
let "index =  index +1"  ;
let "tsfile_count = tsfile_count + 1";
done

#echo -e 'ts files:' $concat "\n";

####concat ts fils
#echo -e "concat ts files as $tempfile \n"


#/opt/ffmpeg20150711/ffmpeg-20150710-git-033dc39/ffmpeg -i "$concat" -c copy $tempfile >/dev/null 2>&1;
/opt/ffmpeg20150711/ffmpeg-20150710-git-033dc39/ffmpeg -i "$concat" -acodec copy -vcodec copy -absf aac_adtstoasc $tempfile >/dev/null 2>&1;

#### delete ts files
#echo -e "delete ts files\n";
#echo -e "ts file count: $tsfile_count \n";


let "index = 0";
while [ $index -lt $tsfile_count ]
do
  rm ${prefix}_${index}.ts;
# echo ${prefix}_${index}.ts;
 let "index = index +1";
done




#########################################################
#echo result is $result;
#echo 'tempfile: ' $tempfile ;
if [ ! -f $tempfile ]; then
   echo '-7' #ffmpeg concat file failed;
   exit -7;
fi


#echo -e '\n\n----------mv--------------------------------';
mv $tempfile $datapath$outputvideo;

if [ ! -f $datapath$outputvideo ]; then
    echo '-6';# move file error, disk is full? ;
    exit -6;
fi


ffmpeg -y -ss 00:00:10 -i $datapath$outputvideo  -vframes 1 $datapath/$outputimage  >>/dev/null 2>>/dev/null;
if [ ! -f $datapath$outputimage ]; then
    echo '-5';# create thumbnail error
    exit -5;
fi


##osscmd put  $datapath$outputvideo oss://amaitest/data/$liveId/video/$outputvideo >>/dev/null 2>>/dev/null ;
##osscmd put  $datapath$outputimage oss://amaitest/data/$liveId/video/$outputimage >>/dev/null 2>>/dev/null;
osscmd put  $datapath$outputimage oss://amai/data/$liveId/video/$outputimage >>/dev/null 2>>/dev/null;
osscmd put  $datapath$outputvideo oss://amai/data/$liveId/video/$outputvideo >>/dev/null 2>>/dev/null ;




echo "0";
exit 0;




