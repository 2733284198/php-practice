# FFmpeg参数使用
## 一、H264编码profile和level控制
`ffmpeg -i input.mp4 -profile:v baseline -level 3.0 output.mp4` 
 >profile参数:   
 >- baseline：基本画质。支持I/P 帧，只支持无交错（Progressive）和CAVLC
 >- extended：进阶画质。支持I/P/B/SP/SI 帧，只支持无交错（Progressive）和CAVLC；(用的少) 
 >- main：主流画质。提供I/P/B 帧，支持无交错（Progressive）和交错（Interlaced），也支持CAVLC 和CABAC 的支持
 >- high：高级画质。在main Profile 的基础上增加了8x8内部预测、自定义量化、 无损视频编码和更多的YUV 格式


    
  
      

    
