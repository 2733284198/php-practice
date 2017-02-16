# FFmpeg参数使用
## 一、H264编码profile和level控制
`ffmpeg -i input.mp4 -profile:v baseline -level 3.0 output.mp4` 
 >profile参数:   
 >- baseline：基本画质。支持I/P 帧，只支持无交错（Progressive）和CAVLC
 >- extended：进阶画质。支持I/P/B/SP/SI 帧，只支持无交错（Progressive）和CAVLC；(用的少) 
 >- main：主流画质。提供I/P/B 帧，支持无交错（Progressive）和交错（Interlaced），也支持CAVLC 和CABAC 的支持
 >- high：高级画质。在main Profile 的基础上增加了8x8内部预测、自定义量化、 无损视频编码和更多的YUV 格式

## 二、码率控制
*   比如一个视频源的码率太高了，有10Mbps，文件太大，想把文件弄小一点，但是又不破坏分辨率   
`ffmpeg -i input.mp4 -b:v 2000k output.mp4` 
  >控制码率有3种选择:   
  >- -minrate
  >- b:v 
  >- -maxrate
  上面把码率从原码率转成2Mbps码率，这样其实也间接让文件变小了。目测接近一半。 不过，ffmpeg官方wiki比较建议，设置b:v时，同时加上 -bufsize -bufsize 用于设置码率控制缓冲器的大小，设置的好处是，让整体的码率更趋近于希望的值，减少波动。（简单来说，比如1 2的平均值是1.5， 1.49 1.51 也是1.5, 当然是第二种比较好）    
  `ffmpeg -i input.mp4 -b:v 2000k -bufsize 2000k output.mp4` 
*   在线视频有时候，希望码率波动，不要超过一个阈值，可以设置maxrate
  `ffmpeg -i input.mp4 -b:v 2000k -bufsize 2000k -maxrate 2500k output.mp4`
  
      

    
