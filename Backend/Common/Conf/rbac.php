<?php
 return array (
  //**********************************RBAC 配置信息 ***********************************
     'SESSION_AUTO_START'=>true,
     'RBAC_SUPERADMIN'   => 'admin',        // 超级管理员,不需要认证
     'ADMIN_AUTH_KEY'    => 'administrator', // session里有这个管理员不需要认证
     'USER_AUTH_ON'      => true,            // 支持权限检查,是否需要认证
     'USER_AUTH_TYPE'    => 1,               // 默认认证类型 1 登录认证 2 实时认证

     'USER_AUTH_KEY'     => 'authId',        // 用户认证SESSION标记
     'ADMINISTRATOR'     => 'admin',
     'USER_AUTH_MODEL'   => 'User',          // 默认验证数据表模型
     'AUTH_PWD_ENCODER'  => 'md5',           // 用户认证密码加密方式
     'USER_AUTH_GATEWAY' => '/Public/login', // 默认认证网关
     'NOT_AUTH_MODULE'   => 'Index,Login',        // 默认无需认证模块
     'REQUIRE_AUTH_MODULE' => 'Category,File,Product,Rbac,System',            // 默认需要认证模块
     'NOT_AUTH_ACTION'   => '',              // 默认无需认证作
     'REQUIRE_AUTH_ACTION' => '',            // 默认需要认证操作
     'GUEST_AUTH_ON'     => false,           // 是否开启游客授权访问
     'GUEST_AUTH_ID'     => 0,               // 游客的用户ID
     'RBAC_ERROR_PAGE'   => '/thinkphp/Public/error404.html',   //错误页面
     'RBAC_ROLE_TABLE'   =>  'tour_admin_role',            //角色表名称
     'RBAC_USER_TABLE'   =>  'tour_admin_role_user',       //用户表名称
     'RBAC_ACCESS_TABLE' =>  'tour_admin_access',          //权限表名称
     'RBAC_NODE_TABLE'   =>  'tour_admin_node',            //节点表名称

 );
?>