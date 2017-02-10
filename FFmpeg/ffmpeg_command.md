![image](https://github.com/Tinywan/PHP_Experience/blob/master/Public/Common/static/images/ffmpeg.png)
## FFmpeg 常用命令DEMO
*  为了设定输出视频码率为64kbit/s：     
    `ffmpeg -i input.avi -b:v 64k -bufsize 64k output.avi`
*  为了切换帧率到24fps：     
    `ffmpeg -i input.avi -r 24 output.avi`
