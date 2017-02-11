![image](https://github.com/Tinywan/PHP_Experience/blob/master/Public/Common/static/images/ffmpeg.png)
## FFmpeg 常用命令DEMO
### 常用
*  为了设定输出视频码率为64kbit/s：(码率转换很慢，尤其高码率到低码率，如：2312kbps=>1024kbps)     
    `ffmpeg -i input.avi -b:v 64k -bufsize 64k output.avi`
*  为了切换帧率到24fps：     
    `ffmpeg -i input.avi -r 24 output.avi`
### 视频
*  FFmpeg concat 协议：     
    `ffmpeg -i "concat:02.mp4|03.mp4" -c copy concat_output.mp4`
    
### 音频
*  FFmpeg concat 协议：     
    `ffmpeg -i "concat:02.mp4|03.mp4" -c copy concat_output.mp4`    

### 复合流
*  第一路流的视频：  
`ffmpeg -i ./0001.mp4 -i ./0002.mp4 -map 0:0  -c copy -y ./0001_video.mp4`    

*  第一路流的音频：  
`ffmpeg -i ./0001.mp4 -i ./0002.mp4 -map 0:1  -c copy -y ./0001_video.mp4`    

*  第二路流的视频：  
`ffmpeg -i ./0001.mp4 -i ./0002.mp4 -map 1:0  -c copy -y ./0001_video.mp4`    

*  第二路流的音频：  
`ffmpeg -i ./0001.mp4 -i ./0002.mp4 -map 1:1  -c copy -y ./0001_video.mp4`    


### 摄像头
*  直接抓取笔记本摄像头视频和音频到本地存储     
    `ffmpeg -f dshow -i video="USB Camera":audio="麦克风 (Conexant SmartAudio HD)" -vcodec libx264 -acodec copy -preset:v ultrafast ./tinywan_computer_out.mpg`    
 
        
    
    
    
    
