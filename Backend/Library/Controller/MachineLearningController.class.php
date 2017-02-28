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


use Phpml\Association\Apriori;
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
        $classifier->train($samples, $labels);
        $result = $classifier->predict([3, 2]); // return b
        echo $result;
        var_dump($classifier);
    }

    /**
     * 基于Apriori算法的关联规则学习，用于频繁项集集挖掘。
     * $(support)信心，列车样本中设置的频繁项目的最小相对量
     * $(confidence)置信度，频繁项目集中设置的项目的最小相对量
     */
    public function Apriori()
    {
        /**
         * 培养,训练关联者只需提供列车样本和标签（as array）
         * 您可以使用多个数据集训练关联器，预测将基于所有训练数据。
         */
        $samples = [['alpha', 'beta', 'epsilon'], ['alpha', 'beta', 'theta'], ['alpha', 'beta', 'epsilon'], ['alpha', 'beta', 'theta']];
        $labels = [];
        $associator = new Apriori($support = 0.5, $confidence = 0.5);
        $associator->train($samples, $labels);
        /**
         * 预测
         * 样品标签使用predict方法。您可以提供一个样品或样品数组
         */
        $res1 = $associator->predict(['alpha', 'theta']);    // return [[['beta']]]
        var_dump($res1);
        $res2 = $associator->predict([['alpha', 'epsilon'], ['beta', 'theta']]);   // return [[['beta']], [['alpha']]]
        var_dump($res2);
        /**
         * 关联
         * 获取生成的关联规则只需使用rules方法。
         */
        $associator->getRules();
        // return [['antecedent' => ['alpha', 'theta'], 'consequent' => ['beta], 'support' => 1.0, 'confidence' => 1.0], ... ]

        /**
         * 频繁项目集
         * 生成k长度频繁项集只需使用apriori方法。
         */
        $associator->apriori();
        // return [ 1 => [['alpha'], ['beta'], ['theta'], ['epsilon']], 2 => [...], ...]

    }
}