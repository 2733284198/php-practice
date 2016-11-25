<?php
namespace Home\Controller;

use Org\Util\RedisInstance;

class EChartsController extends BaseController
{
    /**
     * 官方默认的
     */
    public function defaultIndex()
    {
        $this->title = 'defaultIndex 原始模型数据';
        $this->name = '销量销量';
        $this->display();
    }

    public function index()
    {
        $this->product_name = 'ECharts 异步数据更新非';
        $this->name = '销量销量';
        $this->display();
    }

    public function getJson(){
        $result = [
            'status'=>200,
            'categories'=>["12-01","12-01","12-01","12-01","12-01","12-04"],
            'data'=>[45,23,67,43,89,230]
        ];
        sleep(1);
        exit(json_encode($result));
    }

    /**
     * setpLine index
     */
    public function setpLine()
    {
        $this->title = 'ECharts setpLine';
        $this->name = '销量销量';
        $this->display();
    }

    /**
     * setpLine 异步获取数据
     */
    public function setpLineAjax()
    {
        $this->title = '异步获取数据';
        $this->name = '销量销量';
        $this->display();
    }

    /**
     * setpLine 异步获取数据 JSON
     */
    public function getsetpLineAjaxJson(){

        $legendData = ['Step Start', 'Step Middle', 'Step End'];
        $xAxisData = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        $seriesData = [120, 132, 101, 134, 90, 230, 210];
        $result = [
            'status'=>200,
            'categories'=>'1111111111111',
            'data'=>[
                'xAxisData'=>$xAxisData,
                'seriesData'=>$seriesData,
            ]
        ];
        exit(json_encode($result));
    }

    public function test(){
        $this->display();
    }

    public function redistest(){
        $redis = RedisInstance::MasterInstance();
        $redis->select(12);
        $clientIP = $_SERVER['REMOTE_ADDR'];
        $clientKey = "speed:limiting:{$clientIP}";
        $listClientIpLen = $redis->llen($clientKey);
        $time = time();
        echo $listClientIpLen."<br/>";
        echo $clientKey."<br/>";
        echo $time."<br/>";
        if($listClientIpLen > 10 ){
            $clientIPexpireTime = $redis->lIndex($clientKey,-1); //获取最后一个索引文件
            if($time - $clientIPexpireTime < 60 ){
                exit('超出限制');
            }else{
                $redis->lPush($clientKey,$time);
                $redis->lTrim($clientKey,0,9);
            }
        }
        $redis->lPush($clientKey,$time);
        die;
    }

}