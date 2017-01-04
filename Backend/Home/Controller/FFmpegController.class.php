<?php
namespace Home\Controller;

use FFMpeg\FFMpeg;
use FFMpeg\Coordinate;
use FFMpeg\Format;
use Think\Controller;

require 'vendor/autoload.php';

class FFmpegController extends Controller
{

    public function index()
    {
        echo 'FFmpeg';
    }

    //Basic Usage
    public function createFFmpeg()
    {
        $path = 'http://' . $_SERVER['HTTP_HOST'] . __ROOT__ . '/Uploads/FFmpegVideo/';
        $ffmpeg = FFMpeg::create();
        $video = $ffmpeg->open($path.'out.mpg');
        $video->filters()
            ->resize(new Coordinate\Dimension(320, 240))
            ->synchronize();
        $video->frame(Coordinate\TimeCode::fromSeconds(10))
            ->save($path.'frame.jpg');
        $video->save(new Format\Video\X264(),'export-x264123.mp4');
        var_dump($video);
    }

    //Basic Usage
    public function movie()
    {
        $videoPath = 'http://' . $_SERVER['HTTP_HOST'] . __ROOT__ . '/Uploads/FFmpegVideo/out.mpg';
        $movie = new \ffmpeg_movie($videoPath,true);
        var_dump($movie->getDuration());
    }


}