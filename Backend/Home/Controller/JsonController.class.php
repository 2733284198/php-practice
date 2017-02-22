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

use Seld\JsonLint\JsonParser;
use Think\Controller;
use Think\Log;

class JsonController extends Controller
{
    public function index()
    {
        echo 'Json';
    }

    public function index2()
    {
        //如果它是有效的json则返回null，否则返回一个ParsingException对象。
        $jsonString = <<<JSOM
           {
    "name": "topthink/thinkphp",
    "description": "the ThinkPHP Framework",
    "type": "framework",
    "keywords": [
        "framework",
        "thinkphp",
        "ORM"
    ],
    "homepage": "http://www.cnblogs.com/tinywan/",
    "license": "Apache2",
    "authors": [
        {
            "name": "Tinywan",
            "email": "ovecome.wan@gmail.com"
        }
    ],
    "require": {
        "php": ">=5.3.0",
        "monolog/monolog": "^1.22",
        "php-ffmpeg/php-ffmpeg": "0.9.0",
        "j7mbo/twitter-api-php": "dev-master",
        "hisune/echarts-php": "~1.0.6",
        "phpoffice/phpexcel": "^1.8",
        "matyhtf/swoole_framework": "dev-master",
        "intervention/image": "1.*",
        "mpociot/botman": "^1.3",
        "knplabs/github-api": "^2.0",
        "php-http/guzzle6-adapter": "^1.1",
        "aliyuncs/oss-sdk-php": "^2.2",
        "league/oauth2-client": "^1.4",
        "fzaninotto/faker": "^1.6",
        "qiniu/php-sdk": "^7.1",
        "mobiledetect/mobiledetectlib": "^2.8",
        "ezyang/htmlpurifier": "^4.8",
        "overtrue/wechat": "~3.1",
        "seld/jsonlint": "^1.5"
    },
    "minimum-stability": "dev",
    "autoload": {
        "psr-4": {
            "Addons\\": "Addons"
        }
    }
}
JSOM;

        $parser = new JsonParser();
        $jsonFile = MEDIA_PATH . '\composer.json';
        var_dump($parser->lint($jsonString));
    }
}