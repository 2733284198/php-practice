<?php
namespace Home\Controller;

use Think\Controller;

/**
 * Class JqueryController
 * @package Home\Controller
 */
class ApiController extends Controller
{
    const API_LIVE = 'http://www.amailive.com/api/getLive';
    const API_VIDEO = 'http://www.amailive.com/api/getVideo';
    const API_VIDEO_INFO = 'http://www.amailive.com/api/videoInfo';
    const CACHE_KEY = 'LIVE_INFO';

    /**
     * @var array
     */
    private static $liveParams = [
        'id' => 'L00735'
    ];

    /**
     * @var array
     */
    private static $videoParams = [
        'id' => 'L00735',
        'page' => 1,
        'limit' => 40
    ];

    /**
     * @var array
     */
    private static $videoInfoParams = [
        'id' => '47844'
    ];


    public function getLive($liveId = 'L00735')
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('');
        //这里在操作Redis之前最好判断Reids是否连接服务器成功,可以通过一个Ping命令测试
        if ($redis->ping() == 'PONG') {
            // 获取该活动的缓存数据
            $liveInfo = $redis->hGet(self::CACHE_KEY, $liveId);
            $resultData = [];
            if ($liveInfo) // 缓存为真
            {
                $resultData = json_decode($liveInfo, true);
                $resultData['errcode'] = '这里的数据来自Reids';
            } else  // 缓存没有或者已经过期
            {
                //  请求ApI接口数据 接口返回数据为Json格式
                $response = curlPost(self::API_LIVE, self::$liveParams);
                // 转换接口数据为数组
                $result = json_decode($response, true);
                // 转换成Json可以存储的编码格式
                iconv('GB2312', 'utf-8', $result);
                // 循环写入Redis数据库
                foreach ($result['dataList'] as $key => $vaule) {
                    // 注意：这里的json_encode() 必须是UTF-8的，不然是存储不进去的
                    $redis->hSet(self::CACHE_KEY, $vaule['id'], json_encode($vaule));
                    // 设置缓存过期时间
                    $redis->expire($vaule['id'], 20);
                    // 数据来源标记
                    $result['errcode'] = '这里的数据来自API接口数据';
                }
                $resultData = $result;
            }
        } else {
            $response = curlPost(self::API_LIVE, self::$liveParams);
            $result = json_decode($response, true);
            $resultData = $result;
        }
        return $resultData;
    }

    public function getVideo()
    {
        $response = curlPost(self::API_VIDEO, self::$videoParams);
        var_dump(json_decode($response, true));
    }

    public function videoInfo()
    {
        $response = curlPost(self::API_VIDEO_INFO, self::$videoInfoParams);
        var_dump(json_decode($response, true));
    }

}