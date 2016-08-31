<?php
header("Content-type:text/html;charset=utf-8");

/**
 * =====================================================================================================================
 * 传递数据以易于阅读的样式格式化后输出
 * @param $data
 * =====================================================================================================================
 */
function p($data)
{
    // 定义样式
    $str = '<pre style="display: block;padding: 9.5px;margin: 44px 0 0 0;font-size: 13px;line-height: 1.42857;color: #333;word-break: break-all;word-wrap: break-word;background-color: #F5F5F5;border: 1px solid #CCC;border-radius: 4px;">';
    // 如果是boolean或者null直接显示文字；否则print
    if (is_bool($data)) {
        $show_data = $data ? 'true' : 'false';
    } elseif (is_null($data)) {
        $show_data = 'null';
    } else {
        $show_data = print_r($data, true);
    }
    $str .= $show_data;
    $str .= '</pre>';
    echo $str;
}

/**
 * ===================================【使用curl获取远程数据】=======================================================
 * 使用curl获取远程数据
 * @param  string $url url连接
 * @return string      获取到的数据
 */
function curl_get_contents($url)
{
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);                //设置访问的url地址
    //curl_setopt($ch,CURLOPT_HEADER,1);                //是否显示头部信息
    curl_setopt($ch, CURLOPT_TIMEOUT, 5);               //设置超时
    curl_setopt($ch, CURLOPT_USERAGENT, _USERAGENT_);   //用户访问代理 User-Agent
    curl_setopt($ch, CURLOPT_REFERER, _REFERER_);        //设置 referer
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);          //跟踪301
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);        //返回结果
    $r = curl_exec($ch);
    curl_close($ch);
    return $r;
}

/**
 * =================================【传入时间戳,计算距离现在的时间】=======================================================
 * 传入时间戳,计算距离现在的时间
 * @param  number $time 时间戳
 * @return string       返回多少以前
 * =====================================================================================================================
 */
function word_time($time)
{
    $time = (int)substr($time, 0, 10);
    $int = time() - $time;
    $str = '';
    if ($int <= 2) {
        $str = sprintf('刚刚', $int);
    } elseif ($int < 60) {
        $str = sprintf('%d秒前', $int);
    } elseif ($int < 3600) {
        $str = sprintf('%d分钟前', floor($int / 60));
    } elseif ($int < 86400) {
        $str = sprintf('%d小时前', floor($int / 3600));
    } else {
        $str = date('Y-m-d H:i:s', $time);
    }
    return $str;
}

/**
 * ========================================【关于文件、图片，上传】=======================================================
 * ======================生成缩略图
 * @param  string $image_path 原图path
 * @param  integer $width 缩略图的宽
 * @param  integer $height 缩略图的高
 * @return string             缩略图path
 */
function crop_image($image_path, $width = 170, $height = 170)
{
    $image_path = trim($image_path, '.');
    $min_path = '.' . str_replace('.', '_' . $width . '_' . $height . '.', $image_path);
    $image = new \Think\Image();
    $image->open($image_path);
    // 生成一个居中裁剪为$width*$height的缩略图并保存
    $image->thumb($width, $height, \Think\Image::IMAGE_THUMB_CENTER)->save($min_path);
    oss_upload($min_path);
    return $min_path;
}

/**
 * ======================检测webuploader上传是否成功
 * @param  string $file_path post中的字段
 * @return boolear           是否成功
 */
function upload_success($file_path)
{
    // 为兼容传进来的有数组；先转成json
    $file_path = json_encode($file_path);
    // 如果有undefined说明上传失败
    if (strpos($file_path, 'undefined') !== false) {
        return false;
    }
    // 如果没有.符号说明上传失败
    if (strpos($file_path, '.') === false) {
        return false;
    }
    // 否则上传成功则返回true
    return true;
}

//======================================================================================================================

/**
 * ==============================================【访问方式检测】=========================================================
 * 检测是否是手机访问
 */
