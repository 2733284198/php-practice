[![doodle]][doodle-story]

[doodle]: https://www.google.com/logos/doodles/2016/googles-18th-birthday-5661535679545344-hp2x.gif "Google 18岁啦"
[doodle-story]: https://www.google.com.hk/search?q=Google

## 流媒体、视频编码、直播流测试库
*  2016杭州·云栖大会集锦  
    `
    https://vodcdn.alicdn.com/oss/taobao-ugc/1dde6e764244406cbe5962b26eee078c/1476754829/video.mp4
    `
*  阿里巴巴王坚完整版视频  
    `
    https://vodcdn.alicdn.com/oss/taobao-ugc/e6fb60eae8594f9e812233489bfa2732/1476578718/video.mp4
    `
*  亚太第一卫视(RTMP流)&emsp;`rtmp://v1.one-tv.com/live/mpegts.stream`
*  香港电视台直播&emsp;`rtmp://live.hkstv.hk.lxdns.com/live/hks`
*  亚太卫视&emsp;`rtmp://58.61.150.198/live/Livestream`
*  香港卫视公开的拉流地址&emsp;`rtmp://live.hkstv.hk.lxdns.com/live/hks`
*  香港卫视公开的推流地址&emsp;`rtmp://live.hkstv.hk.lxdns.com/live/tinywan123456`
*  香港卫视公开的推流测试地址&emsp;`rtmp://live.hkstv.hk.lxdns.com/live/tinywan123456`

## 公共脚本库
*  Bootstrap/css&emsp;`http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css`
*  Bootstrap/js&emsp;`http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js`
*  Jquery&emsp;`http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js`
*  Angular&emsp;`http://cdn.static.runoob.com/libs/angular.js/1.4.6/angular.min.js`

## 最新的以ThinkPHP为WEB应用开发提供功能

*  基于角色的RBAC权限管理
*  基于类的无限级分类和数据库的无限级分类
*  非关系性数据库Redis
*  单例模式:针对不同的Redis链接(主从复制)&emsp;`Org/Util/RedisInstance.class.php`
*  存储数据形成消息队列&emsp;`Home/DataBaseController/createRedisList`
*  消息队列元素大于10000时，批量插入到Mysql数据库&emsp;`Home/DataBaseController/RedisSaveToMysql` 
*  读取缓存数据&emsp;`Home/DataBaseController/findDataRedisOrMysql`
*  多级模块化的管理
*  Uploadify图片上传DEMO
*  PHPmailer批量发送邮件&emsp;`Library/EmailController/register`
*  支付宝即时到账接口开发&emsp;`Api/AliPayController/Index`
*  用户注册邮箱激活和邮箱密码修改&emsp;`Library/EmailController/Index`
*  AngularJS 框架&emsp;`Home/AngularJSController`
*  Monolog 日志记录工具&emsp;`Home/MonoLogController` 
*  ECharts 统计工具&emsp;`Home/EChartsController`
*  PDO预处理&emsp;`Home/DataBaseController/pdoExample1` 
*  Socket 服务器框架GatewayWorker&emsp;`Home/GatewayWorker` 
*  WebSocket&emsp;`HTML5/WebSocketController` 
*  PHP-FFmpeg&emsp;`Home/FFmpegController`  
*  数据依赖缓存Cache(Yii2.0文件依赖思想)&emsp;`Home/CacheController` 
*  __E=mc__

## 视频播放插件
*  Sewise&emsp;`HTML5/SewiseController/Index`  
*  JPlayer&emsp;`HTML5/JPlayerController/Index`  
*  Jwplayer&emsp;`HTML5/JwplayerController/Index`  
*  SwfObject&emsp;`HTML5/SwfObjectController/Index` :&emsp;播放RTMP流：1~2S之内
*  Video&emsp;`HTML5/VideoController/Index`  
*  VideoJS&emsp;`HTML5/VideoJSController/Index`:&emsp;`播放RTMP流：3~5S之内

## VideoJs播放插件播放一个RTMP视频流
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


