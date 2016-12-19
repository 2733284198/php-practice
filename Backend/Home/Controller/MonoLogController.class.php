<?php
namespace Home\Controller;

use Monolog\Handler\FirePHPHandler;
use Monolog\Handler\StreamHandler;
use Monolog\Logger;
use Think\Controller;
require 'vendor/autoload.php';

class MonoLogController extends Controller
{
    /**
     * 日志级别
            DEBUG：详细的debug信息
            INFO：感兴趣的事件。像用户登录，SQL日志
            NOTICE：正常但有重大意义的事件。
            WARNING：发生异常，使用了已经过时的API。
            ERROR：运行时发生了错误，错误需要记录下来并监视，但错误不需要立即处理。
            CRITICAL：关键错误，像应用中的组件不可用。
            ALETR：需要立即采取措施的错误，像整个网站挂掉了，数据库不可用。这个时候触发器会通过SMS通知你，
     * 实例化一个日志对象
     * 实例化一个日志对象 https://github.com/Seldaek/monolog
     * @return Logger
     */
    public function monologInstance(){
        // 创建Logger实例
        $logger = new Logger('Admin_Home');
        // 添加handler
//        $logger->pushHandler(new StreamHandler('path/to/admin_home.log', Logger::WARNING));
        $logger->pushHandler(new StreamHandler('Logs/to/admin_home.log'));
//        $logInstance->pushHandler(new FirePHPHandler());
        return $logger;
    }

    public function logTest()
    {
        $logger = $this->monologInstance();
        // 开始使用
        $logger->addInfo('addInfo 开始使用');
        $logger->addInfo('addInfo 有第二个参数',array('admin'=>'Tinywan'));
        var_dump($logger);
    }

    public function logTest2()
    {
        $logger = $this->monologInstance();
        // 开始使用
        $logger->addInfo('addInfo 123');
        var_dump($logger);
    }

    //使用processor
    public function processor()
    {
        $logger = new Logger('Admin_Home_Processor');
        $logger->pushProcessor(function ($record){
            $record['extra']['dummy'] = 'Hello world!';
            return $record;
        });
    }


    /**
     * 频道的使用
     * 使用频道名可以对日志进行分类，这在大型的应用上是很有用的。通过频道名，可以很容易的对日志记录进行刷选。
     */
    public function channel()
    {
        // 创建handler
        $stream = new StreamHandler(LOGGER_PATH.'/my_app.log', Logger::DEBUG);
        $firephp = new FirePHPHandler();
        // 创建应用的主要logger
        $logger = new Logger('my_logger');
        $logger->pushHandler($stream);
        $logger->pushHandler($firephp);

        // 通过不同的频道名创建一个用于安全相关的logger
        $securityLogger = new Logger('Security');
        $securityLogger->pushHandler($stream);
        $securityLogger->pushHandler($firephp);

    }




}