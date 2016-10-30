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

/**
 * 绑定Home模块到当前入口文件(3.2.1以上版本写法)
 * old：http://serverName/index.php/Home/Index/index
 * new：http://serverName/home.php/Index/index
 */
//define('BIND_MODULE','Home');


/**
 * 绑定Index控制器到当前入口文件(3.2.1以上版本写法)
 * old：http://serverName/index.php/Home/Index/index
 * new：http://serverName/home.php/index
 */
//define('BIND_CONTROLLER','Index');
//php-cli http://www.thinkphp.cn/topic/34761.html

// 定义应用目录
define('APP_PATH',dirname(__FILE__).'/Backend/');

// 引入ThinkPHP入口文件
require dirname( __FILE__).'/ThinkPHP/ThinkPHP.php';
