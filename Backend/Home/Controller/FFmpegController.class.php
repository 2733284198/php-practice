<?php
namespace Home\Controller;

use FFMpeg\FFMpeg;
use Think\Controller;
require 'vendor/autoload.php';

class FFmpegController extends Controller
{

    public function index(){
        echo 'FFmpeg';
    }
    //Basic Usage
    public function createFFmpeg(){
        $ffmpeg =   FFMpeg::create();
        var_dump($ffmpeg);
    }





}