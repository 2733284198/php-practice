<?php
return array(
    //*************************************附加设置***********************************
    'LOAD_EXT_CONFIG' => 'db,redis,logs',    // 加载扩展配置文件

    //*************************************附加设置***********************************

    //***********************************URL设置**************************************
    'MODULE_ALLOW_LIST'      => array('Home','Admin','Api','User','App'), //允许访问列表
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

    //**********************************RBAC 配置信息 ***********************************
    'SESSION_AUTO_START'=>true,
    'USER_AUTH_ON'      => true,            // 支持权限检查,是否需要认证
    'USER_AUTH_TYPE'    => 1,               // 默认认证类型 1 登录认证 2 实时认证
    'RBAC_SUPERADMIN'   => 'admin',        // 超级管理员,不需要认证
    'USER_AUTH_KEY'     => 'authId',        // 用户认证SESSION标记
    'ADMIN_AUTH_KEY'    => 'administrator', // session里有这个管理员不需要认证
    'ADMINISTRATOR'     => 'admin',
    'USER_AUTH_MODEL'   => 'User',          // 默认验证数据表模型
    'AUTH_PWD_ENCODER'  => 'md5',           // 用户认证密码加密方式
    'USER_AUTH_GATEWAY' => '/Public/login', // 默认认证网关
    'NOT_AUTH_MODULE'   => 'Public,Login',        // 默认无需认证模块
    'REQUIRE_AUTH_MODULE' => 'System,SystemControl,Share,DataManage',            // 默认需要认证模块
    'NOT_AUTH_ACTION'   => '',              // 默认无需认证操作
    'REQUIRE_AUTH_ACTION' => '',            // 默认需要认证操作
    'GUEST_AUTH_ON'     => false,           // 是否开启游客授权访问
    'GUEST_AUTH_ID'     => 0,               // 游客的用户ID
    'RBAC_ERROR_PAGE'   => '/thinkphp/Public/error404.html',   //错误页面
    'RBAC_ROLE_TABLE'   =>  'tour_admin_role',            //角色表名称
    'RBAC_USER_TABLE'   =>  'tour_admin_role_user',       //用户表名称
    'RBAC_ACCESS_TABLE' =>  'tour_admin_access',          //权限表名称
    'RBAC_NODE_TABLE'   =>  'tour_admin_node',            //节点表名称



);
