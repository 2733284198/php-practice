<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/8/19
 * Time: 9:18
 * Mail: Overcome.wan@Gmail.com
 */
namespace Api\Controller;

use Think\Controller;

class AliYunCsController extends Controller
{

    public function index()
    {
       echo 'AliYunCs';
    }

    /**
     * 查看一段时间内某个域名（或域名下某应用）的推流记录
     * Action:DescribeLiveStreamsPublishList
     * @param $DomainName
     * @param $AppName
     * @param $StreamName
     * @param $StartTime
     * @param $EndTime
     * @return Array
     */
    public function getLiveStreamsPublishList()
    {
        $Action = 'DescribeLiveStreamsPublishList';
        $DomainName = 'ruiyutouzi.amailive.com';
        $AppName = 'live';
        $StreamName = '410';
        $StartTime = '2016-10-18T00:00:00Z';
        $EndTime = '2016-11-16T00:00:00Z';

        $result = $this->aliYunMethod($Action,$DomainName,$AppName,$StreamName,$StartTime,$EndTime);
        $PublishInfo = json_decode(file_get_contents($result),true)['PublishInfo'];
        $LiveStreamPublishInfo = [];
        foreach($PublishInfo['LiveStreamPublishInfo'] as $val){
            $LiveStreamPublishInfo[] = [
                'EdgeNodeAddr' => $val['EdgeNodeAddr'],
                'PublishTime' => $val['PublishTime'],
                'StreamName' => $val['StreamName'],
                'ClientAddr' => $val['ClientAddr'],
                'PublishUrl' => $val['PublishUrl'],
                'StreamUrl' => $val['StreamUrl'],
                'StopTime' => $val['StopTime'],
                'DomainName' => $val['DomainName'],
                'AppName' => $val['AppName'],
            ];
        }
        var_dump($LiveStreamPublishInfo);
    }

    /**
     * 获取RTMP直播流的在线人数，支持基于域名和基于流的查询
     * Action:DescribeLiveStreamOnlineUserNum
     * @param $DomainName
     * @param $AppName
     * @param $StreamName
     * @param $StartTime
     * @param $EndTime
     * @return Array
     */
    public function getLiveStreamOnlineUserNum($DomainName = 'ruiyutouzi.amailive.com',$AppName = 'live',$StreamName = '410',$StartTime = '2016-10-18T00:00:00Z',$EndTime = '2016-11-16T00:00:00Z')
    {
        $Action = 'DescribeLiveStreamOnlineUserNum';
        $result = $this->aliYunMethod($Action,$DomainName,$AppName,$StreamName,$StartTime,$EndTime);
        $responseResult = json_decode(file_get_contents($result),true);
        $TotalUserNumber = $responseResult['TotalUserNumber'];
        $OnlineUserInfo = $responseResult['OnlineUserInfo'];
        $LiveStreamOnlineUser = [];
        foreach($OnlineUserInfo['LiveStreamOnlineUserNumInfo'] as $val){
            $LiveStreamOnlineUser[] = [
                'Time' => $val['Time'],
                'StreamUrl' => $val['StreamUrl'],
                'UserNumber' => $val['UserNumber'],
            ];
        }
        echo '当前在线人数:'.$TotalUserNumber;
        var_dump($LiveStreamOnlineUser);
    }

    /**
     * 查看指定域名下（或者指定域名下某个应用）的所有正在推的流的信息
     * Action:DescribeLiveStreamsOnlineList
     * @param $DomainName
     * @param $AppName
     * @return Array
     */
    public function DescribeLiveStreamsOnlineList($DomainName = 'ruiyutouzi.amailive.com',$AppName = 'live')
    {
        $Action = 'DescribeLiveStreamsOnlineList';
        $StreamName = null;
        $StartTime = null;
        $EndTime = null;
        $result = $this->aliYunMethod($Action,$DomainName,$AppName,$StreamName,$StartTime,$EndTime);
        $responseResult = json_decode(file_get_contents($result),true);
        $OnlineInfo = $responseResult['OnlineInfo']['LiveStreamOnlineInfo'];

        $LiveStreamOnlineInfo = [];
        foreach($OnlineInfo as $val){
            $LiveStreamOnlineInfo[] = [
                'PublishTime' => $val['PublishTime'],
                'PublishUrl' => $val['PublishUrl'],
                'DomainName' => $val['DomainName'],
                'AppName' => $val['AppName'],
                'StreamName' => $val['StreamName'],
            ];
        }
        var_dump($LiveStreamOnlineInfo);
    }