function is_mobile()
{
    $useragent = isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : '';
    $useragent_commentsblock = preg_match('|\(.*?\)|', $useragent, $matches) > 0 ? $matches[0] : '';
    function _is_mobile($substrs, $text)
    {
        foreach ($substrs as $substr)
            if (false !== strpos($text, $substr)) {
                return true;
            }
        return false;
    }

    $mobile_os_list = array('Google Wireless Transcoder', 'Windows CE', 'WindowsCE', 'Symbian', 'Android', 'armv6l', 'armv5', 'Mobile', 'CentOS', 'mowser', 'AvantGo', 'Opera Mobi', 'J2ME/MIDP', 'Smartphone', 'Go.Web', 'Palm', 'iPAQ');
    $mobile_token_list = array('Profile/MIDP', 'Configuration/CLDC-', '160×160', '176×220', '240×240', '240×320', '320×240', 'UP.Browser', 'UP.Link', 'SymbianOS', 'PalmOS', 'PocketPC', 'SonyEricsson', 'Nokia', 'BlackBerry', 'Vodafone', 'BenQ', 'Novarra-Vision', 'Iris', 'NetFront', 'HTC_', 'Xda_', 'SAMSUNG-SGH', 'Wapaka', 'DoCoMo', 'iPhone', 'iPod');

    $found_mobile = _is_mobile($mobile_os_list, $useragent_commentsblock) ||
        _is_mobile($mobile_token_list, $useragent);
    if ($found_mobile) {
        return true;
    } else {
        return false;
    }
}

//======================================================================================================================


/**
 * ===============================================【安全、转换】==========================================================
 * ===========将路径转换加密
 * @param  string $file_path 路径
 * @return string            转换后的路径
 */
function path_encode($file_path)
{
    return rawurlencode(base64_encode($file_path));
}

/**
 * ===========将路径解密
 * @param  string $file_path 加密后的字符串
 * @return string            解密后的路径
 */
function path_decode($file_path)
{
    return base64_decode(rawurldecode($file_path));
}

//======================================================================================================================

/**
 * ================================================【用户登陆信息】=======================================================
 * 返回用户id
 * @return integer 用户id
 */
function get_uid()
{
    return $_SESSION['user']['id'];
}

/**
 * 检测是否登录
 * @return boolean 是否登录
 */
function check_login()
{
    if (!empty($_SESSION['user']['id'])) {
        return true;
    } else {
        return false;
    }
}

/**
 * 设置验证码
 * @return boolean 是否登录
 */
function show_verify($config = '')
{
    if ($config == '') {
        $config = array(
            'codeSet' => '1234567890',
            'fontSize' => 30,
            'useCurve' => false,
            'imageH' => 60,
            'imageW' => 240,
            'length' => 4,
            'fontttf' => '4.ttf',
        );
    }
    $verify = new \Think\Verify($config);
    return $verify->entry();
}

// 检测验证码
function check_verify($code)
{
    $verify = new \Think\Verify();
    return $verify->check($code);
}

//======================================================================================================================


/**
 * =====================================================================================================================
 * 字符串截取，支持中文和其他编码
 * @param string $str 需要转换的字符串
 * @param string $start 开始位置
 * @param string $length 截取长度
 * @param string $suffix 截断显示字符
 * @param string $charset 编码格式
 * @return string
 * =====================================================================================================================
 */
function re_substr($str, $start = 0, $length, $suffix = true, $charset = "utf-8")
{
    if (function_exists("mb_substr"))
        $slice = mb_substr($str, $start, $length, $charset);
    elseif (function_exists('iconv_substr')) {
        $slice = iconv_substr($str, $start, $length, $charset);
    } else {
        $re['utf-8'] = "/[\x01-\x7f]|[\xc2-\xdf][\x80-\xbf]|[\xe0-\xef][\x80-\xbf]{2}|[\xf0-\xff][\x80-\xbf]{3}/";
        $re['gb2312'] = "/[\x01-\x7f]|[\xb0-\xf7][\xa0-\xfe]/";
        $re['gbk'] = "/[\x01-\x7f]|[\x81-\xfe][\x40-\xfe]/";
        $re['big5'] = "/[\x01-\x7f]|[\x81-\xfe]([\x40-\x7e]|\xa1-\xfe])/";
        preg_match_all($re[$charset], $str, $match);
        $slice = join("", array_slice($match[0], $start, $length));
    }
    $omit = mb_strlen($str) >= $length ? '...' : '';
    return $suffix ? $slice . $omit : $slice;
}

