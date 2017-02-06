<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/2/6
 * |  Time: 14:16
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Api\Controller;

/**
 * 聚合数据API调用
 * https://www.juhe.cn/
 */
class JuHeController
{
    public function index()
    {
        echo __METHOD__;
    }

    public function juhecurl($url, $params = false, $ispost = 0)
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
     * 成语词典示例
     * @param array $prizeArr 奖品数组
     * @param string $index 概率键名
     * @return mixed 抽到的奖品
     */
    public function chenYu(){
        header('Content-type:text/html;charset=utf-8');
        //配置您申请的appkey
        $appkey = "e53c4a1f613720fa6b4d557c90b91c4f";

        //************1.根据成语查询详细信息************
        $url = "http://v.juhe.cn/chengyu/query";
        $params = array(
            "word" => urlencode('一帆风顺'),	//填写需要查询的汉字，UTF8 urlencode编码
            "key" => $appkey,	//应用APPKEY(应用详细页查询)
            "dtype" => "json",	//返回数据的格式,xml或json，默认json
        );
        $paramstring = http_build_query($params);
        $content = juhecurl($url,$paramstring);
        $result = json_decode($content,true);
        var_dump($result);
        exit();
    }

}