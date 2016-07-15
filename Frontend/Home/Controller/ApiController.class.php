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

    const CACHE_KEY = 'LIVE_INFO'; //你就当做表名吧！

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

    /**
     * Redis 数据库缓存数据
     * @param string $liveId
     * @return array|mixed
     */
    public function getLive($liveId = 'L00735')
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('');
        //这里在操作Redis之前最好判断Reids是否连接服务器成功,可以通过一个Ping命令测试,返回一个“+PONG”字符串
        if ($redis->ping() == '+PONG') {
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
        } else // Redis数据库连接失败，则直接读取接口数据即可
        {
            $response = curlPost(self::API_LIVE, self::$liveParams);
            $result = json_decode($response, true);
            $resultData = $result;
        }
        return $resultData;
    }

    /**
     * 蝉知中使用Redis 做缓存的实际案例
     * @param string $deviceId
     */
    public function liveRedis($deviceId = '2853')
    {
        $channelInfo = $this->dao->select('*')->from(TABLE_LIVE_CHANNEL)->where('selected')->eq('1')->fetch(); //返回一个对象
        $redis = new \Redis();
        if($redis->connect($this->config->redis->host, $this->config->redis->port) === TRUE)
        {
            $redis->auth($this->config->redis->auth);
            $redis->select($this->config->redis->db);
            $resultData = [];
            if ($redis->ping() == '+PONG') {
                $resultData['errcode'] = 'Redis DB Connection Success';
                $getResult = $redis->hGet(self::CACHE_KEY.':'.$channelInfo->deviceId,$channelInfo->deviceId);
                if ($getResult) {
                    $resultData = json_decode($getResult, true);
                    $resultData['channelNum'] = $channelInfo->num;
                    $resultData['channelId'] = $channelInfo->id;
                    $resultData['channelName'] = $channelInfo->name;
                    $resultData['DataSource'] = 'From Redis DB DATA';
                    $resultData['errcode'] = 'OK';
                } else {
                    $liveInfo = json_decode($this->online->postCurl(self::CHANNEL_URL, ['id'=>$channelInfo->deviceId]), true);
                    if ($liveInfo['errcode'] == 200) {
                        $redis->multi();
                        $redis->hset(self::CACHE_KEY.':'.$channelInfo->deviceId, $channelInfo->deviceId, json_encode($liveInfo['dataList']));
                        $redis->expire(self::CACHE_KEY.':'.$channelInfo->deviceId, 60);
                        $redis->exec();
                        $resultData = $liveInfo['dataList'];
                        $resultData['channelNum'] = $channelInfo->num;
                        $resultData['channelId'] = $channelInfo->id;
                        $resultData['channelName'] = $channelInfo->name;
                        $resultData['DataSource'] = 'FROM API Interface DATA';
                        $resultData['errcode'] = 'OK';
                    } else {
                        $resultData['DataSource'] = 'Interface DATA REQUEST FAIL';
                        $resultData['errcode'] = 'Fail';
                    }
                }
            } else {
                $resultData['errcode'] = 'Redis Server No Runs';
                $liveInfo = json_decode($this->online->postCurl(self::CHANNEL_URL, ['id'=>$channelInfo->deviceId]), true);
                $resultData = $liveInfo['dataList'];
                $resultData['channelNum'] = $channelInfo->num;
                $resultData['channelId'] = $channelInfo->id;
                $resultData['channelName'] = $channelInfo->name;
            }
        }else{
            $liveInfo = json_decode($this->online->postCurl(self::CHANNEL_URL, ['id'=>$channelInfo->deviceId]), true);
            $resultData = $liveInfo['dataList'];
            $resultData['channelNum'] = $channelInfo->num;
            $resultData['channelId'] = $channelInfo->id;
            $resultData['channelName'] = $channelInfo->name;
            $resultData['errcode'] = 'Redis DB CONNECTION FAIL';
        }

        $courses = $this->dao->select('title ,duration ,videoId ,liveId ,duration ,fileName ,fileTime ,fileSize ,views ,course_price ,create_time')
            ->from(TABLE_LIVE_COURSE)
            ->where('is_publish')->eq(1)
            ->fetchAll();
        $this->view->channelInfo = $resultData;
        $this->view->courses = $courses;
        $this->view->HLSDynamicPlugin = 'js/v2/player/HLSDynamicPlugin.swf';
        $this->view->expressInstall = 'js/v2/player/expressInstall.swf';
        $this->view->StrobeMediaPlayback = 'js/v2/player/StrobeMediaPlayback.swf';
        $this->display('online', 'live');
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