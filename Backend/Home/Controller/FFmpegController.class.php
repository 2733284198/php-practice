<?php
namespace Home\Controller;

use Alchemy\BinaryDriver\Listeners\DebugListener;
use FFMpeg\Exception\ExecutableNotFoundException;
use FFMpeg\FFMpeg;
use FFMpeg\Coordinate;
use FFMpeg\FFProbe;
use FFMpeg\Format;
use FFMpeg\Filters;
use Think\Controller;


class FFmpegController extends Controller
{

    public function index()
    {
        echo 'FFmpeg';
    }

    /**
     * 【测试通过！！！！！！！！！！！！！！！！！！！！】
     * 功能：读取视频、设置视频大小、截取视频图片、保存编码过的图片
     * Basic Usageerrdsadsa
     * 在这里可以使用不同的路径
     * 项目路径：这个一定是全域名路径的(http://www.thinkphpstudy.com/Uploads/FFmpegVideo/)
     * 本地磁盘路径：这个则是读取磁盘路径哦！！(F:\Tinywan\Video\ImageOut.mpg)
     */
    public function createFFmpeg()
    {
        //$path = 'http://' . $_SERVER['HTTP_HOST'] . __ROOT__ . '/Uploads/FFmpegVideo/'; //项目路径
        $inPutPath = 'F:\Tinywan\Video\out.mpg';    //本地磁盘路径
        $outPutPath = 'F:\Tinywan\Video\outVideo\\';   //视频输出路径
        $ffmpeg = FFMpeg::create();
        $video = $ffmpeg->open($inPutPath);
        //设置视频大小
        $video->filters()
            ->resize(new Coordinate\Dimension(320, 240))
            ->synchronize();
        //截取视频图片 2s 时候截取
        $video->frame(Coordinate\TimeCode::fromSeconds(2))
            ->save(MEDIA_PATH . '\windows-10.jpg');
        //编码视频编码为X264 同时输出保存
        $video->save(new Format\Video\X264(), MEDIA_PATH . '\windows-10.mp4')
            ->save(new Format\Video\WMV(), MEDIA_PATH . '\windows-wmv.wmv')
            ->save(new Format\Video\WebM(), MEDIA_PATH . '\windows-webm.webm');
        var_dump($video);
    }

    /**
     * 【测试通过！！！！！！！！！！！！！！！！！！！！】
     * 获取一个视频的编码格式 h264
     * 获取一个视频的时长
     */
    public function FFProbe()
    {
        $ffprobe = FFProbe::create();
        $MP4Path = 'F:\Tinywan\Video\out.mpg';
        $encodeFormat = $ffprobe->streams($MP4Path)->videos()->first()->get('codec_name');
        echo '视频格式为：' . $encodeFormat . "<br/>";
        $duration = $ffprobe->format($MP4Path)->get('duration');
        echo '视频的时长:' . $duration . 's';
    }

    /**
     * 【测试通过！！！！！！！！！！！！！！！！！！！！】
     *  功能：MP4格式到MP3格式转换
     *  如果命令可以执行，运行以下行PHP代码配置FFMpeg包装器，并使用它为您的应用程序创建真棒视频功能。
     */
    public function mp4_to_mp3()
    {
        $ffmpeg = FFMpeg::create([
            'ffmpeg.binaries' => 'd:\ffmpeg\bin\ffmpeg.EXE',
            'ffprobe.binaries' => 'd:\ffmpeg\bin\ffprobe.exe',
            'timeout' => 3600,
            'ffmpeg.threads' => 12,
        ]);
        $MP4Path = 'F:\Tinywan\Video\image.mp4';
        //Open your video file
        $video = $ffmpeg->open($MP4Path);
        // Set an audio format
        $audio_format = new Format\Audio\Mp3();
        // Extract the audio into a new file
        $video->save($audio_format, 'ffmpeg_mp3.mp3');
        var_dump($video);
    }

    /**
     * 【测试通过！！！！！！！！！！！！！！！！！！！！】
     * Extracting image 提取图像f
     * 此代码返回一个FFMpeg\Media\Frame对应于第二实例42.您可以通过任何FFMpeg\Coordinate\TimeCode作为参数
     */
    public function extracting_image()
    {
        $ffmpeg = FFMpeg::create();
        $MP4Path = 'F:\Tinywan\Video\out.mpg';
        //Open your video file
        $video = $ffmpeg->open($MP4Path);
        $rand = mt_rand(000, 222);
        //Set an image cut time
        $frame = $video->frame(Coordinate\TimeCode::fromSeconds($rand));
        // Extract the image into a new file
        $images = $frame->save(MEDIA_PATH . '\ffmpeg_mp4_' . $rand . '.jpg');
        var_dump($images);
    }

    /**
     * 【测试通过！！！！！！！！！！！！！！！！！！！！】
     *  提取多张图像
     */
    public function extracting_multiple_image()
    {
        $ffmpeg = FFMpeg::create();
        $MP4Path = 'F:\Tinywan\Video\out.mpg';
        $video = $ffmpeg->open($MP4Path);
        $video->filters()
            ->extractMultipleFrames(Filters\Video\ExtractMultipleFramesFilter::FRAMERATE_EVERY_2SEC, MEDIA_PATH . '/image/')//这是是一个文件夹
            ->synchronize();
        $video->save(new Format\Video\X264(), MEDIA_PATH . '/extracting_multiple_image.mp4'); //这里必须执行输出文件名
        var_dump($video);
    }

