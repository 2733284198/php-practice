<?php
/**
 * Created by PhpStorm.
 * User: Tinywan
 * Date: 2016/8/23
 * Time: 23:24
 */
//*************************************Redis Master 设置*************************************
return array(
    'REDIS_MASTER' => array(
        'host' => '127.0.0.1',
        'port' => 6379,
        'auth' => 'mastertestpassword',
    ),
    'REDIS_SLAVE1' => array(
        'host' => '127.0.0.1',
        'port' => 6000,
        'auth' => '',
    ),
    'REDIS_SLAVE2' => array(
        'host' => '127.0.0.1',
        'port' => 6001,
        'auth' => '',
    ),
);