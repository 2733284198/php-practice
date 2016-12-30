<?php
namespace Home\Controller;


class WebRTCController extends BaseController
{
    public function index()
    {
        echo 'Welocome WebRTC';
    }

    public function test()
    {
        $this->display('WebRTC/test');
    }

    /**
     * 一个超级简单的例子
     * 这里写一个超级简单的例子，用来展现getUserMedia的效果：
     */
    public function getUserMedia()
    {
        $this->display('WebRTC/getusermedia');
    }

    public function RecordRTC()
    {
        $this->display('WebRTC/recordrtc');
    }

    public function uploadAudio()
    {
        $upload = __ROOT__ . '/Uploads/RecordRTC/';
        foreach (array('video', 'audio') as $type) {
            if (isset($_FILES["${type}-blob"])) {
                $fileName = $_POST["${type}-filename"];
                $uploadDirectory = $upload . $fileName;
                if (!move_uploaded_file($_FILES["${type}-blob"]["tmp_name"], $uploadDirectory)) {
                    echo(" problem moving uploaded file");
                }
                echo($uploadDirectory);
            }
        }
    }
}