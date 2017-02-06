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
        $faker = Factory::create();
        echo $faker->name."<br/>";
        echo $faker->address;
    }
}