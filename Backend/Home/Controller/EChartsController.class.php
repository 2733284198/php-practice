<?php
namespace Home\Controller;

class EChartsController extends BaseController
{
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

    public function test(){
        date_default_timezone_set('UTC');
        $utc = date('Y-m-d\TH:i:s\Z', time());
        var_dump($utc);
    }

}