<?php
namespace Home\Controller;

use Monolog\Formatter\LineFormatter;
use Monolog\Handler\FirePHPHandler;
use Monolog\Handler\StreamHandler;
use Monolog\Logger;
use Org\Util\PDOHandler;
use Org\Util\PDOInstance;
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
        // 第一步，创建Logger实例，参数即通道名字
        $logger = new Logger('Admin_Home');
        //Logger本身不知道如何处理记录，它将处理委托给Handler[s]，上面的代码注册了两个Handlers，这样就可以用两种方法来处理记录。
        $logger->pushHandler(new StreamHandler('Logs/to/admin_home.log',Logger::DEBUG));
        //提示：FirePHPHandler最先被调用，因为它被添加在栈的顶部。这就允许你临时添加一个阻塞的Logger，如果你想覆盖其他Logger[s]的话。
        $logger->pushHandler(new FirePHPHandler());
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


    /**
     * 使用 processors
     * Processors 可以是任何可调用的方法（回调）
     */
    public function processor()
    {
        $logger = new Logger('Admin_Home_Processor');
        $logger->pushProcessor(function ($record){
            $record['extra']['dummy'] = 'Hello world!';
            return $record;
        });
    }

    public function callBackProcessor()
    {
        var_dump($this->processor());
    }


    /**
     * 频道的使用
     * 使用频道名可以对日志进行分类，这在大型的应用上是很有用的。通过频道名，可以很容易的对日志记录进行刷选。
     */
    public function channel()
    {
        // 创建handler
        //比如我们有一个StreamHandler，它在栈的最底部，它会把记录都保存到硬盘上
        $stream = new StreamHandler(LOGGER_PATH.'/my_app.log', Logger::DEBUG);
        $firephp = new FirePHPHandler();
        // 创建应用的主要logger Create the main logger of the app
        $logger = new Logger('my_logger');
        $logger->pushHandler($stream);
        $logger->pushHandler($firephp);

        /**
         *  Create a logger for the security-related stuff with a different channel
         *  通过不同的频道名创建一个用于安全相关的logger
         */
        $securityLogger = new Logger('Security');
        $securityLogger->pushHandler($stream);
        $securityLogger->pushHandler($firephp);

        //Or clone the first one to only change the channel
        $securityLogger = $logger->withName('security');

    }

    //自定义日志格式
    public function customizeFormat()
    {
        $dateFormat = "Y n j, g:i a";
        // the default output format is [%datetime%] %channel%.%level_name%: %message% %context% %extra%\n"
        $output = "%datetime% > %level_name% > %message% %context% %extra%\n";
        $formatter = new LineFormatter($output, $dateFormat);

        // Create a handler
        $stream = new StreamHandler('Logs/to/admin_home_format.log', Logger::DEBUG);
        $stream->setFormatter($formatter);

        // bind it to a logger object
        $securityLogger = new Logger('security');
        $securityLogger->pushHandler($stream);

        //记录一个日志到格式化日志文件中去
        $securityLogger->addInfo('Returns the priority of the filter.',array('admin'=>'Tinywan123'));
        var_dump($securityLogger);
    }

    //虽然 Monolog 提供了很多内置的 Handler，但是我们依然可能没有找到我们想要的那个，这时我们就要来编写并使用自己的了。仅需 implement
    public function pdoInsertSql()
    {
        $logger = new Logger('PDO_Record');
        $logger->pushHandler(new PDOHandler(PDOInstance::connectTp5()));
        $logger->addEmergency('In case any of our addEmergency');
        var_dump($logger);
    }



}