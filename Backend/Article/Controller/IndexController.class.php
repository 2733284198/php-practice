<?php
/**
 *
 */
namespace Article\Controller;
use Think\Auth;
use Think\Controller;
class IndexController extends Controller {
    public function index()
    {
        echo 'Article---index';
        new Auth();
    }
}