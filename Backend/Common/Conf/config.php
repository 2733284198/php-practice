<?php
return array(
    //*************************************附加设置***********************************
    'LOAD_EXT_CONFIG' => 'db,redis,logs,rbac',    // 加载扩展配置文件
    'URL_CASE_INSENSITIVE'  =>  True,  // URL区分大小写

    //*************************************附加设置***********************************

    //***********************************URL设置**************************************
    'MODULE_ALLOW_LIST'      => array('Home','Admin','Api','User','App','WeChat','Library','Html5'), //允许访问列表
    'URL_MODEL'              => 1,  //启用rewrite
    'HTML_CACHE_ON'     =>    false, // 开启静态缓存
    'HTML_CACHE_TIME'   =>    60,   // 全局静态缓存有效期（秒）
    'HTML_FILE_SUFFIX'  =>    '.shtml', // 设置静态缓存文件后缀
    'HTML_CACHE_RULES'  =>     array(  // 定义静态缓存规则
        // 定义格式1 数组方式
        '静态地址'    =>     array('静态规则', '有效期', '附加规则'),
        // 定义格式2 字符串方式
        '静态地址'    =>     '静态规则',
    ),
    'URL_HTML_SUFFIX' => 'jsp|html|shtml|xml',   // 多个伪静态后缀设置 用|分割
    'URL_DENY_SUFFIX' => 'pdf|ico|png|gif|jpg',  // URL禁止访问的后缀设置

    //***********************************SESSION设置**********************************
    'SESSION_OPTIONS'        => array(
        'name'               => 'TINYWANADMIN',//设置session名
        'expire'             => 24*3600*15, //SESSION保存15天
        'use_trans_sid'      => 1,//跨页传递
        'use_only_cookies'   => 0,//是否只开启基于cookies的session的会话方式
    ),

    //***********************************页面设置**************************************
    //'TMPL_EXCEPTION_FILE'    => APP_DEBUG ? THINK_PATH.'Tpl/think_exception.tpl' : './Template/default/Home/Public/404.html',
    //'TMPL_ACTION_ERROR'      => TMPL_PATH.'/Public/dispatch_jump.tpl', // 默认错误跳转对应的模板文件
    //'TMPL_ACTION_SUCCESS'    => TMPL_PATH.'/Public/dispatch_jump.tpl', // 默认成功跳转对应的模板文件

    //*************************************显示页面Trace信息***************************
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


    //========设置访问列表===============允许访问列表======================无法加载控制器:Auth和默认模块
    //'MODULE_ALLOW_LIST'    =>    array('Home','Admin','User'),

    //=======================默认访问的模块=================================
    //'DEFAULT_MODULE'       =>    'Home',

    // 设置禁止访问的模块列表
    /**
     * Auth 直接是访问不了的，只能通过主模块去调用
     */
    //'MODULE_DENY_LIST'      =>  array('Common','Runtime','Api','Auth'),



    //错误页面
    //'TMPL_ACTION_FILE' => __ROOT__.'/Public/error/exception.tpl',




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

    //***********************************定义一下在html中就直接可以使用的路径**********************************
    'TMPL_PARSE_STRING'      => array(    // 定义常用路径
        '__PUBLIC__'         => __ROOT__.'/Public',
        '__PUBLIC__'         => __ROOT__.'/Public',
        '__HOME_CSS__'       => __ROOT__.trim(TMPL_PATH,'.').'Home/Public/css',
        '__HOME_JS__'        => __ROOT__.trim(TMPL_PATH,'.').'Home/Public/js',
        '__HOME_IMAGES__'    => __ROOT__.trim(TMPL_PATH,'.').'Home/Public/images',
        '__ADMIN_CSS__'      => __ROOT__.trim(TMPL_PATH,'.').'Admin/Public/css',
        '__ADMIN_JS__'       => __ROOT__.trim(TMPL_PATH,'.').'Admin/Public/js',
        '__ADMIN_IMAGES__'   => __ROOT__.trim(TMPL_PATH,'.').'Admin/Public/images',
        '__ADMIN_ACEADMIN__' => __ROOT__.trim(TMPL_PATH,'.').'Admin/Public/aceadmin',
        '__PUBLIC_CSS__'     => __ROOT__.trim(TMPL_PATH,'.').'Public/css',
        '__PUBLIC_JS__'      => __ROOT__.trim(TMPL_PATH,'.').'Public/js',
        '__PUBLIC_IMAGES__'  => __ROOT__.trim(TMPL_PATH,'.').'Public/images',
        '__USER_CSS__'       => __ROOT__.trim(TMPL_PATH,'.').'User/Public/css',
        '__USER_JS__'        => __ROOT__.trim(TMPL_PATH,'.').'User/Public/js',
        '__USER_IMAGES__'    => __ROOT__.trim(TMPL_PATH,'.').'User/Public/images',
        '__APP_CSS__'        => __ROOT__.trim(TMPL_PATH,'.').'App/Public/css',
        '__APP_JS__'         => __ROOT__.trim(TMPL_PATH,'.').'App/Public/js',
        '__APP_IMAGES__'     => __ROOT__.trim(TMPL_PATH,'.').'App/Public/images'
    ),

    /************************************************************************************************************
     *          阿里云OSS存储配置信息
     *************************************************************************************************************/
    'OSS_CONFIG'          => array(
        'accessKeyId'        => 'gyPMyJ8Tn5pTRmx0', // 阿里云oss key_id
        'accessKeySecret'    => 'SSyqdcAwkBsvlCD6Ka22jPxwYYrLGx', // 阿里云oss key_secret
        'endpoint'           => 'oss-cn-shanghai.aliyuncs.com', // 阿里云oss endpoint
        'BUCKET'             => 'tinywan01'  // bucken 名称
    ),
);
