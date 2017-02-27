<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/2/27
 * |  Time: 9:40
 * |  Mail: Overcome.wan@Gmail.com
 * |  https://github.com/php-ai/php-ml
 * '-------------------------------------------------------------------*/

namespace Library\Controller;


use Phpml\Classification\KNearestNeighbors;
use Think\Controller;

class MachineLearning extends Controller
{
    public function index()
    {
        echo 'PHP-ML - Machine Learning library for PHP 对PHP的请求是一个谦虚的HTTP请求库。 它简化了您如何与其他网站进行互动，并消除所有的后顾之忧。';
    }

    //PHP的机器学习库(PHP-ML - Machine Learning library for PHP)
    public function simpleExample()
    {
        $samples = [[1, 3], [1, 4], [2, 4], [3, 1], [4, 1], [4, 2]];
        $labels = ['a', 'a', 'a', 'b', 'b', 'b'];
        $classifier = new KNearestNeighbors();
        $classifier->train($samples,$labels);
        $result = $classifier->predict([3,2]); // return b
        echo $result;
        var_dump($classifier);
    }
}