/**
 * =====================================================================================================================
 * 返回文件格式
 * @param  string $str 文件名
 * @return string      文件格式
 * =====================================================================================================================
 */
function file_format($str)
{
    // 取文件后缀名
    $str = strtolower(pathinfo($str, PATHINFO_EXTENSION));
    // 图片格式
    $image = array('webp', 'jpg', 'png', 'ico', 'bmp', 'gif', 'tif', 'pcx', 'tga', 'bmp', 'pxc', 'tiff', 'jpeg', 'exif', 'fpx', 'svg', 'psd', 'cdr', 'pcd', 'dxf', 'ufo', 'eps', 'ai', 'hdri');
    // 视频格式
    $video = array('mp4', 'avi', '3gp', 'rmvb', 'gif', 'wmv', 'mkv', 'mpg', 'vob', 'mov', 'flv', 'swf', 'mp3', 'ape', 'wma', 'aac', 'mmf', 'amr', 'm4a', 'm4r', 'ogg', 'wav', 'wavpack');
    // 压缩格式
    $zip = array('rar', 'zip', 'tar', 'cab', 'uue', 'jar', 'iso', 'z', '7-zip', 'ace', 'lzh', 'arj', 'gzip', 'bz2', 'tz');
    // 文档格式
    $text = array('exe', 'doc', 'ppt', 'xls', 'wps', 'txt', 'lrc', 'wfs', 'torrent', 'html', 'htm', 'java', 'js', 'css', 'less', 'php', 'pdf', 'pps', 'host', 'box', 'docx', 'word', 'perfect', 'dot', 'dsf', 'efe', 'ini', 'json', 'lnk', 'log', 'msi', 'ost', 'pcs', 'tmp', 'xlsb');
    // 匹配不同的结果
    switch ($str) {
        case in_array($str, $image):
            return 'image';
            break;
        case in_array($str, $video):
            return 'video';
            break;
        case in_array($str, $zip):
            return 'zip';
            break;
        case in_array($str, $text):
            return 'text';
            break;
        default:
            return 'image';
            break;
    }
}

/**
 * =====================================================================================================================
 * app 图片上传
 * @return string 上传后的图片名
 * =====================================================================================================================
 */
function app_upload_image($path, $maxSize = 52428800)
{
    ini_set('max_execution_time', '0');
    // 去除两边的/
    $path = trim($path, '.');
    $path = trim($path, '/');
    $config = array(
        'rootPath' => './',         //文件上传保存的根路径
        'savePath' => './' . $path . '/',
        'exts' => array('jpg', 'gif', 'png', 'jpeg', 'bmp'),
        'maxSize' => $maxSize,
        'autoSub' => true,
    );
    $upload = new \Think\Upload($config);// 实例化上传类
    $info = $upload->upload();
    if ($info) {
        foreach ($info as $k => $v) {
            $data[] = trim($v['savepath'], '.') . $v['savename'];
        }
        return $data;
    }
}


/**
 * ============================================【APi 接口、CURL】========================================================
 * 请求接口返回内容
 * @param  string $url [请求的URL地址]
 * @param  string $params [请求的参数]
 * @param  int $ipost [是否采用POST形式]
 * @return  string
 * =====================================================================================================================
 */
function juhecurl($url, $params = false, $ispost = 0)
{
    $httpInfo = array();
    $ch = curl_init();

    curl_setopt($ch, CURLOPT_HTTP_VERSION, CURL_HTTP_VERSION_1_1);
    curl_setopt($ch, CURLOPT_USERAGENT, 'JuheData');
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 60);
    curl_setopt($ch, CURLOPT_TIMEOUT, 60);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    if ($ispost) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
        curl_setopt($ch, CURLOPT_URL, $url);
    } else {
        if ($params) {
            curl_setopt($ch, CURLOPT_URL, $url . '?' . $params);
        } else {
            curl_setopt($ch, CURLOPT_URL, $url);
        }
    }

    $response = curl_exec($ch);
    if ($response === FALSE) {
        //echo "cURL Error: " . curl_error($ch);
        return false;
    }
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $httpInfo = array_merge($httpInfo, curl_getinfo($ch));
    curl_close($ch);
    return $response;
}


