<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/2/27
 * |  Time: 18:30
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Library\Controller;


use Phpml\Classification\KNearestNeighbors;
use Think\Controller;

class MachineLearningController extends Controller
{
    public function index()
    {
        echo 'MachineLearning';
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