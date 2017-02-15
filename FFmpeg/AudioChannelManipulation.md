![image](https://github.com/Tinywan/PHP_Experience/blob/master/Public/Common/static/images/ffmpeg.png)
# 音频通道操作
## 操作音频通道
#### 立体声→单声道流
![image](https://trac.ffmpeg.org/raw-attachment/wiki/AudioChannelManipulation/stereo_mono.png)
*  为了切换帧率到24fps：     
    `ffmpeg -i input.avi -r 24 output.avi`
### 视频
*  FFmpeg concat 协议：     
    `ffmpeg -i "concat:02.mp4|03.mp4" -c copy concat_output.mp4`
    
  
      

    
