<?php

/**
 * 请求接口返回内容
 * @param  string $url [请求的URL地址]
 * @param  string $params [请求的参数]
 * @param  int $ipost [是否采用POST形式]
 * @return  string
 */
function juhecurl($url,$params=false,$ispost=0){
    $httpInfo = array();
    $ch = curl_init();
 
    curl_setopt( $ch, CURLOPT_HTTP_VERSION , CURL_HTTP_VERSION_1_1 );
    curl_setopt( $ch, CURLOPT_USERAGENT , 'JuheData' );
    curl_setopt( $ch, CURLOPT_CONNECTTIMEOUT , 60 );
    curl_setopt( $ch, CURLOPT_TIMEOUT , 60);
    curl_setopt( $ch, CURLOPT_RETURNTRANSFER , true );
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    if( $ispost )
    {
        curl_setopt( $ch , CURLOPT_POST , true );
        curl_setopt( $ch , CURLOPT_POSTFIELDS , $params );
        curl_setopt( $ch , CURLOPT_URL , $url );
    }
    else
    {
        if($params){
            curl_setopt( $ch , CURLOPT_URL , $url.'?'.$params );
        }else{
            curl_setopt( $ch , CURLOPT_URL , $url);
        }
    }

    $response = curl_exec( $ch );
    if ($response === FALSE) {
        //echo "cURL Error: " . curl_error($ch);
        return false;
    }
    $httpCode = curl_getinfo( $ch , CURLINFO_HTTP_CODE );
    $httpInfo = array_merge( $httpInfo , curl_getinfo( $ch ) );
    curl_close( $ch );
    return $response;
}

//curl post method
function curlPost($method, $url, $data)
{
    //初始化一个curl会话，curl_init()函数唯一的一个参数是可选的，表示一个url地址
    $curl = curl_init();

//    switch ($method)
//    {
//        case "POST":
//            curl_setopt($curl, CURLOPT_POST, 1);
//
//            if ($data)
//                curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
//            break;
//        case "PUT":
//            curl_setopt($curl, CURLOPT_PUT, 1);
//            break;
//        default:
//            if ($data)
//                $url = sprintf("%s?%s", $url, http_build_query($data));
//    }

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
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data);

    //执行一个curl会话
    $return_str = curl_exec($curl);

    //关闭一个curl会话
    curl_close($curl);
    return $return_str;
}

function Get($url)
{
    if(function_exists('file_get_contents'))
    {
        $file_contents = file_get_contents($url);
    }else{
        $ch = curl_init();
        $timeout = 5;
        curl_setopt ($ch, CURLOPT_URL, $url);
        curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt ($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
        $file_contents = curl_exec($ch);
        curl_close($ch);
    }
    return $file_contents;
}

/**
 * PHP发送Post数据
 *
 * @param string $url 请求url
 * @param array/string $params 发送的参数
 * @return array
 */
function http_post_data($url, $params = array())
{
    //在没有需要上传文件的情况下，尽量对 post 提交的数据进行 http_build_query 处理，然后再发送出去，能实现更好的兼容性，更小的请求数据包。
    if (is_array($params))
    {
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