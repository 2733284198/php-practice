<?php
namespace Home\Controller;

use Hisune\EchartsPHP\ECharts;
use Org\Util\RedisInstance;

class EChartsController extends BaseController
{
    /**
     * 官方默认的 百度默认的一个最记得拿都拿的
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
            'categories'=>["12-01","12-01","12-01","12-01","12-01","12-04","12-05"],
            'data'=>[45,23,67,43,89,230,480]
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
     * 折线图
     */
    public function chart_type_line()
    {
        $this->title = '折线图';
        $this->name = '销量销量';
        $this->display();
    }

    /**
     * 饼图形
     */
    public function chart_type_pie()
    {
        $this->title = '饼图形';
        $this->name = '销量销量';
        $this->display();
    }

    //mix-timeline-finance
    public function mix_timeline_finance(){
        $this->title = '坐标轴刻度与标签对齐';
        $this->display();
    }

    //mix-timeline-finance
    public function Map_China(){
        $this->title = 'Map China';
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

    public function test123(){

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

    /**
     * Echarts图表的php库开源了
     * Echarts-PHP a PHP library that works as a wrapper for the Echarts js library
     */
    public function EChartsPhpLibrarySimple(){
        $chart = new ECharts();
        $chart->tooltip->show = true;
        $chart->legend->data = array('销量');
        $chart->xAxis = array(
            array(
                'type' => 'category',
                'data' => array("衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子")
            ),

        );
        $chart->yAxis = array(
            array('type' => 'value')
        );
        $chart->series = array(
            array(
                'name' => '销量',
                'type' => 'bar',
                'data' => array(5, 20, 40, 10, 10, 20)
            )
        );
        echo $chart->render('simple-custom-id');
    }

    public function EChartsPhpLibraryAdvance(){
        $chart = new ECharts();
        $chart->tooltip->trigger = 'axis';
        $chart->legend->data = array('蒸发量','降水量','最低气温','最高气温');
        $chart->toolbox = array(
            'show' => true,
            'feature' => array(
                'mark' => array('show' => true),
                'dataView' => array('show' => true),
                'magicType' => array('show' => true, 'type' => array('line', 'bar')),
                'restore' => array('show' => true),
                'saveAsImage' => array('show' => true),
            )
        );
        $chart->xAxis = array(
            array(
                'type' => 'category',
                'position' => 'bottom',
                'boundaryGap' => true,
                'axisLine' => array(
                    'show' => true,
                    'lineStyle' => array(
                        'color' => 'green',
                        'type' => 'solid',
                        'width' => 2,
                    ),
                ),
                'axisTick' => array(
                    'show' => true,
                    'length' => 10,
                    'lineStyle' => array(
                        'color' => 'red',
                        'type' => 'solid',
                        'width' => 2,
                    ),
                ),
                'axisLabel' => array(
                    'show' => true,
                    'interval' => 'auto',
                    'rotate' => 45,
                    'margin' => 8,
                    'formatter' => '{value}月',
                    'textStyle' => array(
                        'color' => 'blue',
                        'fontFamily' => 'sans-serif',
                        'fontSize' => 15,
                        'fontStyle' => 'italic',
                        'fontWeight' => 'bold',
                    ),
                ),
                'splitLine' => array(
                    'show' => true,
                    'lineStyle' => array(
                        'color' => '#483d8b',
                        'type' => 'dashed',
                        'width' => 1,
                    ),
                ),
                'splitArea' => array(
                    'show' => true,
                    'areaStyle' => array(
                        'color' => array('rgba(144,238,144,0.3)','rgba(135,200,250,0.3)')
                    ),
                ),
                'data' => array(
                    '1','2','3','4','5',
                    array(
                        'value' => '6',
                        'textStyle' => array(
                            'color' => 'red',
                            'fontSize' => 30,
                            'fontStyle' => 'normal',
                            'fontWeight' => 'bold',
                        ),
                    ),
                    '7','8','9','10','11','12'
                )
            ),
            array(
                'type' => 'category',
                'data' => array('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'),
            ),
        );
        $chart->yAxis = array(
            array(
                'type' => 'value',
                'position' => 'left',
                'boundaryGap' => array(0,0.1),
                'axisLine' => array(
                    'show' => true,
                    'lineStyle' => array(
                        'color' => 'red',
                        'type' => 'dashed',
                        'width' => 2,
                    ),
                ),
                'axisTick' => array(
                    'show' => true,
                    'length' => 10,
                    'lineStyle' => array(
                        'color' => 'green',
                        'type' => 'solid',
                        'width' => 2,
                    ),
                ),
                'axisLabel' => array(
                    'show' => true,
                    'interval' => 'auto',
                    'rotate' => -45,
                    'margin' => 18,
                    'formatter' => '{value} ml',
                    'textStyle' => array(
                        'color' => '#1e90ff',
                        'fontFamily' => 'verdana',
                        'fontSize' => 10,
                        'fontStyle' => 'normal',
                        'fontWeight' => 'bold',
                    ),
                ),
                'splitLine' => array(
                    'show' => true,
                    'lineStyle' => array(
                        'color' => '#483d8b',
                        'type' => 'dotted',
                        'width' => 2,
                    ),
                ),
                'splitArea' => array(
                    'show' => true,
                    'areaStyle' => array(
                        'color' => array('rgba(205,92,92,0.3)','rgba(255,215,0,0.3)')
                    ),
                ),
            ),
            array(
                'type' => 'value',
                'splitNumber' => 10,
                'axisLabel' => array(
                    'formatter' => "
                function (value)
                {
                    return value + ' °C'
                }
            ",
                ),
                'splitLine' => array(
                    'show' => true,
                )
            ),
        );
        $chart->series = array(
            array(
                'name' => '蒸发量',
                'type' => 'bar',
                'data' => array(2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3),
            ),
            array(
                'name' => '降水量',
                'type' => 'bar',
                'data' => array(2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3)
            ),
            array(
                'name' => '最低气温',
                'type' => 'line',
                'yAxisIndex' => 1,
                'data' => array(2.0, 2.2, 3.3, 4.5, 6.3, 10.2, 20.3, 23.4, 23.0, 16.5, 12.0, 6.2)
            ),
            array(
                'name' => '最高气温',
                'type' => 'line',
                'yAxisIndex' => 1,
                'data' => array(12.0, 12.2, 13.3, 14.5, 16.3, 18.2, 28.3, 33.4, 31.0, 24.5, 18.0, 16.2)
            ),
        );
        echo $chart->render('advance-custom-id');
    }

}