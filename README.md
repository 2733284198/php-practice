## 简介

ThinkPHP 是一个免费开源的，快速、简单的面向对象的 轻量级PHP开发框架。

## What is he thinking about?
![Tinywan](https://camo.githubusercontent.com/9e32acff11b04496eb14e09b198fcbb055c9ccf0/68747470733a2f2f646e67356c33717a7265616c362e636c6f756466726f6e742e6e65742f323031362f4175672f636f64696e675f626f6172645f736d616c6c2d313437303836363336393131382e6a7067)

## Github个人主页

[Github地址] : https://tinywan.github.io/<br>
[Yii2] :<br> [![Yii2] (https://img.shields.io/badge/Powered_by-Yii_Framework-green.svg?style=flat)](http://www.yiiframework.com/)

## 详细说明文档请见个人博客

[博客地址] : http://www.cnblogs.com/tinywan/

## 公共视频测试库
*  2016杭州·云栖大会集锦:<br>https://vodcdn.alicdn.com/oss/taobao-ugc/1dde6e764244406cbe5962b26eee078c/1476754829/video.mp4
*  阿里巴巴王坚完整版视频:<br>https://vodcdn.alicdn.com/oss/taobao-ugc/e6fb60eae8594f9e812233489bfa2732/1476578718/video.mp4

## 公共脚本库
*  bootstrap/css:<br>http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css
*  bootstrap/js:<br>http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js
*  jquery:<br>http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js

## 全面的WEB开发特性支持

最新的以ThinkPHP为WEB应用开发提供功能有以下，包括：

*  基于角色的RBAC权限管理【实例】
*  基于类的无限级分类和数据库的无限级分类【实例】
*  非关系性数据库Redis
 *  单例模式 【Org/Util/RedisInstance.class.php】针对不同的Redis链接(主从复制)
 *  高并发简单解决方案
        * 存储数据形成消息队列 【Home模块/DataBaseController/createRedisList】
        * 消息队列元素大于10000时，批量插入到Mysql数据库 【Home模块/DataBaseController/RedisSaveToMysql】 
        * 读取缓存数据 【Home模块/DataBaseController/findDataRedisOrMysql】
*  多级模块化的管理【实例】
*  Uploadify图片上传DEMO【实例】
*  phpmailer批量发送邮件DEMO【Library模块/Index控制器/send_email方法】
*  支付宝即时到账接口开发DEMO【Api模块/AliPay控制器/Index方法】
*  用户注册邮箱激活和邮箱密码修改DEMO【Library模块/Email控制器/Index方法】
*  视频播放插件Video【HTML5模块/Video控制器/Index方法】
*  视频播放插件Sewise【HTML5模块/Sewise控制器/Index方法】<br>
     (1)支持多种视频格式，如mp4、m3u8、oga、webm、theora、flv、f4v等。<br>
     (2)支持多种协议直播流，如rtmp、hls、http等。
*  视频播放插件Jwplayer【HTML5模块/Jwplayer控制器/Index方法】     
*  通过定界符修改配置文件信息,可以拿配置文件存储一些不常修改的数据,列如一下网站配置信息(logo/关键词/版权等等)
*  云平台支持-提供了对新浪SAE平台和百度BAE平台的强力支持，具备“横跨性”和“平滑性”，支持本地化开发和调试以及部署切换，让你轻松过渡，打造全新的开发体验。
*  CLI支持-支持基于命令行的应用开发
*  RPC支持-提供包括PHPRpc、HProse、jsonRPC和Yar在内远程调用解决方案
*  MongoDb支持-提供NoSQL的支持
*  缓存支持-提供了包括文件、数据库、Memcache、Xcache、Redis等多种类型的缓存支持
      
## 大道至简的开发理念

ThinkPHP从诞生以来一直秉承大道至简的开发理念，无论从底层实现还是应用开发，我们都倡导用最少的代码完成相同的功能，正是由于对简单的执着和代码的修炼，让我们长期保持出色的性能和极速的开发体验。在主流PHP开发框架的评测数据中表现卓越，简单和快速开发是我们不变的宗旨。

## 安全性

框架在系统层面提供了众多的安全特性，确保你的网站和产品安全无忧。这些特性包括：

*  XSS安全防护
*  表单自动验证
*  强制数据类型转换
*  输入数据过滤
*  表单令牌验证
*  防SQL注入
*  图像上传检测

## 编辑格式
【标题】：
#一级标题  
##二级标题  
###三级标题  
####四级标题  
#####五级标题  
######六级标题 

【普通文本】：

这是一段普通的文本，  
直接回车不能换行，<br>  
要使用\<br>

【多行文本，多行文本和单行文本异曲同工，只要在每行行首加两个Tab】
欢迎到访  
很高兴见到您  
祝您，早上好，中午好，下午好，晚安 

【部分文字的高亮，如果你想使一段话中部分文字高亮显示，来起到突出强调的作用，那么可以把它用 `  ` 包围起来】

【此外还有二级圆点和三级圆点，就是多加一个Tab】：
Thank `You` . Please `Call` Me `Tinywan`

* 编程语言
    * 脚本语言  
        * Python 
        * Python 
        * Python 


【缩进】：
>数据结构  
>>树  
>>>二叉树  
>>>>平衡二叉树  
>>>>>满二叉树 


【图片】：
[![baidu]](http://baidu.com)  
[baidu]:http://www.baidu.com/img/bdlogo.gif "百度Logo" 
