<?php
namespace Home\Controller;

use Monolog\Handler\StreamHandler;
use Monolog\Logger;
use Think\Controller;

class MonoLogController extends Controller
{
    /**
     * 实例化一个日志对象
     * 实例化一个日志对象 https://github.com/Seldaek/monolog
     * @return Logger
     */
    public function monologInstance(){
        $logInstance = new Logger('Home');
        $logInstance->pushHandler(new StreamHandler('path/to/adminHome.log', Logger::WARNING));
        return $logInstance;
    }

    public function logTest()
    {
        $log = $this->monologInstance();
        // add records to the log
        $log->warning('This is a warning');
        $log->error('Bar');
        var_dump($log);
    }




}