<?php
namespace Home\Controller;

use Home\Controller\BaseController;
use Org\Util\Car;
use Org\Util\RedisInstance;
use Org\Util\Tree;
use Org\Util\UserAgent;
use Org\Util\Rbac;
use Think\Log;

class IndexController extends BaseController
{
    public function index()
    {

        $user = M('AdminUser')->select();
        $where['username'] = session('username');

        $user = M('AdminUser')->where($where)->field(['username', 'logintime', 'loginip', 'expire'])->find();
        $this->user = $user;
        $this->display();
    }

    public function tpltest()
    {
        $this->display('Index/tpltest');
    }

    public function welcome()
    {
        $this->display('Index/welcome');
    }

    public function notice()
    {
        $this->display('Index/notice');
    }

    /**
     * 通过 A 方法跨模块调用操作
     * 尝试去调用一个Category模块下面Index控制器的Test()的方法
     * A()方法
     * ***建议：如果要使用其他模块内的多个方法，那么建议使用 A 方法，通过对象的方式调用该模块的不同方法，避免多次实例化对象。
     */
    public function aGetModule()
    {
        //$User = new \Category\Controller\IndexController(); 等价于这个
        $category = A('Category/Index');
        $category->test();
    }

    /**
     * 通过 R 方法跨模块调用操作
     * 尝试去调用一个Category模块下面Index控制器的Test()的方法
     * R()方法
     * ***建议：如果只需要使用其他模块内的其中一个方法，那么无疑 R 方法是最简洁的
     */
    public function rGetModule()
    {
        $category = R('Category/Index/test');
        echo $category;
    }

    /**
     * 通过 R 方法跨模块调用操作
     * 尝试去调用一个Category模块下面Index控制器的Test()的方法
     * R()方法
     * 建议：如果只需要使用其他模块内的其中一个方法，那么无疑 R 方法是最简洁的
     */
    public function aGetAppModule($id)
    {
        $category = A('ThinkPhpStudy://Frontend/Home/Index/index');
        echo $category;
        echo '111111111';
        echo $id;
    }

    //空操作是指系统在找不到请求的操作方法的时候，会定位到空操作（_empty）方法来执行，利用这个机制，我们可以实现错误页面和一些URL的优化。
    public function _empty($name)
    {
        //把所有城市的操作解析到city方法
        $this->city($name);
    }

    //注意 city方法 本身是 protected 方法
    protected function city($name)
    {
        //和$name这个城市相关的处理
        echo __METHOD__ . "方法名" . $name . "不存在啊";
    }

    public function show($name = '')
    {
        $this->id = 1024;
        $this->name = $name;
        $this->display('/Index/show');
    }

    /**
     * 判断用户是否是手机和微信登陆
     */
    public function userAgent()
    {
        p(UserAgent::IS_WECHAT());
    }

    public function testFunction()
    {
        static $i = 1; //第一次调用初始化，第二次调用的时候将不会重复去初始化
        echo $i . "\n";
        $i++;

    }

    public function test()
    {
        global $a, $b;
        $this->testFunction();
        $this->testFunction();
        $this->testFunction();
        $this->testFunction();
        print_r($GLOBALS);
        homePrint($GLOBALS['_SESSION']);

    }

    public function curltest()
    {
//        $url="http://121.43.63.240/control/record/stop?app=live&name=L00735&rec=rec1";
//        $result = http_post_data($url,$ost=null);
//        var_dump($result);
//        $userId = explode('_','test_8')[1];
//        var_dump($userId);
        $str = 'rtmp://120.26.206.180/live';
        preg_match("/[0-9]+[^\s]*[0-9]/", $str, $matches);
        var_dump($matches[0]);
    }

    public function testRedis()
    {
        $session_name = 'tinywan';
        $save_path = 'F:/wamp/sessionredis';
        $session_expire = 60;
        echo session_id();
        $redis = RedisInstance::MasterInstance();
        $str = 'PHPREDIS_SESSION:1a2t9ln6so69j38frhivm79ak0';
        homePrint($redis->get($str));
        var_dump(session('_ACCESS_LIST'));
        die;

        session_save_path($save_path);
        session_name($session_name);
        session_cache_expire($session_expire);

        echo 'session_name:' . session_name() . 'session_id:' . session_id() . 'session_expire:' . session_cache_expire();

        $redis = RedisInstance::MasterInstance();
        $redis->select(3);
        echo session_name() . '=' . session_id();
        die;
    }

