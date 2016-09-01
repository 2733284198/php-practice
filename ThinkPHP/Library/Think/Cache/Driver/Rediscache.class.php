<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2014 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
namespace Think\Cache\Driver;
use Think\Cache;
defined('THINK_PATH') or exit();

/**
 * Redis缓存驱动 
 * 要求安装phpredis扩展：https://github.com/nicolasff/phpredis
 */
class RedisCache extends Cache {
    /**
     * 类对象实例数组
     * 共有静态变量
     *@param mixed $_instance存放实例
     */
    private static $_instance = array();

    /**
     *每次实例的句柄
     *保护变量
     */
    protected $handler;

    /**
     *redis的配置
     *全局 静态变量
     *静态的方法里调用静态变量和静态方法只能用self(也可以使用static)，不能出现$this
     */
    public static $option = array();

    /**
     *架构函数，必须设置为私有，防止外部new
     *实例化redis驱动的实例，寄一个socket
     *
     */
    private function __construct($host,$port,$auth) {
        if(!$this->handler) {
            $this->handler= new \Redis;
        }
        $func = self::$option['persistent'] ? 'pconnect' : 'connect';
        if(self::$option['timeout'] === false) {
            $this->handler->$func($host,$port);
        }else {
            $this->handler->$func($host,$port,self::$option['timeout']);
        }

//        // 认证
//        if($auth){
//            $this->handler->auth($auth);
//        }
    }

    /**
     * 实例函数，单例入口
     * 共有，静态函数
     */

    public static function getInstance($options=array()) {
        // 判断是否存在redis扩展
        if ( !extension_loaded('redis') ) {
            E(L('_NOT_SUPPERT_').':redis');
        }
        if(empty($options)) {
            $options = array (
                'host'          => C('DATA_REDIS_HOST') ? C('DATA_REDIS_HOST') : '127.0.0.1',
                'port'          => C('DATA_REDIS_PORT') ? C('DATA_REDIS_PORT') : 6379,
                'timeout'       => C('DATA_CACHE_TIME') ? C('DATA_CACHE_TIME') : false,
                'auth'          => C('DATA_REDIS_AUTH') ? C('DATA_REDIS_AUTH') : false,
                'select'          => C('DATA_REDIS_DB') ? C('DATA_REDIS_DB') : false,
                'persistent'    => C('DATA_PERSISTENT') ? C('DATA_PERSISTENT') : false,

            );
        }
        $options['host'] = explode(',', $options['host']);
        $options['port'] = explode(',', $options['port']);
        $options['auth'] = explode(',', $options['auth']);
        foreach ($options['host'] as $key=>$value) {
            if (!isset($options['port'][$key])) {
                $options['port'][$key] = $options['port'][0];
            }
            if (!isset($options['auth'][$key])) {
                $options['auth'][$key] = $options['auth'][0];
            }
        }
        self::$option =  $options;
        self::$option['expire'] =  isset($options['expire']) ?  $options['expire']  :   C('DATA_EXPIRE');
        self::$option['prefix'] =  isset($options['prefix']) ?  $options['prefix']  :   C('DATA_CACHE_PREFIX');
        self::$option['length'] =  isset($options['length']) ?  $options['length']  :   0;
        // 一次性创建redis的在不同host的实例
        foreach(self::$option['host'] as $i=>$server) {
            $host=self::$option['host'][$i];
            $port=self::$option['port'][$i];
            $auth=self::$option['auth'][$i];
            if(!(self::$_instance[$i] instanceof self)) {
                self::$_instance[$i]=new self($host,intval($port),$auth);
            }
        }

        // 默认返回第一个实例，即master
        return self::$_instance[0];
    }

    /**
     *判断是否master/slave,调用不同的master或者slave实例
     *
     */
    public function is_master($master=true) {
        if($master) {
            $i=0;
        }else {
            $count=count(self::$option['host']);
            if($count==1) {
                $i=0;
            }else{
                $i=rand(1,$count - 1);
            }
        }
        //返回每一个实例的句柄
        return self::$_instance[$i]->handler;
    }

    /**
     * 读取缓存，随机从slave服务器中读缓存
     * @access public
     * @param string $name 缓存变量名
     * @return mixed
     */
    public function get($name) {
        $redis=$this->is_master(false);
        N('cache_read',1);
        $value = $redis->get(self::$option['prefix'].$name);
        $jsonData  = json_decode( $value, true );
        //检测是否为JSON数据 true 返回JSON解析数组, false返回源数据
        return ($jsonData === NULL) ? $value : $jsonData;

    }

    /**
     * 写入缓存，写入master的redis服务器
     * @access public
     * @param string $name 缓存变量名
     * @param mixed $value  存储数据
     * @param integer $expire  有效时间（秒）
     * @return boolean
     */
    public function set($name, $value, $expire = null) {
        $redis=$this->is_master(true);
        N('cache_write',1);
        if(is_null($expire)) {
            $expire  =  self::$option['expire'];
        }
        $name   =   self::$option['prefix'].$name;
        //对数组/对象数据进行缓存处理，保证数据完整性
        $value  =  (is_object($value) || is_array($value)) ? json_encode($value) : $value;
        if(is_int($expire) && $expire > 0) {
            $result = $redis->setex($name, $expire, $value);
        }else{
            $result = $redis->set($name, $value);
        }
        if($result && self::$option['length']>0) {
            // 记录缓存队列
            $this->queue($name);
        }
        return $result;
    }

    /**
     * 删除缓存
     * @access public
     * @param string $name 缓存变量名
     * @return boolean
     */
    public function rm($name) {
        $redis=$this->is_master(true);
        return $redis->delete(self::$option['prefix'].$name);
    }

    /**
     * 清除缓存
     * @access public
     * @return boolean
     */
    public function clear() {
        $redis=$this->is_master(true);
        return $redis->flushDB();
    }

    /**
     * 禁止外部克隆对象
     *
     */
    private function __clone() {

    }

    //可以根据需要，继续添加phpredis的驱动api.

    /**
     * 关闭长连接
     * @access public
     */
    public function __destruct() {
        if (self::$option['persistent'] == 'pconnect') {
            // 关闭master的长连接，不可以写，但slave任然可以读
            $redis=$this->is_master(true);
            $redis->close();
        }
    }

}
