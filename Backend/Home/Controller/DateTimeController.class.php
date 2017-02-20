<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/2/20
 * |  Time: 8:36
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Home\Controller;


use Think\Controller;

class DateTimeController extends Controller
{
    public function index()
    {
        echo 'DateTime';
    }

    /**
     * //构造新的UTC日期。 总是指定UTC，除非你真的知道你在做什么！
     */
    public function utcOperator()
    {
        //构造新的UTC日期。 总是指定UTC，除非你真的知道你在做什么！
        $date = new \DateTime('2011-05-04 05:00:00',new \DateTimeZone('UTC'));

        //将十天添加到我们的初始日期
        $date->add(new \DateInterval('P10D'));
        echo($date->format('Y-m-d h:i:s')); // 2011-05-14 05:00:00

        //很遗憾，我们没有中地球时区,将UTC日期转换为PST（或PDT，取决于）时区
        $date->setTimezone(new \DateTimeZone('America/Los_Angeles'));

        // 请注意，如果你自己跑这条线，它可能是由一个小时因夏令不同
        echo($date->format('Y-m-d h:i:s')); // 2011-05-13 10:00:00

        $later = new \DateTime('2012-05-20', new \DateTimeZone('UTC'));

        // Compare two dates
        if($date < $later)
            echo('Yup, you can compare dates using these easy operators!');

        // Find the difference between two dates
        $difference = $date->diff($later);

        echo('The 2nd date is ' . $difference['days'] . ' later than 1st date.');
    }
}