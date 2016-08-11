<?php
namespace Auth\Controller;

use Think\Controller;
use Think\Model;

class IndexController extends Controller
{
    public function index()
    {
        echo '当前访问模块路径：'.__METHOD__;
    }
    
}