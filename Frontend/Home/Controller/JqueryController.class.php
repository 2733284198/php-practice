<?php
namespace Home\Controller;
use Think\Controller;

/**
 * Class JqueryController
 * @package Home\Controller
 */
class JqueryController extends Controller
{
    public function index()
    {
        echo 'Jquery';
    }

    public function demo1(){
        $this->display();
    }
}