    public function getSessionRedis()
    {
//        echo 'session_name:'.session_name().'session_id:'.session_id().'session_expire:'.session_cache_expire();
        echo '========' . session_save_path();
        $redis = RedisInstance::MasterInstance();
        $redis->hSet();
        $redis->select(3);
        echo session_name() . '=' . session_id();
        die;
    }

    public function everyFunction()
    {
        $carObj = new Car();
        var_dump($carObj);
        $carObj->add('butter', 1);
        $carObj->add('milk', 4);
        $carObj->add('eggs', 9);
        print_r($carObj->getTotal(0.05));
        echo sprintf("%u\n", ip2long("157.23.56.90"));
    }

    //=======================================================乐视云计算==================================================
    public function leCloudApi()
    {
        $userid = 882860;
        $uri = '/data/bandwidth';
        $appkey = '07f82bfcc7eeda519241d8fe1d53c1e6';
        $method = 'GET';
        $md5Val = md5($userid . $method . $uri . $appkey);
        $base64Val = 'Basic ' . base64_encode($userid . ':' . $md5Val);
        $header = [
            "Authorization:{$base64Val}",
            'Lecloud-api-version:0.4'
        ];
        $url = "http://api.open.letvcloud.com/data/bandwidth?productline=CDN&domaintype=VOD&startday=20161228&endday=20161228";
        $res = curl_header_get_contents($url, $header);
        var_dump(json_decode($res, true)['data']['bandwidth']);

    }

    //直播时长查询
    public function liveDuration()
    {
        $userid = 882860;
        $uri = '/data/bandwidth';
        $appkey = '07f82bfcc7eeda519241d8fe1d53c1e6';
        $method = 'GET';
        $md5Val = md5($userid . $method . $uri . $appkey);
        $base64Val = 'Basic ' . base64_encode($userid . ':' . $md5Val);
        $header = [
            "Authorization:{$base64Val}",
            'Lecloud-api-version:0.4'
        ];
        $url = "http://api.open.letvcloud.com/data/duration?startday=20161228&endday=20161228&pushDomain=lepush.amaitech.com";
        $res = curl_header_get_contents($url, $header);
        var_dump(json_decode($res, true));

    }

    //录像接口调用
    public function recordFunction()
    {
        $method='lecloud.cdnlive.rec.createCdnRecTaskByStreamName';
        $ver = 3.1;
        $userid = 882860;
        $timestamp = time().'000';
        $streamName = 123456;
        $appName = 'test';
        $domain = 'leplay.amaitech.com';     #客户的访问域名
        $fileType = 'flv';                    #下载类型flv|mp4
        $startTime = '20161229123025';         #直播开始时间，（早于开始时间几秒就可以例如20161227123025）
        $endTime = '20161229193025';           #直播结束时间（晚于结束时间几秒就可以

        $seckey = '07f82bfcc7eeda519241d8fe1d53c1e6';
        $sign = "appName{$appName}domain{$domain}endTime{$endTime}fileType{$fileType}method{$method}startTime{$startTime}streamName{$streamName}timestamp{$timestamp}userid{$userid}ver{$ver}{$seckey}";
        $md5Sifn = md5($sign);
        $url = 'http://api.open.lecloud.com/live/execute';
        $arrData = [
            'appName'=>$appName,
            'domain'=>$domain,
            'endTime'=>$endTime,
            'fileType'=>$fileType,
            'method'=>$method,
            'startTime'=>$startTime,
            'streamName'=>$streamName,
            'timestamp'=>$timestamp,
            'userid'=>$userid,
            'ver'=>$ver,
            'sign'=>$md5Sifn
        ];

        $res = http_post_data($url,$arrData);
        var_dump($res);


    }


}