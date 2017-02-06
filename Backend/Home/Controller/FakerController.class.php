<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/2/6
 * |  Time: 11:28
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Home\Controller;


use Faker\Factory;

class FakerController
{
    public function Basic_Usage()
    {
        $faker = Factory::create($locale = 'zh_CN');
        echo $faker->name . "<br/>";
        echo $faker->address . "<br/>";
        for ($i = 0; $i < 10; $i++) {
            echo $faker->name, "<br/>";
        }
        //适用于抛出异常的字符串格式化输出
        //throw new \InvalidArgumentException(sprintf('Unable to find provider "%s" with locale "%s"', $faker->name, $faker->address));
    }
}