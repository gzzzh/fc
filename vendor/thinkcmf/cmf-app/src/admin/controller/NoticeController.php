<?php
namespace app\admin\controller;

use think\cache\driver\Redis;
use cmf\controller\HomeBaseController;
use think\Db;
class NoticeController extends HomeBaseController
{

	/*
    配置参数
    */
    private $config = [
        'appid' => "wx2759a229ef410aef",//公众号ID
        'api_key' => 'ce0bfd15059b68d67688884d7a3d3e8c',
        'appsecret' => '648923a26624549c1fae6e0445bd2436',
    ];



    private $message = [
        'fk' => "FaOmliO_KXm_m_yYzHpr5ZBCUVhkhf-_5hxJcEAyFHM",//付款
        'fh' => "mGpZzl5l0_WKyslshoLjjAS8w1VIgWfnuT-wVoc6DmQ",//已发货
        'jj' => '4vQOKx_Ft73J6xTb1tKFbYbsGcH3mDLu6YZuTiITt1Y',//晋级
        'sy' => 'ZlJ2w6RpppMXIukrsFduFA-4yUuzl_5h8HG88IO5IGg',//收益
        'tx' => 'Skf0DwW5w0PSIy8UAKB9uBSsIBqRM1ZPN4WKW0334X4',//提现
        'txdz' => 'Y5roTILxjZJquFf4KpvNw_nies2rbOnozSruGWzAn9w',//提现到账
        'fangke' => 'h9p3h9U2g9FKmq5R1ohGP_5WsRugwhHJhGKdLApdckg',//用户访客
        'xjgm' => 'Vp3IZw2IHtjsqTKXTAAII7I3I18dSTFx5dodAjHrruQ',//下级首次购买
    ];



    /**
    *
    *发送模板消息
    *
    **/
    public function sendNoticeMessage($keys, $data, $return_url, $open_id = '', $member_id)
    {

    	//发送类型,匹配
        WL(['msg' => 'admin发送通知消息', 'type' => $keys], 'send_msg');
    	if(empty($keys) || empty($this->message[$keys]) || empty($member_id))
    	{
    		WL(['msg' => '模板类型为空,无法发送', 'keys' => $keys], 'send_msg');
    		return;
    	}

    	$appid = $this->config['appid'];
        $appsecret = $this->config['appsecret'];


    	//access_token是否存在
    	//$redis = new Redis();
        //$str = 'access_token_member_uid';
        //$access_token = $redis->get($str);
        //if(empty($access_token))
        //{
        	$url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=".$appid."&secret=".$appsecret;
	        $json_token = $this->curl_post($url);
	        $res_data = json_decode($json_token, true);


            WL(['msg' => '获取token', 'res_data' => $res_data], 'send_msg');
	        $access_token = $res_data['access_token'];

	       	//$redis->set($str, $access_token, 7000);
        //}

        //找出用户OPEN——ID
        //$memModel = new \app\home\model\MemberModel();
		//$member_info = $memModel->getMemberIdWhereMemberId($member_id, 'member_id, open_id');
        $member_info = Db::name('member')->where('member_id', $member_id)->field('member_id, open_id')->find();

		if(empty($open_id))
		{
			$open_id = $member_info['open_id'];
		}
		

        //组装提醒数据
		$template = [
            'touser' => $open_id,//openID
            'template_id' => $this->message[$keys],//模版id
            'url' => $return_url,
            'data' => $data,
        ];


		
        //发送模板通知
        $params = json_encode($template, JSON_UNESCAPED_UNICODE);
        $url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=".$access_token;
        $params = $this->curl_post($url, urldecode($params));
        $params = json_decode($params, true);

        WL(['msg' => '请求Wx', 'params' => $params], 'send_msg');
        if($params['errcode'] == 0){
        	WL(['msg' => 'ok', 'keys' => $params], 'send_msg');
            return '发送成功';

        }else{
        	WL(['msg' => 'error', 'keys' => $params], 'send_msg');

            return '发送失败';
        }
    }



    /**
     *  curl请求
     * @param $url  请求的目的地址
     * @param array $data 请求带的数据
     * @return mixed
     *
     */
    public function curl_post($url , $data=array())
    {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);
        // POST数据
        curl_setopt($ch, CURLOPT_POST, 1);
        // 把post的变量加上
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        $output = curl_exec($ch);
        curl_close($ch);
        return $output;
    }

}