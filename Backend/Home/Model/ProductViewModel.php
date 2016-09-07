<?php
/**
 * Created by PhpStorm.
 * User: 1
 * Date: 2016/9/6
 * Time: 14:11
 */

namespace Home\Model;

use Think\Model;
use Think\Model\ViewModel;

class ProductViewModel extends ViewModel
{
    //$viewFields 属性表示视图模型包含的字段，每个元素定义了某个数据表或者模型的字段
    public $viewFields = array(
        'Blog'=>array('id','name','title'),
        'Category'=>array('title'=>'category_name', '_on'=>'Blog.category_id=Category.id'),
        'User'=>array('name'=>'username', '_on'=>'Blog.user_id=User.id'),
    );
}