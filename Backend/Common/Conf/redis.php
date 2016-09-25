<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/8/23
 * Time: 23:24
 */
//*************************************Redis Master 设置*************************************
return array(
    'MASTER' => array(
        'HOST' => '121.41.88.209',
        'PORT' => 63789,
        'TIMEOUT' => 0,
        'AUTH' => '',
        'DB' => 0,
    ),
    'SLAVE1' => array(
        'HOST' => '127.0.0.1',
        'PORT' => 63579,
        'TIMEOUT' => 0,
        'AUTH' => 'amaitestredis',
        'DB' => 10,
    ),
    'SLAVE2' => array(
        'HOST' => '127.0.0.1',
        'PORT' => 63579,
        'TIMEOUT' => 0,
        'AUTH' => 'amaitestredis',
        'DB' => 10,
    ),
    //*************************************TP 自带缓存 Redis 设置*************************************
    'REDIS_HOST' =>'218.244.141.124',
    'REDIS_PORT' => 63579,
    'REDIS_TIMEOUT' => 0,
    'REDIS_PREFIX' =>'redis_',
    'REDIS_AUTH'   =>'amaitestredis',
    'REDIS_DB'   =>10,
    //*************************************Redis 缓存以及主从复制 设置*************************************
    //默认第一个是master，其余的是slave
    'DATA_CACHE_TYPE' =>'Redis',
    'DATA_REDIS_HOST' =>'localhost,localhost',
    'DATA_REDIS_PORT' =>'6379,6380',
    'DATA_CACHE_TIME' => 30,
    'DATA_CACHE_PREFIX' =>'redis_',
    'DATA_PERSISTENT'   => true,
    'DATA_REDIS_AUTH'   =>'amaitestredis',
    'DATA_REDIS_DB'   =>10,
);