<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>物联网智能数据平台</title>

    <meta name="description" content="overview &amp; stats" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- basic styles -->

    <link href="/PHP_Experience/Public/Backend/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="/PHP_Experience/Public/Backend/css/font-awesome.min.css" />

    <!--[if IE 7]>
    <link rel="stylesheet" href="/PHP_Experience/Public/Backend/css/font-awesome-ie7.min.css" />
    <![endif]-->

    <!-- page specific plugin styles -->

    <!-- fonts -->

    <link rel="stylesheet" href="/PHP_Experience/Public/Backend/css/ace-fonts.css" />

    <!-- ace styles -->

    <link rel="stylesheet" href="/PHP_Experience/Public/Backend/css/ace.min.css" />
    <link rel="stylesheet" href="/PHP_Experience/Public/Backend/css/ace-rtl.min.css" />
    <link rel="stylesheet" href="/PHP_Experience/Public/Backend/css/ace-skins.min.css" />

    <!--[if lte IE 8]>
    <link rel="stylesheet" href="/PHP_Experience/Public/Backend/css/ace-ie.min.css" />
    <![endif]-->

    <!-- inline styles related to this page -->

    <!-- ace settings handler -->

    <script src="/PHP_Experience/Public/Backend/js/ace-extra.min.js"></script>
    <script type="text/javascript">
        window.jQuery || document.write("<script src='/PHP_Experience/Public/Backend/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
    </script>
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

    <!--[if lt IE 9]>
    <script src="/PHP_Experience/Public/Backend/js/html5shiv.js"></script>
    <script src="/PHP_Experience/Public/Backend/js/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="navbar navbar-default" id="navbar">
    <script type="text/javascript">
        try{ace.settings.check('navbar' , 'fixed')}catch(e){}
    </script>

    <div class="navbar-container" id="navbar-container">
        <div class="navbar-header pull-left">
            <a href="<?php echo U('Home/Index/index');?>" class="navbar-brand">
                <small>
                    <i class="icon-leaf"></i>
                    物联网智能数据平台
                </small>
            </a><!-- /.brand -->
        </div><!-- /.navbar-header -->

        <div class="navbar-header pull-right" role="navigation">
            <ul class="nav ace-nav">
                <li class="grey">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <i class="icon-tasks"></i>
                        <span class="badge badge-grey">4</span>
                    </a>

                    <ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
                        <li class="dropdown-header">
                            <i class="icon-ok"></i>
                            4 Tasks to complete
                        </li>

                        <li>
                            <a href="#">
                                <div class="clearfix">
                                    <span class="pull-left">Software Update</span>
                                    <span class="pull-right">65%</span>
                                </div>

                                <div class="progress progress-mini ">
                                    <div style="width:65%" class="progress-bar "></div>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <div class="clearfix">
                                    <span class="pull-left">Hardware Upgrade</span>
                                    <span class="pull-right">35%</span>
                                </div>

                                <div class="progress progress-mini ">
                                    <div style="width:35%" class="progress-bar progress-bar-danger"></div>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <div class="clearfix">
                                    <span class="pull-left">Unit Testing</span>
                                    <span class="pull-right">15%</span>
                                </div>

                                <div class="progress progress-mini ">
                                    <div style="width:15%" class="progress-bar progress-bar-warning"></div>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <div class="clearfix">
                                    <span class="pull-left">Bug Fixes</span>
                                    <span class="pull-right">90%</span>
                                </div>

                                <div class="progress progress-mini progress-striped active">
                                    <div style="width:90%" class="progress-bar progress-bar-success"></div>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                See tasks with details
                                <i class="icon-arrow-right"></i>
                            </a>
                        </li>
                    </ul>
                </li>

                <li class="purple">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <i class="icon-bell-alt icon-animated-bell"></i>
                        <span class="badge badge-important">8</span>
                    </a>

                    <ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
                        <li class="dropdown-header">
                            <i class="icon-warning-sign"></i>
                            8 Notifications
                        </li>

                        <li>
                            <a href="#">
                                <div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-pink icon-comment"></i>
												New Comments
											</span>
                                    <span class="pull-right badge badge-info">+12</span>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <i class="btn btn-xs btn-primary icon-user"></i>
                                Bob just signed up as an editor ...
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-success icon-shopping-cart"></i>
												New Orders
											</span>
                                    <span class="pull-right badge badge-success">+8</span>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-info icon-twitter"></i>
												Followers
											</span>
                                    <span class="pull-right badge badge-info">+11</span>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                See all notifications
                                <i class="icon-arrow-right"></i>
                            </a>
                        </li>
                    </ul>
                </li>

                <li class="green">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                        <i class="icon-envelope icon-animated-vertical"></i>
                        <span class="badge badge-success">5</span>
                    </a>

                    <ul class="pull-right dropdown-navbar dropdown-menu dropdown-caret dropdown-close">
                        <li class="dropdown-header">
                            <i class="icon-envelope-alt"></i>
                            5 Messages
                        </li>

                        <li>
                            <a href="#">
                                <img src="assets/avatars/avatar.png" class="msg-photo" alt="Alex's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Alex:</span>
												Ciao sociis natoque penatibus et auctor ...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>a moment ago</span>
											</span>
										</span>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <img src="assets/avatars/avatar3.png" class="msg-photo" alt="Susan's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Susan:</span>
												Vestibulum id ligula porta felis euismod ...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>20 minutes ago</span>
											</span>
										</span>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <img src="assets/avatars/avatar4.png" class="msg-photo" alt="Bob's Avatar" />
										<span class="msg-body">
											<span class="msg-title">
												<span class="blue">Bob:</span>
												Nullam quis risus eget urna mollis ornare ...
											</span>

											<span class="msg-time">
												<i class="icon-time"></i>
												<span>3:15 pm</span>
											</span>
										</span>
                            </a>
                        </li>

                        <li>
                            <a href="inbox.html">
                                See all messages
                                <i class="icon-arrow-right"></i>
                            </a>
                        </li>
                    </ul>
                </li>

                <li class="light-blue">
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        <img class="nav-user-photo" src="/PHP_Experience/Public/Backend/avatars/user.jpg" alt="Jason's Photo" />
								<span class="user-info">
									<small>欢迎,</small>
									<?php echo (session('username')); ?>
								</span>

                        <i class="icon-caret-down"></i>
                    </a>

                    <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                        <li>
                            <a href="#">
                                <i class="icon-cog"></i>
                                设置
                            </a>
                        </li>

                        <li>
                            <a href="<?php echo U('Home/Member/memberCenter');?>">
                                <i class="icon-user"></i>
                                个人信息
                            </a>
                        </li>

                        <li class="divider"></li>

                        <li>
                            <a href="<?php echo U('Home/Login/logout');?>">
                                <i class="icon-off"></i>
                                退出
                            </a>
                        </li>
                    </ul>
                </li>
            </ul><!-- /.ace-nav -->
        </div><!-- /.navbar-header -->
    </div><!-- /.container -->
</div>
<div class="main-container" id="main-container">
    <script type="text/javascript">
        try{ace.settings.check('main-container' , 'fixed')}catch(e){}
    </script>

    <div class="main-container-inner">
        <a class="menu-toggler" id="menu-toggler" href="#">
            <span class="menu-text"></span>
        </a>

        <div class="sidebar" id="sidebar">
            <script type="text/javascript">
                try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
            </script>

            <div class="sidebar-shortcuts" id="sidebar-shortcuts">
                <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
                    <button class="btn btn-success">
                        <i class="icon-signal"></i>
                    </button>

                    <button class="btn btn-info">
                        <i class="icon-pencil"></i>
                    </button>

                    <button class="btn btn-warning">
                        <i class="icon-group"></i>
                    </button>

                    <button class="btn btn-danger">
                        <i class="icon-cogs"></i>
                    </button>
                </div>

                <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
                    <span class="btn btn-success"></span>

                    <span class="btn btn-info"></span>

                    <span class="btn btn-warning"></span>

                    <span class="btn btn-danger"></span>
                </div>
            </div><!-- #sidebar-shortcuts -->

            <ul class="nav nav-list">
                <?php if(is_array($menus)): $i = 0; $__LIST__ = $menus;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if($vo["menus"] == 1): ?><li>
                            <a href="/PHP_Experience/admin.php/Home/<?php echo ($vo["name"]); ?>/index" class="dropdown-toggle">
                                <i class="<?php echo ($vo["class"]); ?>"></i>
                                <span class="menu-text"><?php echo ($vo["title"]); ?></span>
                                <b class="arrow icon-angle-down"></b>
                            </a>
                            <ul class="submenu">
                                <?php if(is_array($vo['node'])): $i = 0; $__LIST__ = $vo['node'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$sub): $mod = ($i % 2 );++$i; if($sub["menus"] == 1): ?><li><a href="/PHP_Experience/admin.php/Home/<?php echo ($vo["name"]); ?>/<?php echo ($sub["name"]); ?>">
                                            <i class="icon-double-angle-right"></i>
                                            <?php echo ($sub["title"]); ?>
                                        </a>
                                        </li><?php endif; endforeach; endif; else: echo "" ;endif; ?>
                            </ul>
                        </li><?php endif; endforeach; endif; else: echo "" ;endif; ?>
                <li>
                    <a href="#" class="dropdown-toggle">
                        <i class="icon-list"></i>
                        微信模块
                        <b class="arrow icon-angle-down"></b>
                    </a>
                    <ul class="submenu">
                        <li>
                            <a href="/PHP_Experience/admin.php/WeChat/Index/Addons">
                                <i class="icon-desktop"></i>
                                Addons
                            </a>
                        </li>
                        <li>
                            <a href="/PHP_Experience/admin.php/WeChat/Video/VideoTest">
                                <i class="icon-desktop"></i>
                                Video视频
                            </a>
                        </li>

                        <li>
                            <a href="/PHP_Experience/admin.php/WeChat/WorkerMan/WebSocket">
                                <i class="icon-list"></i>
                                WorkerMan
                            </a>
                        </li>

                    </ul>
                </li>
                <li>
                    <a href="#" class="dropdown-toggle">
                        <i class="icon-list"></i>
                        HTML5
                        <b class="arrow icon-angle-down"></b>
                    </a>
                    <ul class="submenu">
                        <li>
                            <a href="/PHP_Experience/admin.php/Html5/Sewise/index">
                                <i class="icon-desktop"></i>
                                Sewise Player
                            </a>
                        </li>
                        <li>
                            <a href="/PHP_Experience/admin.php/Html5/Video/VideoTest">
                                <i class="icon-desktop"></i>
                                Video视频
                            </a>
                        </li>

                        <li>
                            <a href="/PHP_Experience/admin.php/Html5/WorkerMan/WebSocket">
                                <i class="icon-list"></i>
                                WorkerMan
                            </a>
                        </li>

                    </ul>
                </li>
            </ul><!-- /.nav-list -->

            <div class="sidebar-collapse" id="sidebar-collapse">
                <i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
            </div>

            <script type="text/javascript">
                try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
            </script>
        </div>


    <div class="main-content">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try {
                    ace.settings.check('breadcrumbs', 'fixed')
                } catch (e) {
                }
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="icon-home home-icon"></i>
                    <a href="#"> 云系统管理平台</a>
                </li>

                <li>
                    <a href="#">系统基本信息</a>
                </li>
                <li class="active">系统设置</li>
            </ul>
            <!-- .breadcrumb -->

            <div class="nav-search" id="nav-search">
                <form class="form-search">
                <span class="input-icon">
                    <input type="text" placeholder="Search ..." class="nav-search-input" id="nav-search-input"
                           autocomplete="off"/>
                    <i class="icon-search nav-search-icon"></i>
                </span>
                </form>
            </div>
            <!-- #nav-search -->
        </div>

        <div class="page-content">
            <div class="row">
                <div class="col-xs-12">
                    <!-- PAGE CONTENT BEGINS -->

                    <div class="error-container">
                        <div class="well">
                            <h1 class="grey lighter smaller">
											<span class="blue bigger-125">
												<i class="icon-random"></i>
												当前用户
											</span>
                                详细信息
                            </h1>

                            <hr/>
                            <h3 class="lighter smaller">
                                欢迎你的到来
                                <i class="icon-wrench icon-animated-wrench bigger-125"></i>
                                <strong><?php echo ($user["username"]); ?></strong>
                                <span class="badge badge-info"></span>

                            </h3>

                            <div class="space"></div>

                            <div>
                                <h4 class="lighter smaller">登录信息记录:</h4>

                                <ul class="list-unstyled spaced inline bigger-110 margin-15">
                                    <li>
                                        <i class="icon-group blue"></i>
                                        等级:&nbsp;<span class="label label-success arrowed">L<?php echo (exp_to_level($user["expire"])); ?></span>
                                    </li>
                                    <li>
                                        <i class="icon-group blue"></i>
                                        积分:&nbsp;<?php echo ($user["expire"]); ?>
                                    </li>
                                    <li>
                                        <i class="icon-calendar blue"></i>
                                        最后登录:&nbsp;<?php echo (time_format($user["logintime"])); ?>
                                    </li>

                                    <li>
                                        <i class="icon-desktop blue"></i>
                                        最近登录IP地址:<?php echo ($user["loginip"]); ?>
                                    </li>
                                </ul>
                            </div>

                            <hr/>
                            <div class="space"></div>

                        </div>
                    </div>

                    <!-- PAGE CONTENT ENDS -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /.page-content -->
    </div>
    <!-- /.main-content -->


<div class="ace-settings-container" id="ace-settings-container">
    <div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
        <i class="icon-cog bigger-150"></i>
    </div>

    <div class="ace-settings-box" id="ace-settings-box">
        <div>
            <div class="pull-left">
                <select id="skin-colorpicker" class="hide">
                    <option data-skin="default" value="#438EB9">#438EB9</option>
                    <option data-skin="skin-1" value="#222A2D">#222A2D</option>
                    <option data-skin="skin-2" value="#C6487E">#C6487E</option>
                    <option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
                </select>
            </div>
            <span>&nbsp; Choose Skin</span>
        </div>

        <div>
            <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
            <label class="lbl" for="ace-settings-navbar"> Fixed Navbar</label>
        </div>

        <div>
            <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
            <label class="lbl" for="ace-settings-sidebar"> Fixed Sidebar</label>
        </div>

        <div>
            <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" />
            <label class="lbl" for="ace-settings-breadcrumbs"> Fixed Breadcrumbs</label>
        </div>

        <div>
            <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
            <label class="lbl" for="ace-settings-rtl"> Right To Left (rtl)</label>
        </div>

        <div>
            <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
            <label class="lbl" for="ace-settings-add-container">
                Inside
                <b>.container</b>
            </label>
        </div>
    </div>
</div><!-- /#ace-settings-container -->
</div><!-- /.main-container-inner -->

<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
    <i class="icon-double-angle-up icon-only bigger-110"></i>
</a>
</div><!-- /.main-container -->

<!-- basic scripts -->

<!--[if IE]>


<footer class="footer mt-20">
    <div class="container">
            本后台系统由提供前端技术支持</p>
    </div>
</footer>
<script type="text/javascript">
    window.jQuery || document.write("<script src='/PHP_Experience/Public/Backend/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

<!--[if !IE]> -->

<script type="text/javascript">
    if("ontouchend" in document) document.write("<script src='/PHP_Experience/Public/Backend/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="/PHP_Experience/Public/Backend/js/bootstrap.min.js"></script>
<script src="/PHP_Experience/Public/Backend/js/typeahead-bs2.min.js"></script>
<script src='/PHP_Experience/Public/Backend/js/jquery-2.0.3.min.js'></script>
<!-- ace scripts -->

<script src="/PHP_Experience/Public/Backend/js/ace-elements.min.js"></script>
<script src="/PHP_Experience/Public/Backend/js/ace.min.js"></script>

<!-- inline scripts related to this page -->

<script type="text/javascript">
    jQuery(function($){
        $('#tree1').ace_tree({
            dataSource: treeDataSource ,
            multiSelect:true,
            loadingHTML:'<div class="tree-loading"><i class="icon-refresh icon-spin blue"></i></div>',
            'open-icon' : 'icon-minus',
            'close-icon' : 'icon-plus',
            'selectable' : true,
            'selected-icon' : 'icon-ok',
            'unselected-icon' : 'icon-remove'
        });

        $('#tree2').ace_tree({
            dataSource: treeDataSource2 ,
            loadingHTML:'<div class="tree-loading"><i class="icon-refresh icon-spin blue"></i></div>',
            'open-icon' : 'icon-folder-open',
            'close-icon' : 'icon-folder-close',
            'selectable' : false,
            'selected-icon' : null,
            'unselected-icon' : null
        });
        /**
         $('#tree1').on('loaded', function (evt, data) {
		});

         $('#tree1').on('opened', function (evt, data) {
		});

         $('#tree1').on('closed', function (evt, data) {
		});

         $('#tree1').on('selected', function (evt, data) {
		});
         */
    });
</script>
</body>
</html>