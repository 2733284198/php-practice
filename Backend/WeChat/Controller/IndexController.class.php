<?php
namespace WeChat\Controller;

use Org\Util\UserAgent;
use Think\Controller;
use Think\Log;

class IndexController extends Controller
{
    /**
     * 这里采用高级授权模式，为了获取用户信息
     * 这个页面是用户进来就能够刚问的页面，也就是首次进来的页面
     * 首先访问的地址 ；http://wechatu.xd107.com/home/WeiXin/index
     */
    public function index($redirect_url = "http://wechatu.xd107.com/")
    {
        if (!isWeiXin()) return $this->error("提示", "请在微信中打开链接");

        /*高级授权 snsapi_userinfo*/
        $redirect_uri = urlencode('http://wechatu.xd107.com/home/WeiXin/getUserInfo');

        $url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" . C('WECHAT_OAUTH2.DOMAIN') . "&redirect_uri=" . $redirect_uri . "&response_type=code&scope=snsapi_userinfo&state=1234#wechat_redirect";
        //跳转
        $this->redirect($url);
        //header('location:' . $url);
    }

    /*拉取用户信息*/
    public function getUserInfo()
    {
        $appid = 'wx94c43716d8a91f3f';
        $appsecret = 'd4624c36b6795d1d99dcf0547af5443d';
        /*回调的时候自带的这个参数*/
        $code = $_GET['code'];

        /*基本授权 snsapi_base*/
        //$url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=".$appid."&redirect_uri=".$redirect_uri."&response_type=code&scope=snsapi_base&state=1234#wechat_redirect";
        $url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" . $appid . "&secret=" . $appsecret . "&code=" . $code . "&grant_type=authorization_code";

        $result = json_decode(curlPost($url, $parm = null), true);

        /*取出数组中的access_token这个值*/
        $access_token = $result['access_token'];
        $openid = $result['openid'];
        $URL2 = "https://api.weixin.qq.com/sns/userinfo?access_token=" . $access_token . "&openid=" . $openid . "&lang=zh_CN";
        $responseInfo = json_decode(curlPost($URL2, $parameter = null), true);
        $_SESSION['headimgurl'] = $responseInfo['headimgurl'];
        // var_dump($responseInfo);
        // die;
        $this->headimgurl = $responseInfo['headimgurl'];
        $this->userInfo = $responseInfo;
        $this->display();
    }


    /*
     * 获取“分享到朋友圈”按钮点击状态及自定义分享内容接口
     *
    */
    public function share()
    {
        /*获取 jsapi_ticket 临时票据 */
        $noncestr = $this->getRandCode(); // 必填，生成签名的随机串
        $jsapi_ticket = $this->getJsApiTicket();
        $timestamp = time();        // 必填，生成签名的时间戳
        $url = "http://wechatu.xd107.com/home/WeiXin/share";

        /* 获取 signature */
        $signature = "jsapi_ticket=" . $jsapi_ticket . "&noncestr=" . $noncestr . "&timestamp=" . $timestamp . "&url=" . $url;
        $signature = sha1($signature);

        $this->name = '微信测试数据二维码';
        $this->appid = 'wx94c43716d8a91f3f';
        $this->timestamp = $timestamp;
        $this->noncestr = $noncestr;
        $this->signature = $signature;
        $this->nonceStr = $noncestr;
        $this->display('share');
    }

    /*
     * jsapi_ticket是公众号用于调用微信JS接口的临时票据
     *
     */
    public function getJsApiTicket()
    {
        if ($_SESSION['jsapi_ticket_expire_time'] > time() && $_SESSION['jsapi_ticket']) {
            $jsapi_ticket = $_SESSION['jsapi_ticket'];
        } else {
            $access_token = $this->getAccessToken();
            $url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=" . $access_token . "&type=jsapi";
            $result = json_decode(curlPost($url, $parameter = ''), true);
            $jsapi_ticket = $result['ticket'];
            $_SESSION['jsapi_ticket'] = $jsapi_ticket;
            $_SESSION['jsapi_ticket_expire_time'] = time() + 7000;
        }
        return $jsapi_ticket;
    }

    public static function getOAuth2CodeUrl($options) {
        $APPID = $options->appid;
        $SCOPE = $options->scope;
        $STATE = $options->state;
        $REDIRECT_URI = urlencode($options->redirect_uri);

        $url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=".$APPID."&redirect_uri=".$REDIRECT_URI."&response_type=code&scope=".$SCOPE."&state=".$STATE."#wechat_redirect";
        return $url;
    }

    public static function getOAuth2AccessToken($options) {
        $APPID = $options->appid;
        $SECRET = $options->appsecret;
        $CODE = $options->code;
        $url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=".$APPID."&secret=".$SECRET."&code=".$CODE."&grant_type=authorization_code";

        Log::debug("Wechat:getOAuth2AccessToken => " . $url);

        $raw = file_get_contents($url);

        return $raw;
    }

    public function test()
    {
        var_dump(C('WECHAT_OAUTH2.APPID'));
        var_dump(C('WECHAT_OAUTH2.APPSECRET'));
    }

}