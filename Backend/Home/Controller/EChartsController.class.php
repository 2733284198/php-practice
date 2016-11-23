<?php
namespace Home\Controller;

use Home\Controller\BaseController;
use Org\Util\Car;
use Org\Util\RedisInstance;
use Org\Util\Tree;
use Org\Util\UserAgent;
use Org\Util\Rbac;
use Think\Log;

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
        sleep(3);
        exit(json_encode($result));
    }

}