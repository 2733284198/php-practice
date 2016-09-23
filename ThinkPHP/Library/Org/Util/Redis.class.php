<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/7/3
 * Time: 9:26
 * Mail: Overcome.wan@Gmail.com
 * Singleton instance
 */
namespace Org\Util;

class Redis
{
    /**
     * @param $option
     * [1]当使用pconnect时，连接会被重用，连接的生命周期是fpm进程的生命周期，而非一次php的执行,
     *    close的作用仅是使当前php不能再进行redis请求，但无法真正关闭redis长连接，连接在后续请求中仍然会被重用，直至fpm进程生命周期结束。
     * [2]使用connect连接redis,除了建立连接外，在程序结尾，还向reids发送了quit命令，并关闭了连接的文件描述符
     *
     */

    /**
     * 每次实例的句柄,用于保存变量
     * @var
     */
    protected $handler;

    private $options;

    /**
     * 架构函数,实例化redis驱动的实例，寄一个socket
     * @param $option
     */
    public function __construct($options)
    {
        $this->handler = new \Redis();
        $this->options = $options;
//        if (!class_exists('Redis')) {
//            throw new Exception('PHP extension does not exist: Redis');
//        }
//        try {
//            if (!$this->handler) $this->handler = new \Redis();
//            //Logger::redis('new Redis'.$this->handler->incr(0));
//            $method = $option->persistent ? 'pconnect' : 'connect';
//            if ($option->timeout === false) {
//                $this->handler->$method($option->host, $option->port);
//            } else {
//                $this->handler->$method($option->host, $option->port, $option->timeout);
//            }
//            if ($option->auth !== false) $this->handler->auth($option->auth);
//            if ($option->db !== false) $this->handler->select($option->db);
//        } catch (\Exception $e) {
//            exit('Redis connection fail，this error messages:' . $e->getMessage());
//        }
        $this->connect();
    }

    /**
     * 返回一个Redis实例
     * @return \Redis
     */
    public function getHandle()
    {
        return $this->handler;
    }

    /**
     * 链接操作
     */
    public function connect()
    {
        //$this->handler->connect($host, $port, $timeout);
        $this->handler->connect($this->options->host, $this->options->port);
        //$this->handler->auth($this->options->auth);
    }

    /**
     * 关闭链接
     */
    public function close()
    {
        $this->handler->close();
    }

    /**
     * 设置
     */
    public function get($key)
    {
        return $this->handler->get($key);
    }

    /**
     * 设置
     */
    public function set($key, $value, $timeout = 0 )
    {
        return $this->handler->set($key, $value, $timeout);
    }

    /**
     * 设置
     */
    public function hGet($key, $hashKey)
    {
        return $this->handler->hGet($key, $hashKey);
    }

    //测试
    public function test()
    {
        return 'this is a Redis method';
    }

    /**
     * 关闭长连接
     */
    public function __destruct()
    {
        // TODO: Implement __destruct() method.
        $this->handler->close();
    }


}