    /**
     * 获取直播流帧率和码率历史数据的查询，支持基于域名和基于流的查询；
     * Action:DescribeLiveStreamsOnlineList
     * @param $DomainName
     * @param $AppName
     * @return Array
     */
    public function DescribeLiveStreamsFrameRateAndBitRateData($DomainName = 'ruiyutouzi.amailive.com',$AppName = 'live',$StreamName = '410',$StartTime = '2016-10-18T00:00:00Z',$EndTime = '2016-11-16T00:00:00Z')
    {
        $Action = 'DescribeLiveStreamsFrameRateAndBitRateData';
        $result = $this->aliYunMethod($Action,$DomainName,$AppName,$StreamName,$StartTime,$EndTime);
        $responseResult = json_decode(file_get_contents($result),true);
        $FrameRateAndBitRateInfos = $responseResult['FrameRateAndBitRateInfos'];
        $FrameRateAndBitRateInfo = [];
        foreach($FrameRateAndBitRateInfos['FrameRateAndBitRateInfo'] as $val){
            $FrameRateAndBitRateInfo[] = [
                'AudioFrameRate' => $val['AudioFrameRate'],
                'Time' => $val['Time'],
                'StreamUrl' => $val['StreamUrl'],
                'BitRate' => $val['BitRate'],
                'VideoFrameRate' => $val['VideoFrameRate']
            ];
        }
        var_dump($FrameRateAndBitRateInfo);
    }


    /**
     * 公共调用接口方法
     */
    public function aliYunMethod($Action,$DomainName,$AppName,$StreamName,$StartTime,$EndTime)
    {
        $access_key_id = "3eyuRfszR0RyCDZH";
        $cdn_server_address = 'https://cdn.aliyuncs.com';
        $parameters =  array("Format"=>"JSON",
            "Version"=>"2014-11-11",
            "AccessKeyId"=>$access_key_id,
            "SignatureVersion"=>"1.0",
            "SignatureMethod"=>"HMAC-SHA1",
            "SignatureNonce"=>$this->uuid(),
            "TimeStamp"=>gmdate('c'),
        );
        //这几个参数应该是输入的 这里写死了
        $parameters['Action'] = $Action;//操作接口名，系统规定参数，取值：RefreshObjectCaches
        $parameters['DomainName'] = $DomainName;
        $parameters['AppName'] = $AppName;
        if($StreamName != null) $parameters['StreamName'] = $StreamName;
        if($StartTime != null) $parameters['StartTime'] = $StartTime;
        if($EndTime != null) $parameters['EndTime'] = $EndTime;

        //添加签名信息
        $parameters['Signature'] = $this->getSign($parameters);
        //拼接url
        $url = $cdn_server_address."/?".http_build_query($parameters);
        return $url;
    }

    public function getSign($parameters)
    {
        $access_key_secret = "uFdhSfhWGAiosiKE7BgiDK9OISQVlo";
        //构造用来计算签名信息的字符串
        $stringToSign = $this->det_stringToSign($parameters);
        //计算签名信息
        $signature = base64_encode(hash_hmac("SHA1",$stringToSign,$access_key_secret.'&', true));
        return $signature;
    }

    /**
     * 使用请求参数构造规范化的请求字符串
     * @param 输入的字符串
     * @return 规范后的字符串
     */
    public function percent_encode($str) {
        $res = urlencode(mb_convert_encoding($str,'utf-8', 'gb2312'));
        return $res;
    }

    /**
     * 计算构造用于签名的字符串
     * @param $parameters 参数
     * @return string  $stringToSign 用于计算签名的字符串
     */
    public function det_stringToSign($parameters){
        ksort($parameters);
        $cannibalizedQueryString = "";
        foreach ($parameters as $key => $value){
            $cannibalizedQueryString = $cannibalizedQueryString."&".$this->percent_encode($key)."=".$this->percent_encode($value)  ;
        }
        $cannibalizedQueryString=substr($cannibalizedQueryString,1);
        $stringToSign = "GET&%2F&".$this->percent_encode($cannibalizedQueryString);
        return $stringToSign;
    }

    /**
     * 生成UUID
     * @return uuid
     */
    public function uuid() {
        return preg_replace(
            '~^(.{8})(.{4})(.{4})(.{4})(.{12})$~',
            '\1-\2-\3-\4-\5',
            md5(uniqid('', true))
        );
    }

}