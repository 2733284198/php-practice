<?php
/** .-------------------------------------------------------------------
 * |  Github: https://github.com/Tinywan
 * |  Blog: http://www.cnblogs.com/Tinywan
 * |-------------------------------------------------------------------
 * |  Author: Tinywan
 * |  Date: 2017/1/20
 * |  Time: 16:25
 * |  Mail: Overcome.wan@Gmail.com
 * |  Created by PhpStorm.
 * '-------------------------------------------------------------------*/

namespace Home\Controller;
use Github\Client;
use Think\Controller;

class GitHubController extends Controller
{
    public function index()
    {
        echo 'GitHub';
    }

    /**
     * Basic usage of php-github-api client
     */
    public function client()
    {
        $client = new Client();
        $keys = $client->user()->keys()->all();
        var_dump($keys);
    }

}