<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/1/20
 * |  Time: 16:25
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Home\Controller;

use Curl\Curl;
use Curl\MultiCurl;
use Think\Controller;

class CURLController extends Controller
{
    public function index()
    {
        echo __METHOD__;
        //检测扩展是否安装, return bool
        var_dump(extension_loaded('curl'));
    }

    public function services()
    {
        $credentials = "username:password";
        $defined_vars = [];

        // Read the XML to send to the Web Service
        $request_file = "./SampleRequest.xml";
        $fh = fopen($request_file, 'r');
        $xml_data = fread($fh, filesize($request_file));
        fclose($fh);

        $url = "http://www.example.com/services/calculation";
        $page = "/services/calculation";
        $headers = array(
            "POST " . $page . " HTTP/1.0",
            "Content-type: text/xml;charset=\"utf-8\"",
            "Accept: text/xml",
            "Cache-Control: no-cache",
            "Pragma: no-cache",
            "SOAPAction: \"run\"",
            "Content-length: " . strlen($xml_data),
            "Authorization: Basic " . base64_encode($credentials)
        );

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 60);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_USERAGENT, $defined_vars['HTTP_USER_AGENT']);

        // Apply the XML to our curl call
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $xml_data);

        $data = curl_exec($ch);

        if (curl_errno($ch)) {
            print "Error: " . curl_error($ch);
        } else {
            // Show me the result
            var_dump($data);
            curl_close($ch);
        }
    }

    /**
     *  get 请求
     */
    public function curlGet1()
    {
        $curl = new Curl();
        $curl->get('http://www.amailive.com/');
        if ($curl->error) {
            echo 'Error: ' . $curl->errorCode . ': ' . $curl->errorMessage . "\n";
            exit(1);
        }
        echo 'Response:' . "\n";
        print_r($curl->response);
    }

    /**
     * GET 带参数的请求
     * https://www.example.com/search?q=keyword
     */
    public function curlGetParm()
    {
        $curl = new Curl();
        $curl->get('https://www.example.com/search', array(
            'q' => 'keyword',
        ));
        if ($curl->error) {
            echo 'Error: ' . $curl->errorCode . ': ' . $curl->errorMessage . "\n";
            exit(1);
        }
        echo 'Response:' . "\n";
        var_dump($curl->response);
    }

    /**
     * POST 带参数的请求
     */
    public function curlPostParm()
    {
        $curl = new Curl();
        $curl->post('https://www.example.com/login/', array(
            'username' => 'myusername',
            'password' => 'mypassword',
        ));
        if ($curl->error) {
            echo 'Error: ' . $curl->errorCode . ': ' . $curl->errorMessage . "\n";
            exit(1);
        }
        echo 'Response:' . "\n";
        var_dump($curl->response);
    }
    /**
     * POST 带参数的请求
     */
    public function curlGetAuth()
    {
        $curl = new Curl();
        //使用的HTTP验证方法,HTTP代理连接的验证方式,对于代理验证只有CURLAUTH_BASIC和CURLAUTH_NTLM当前被支持
        $curl->setBasicAuthentication('username', 'password');
        //在HTTP请求中包含一个”user-agent”头的字符串
        $curl->setUserAgent('MyUserAgent/0.0.1 (+https://www.example.com/bot.html)');
        //在HTTP请求中包含一个”referer”头的字符串
        $curl->setReferrer('https://www.example.com/url?url=https%3A%2F%2Fwww.example.com%2F');
        //一个用来设置HTTP头字段的数组。使用如下的形式的数组进行设置： array('Content-type: text/plain', 'Content-length: 100')
        $curl->setHeader('X-Requested-With', 'XMLHttpRequest');
        //启用时curl会仅仅传递一个session cookie，忽略其他的cookie，默认状况下cURL会将所有的cookie返回给服务端。session cookie是指那些用来判断服务器端的session是否有效而存在的cookie。
        $curl->setCookie('key', 'value');
        $curl->get('https://www.example.com/');

        if ($curl->error) {
            echo 'Error: ' . $curl->errorCode . ': ' . $curl->errorMessage . "\n";
        } else {
            echo 'Response:' . "\n";
            var_dump($curl->response);
        }

        var_dump($curl->requestHeaders);
        var_dump($curl->responseHeaders);
    }

    public function MultiCurl()
    {
        $multi_curl = new MultiCurl();
        $multi_curl->addGet('https://www.google.com/search', array(
            'q' => 'hello world',
        ));
        $res = $multi_curl->start();
        var_dump($res);
    }

}