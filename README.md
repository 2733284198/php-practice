[![Tinywan](https://img.shields.io/badge/Tinywan-PHP__Experience-ff69b4.svg)](http://www.cnblogs.com/tinywan/)
[![GitHub stars](https://img.shields.io/github/stars/badges/shields.svg?style=social&label=Star)]()
![image](https://github.com/Tinywan/PHP_Experience/blob/master/Public/Common/static/email_google.png)   
![image](https://github.com/Tinywan/PHP_Experience/blob/master/Public/Common/static/yinzhang.png)
# Work experience based on ThinkPhp framework
**&nbsp;&nbsp;&nbsp;&nbsp;主要有视频播放器插件、阿里云OSS存储、支付宝即时到账接口、Redis缓存、PHPmailer批量发送邮件、Monolog 日志工具、ECharts图表库、PDO预处理、PHP-FFmpeg、WebSocket、无限级分类、RBAC、AngularJS等等**
- - -
![image](https://github.com/Tinywan/PHP_Experience/blob/master/Public/GitHub/Images/readme2.jpg)

## 流媒体、视频编码、直播流测试库
*  2016杭州·云栖大会集锦  
    - `
    https://vodcdn.alicdn.com/oss/taobao-ugc/1dde6e764244406cbe5962b26eee078c/1476754829/video.mp4
    `
*  阿里巴巴王坚完整版视频  
    - `
    https://vodcdn.alicdn.com/oss/taobao-ugc/e6fb60eae8594f9e812233489bfa2732/1476578718/video.mp4
    `
*  RTMP协议直播源&emsp;<br/>
    - 亚太第一卫视(RTMP流)&emsp;`rtmp://v1.one-tv.com/live/mpegts.stream`
    - 香港电视台直播&emsp;`rtmp://live.hkstv.hk.lxdns.com/live/hks`
    - 亚太卫视&emsp;`rtmp://58.61.150.198/live/Livestream`
    - 香港卫视公开的拉流地址&emsp;`rtmp://live.hkstv.hk.lxdns.com/live/hks`
    - 香港卫视公开的推流地址&emsp;`rtmp://live.hkstv.hk.lxdns.com/live/tinywan123456`
    - 香港卫视公开的推流测试地址&emsp;`rtmp://live.hkstv.hk.lxdns.com/live/tinywan123456`
*  RTSP协议直播源&emsp;
    - `rtsp://184.72.239.149/vod/mp4://BigBuckBunny_175k.mov`
*  HTTP协议直播源&emsp;
    - 香港卫视&emsp;`http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8`
    - CCTV1高清&emsp;`http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8`
    - CCTV5高清&emsp;`http://ivi.bupt.edu.cn/hls/cctv5hd.m3u8`
    - 杭康&emsp;`http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8`
    
## FFmpeg录制、转换以及流化音视频的解决方案
*  [更多FFmpeg 命令相关文档](https://github.com/Tinywan/PHP_Experience/blob/master/FFmpeg/ffmpeg_command.md)
*  将网络直播源(RTMP流)拉取到内网(本地文件)，切片成m3u8+ts
    - `ffmpeg -i rtmp://live.hkstv.hk.lxdns.com/live/hks -f hls -hls_list_size 5 -hls_time 10 -hls_wrap 10 ./live.m3u8`
*  将本地摄像头RTSP流拉取到公网RTMP流(默认使用UDP协议传送)
    - `ffmpeg -i rtsp://192.168.18.240:554/onvif/live/1 -c:a copy -c:v libx264 -f flv "rtmp://公网IP地址/live/tinywan123"`
*  将本地摄像头RTSP流拉取到公网RTMP流(TCP协议传送)
    - `ffmpeg -rtsp_transport tcp -i rtsp://admin:12345@192.168.18.252:554/h264/ch1/main/av_stream -c:a copy -c:v libx264 -f flv rtmp://公网IP地址/live/tinywan123`
*  将rtmp流，以文件的形势保存到本地
    - `ffmpeg -i "rtmp://tinywan.www.com/live123/4008899 live=1" -acodec copy -vcodec copy -f flv -y F:\Tinywan\Video\RTMPtest2test.flv`
*  列出本机的设备
    - `ffmpeg -list_devices true -f dshow -i dummy`
*  FFmpeg进行笔记本摄像头+麦克风实现流媒体直播服务
    - `ffmpeg -f dshow -i video="Lenovo EasyCamera":audio="麦克风 (Realtek High Definition Audio)" -vcodec libx264 -acodec copy -preset:v ultrafast -tune:v zerolatency -f flv "rtmp://aitech.com/live/tinywan123"`
*  将本地摄像头RTSP流拉取到公网EasyDarwin流媒体服务器,播放RTSP流(TCP协议传送)
    - 推流模式：`ffmpeg -i "rtsp://192.168.18.240:554/onvif/live/1" -vcodec copy -acodec copy  -rtsp_transport tcp -f rtsp "rtsp://114.55.107.180:10554/tinywan123.sdp"`
    - 播放地址：`rtsp://114.55.107.180:10554/tinywan123.sdp`

## 公共脚本库
*  Bootstrap/css&emsp;`http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css`
*  Bootstrap/js&emsp;`http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js`
*  Jquery&emsp;`http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js`
*  Angular&emsp;`http://cdn.static.runoob.com/libs/angular.js/1.4.6/angular.min.js`

## 最新的以ThinkPHP为WEB应用开发提供功能

- [x] [基于角色的RBAC权限管理](https://github.com/Tinywan/PHP_Experience/blob/master/Backend/Home/Controller/RbacController.class.php)
- [x] [基于类的无限级分类和数据库的无限级分类](https://github.com/Tinywan/PHP_Experience/blob/master/Backend/Home/Controller/CategoryController.class.php)
- [x] [Redis数据库作为Mysql数据库缓存](https://github.com/Tinywan/PHP_Experience/blob/master/Backend/Home/Controller/RedisCacheController.class.php)
- [x] 基于角色的RBAC权限管理
- [x] 基于类的无限级分类和数据库的无限级分类
- [x] 非关系性数据库Redis
- [x] 存储数据形成消息队列&emsp;`Home/DataBaseController/createRedisList`
- [x] 消息队列元素大于10000时，批量插入到Mysql数据库&emsp;`Home/DataBaseController/RedisSaveToMysql` 
- [x] 读取缓存数据&emsp;`Home/DataBaseController/findDataRedisOrMysql`
- [x] 多级模块化的管理
- [x] Uploadify图片上传DEMO
- [x] [PHPmailer批量发送邮件](https://github.com/Tinywan/PHP_Experience/blob/master/Backend/Library/Controller/EmailController.class.php)
    - [x] PHP 命令行模式
    - [x] PHP+Mysql 模拟队列发送邮件
- [x] 支付宝即时到账接口开发&emsp;`Api/AliPayController/Index`
- [x] 用户注册邮箱激活和邮箱密码修改&emsp;`Library/EmailController/Index`
- [x] AngularJS 框架&emsp;`Home/AngularJSController`
- [x] Monolog 日志记录工具&emsp;`Home/MonoLogController` 
- [x] ECharts 统计工具&emsp;`Home/EChartsController`
- [x] PDO 数据库抽象层&emsp;`Home/DataBaseController/pdoExample1`
    - [x] 陷阱
        > PDO::PARAM_INT,PDOStatement::bindParam的一个陷阱    
        `Home/DataBaseController/PDOStatementBindParam2`
    - [ ] 优化
- [x] Socket 服务器框架GatewayWorker&emsp;`Home/GatewayWorker` 
- [x] WebSocket&emsp;`HTML5/WebSocketController` 
- [x] [PHP-FFmpeg视频编码处理](https://github.com/Tinywan/PHP_Experience/blob/master/Backend/Home/Controller/FFmpegController.class.php)
    - [x] 读取视频、设置视频大小 
    - [x] 视频编码h264 
    - [x] 获取一个视频的时长、宽度、高度等基本信息 
    - [x] MP4格式=>MP3格式转换 
    - [x] 提取单张、多张图像 
    - [x] 视频剪切 
    - [x] 转码进度实时监控
    - [ ] 提取GIF动画图像
    - [ ] 视频旋转到给定的角度
    - [ ] 视频水印
- [x] 数据依赖缓存Cache(Yii2.0文件依赖思想)&emsp;`Home/CacheController` 
- [x] Intervention Image 基本用法&emsp;`Home/ImageController` 
- [x] Faker生成测试数据的PHP库&emsp;`Home/FakerController`
- [x] 一个简单的APi接口签名方法&emsp;`Home/SignEncryptController`
- [x] Mobile_Detect是一个轻量级的PHP类,用于检测移动设备&emsp;`Home/MobileController`
- [ ]  __E=mc__
- [X] PHP标准的HTML过滤器: `Home/HtmlController/complexFilter`   
- [ ] PHP GitHub API 2.0

## 常用单利模式调用
- [x] Redis单利模式：`RedisInstance::Instance`
- [x] PDO单利模式：`PDOInstance::Instance`
- [x] OSS单利模式：`OssInstance::Instance`
- [x] MonoLog单利模式：`MonoLogInstance::Instance`

## 支付功能
*   支付宝支付
    - [x] 即时到帐
    - [ ] 手机网站
    - [ ] 移动支付
    - [ ] 订单查询
    - [ ] 退款
    - [ ] 转款
*   微信支付
    - [ ] APP支付
    - [ ] 公众号支付
    - [ ] 扫码支付 

## 视频播放插件
播放器 | 代码路径| RTMP延迟| HLS延迟| FLV延迟| 描述
------------ | -------------| -------------| -------------| -------------| -------------
Sewise | HTML5/SewiseController/Index| 20s | 30s | 20s| ~
JPlayer | HTML5/JPlayerController/Index| 15s | 30s | 20s| ~
Jwplayer | HTML5/JwplayerController/Index| 15s | 30s | 20s| ~
SwfObject | HTML5/SwfObjectController/Index| 1~2S | 30s | 20s| 推荐
Video | HTML5/VideoController/Index| 15s | 30s | 20s| ~
VideoJS | HTML5/VideoJSController/Index| 3~5S | 30s | 20s| 推荐

## Google
[![doodle]][doodle-story]

[doodle]: https://www.google.com/logos/doodles/2016/googles-18th-birthday-5661535679545344-hp2x.gif "Google 18岁啦"
[doodle-story]: https://www.google.com.hk/search?q=Google

## VideoJs插件播放一个RTMP视频流
```
 <link href="__PUBLIC__/lib/video-js/video-js.css" rel="stylesheet">
 <script src="__PUBLIC__/lib/video-js/video.js"></script>
 <script>
     videojs.options.flash.swf = "__PUBLIC__/lib/video-js/video-js.swf"
 </script>
 <video 
    id="livestream" 
    class="video-js vjs-default-skin vjs-big-play-centered"
    controls autoplay preload="auto" width="1280" height="720"
    data-setup='{"example_option":true}'>
    <source src="rtmp://live.hkstv.hk.lxdns.com/live/hks" type="rtmp/mp4"></source>
 </video>
```
## 常用Shell脚本
*  凌晨备份昨天的日志,放在该日期的月份目录下面,同时以昨天的时间为后缀名  
    `Shell文件夹/Logs文件夹/auto_backup_logs_del_current.sh`  
*  RTMP模块的分发服务器分发本地流到各个节点服务器上去  
    `Shell文件夹/Logs文件夹/auto_backup_logs_del_current.sh`  
*  每隔10分钟把每个活动对应的评论和礼物数量同步到MySQL数据库中去  
    `Shell文件夹/Redis文件夹/comment_redis_pdo.sh`
*  每隔10分钟把每个活动对应的评论和礼物数量同步到MySQL数据库中去  
    `Shell文件夹/Redis文件夹/comment_redis_pdo.sh`   
*  Nginx RTMP录像自动上传到阿里云oss存储  
    `Shell文件夹/Rtmp文件夹/rtmpRecordedNotify.sh` 

## What is he thinking about?
![Tinywan](https://raw.githubusercontent.com/docker/dockercraft/master/docs/img/contribute.png)

## Git工作流指南：Gitflow工作流
![Tinywan](https://github.com/Tinywan/PHP_Experience/blob/master/Public/Common/static/images/git-workflow-release.png)

