<?php
namespace Home\Controller;

use Think\Controller;
use TwitterAPIExchange;
require 'vendor/autoload.php';

class TwitterAPIController extends Controller
{

    public function index()
    {
        echo 'TwitterAPI';
    }

    //Basic
    public function createApi()
    {
        $settings = [
            'oauth_access_token' => "YOUR_OAUTH_ACCESS_TOKEN",
            'oauth_access_token_secret' => "YOUR_OAUTH_ACCESS_TOKEN_SECRET",
            'consumer_key' => "YOUR_CONSUMER_KEY",
            'consumer_secret' => "YOUR_CONSUMER_SECRET"
        ];
        $url = 'https://api.twitter.com/1.1/blocks/create.json';
        $requestMethod = 'POST';
        $postfields = array(
            'screen_name' => 'usernameToBlock',
            'skip_status' => '1'
        );
        $twitter = new TwitterAPIExchange($settings);
        echo $twitter->buildOauth($url,$requestMethod)->setPostfields($postfields)->performRequest();
    }

    public function getRequestExample()
    {
        $settings = [
            'oauth_access_token' => "YOUR_OAUTH_ACCESS_TOKEN",
            'oauth_access_token_secret' => "YOUR_OAUTH_ACCESS_TOKEN_SECRET",
            'consumer_key' => "YOUR_CONSUMER_KEY",
            'consumer_secret' => "YOUR_CONSUMER_SECRET"
        ];
        $url = 'https://api.twitter.com/1.1/followers/ids.json';
        $getfield = '?screen_name=J7mbo';
        $requestMethod = 'GET';
        $twitter = new TwitterAPIExchange($settings);
        echo $twitter->setGetfield($getfield)->buildOauth($url, $requestMethod)->performRequest();
    }



}