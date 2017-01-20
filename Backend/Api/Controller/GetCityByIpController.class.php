<?php
namespace Api\Controller;

use Think\Controller;

//PHP通过访问第三方接口，根据IP地址获取所在城市
class GetCityByIpController extends Controller
{
    public function index()
    {
        echo 'GetCityByIpeqweqweqw';
    }

    public function test()
    {
        $ipInfos = $this->get_ip_info('123.125.114.144'); // baidu.com IP地址
        print_r($ipInfos);
    }

    /**
     * 获取IP地址
     *
     * @return string
     */
    public function get_ip()
    {
        $realip = '';
        $unknown = 'unknown';
        if (isset($_SERVER)) {
            if (isset($_SERVER['HTTP_X_FORWARDED_FOR']) && !empty($_SERVER['HTTP_X_FORWARDED_FOR']) && strcasecmp($_SERVER['HTTP_X_FORWARDED_FOR'], $unknown)) {
                $arr = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
                foreach ($arr as $ip) {
                    $ip = trim($ip);
                    if ($ip != 'unknown') {
                        $realip = $ip;
                        break;
                    }
                }
            } else if (isset($_SERVER['HTTP_CLIENT_IP']) && !empty($_SERVER['HTTP_CLIENT_IP']) && strcasecmp($_SERVER['HTTP_CLIENT_IP'], $unknown)) {
                $realip = $_SERVER['HTTP_CLIENT_IP'];
            } else if (isset($_SERVER['REMOTE_ADDR']) && !empty($_SERVER['REMOTE_ADDR']) && strcasecmp($_SERVER['REMOTE_ADDR'], $unknown)) {
                $realip = $_SERVER['REMOTE_ADDR'];
            } else {
                $realip = $unknown;
            }
        } else {
            if (getenv('HTTP_X_FORWARDED_FOR') && strcasecmp(getenv('HTTP_X_FORWARDED_FOR'), $unknown)) {
                $realip = getenv("HTTP_X_FORWARDED_FOR");
            } else if (getenv('HTTP_CLIENT_IP') && strcasecmp(getenv('HTTP_CLIENT_IP'), $unknown)) {
                $realip = getenv("HTTP_CLIENT_IP");
            } else if (getenv('REMOTE_ADDR') && strcasecmp(getenv('REMOTE_ADDR'), $unknown)) {
                $realip = getenv("REMOTE_ADDR");
            } else {
                $realip = $unknown;
            }
        }
        $realip = preg_match("/[\d\.]{7,15}/", $realip, $matches) ? $matches[0] : $unknown;
        return $realip;
    }

    /**
     * 根据IP获取地址详情
     *
     * @param string $ip
     * @return bool|mixed
     */
    public function get_ip_info($ip = '')
    {
        if (empty($ip)) $ip = $this->get_ip();

        $res = @file_get_contents('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js&ip=' . $ip);
        if (empty($res)) return false;

        $jsonMatches = array();
        preg_match('#\{.+?\}#', $res, $jsonMatches);
        if (!isset($jsonMatches[0])) return false;

        $json = json_decode($jsonMatches[0], true);
        if (isset($json['ret']) && $json['ret'] == 1) {
            $json['ip'] = $ip;
            unset($json['ret']);
        } else {
            return false;
        }

        return $json;
    }

}