    /**
     * 【测试通过！！！！！！！！！！！！！！！！！！！！】
     * 功能：视频剪切
     * 注意：开始时间和持续时间必须小于视频总时间否则编码错误！！！
     * 剪辑过滤器有两个参数：
     *      $start的一个实例FFMpeg\Coordinate\TimeCode，指定了剪辑的开始点
     *      $duration的，可选的一个实例FFMpeg\Coordinate\TimeCode，指定了剪辑的持续时间
     *
     */
    public function Clip($startTime = 200, $duration = 25)
    {
        $ffmpeg = FFMpeg::create();
        $ffprobe = FFProbe::create();
        $MP4Path = 'F:\Tinywan\Video\output64.mp4';
        $video = $ffmpeg->open($MP4Path);
        $currentDuration = $ffprobe->format($MP4Path)->get('duration');
        //判断截取的视频长度是否大于视频本身最大长度，
        if (($startTime + $duration) > floor($currentDuration)) exit('截取视频长度参数错误!请合理的设置开始时间和持续时间');
        //开始截取
        $video->filters()->clip(Coordinate\TimeCode::fromSeconds($startTime), Coordinate\TimeCode::fromSeconds($duration));
        $video->save(new Format\Video\X264(), floor($currentDuration).'_'.$startTime.'_'.$duration.'.mp4');
        var_dump($video);
    }

    public function debugInfo()
    {
        //打印编译步骤信息
        $ffmpeg = FFMpeg::create();
        $ffmpeg->getFFMpegDriver()->listen(new DebugListener());
        $ffmpeg->getFFMpegDriver()->on('debug', function ($message) {
            echo $message . "/n";
        });
    }

    /**
     * 将视频旋转到给定的角度。Rotates a video to a given angle.
     */
    public function video_rotate()
    {
        $ffmpeg = FFMpeg::create();
        $MP4Path = 'http://' . $_SERVER['HTTP_HOST'] . __ROOT__ . '/Uploads/FFmpegVideo/ffmpeg_mp4.mp4';
        //Open your video file
        $video = $ffmpeg->open($MP4Path);
        //The resize filter takes three parameters :
        $format = $video->filters()->rotate(Filters\Video\RotateFilter::ROTATE_90);
        // Extract the image into a new file
        $video->save($format, 'ffmpeg_mp4_90.mp4');
        var_dump($video);
    }

    /**
     * Watermark
     * 使用给定图像对视频进行水印。
     * 错误信息：Encoding failed
     */
    public function videoWatermark()
    {
        $inPutPath = 'F:\Tinywan\Video\out.mpg';    //本地磁盘路径
        $ffmpeg = FFMpeg::create([
            'ffmpeg.binaries' => 'd:\ffmpeg\bin\ffmpeg.EXE',
            'ffprobe.binaries' => 'd:\ffmpeg\bin\ffprobe.exe',
            'timeout' => 3600,
            'ffmpeg.threads' => 12,
        ]);
        $video = $ffmpeg->open($inPutPath);
        $watermarkPath = 'F:\Tinywan\Video\amailogo.png';
        $video->filters()->watermark($watermarkPath, array(
            'position' => 'absolute',
            'x' => 1180,
            'y' => 620,
        ));
        //编码视频编码为X264 同时输出保存
        $video->save(new Format\Video\X264(), 'Watermark2.mp4');
        var_dump($video);
    }

    /**
     * Transcoding StackOverflow
     * 您可以使用音频转码FFMpeg\Media\Audio:save的方法。您将通过一个FFMpeg\Format\FormatInterface针对
     */
    public function Transcoding()
    {
        $ffmpeg = FFMpeg::create();
        $MP4Path = 'http://' . $_SERVER['HTTP_HOST'] . __ROOT__ . '/Uploads/FFmpegVideo/ffmpeg_mp4.mp4';
        $watermarkPath = 'F:\Tinywan\Video\00018.jpg';
        //Open your video file StackOverflow
        $video = $ffmpeg->open($MP4Path);
        //The resize filter takes three parameters :
        $format = $video->filters()->watermark($watermarkPath, array('position' => 'relative', 'bottom' => 50, 'right' => 50));
        // Extract the image into a new file
        $video->save($format, 'ffmpeg_mp4_Watermark.mp4');
        var_dump($video);
    }

    /**
     * 的一种格式实现FFMpeg\Format\FormatInterface。
     * 要保存到视频文件，使用FFMpeg\Format\VideoInterface和FFMpeg\Format\AudioInterface音频文件。
     */
    public function Formats()
    {
        $ffmpeg = FFMpeg::create();
        $MP4Path = 'http://' . $_SERVER['HTTP_HOST'] . __ROOT__ . '/Uploads/FFmpegVideo/ffmpeg_mp4.mp4';
        $video = $ffmpeg->open($MP4Path);
        //The resize filter takes three parameters :
        $format = new Format\Video\X264();
        $format->on('progress', function ($video, $format, $percentage) {
            echo "$percentage % transcoded";
        });
        // Extract the image into a new file
        $video->save($format, 'video.avi');
        var_dump($video);
    }


    public function test()
    {
        $ffprobe = FFProbe::create();
        var_dump($ffprobe);
    }


}