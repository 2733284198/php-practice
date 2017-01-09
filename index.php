<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2014 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用入口文件

// 检测PHP环境
if(version_compare(PHP_VERSION,'5.3.0','<'))  die('require PHP > 5.3.0 !');

// 开启调试模式 建议开发阶段开启 部署阶段注释或者设为false
define('APP_DEBUG',True);

// 定义应用目录,官方下载的框架文件里面的index.php文件引入其他文件使用的是相对路径，这导致了定时执行的时候引入ThinkPHP.php文件不存在的问题，修改成绝对路径即可
define('APP_PATH',dirname(__FILE__).'/Frontend/');

define("APP_MODE",'cli');

// 引入ThinkPHP入口文件
require dirname(__FILE__).'/ThinkPHP/ThinkPHP.php';



// 亲^_^ 后面不需要任何代码了 就是如此简单
