<?php
namespace Home\Controller;

use Think\Controller;
use Think\Log;
use Think\Model\RelationModel;

class DeBugController extends Controller
{
    /**
     * 模型调试
     */
    public function index()
    {
        $User = M('User');
        $User->find(1);
        //调试执行的SQL语句
        echo $User->getLastSql() . '<br/>';
        // 3.2版本中可以使用简化的方法
        echo $User->_sql() . '<br/>';
        //getLastSql方法只能获取最后执行的sql记录，如果需要了解更多的SQL日志，可以通过查看当前的页面Trace或者日志文件。
        echo $User->getLastSql();
    }

    /**
     * 错误调试
     */
    public function index2()
    {
        $User = M('User');
        $User->find(1);

        //输出错误信息，并中止执行
        $msg = 'error info';
        //  手工抛出错误
        E($msg);

    }

    /**
     * 日志记录
     */
    public function log()
    {
        // 在开启调试模式的情况下，手工写入日志,默认的是ERR
        Log::record('在开启调试模式的情况下，手工写入日志', 'WARN');

        //在关闭调试模式的情况下，是写入不了的
        Log::record('在关闭调试模式的情况下，是写入不了的', 'WARN');

        //在关闭调试模式的情况下,强制写入记录
        Log::record('在关闭调试模式的情况下,强制写入记录', 'WARN', true);

        //不根据系统错误级别，自己设定写入
        //write方法写入日志的时候 不受配置的允许日志级别影响，可以实时写入任意级别的日志信息
        Log::write('不根据系统错误级别，自己设定写入', 'WARN');

        $msg = 'error info';
        //  手工抛出错误

    }

    /**
     * 日志记录
     */
    public function trace()
    {
        $User = M('User');
        $User->find(1);
        $msg = 'error info';
        // 调试方法 trace 用于打印变量或者方法信息（Ajax信息）
        trace('显示一个自定义的User 模块显示信息', '提示');

        //我们把刚才的用户信息调试输出到用户选项卡，trace方法的用法如下
        trace($msg, '用户信息', 'user');

    }

    /**
     * ThinkPHP支持模型的分层 ，除了Model层之外，我们可以项目的需要设计和创建其他的模型层
     * 逻辑层：Home\Logic\UserLogic 用于定义用户相关的业务逻辑
     */
    public function instanceLogicModel()
    {
        //实例化方法UserLogic模型
        $Logic = D('UserLogic','Logic');
    }


}