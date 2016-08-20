<?php
return array(
	//'配置项'=>'配置值'

    /* 数据库设置 */
    'DB_TYPE'               =>  'mysql',     // 数据库类型
    'DB_HOST'               =>  'localhost', // 服务器地址
    'DB_NAME'               =>  'tp5',          // 数据库名
    'DB_USER'               =>  'root',      // 用户名
    'DB_PWD'                =>  '',          // 密码
    'DB_PORT'               =>  '3306',        // 端口
    'DB_PREFIX'             =>  'tour_',    // 数据库表前缀
    'DB_PARAMS'          	=>  array(), // 数据库连接参数
    'DB_DEBUG'  			=>  TRUE, // 数据库调试模式 开启后可以记录SQL日志
    'DB_FIELDS_CACHE'       =>  true,        // 启用字段缓存
    'DB_CHARSET'            =>  'utf8',      // 数据库编码默认采用utf8
    'DB_DEPLOY_TYPE'        =>  0, // 数据库部署方式:0 集中式(单一服务器),1 分布式(主从服务器)
    'DB_RW_SEPARATE'        =>  false,       // 数据库读写是否分离 主从式有效
    'DB_MASTER_NUM'         =>  1, // 读写分离后 主服务器数量
    'DB_SLAVE_NO'           =>  '', // 指定从服务器序号1

    /* Redis Master 设置 */
    'REDIS_MASTER' => array(
        'host' => '127.0.0.1',
        'port' => 6379,
        'auth' => 'mastertestpassword',
    ),
    'REDIS_SLAVE1' => array(
        'host' => '127.0.0.1',
        'port' => 6000,
        'auth' => '',
    ),
    'REDIS_SLAVE2' => array(
    'host' => '127.0.0.1',
    'port' => 6001,
    'auth' => '',
    ),

    // 显示页面Trace信息
    'SHOW_PAGE_TRACE' =>true,
    // 自定义显示模块
    'TRACE_PAGE_TABS'=>array(
        'base'=>'基本',
        'file'=>'文件',
        'think'=>'流程',
        'error'=>'错误',
        'sql'=>'SQL',
        'debug'=>'调试',
        'user' =>'用户信息'
    ),
    //如果不希望保存所有的选项卡的信息，可以设置需要保存的选项卡，例如：
    'PAGE_TRACE_SAVE' => array('base','file','sql'),

    //静态规则定义
    'HTML_CACHE_ON'     =>    false, // 开启静态缓存
    'HTML_CACHE_TIME'   =>    60,   // 全局静态缓存有效期（秒）
    'HTML_FILE_SUFFIX'  =>    '.shtml', // 设置静态缓存文件后缀
    'HTML_CACHE_RULES'  =>     array(  // 定义静态缓存规则
        // 定义格式1 数组方式
        '静态地址'    =>     array('静态规则', '有效期', '附加规则'),
        // 定义格式2 字符串方式
        '静态地址'    =>     '静态规则',
    ),

    //========设置访问列表===============允许访问列表======================无法加载控制器:Auth和默认模块
    //'MODULE_ALLOW_LIST'    =>    array('Home','Admin','User'),

    //=======================默认访问的模块=================================
    //'DEFAULT_MODULE'       =>    'Home',

    // 设置禁止访问的模块列表
    /**
     * Auth 直接是访问不了的，只能通过主模块去调用
     */
    //'MODULE_DENY_LIST'      =>  array('Common','Runtime','Api','Auth'),

    // 多个伪静态后缀设置 用|分割
    'URL_HTML_SUFFIX' => 'jsp|html|shtml|xml',

    // URL禁止访问的后缀设置
    'URL_DENY_SUFFIX' => 'pdf|ico|png|gif|jpg',

    //错误页面
    'TMPL_ACTION_FILE' => __ROOT__.'/Public/error/exception.tpl',




    //======================================图片上传配置=========================
    'UPLOAD_MAX_SIZE' => 2000000, //最大上传大小
    'UPLOAD_PATH' => './Uploads/', //文件上传保存路径
    //'UPLOAD_PATH' => './', //文件上传保存路径
    'UPLOAD_EXTS' => array('jpg','jpeg','gif','png'),

    //***********************************融云开发设置**********************************
    'RONG_IS_DEV'            => true,//是否是在开发中
    'RONG_DEV_APP_KEY'       => 'qd46yzrf448if', //融云开发环境下的key       仅供测试使用
    'RONG_DEV_APP_SECRET'    => 'XE7BLIezTlIdU', //融云开发环境下的SECRET     仅供测试使用
    'GEETEST_ID'             => '034b9cc862456adf05398821cefc94eb',//极验id  仅供测试使用
    'GEETEST_KEY'            => 'b7f064b9ae813699de794303f0b0e76f',//极验key 仅供测试使用
    'RONG_PRO_APP_KEY'       => '', //融云生产环境下的key
    'RONG_PRO_APP_SECRET'    => '', //融云生产环境下的SECRET
    'UMENG_IOS_APP_KEY'      => '', //友盟ios AppKey
    'UMENG_IOS_SECRET'       => '', //友盟ios App Master Secret
    'UMENG_ANDROID_APP_KEY'  => '', //友盟android AppKey
    'UMENG_ANDROID_SECRET'   => '', //友盟android App Master Secret
    'RONGLIAN_ACCOUNT_SID'   => '', //容联云通讯 主账号 accountSid
    'RONGLIAN_ACCOUNT_TOKEN' => '', //容联云通讯 主账号token accountToken
    'RONGLIAN_APPID'         => '', //容联云通讯 应用Id appid
    'RONGLIAN_TEMPLATE_ID'   => '', //容联云通讯 模板Id

);
