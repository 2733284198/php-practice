# 音频通道操作
## 操作音频通道
#### 立体声→单声道流
![image](https://trac.ffmpeg.org/raw-attachment/wiki/AudioChannelManipulation/stereo_mono.png)
*  将单个立体声流混合到单声道流。 立体声流的两个声道将被下混合成流：     
    `ffmpeg -i stereo.flac -ac 1 mono.flac`
    >注意：任何异相立体声将会消除   
    
### 视频
*  FFmpeg concat 协议：     
- [x] `ffmpeg -i "concat:02.mp4|03.mp4" -c copy concat_output.mp4`   
    []`ffmpeg -i "concat:02.mp4|03.mp4" -c copy concat_output.mp4`   
    [x]`ffmpeg -i "concat:02.mp4|03.mp4" -c copy concat_output.mp4`
    
  
      

    
