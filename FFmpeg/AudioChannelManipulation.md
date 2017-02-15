# 操作音频通道
### 立体声→单声道流
![image](https://trac.ffmpeg.org/raw-attachment/wiki/AudioChannelManipulation/stereo_mono.png)
*  将单个立体声流混合到单声道流。 立体声流的两个声道将被下混合成流：     
    `ffmpeg -i stereo.flac -ac 1 mono.flac`
    >注意：任何异相立体声将会消除   
    
### 立体→2×单声道文件   
---   
![image](https://trac.ffmpeg.org/raw-attachment/wiki/AudioChannelManipulation/stereo_2mono_outputs.png)    
*  将立体声输入中的每个通道输出到各个单声道文件：     
    `ffmpeg -i stereo.wav -map_channel 0.0.0 left.wav -map_channel 0.0.1 right.wav`      
    >或使用平移音频滤波器:   
    >> `ffmpeg -i stereo.wav -filter_complex "[0:0]pan=1c|c0=c0[left];[0:0]pan=1c|c0=c1[right]" -map "[left]" left.wav -map "[right]" right.wav`
    
    
### 视频
*  FFmpeg concat 协议：     
    - [x] `ffmpeg -i "concat:02.mp4|03.mp4" -c copy concat_output.mp4`   
    - [x] `ffmpeg -i "concat:02.mp4|03.mp4" -c copy concat_output.mp4`   
    - [x] `ffmpeg -i "concat:02.mp4|03.mp4" -c copy concat_output.mp4`
    - [ ] `ffmpeg -i "concat:02.mp4|03.mp4" -c copy concat_output.mp4`
    
  
      

    