/**
 * =====================================================================================================================
 * PHP发送Post数据
 * @param string $url 请求url
 * @param array /string $params 发送的参数
 * @return array
 * =====================================================================================================================
 */
function http_post_data($url, $params = array())
{
    //在没有需要上传文件的情况下，尽量对 post 提交的数据进行 http_build_query 处理，然后再发送出去，能实现更好的兼容性，更小的请求数据包。
    if (is_array($params)) {
        $params = http_build_query($params, null, '&');
    }

    //初始化一个curl会话，curl_init()函数唯一的一个参数是可选的，表示一个url地址
    $curl = curl_init();

    //这是你想用PHP取回的URL地址
    curl_setopt($curl, CURLOPT_URL, $url);

    //如果想把一个头包含在输出中，设置这个选项为一个非零值。
    curl_setopt($curl, CURLOPT_HEADER, false);

    //如果成功只将结果返回，不自动输出任何内容。如果失败返回FALSE
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);

    //如果你不想在输出中包含body部分，设置这个选项为一个非零值。
    curl_setopt($curl, CURLOPT_NOBODY, true);

    //如果你想PHP去做一个正规的HTTP POST，设置这个选项为一个非零值。
    //这个POST是普通的 application/x-www-from-urlencoded 类型，多数被HTML表单使用
    curl_setopt($curl, CURLOPT_POST, true);

    // 传递一个作为HTTP “POST”操作的所有数据的字符串
    curl_setopt($curl, CURLOPT_POSTFIELDS, $params);

    //执行一个curl会话
    $response = curl_exec($curl);

    //获取一个Http服务器状态吗
    $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);

    //关闭一个curl会话
    curl_close($curl);

    return array($httpCode, $response);
}

/**
 * ====================================融云开发环境=================================================================
 * 根据配置项获取对应的key和secret
 * @return array key和secret
 */
function get_rong_key_secret()
{
    // 判断是需要开发环境还是生产环境的key
    if (C('RONG_IS_DEV')) {
        $key = C('RONG_DEV_APP_KEY');
        $secret = C('RONG_DEV_APP_SECRET');
    } else {
        $key = C('RONG_PRO_APP_KEY');
        $secret = C('RONG_PRO_APP_SECRET');
    }
    $data = array(
        'key' => $key,
        'secret' => $secret
    );
    return $data;
}

/**
 * 获取融云token
 * @param  integer $uid 用户id
 * @return integer      token
 */
function get_rongcloud_token($uid)
{
    // 从数据库中获取token
    $token = D('OauthUser')->getToken($uid, 1);
    // 如果有token就返回
    if ($token) {
        return $token;
    }
    // 获取用户昵称和头像
    $user_data = M('Users')->field('username,avatar')->getById($uid);
    // 用户不存在
    if (empty($user_data)) {
        return false;
    }
    // 获取头像url格式
    $avatar = get_url($user_data['avatar']);
    // 获取key和secret
    $key_secret = get_rong_key_secret();
    // 实例化融云
    $rong_cloud = new \Org\Xb\RongCloud($key_secret['key'], $key_secret['secret']);
    // 获取token
    $token_json = $rong_cloud->getToken($uid, $user_data['username'], $avatar);
    $token_array = json_decode($token_json, true);
    // 获取token失败
    if ($token_array['code'] != 200) {
        return false;
    }
    $token = $token_array['token'];
    $data = array(
        'uid' => $uid,
        'type' => 1,
        'nickname' => $user_data['username'],
        'head_img' => $avatar,
        'access_token' => $token
    );
    // 插入数据库
    $result = D('OauthUser')->addData($data);
    if ($result) {
        return $token;
    } else {
        return false;
    }
}

