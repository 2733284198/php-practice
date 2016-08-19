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
 * =====================================================================================================================
 * 生成一定数量的随机数，并且不重复
 * @param integer $number 数量
 * @param string $len 长度
 * @param string $type 字串类型
 * 0 字母 1 数字 其它 混合
 * @return string
 * =====================================================================================================================
 */
function build_count_rand($number, $length = 4, $mode = 1)
{
    if ($mode == 1 && $length < strlen($number)) {
        //不足以生成一定数量的不重复数字
        return false;
    }
    $rand = array();
    for ($i = 0; $i < $number; $i++) {
        $rand[] = rand_string($length, $mode);
    }
    $unqiue = array_unique($rand);
    if (count($unqiue) == count($rand)) {
        return $rand;
    }
    $count = count($rand) - count($unqiue);
    for ($i = 0; $i < $count * 3; $i++) {
        $rand[] = rand_string($length, $mode);
    }
    $rand = array_slice(array_unique($rand), 0, $number);
    return $rand;
}


/**
 * =====================================================================================================================
 * 返回用户id
 * @return integer 用户id
 * =====================================================================================================================
 */
function get_uid()
{
    return $_SESSION['user']['id'];
}

/**
 * =====================================================================================================================
 * 检测是否登录
 * @return boolean 是否登录
 * =====================================================================================================================
 */
function check_login()
{
    if (!empty($_SESSION['user']['id'])) {
        return true;
    } else {
        return false;
    }
}

// 设置验证码
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
 * =====================================================================================================================
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

function toJson($result)
{
    //header("Content-Type:text/html; charset=utf-8");
    return json_decode($result);
}

?>