/**
 * 更新融云头像
 * @param  integer $uid 用户id
 * @return boolear      操作是否成功
 */
function refresh_rongcloud_token($uid)
{
    // 获取用户昵称和头像
    $user_data = M('Users')->field('username,avatar')->getById($uid);
    // 用户不存在
    if (empty($user_data)) {
        return false;
    }
    $avatar = get_url($user_data['avatar']);
    // 获取key和secret
    $key_secret = get_rong_key_secret();
    // 实例化融云
    $rong_cloud = new \Org\Xb\RongCloud($key_secret['key'], $key_secret['secret']);
    // 更新融云用户头像
    $result_json = $rong_cloud->userRefresh($uid, $user_data['username'], $avatar);
    $result_array = json_decode($result_json, true);
    if ($result_array['code'] == 200) {
        return true;
    } else {
        return false;
    }
}

/** 删除所有空目录
 * @param String $path 目录路径
 */
function rm_empty_dir($path)
{
    if (is_dir($path) && ($handle = opendir($path)) !== false) {
        while (($file = readdir($handle)) !== false) {// 遍历文件夹
            if ($file != '.' && $file != '..') {
                $curfile = $path . '/' . $file;// 当前目录
                if (is_dir($curfile)) {// 目录
                    rm_empty_dir($curfile);// 如果是目录则继续遍历
                    if (count(scandir($curfile)) == 2) {//目录为空,=2是因为.和..存在
                        rmdir($curfile);// 删除空目录
                    }
                }
            }
        }
        closedir($handle);
    }
}

/**
 * 删除空目录
 * @param $dir
 * @return bool
 */
function rmdirs($dir)
{
    $dh = opendir($dir);
    while ($file = readdir($dh)) {
        if ($file != "." && $file != "..") {
            $fullpath = $dir . "/" . $file;
            if (!is_dir($fullpath)) {
                @unlink($fullpath);
            } else {
                $this->rmdirs($fullpath);
            }
        }
    }

    closedir($dh);
    //删除当前文件夹：
    if (rmdir($dir)) {
        return true;
    } else {
        return false;
    }
}

/**
 * 获取完整网络连接
 * @param  string $path 文件路径
 * @return string       http连接
 */
function get_url($path)
{
    // 如果是空；返回空
    if (empty($path)) {
        return '';
    }
    // 如果已经有http直接返回
    if (strpos($path, 'http://') !== false) {
        return $path;
    }
    // 判断是否使用了oss
    $alioss = C('ALIOSS_CONFIG');
    if (empty($alioss['KEY_ID'])) {
        return 'http://' . $_SERVER['HTTP_HOST'] . $path;
    } else {
        return 'http://' . $alioss['BUCKET'] . '.' . $alioss['END_POINT'] . $path;
    }

}

/** ***********************************异位或加密 **********************************
 *
 * @param  [type]  $value [description]
 * @param  integer $type [description]
 * @return [type]         [description]
 */
function encrytion($value, $type = 0)
{
    $key = md5(C('AUTO_LOGIN_KEY'));
    if ($type) {
        return str_replace('=', '', base64_encode($value ^ $key));
    }
    $value = base64_decode($value);
    return $value ^ $key;
}

/** ***********************************格式化字符串时间 **********************************
 *
 * @param  [type] $time [description]
 * @return [type]       [description]
 */

function time_format($time)
{
    $now = time();
    $today = strtotime(date('y-m-d'));
    $yesterday = strtotime('-1 day', $today);

    $diff = $now - $time;

    $str = '';
    switch (true) {
        case $diff < 60 :
            $str = '刚刚';
            break;
        case $diff < 3600 :
            $str = floor($diff / 60) . '分钟前';
            break;
        case $diff < (3600 * 8) :
            $str = floor($diff / 3600) . '小时前';
            break;
        case $time > $today :
            $str = '今天' . date('H:i', $time);
            break;
        case $time > $yesterday :
            $str = '昨天' . date('H:i', $time);
            break;
        default :
            $str = date('Y-m-d H:i', $time);
    }
    return $str;
}

/*************************************经验值转换为等级 **********************************
 *
 * @param  [type] $exp [description]
 * @return [type]      [description]
 */
function exp_to_level($exp)
{
    switch (true) {
        case $exp >= C('LV20') :
            return 20;
        case $exp >= C('LV19') :
            return 19;
        case $exp >= C('LV18') :
            return 18;
        case $exp >= C('LV17') :
            return 17;
        case $exp >= C('LV16') :
            return 16;
        case $exp >= C('LV15') :
            return 15;
        case $exp >= C('LV14') :
            return 14;
        case $exp >= C('LV13') :
            return 13;
        case $exp >= C('LV12') :
            return 12;
        case $exp >= C('LV11') :
            return 11;
        case $exp >= C('LV10') :
            return 10;
        case $exp >= C('LV9') :
            return 9;
        case $exp >= C('LV8') :
            return 8;
        case $exp >= C('LV7') :
            return 7;
        case $exp >= C('LV6') :
            return 6;
        case $exp >= C('LV5') :
            return 5;
        case $exp >= C('LV4') :
            return 4;
        case $exp >= C('LV3') :
            return 3;
        case $exp >= C('LV2') :
            return 2;
        default :
            return 1;
    }
}


/*************************************用户登陆操作日志记录 Logs **********************************************************
 * 全程记录用户的每一步操作，包括详细的描述
 * 读取配置项的详细信息
 * @return array
 */
function getGlobalSkypeLogDbConfig()
{
    $global_skype_db_config = array(
        'dbms' => C('DB_TYPE'),
        'username' => C('DB_USER'),
        'password' => C('DB_PWD'),
        'hostname' => C('DB_HOST'),
        'database' => C('DB_NAME'),
    );
    return $global_skype_db_config;
}

/**
 *
 * @param null $desc 【日志详细描述，可以自定义详细信息】
 * @param string $unique_flag 【日志操作的唯一标识符】
 * @param mixed|string $app 【操作项目】
 * @param mixed|string $action 【控制器】
 * @param string $method 【具体的每一个操作】
 * @return bool 【返回一个布尔值，TRUE表示插入成功，否则失败】
 */

function addOperationLog($desc = NULL, $unique_flag = 'system', $app = MODULE_NAME, $action = CONTROLLER_NAME, $method = ACTION_NAME)
{
    $config = getGlobalSkypeLogDbConfig();
    $conn = new \mysqli($config['hostname'], $config['username'], $config['password'], $config['database']);
    if ($conn->connect_error) {
        die("连接失败: " . $conn->connect_error);
    }
    mysqli_query($conn, 'set names utf8');
    $account = getAdminAccount();
    $nickname = getAdminNickname();
    $user_id = getAdminUserId();
    $ipaddr = get_client_ip();
    $query_string = implode('--', array_merge($_GET, $_POST));

    $is_desc = 0;
    if ($desc) $is_desc = 1;
    $insert_time = date('Y-m-d H:i:s');

    $query = "INSERT INTO `" . C('LOG_DB_TABLE') . "` (`guid`,`account`,`nickname`,`addtime`,`app`,`action`,
    `method`,`query_string`,`is_desc`,`desc`,`ipaddr`,`unique_flag`) VALUES ('$user_id','$account','$nickname','$insert_time','$app',
    '$action','$method','$query_string','$is_desc','$desc','$ipaddr','$unique_flag');";
    if (mysqli_query($conn, $query)) {
        $result = TRUE;
    } else {
        //$result = "Error:" . $query . "<br/>" . mysqli_error($conn); 用于以后调试
        $result = FALSE;
    }
    return $result;
}

/**
 * 获取用户账号
 * @return mixed
 */
function getAdminAccount()
{
    return $_SESSION['loginAccount'];
}

/**
 * 获取用户昵称
 * @return mixed
 */
function getAdminNickname()
{
    return $_SESSION['loginUserName'];
}

/**
 * 获取用户ID信息，这条信息是用户登陆的时候保存的
 * @return mixed
 */
function getAdminUserId()
{
    return $_SESSION[C('USER_AUTH_KEY')];
}

/** ***********************************用户登陆操作日志记录 Logs ***************************************************************/

?>