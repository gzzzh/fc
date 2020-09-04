<?php
namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;
use think\db\Query;

define("APPID", "wx2759a229ef410aef"); // 商户账号appid
define("MCHID", "1581874891");  // 商户号
define("SECRECT_KEY", "SDFJW8HD289cc3ss778tHHUDfSFsss99"); //支付密钥签名
define("IP", $_SERVER['SERVER_ADDR'] ); //IP

class TxController extends AdminBaseController
{


	/**
	*
	*提现列表
	*
	**/
	public function index()
	{
		$content = hook_one('admin_user_index_view');

        if (!empty($content)) {
            return $content;
        }

        $status = trim($this->request->param('status', 1));
        $member_id = trim($this->request->param('member_id', ''));

        if(!empty($member_id))
        {
			$list = Db::name('withdrawals')->where('status',$status)->where('member_id', $member_id)->order("add_time DESC")->paginate(20);
        }else{
        	$list = Db::name('withdrawals')->where('status',$status)->order("add_time DESC")->paginate(20);
        }
        
        
        // 获取分页显示
        $page = $list->render();

        $list = $list->toArray();
        foreach ($list['data'] as $key => $value) 
        {
        	$m_info = Db::name('member')->where('member_id', $value['member_id'])->field('member_id, nickname, money')->find();
            $list['data'][$key]['nickname'] = $m_info['nickname'];
            $list['data'][$key]['member_money'] = $m_info['money'];
        }

        $this->assign("status", $status);
        $this->assign("member_id", $member_id);

        $this->assign("page", $page);
        $this->assign("list", $list['data']);
        return $this->fetch();
	}


	/**
	*
	*提现-通过
	*
	**/
	public function txPass()
	{
		$id = trim($this->request->param('id', ''));
		if(empty($id)) $this->error("参数非法，无法通过");

		$info = Db::name('withdrawals')->where('id', $id)->find();
		if(empty($info)) $this->error("数据不存在");

		//直接修改状态
		Db::startTrans();
		$res = Db::name('withdrawals')->where('id', $id)->where('status', 1)->update(['status' => 2]);
		if(empty($res))
		{
			Db::rollback();
			$this->error("该提现记录已被操作，请刷新页面");
		}

		//用户信息
		$member_info = Db::name('member')->where('member_id', $info['member_id'])->field('member_id, money, open_id')->find();

		//微信那边提现
		$partner_trade_no = date('YmdHis').rand(1000, 9999);
		$res = $this->sendMoney($info['money'], $member_info['open_id'], $partner_trade_no);
		//提现成功
		if($res['result_code'] == 'SUCCESS')
		{
			//修改财务日志状态
			$where = [
				['member_id', '=', $member_info['member_id']],
				['type', '=', 5],
				['status', '=', 1],
				['table_id', '=', $id],

			];
			$res = Db::name('finance')->where($where)->update(['status' => 2]);
			if(empty($res))
			{
				WL(['msg' => '提现更新财务日志失败', 'id' => $id], 'tx_update_finance');
			}

			Db::commit();

			//提现成功，通知消息
	        $notice_contro = new NoticeController();
	        $send_data = [
	            'first' => ['value'=>'您的提现已到账', 'color'=>"#173177"],
	            'keyword1' => ['value'=> $info['add_time'], 'color'=>'#173177'],
	            'keyword2' => ['value'=> date('Y-m-d H:i:s'), 'color'=>'#173177'],
	            'keyword3' => ['value'=> $info['money'], 'color'=>'#173177'],
	            'keyword4' => ['value'=> $member_info['money'], 'color'=>'#173177'],
	       
	            'remark' => ['value'=>'点击查看详情', 'color'=>'#173177']
	        ];
	        $return_url = WEB_URL."/tx_list";
	        $notice_contro->sendNoticeMessage('txdz', $send_data, $return_url, '', $info['member_id']);

			$this->success('提现成功');
		}else{
			WL(['msg' => '用户提现', 'data' => $res], 'tx_member');
			Db::rollback();
			$this->error("提现失败，系统错误");
		}
		
	}



	/**
	*
	*提现-驳回
	*
	**/
	public function txRejected()
	{

		$id = trim($this->request->param('id', ''));
		if(empty($id)) $this->error("参数非法，无法通过");

		$info = Db::name('withdrawals')->where('id', $id)->find();
		if(empty($info)) $this->error("数据不存在");

		//直接修改状态
		Db::startTrans();
		$res = Db::name('withdrawals')->where('id', $id)->where('status', 1)->update(['status' => 3]);
		if(empty($res))
		{
			$this->error("该提现记录已被操作，请刷新页面");
		}

		//用户信息
		$member_info = Db::name('member')->where('member_id', $info['member_id'])->field('member_id, money')->find();

		//返回余额
		$money = $member_info['money'] + $info['money'];
		$member_res = Db::name('member')->where('member_id', $info['member_id'])->update(['money' => $money]);
		
		//驳回成功
		if(!empty($member_res))
		{
			//修改财务日志状态
			$where = [
				['member_id', '=', $member_info['member_id']],
				['type', '=', 5],
				['status', '=', 1],
				['table_id', '=', $id],
			];
			$res = Db::name('finance')->where($where)->update(['status' => 3]);
			if(empty($res))
			{
				WL(['msg' => '提现更新财务日志失败', 'id' => $id], 'tx_update_finance');
			}

			Db::commit();

			//提现失败，通知消息
	        $notice_contro = new NoticeController();
	        $send_data = [
	            'first' => ['value'=>'您的提现已被驳回，请联系客服', 'color'=>"#173177"],
	            'keyword1' => ['value'=> $info['add_time'], 'color'=>'#173177'],
	            'keyword2' => ['value'=> date('Y-m-d H:i:s'), 'color'=>'#173177'],
	            'keyword3' => ['value'=> 0, 'color'=>'#173177'],
	            'keyword4' => ['value'=> $money, 'color'=>'#173177'],
	       
	            'remark' => ['value'=>'点击查看详情', 'color'=>'#173177']
	        ];
	        $return_url = WEB_URL."/tx_list";
	        $notice_contro->sendNoticeMessage('txdz', $send_data, $return_url, '', $info['member_id']);

			$this->success('驳回提现成功');
		}else{
			Db::rollback();
			$this->error("驳回提现失败，系统错误");
		}
	}



	/**
	 * [sendMoney 企业付款到零钱]
	 * @param [type] $amount  [发送的金额（分）目前发送金额不能少于1元]
	 * @param [type] $re_openid [发送人的 openid]
	 * @param string $desc  [企业付款描述信息 (必填)]
	 * @param string $check_name [收款用户姓名 (选填)]
	 * @return [type]    [description]
	 */
	function sendMoney($amount,$re_openid,$partner_trade_no,$check_name='',$desc='启蒙优选提现')
	{

    $total_amount = (100) * $amount;

    $data = array(
        'mch_appid'=>APPID,//商户账号appid
        'mchid'=> MCHID,//商户号
        'nonce_str'=> $this->createNoncestr(),//随机字符串
        'partner_trade_no'=> $partner_trade_no,//date('YmdHis').rand(1000, 9999),//商户订单号
        'openid'=> $re_openid,//用户openid
        'check_name'=>'NO_CHECK',//校验用户姓名选项,
        're_user_name'=> $check_name,//收款用户姓名
        'amount'=>$total_amount,//金额
        'desc'=> $desc,//企业付款描述信息
        'spbill_create_ip'=> IP,//Ip地址
    );
    if($check_name)
    {
        $data['check_name'] = 'CHECK';
    }
    
    //生成签名算法
    $secrect_key=SECRECT_KEY;///这个就是个API密码。MD5 32位。
    $data=array_filter($data);
    ksort($data);
    $str='';
    foreach($data as $k=>$v) {
        $str.=$k.'='.$v.'&';
    }
    $str.='key='.$secrect_key;
    $data['sign']=md5($str);
    //生成签名算法


    $xml=$this->arraytoxml($data);

    $url='https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers'; //调用接口
    $res=$this->curl_post_ssl($url,$xml);
    $return=$this->xmltoarray($res);
    return $return;
	}


	/**
	 * [curl_post_ssl 发送curl_post数据]
	 * @param [type] $url  [发送地址]
	 * @param [type] $xmldata [发送文件格式]
	 * @param [type] $second [设置执行最长秒数]
	 * @param [type] $aHeader [设置头部]
	 * @return [type]   [description]
	 */
	function curl_post_ssl($url, $xmldata, $second = 30, $aHeader = array())
	{
	    $isdir = CMF_ROOT."cert/";//证书位置;绝对路径
	    $ch = curl_init();//初始化curl

	    curl_setopt($ch, CURLOPT_TIMEOUT, $second);//设置执行最长秒数
	    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);//要求结果为字符串且输出到屏幕上
	    curl_setopt($ch, CURLOPT_URL, $url);//抓取指定网页
	    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);// 终止从服务端进行验证
	    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);//
	    curl_setopt($ch, CURLOPT_SSLCERTTYPE, 'PEM');//证书类型
	    curl_setopt($ch, CURLOPT_SSLCERT, $isdir . 'apiclient_cert.pem');//证书位置
	    curl_setopt($ch, CURLOPT_SSLKEYTYPE, 'PEM');//CURLOPT_SSLKEY中规定的私钥的加密类型
	    curl_setopt($ch, CURLOPT_SSLKEY, $isdir . 'apiclient_key.pem');//证书位置
	    if (count($aHeader) >= 1) {
	        curl_setopt($ch, CURLOPT_HTTPHEADER, $aHeader);//设置头部
	    }
	    curl_setopt($ch, CURLOPT_POST, 1);//post提交方式
	    curl_setopt($ch, CURLOPT_POSTFIELDS, $xmldata);//全部数据使用HTTP协议中的"POST"操作来发送

	    $data = curl_exec($ch);//执行回话
	    curl_close($ch);
	    return $data;
	}


	/**
	 * [xmltoarray xml格式转换为数组]
	 * @param [type] $xml [xml]
	 * @return [type]  [xml 转化为array]
	 */
	function xmltoarray($xml) {
	    //禁止引用外部xml实体
	    libxml_disable_entity_loader(true);
	    $xmlstring = simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA);
	    $val = json_decode(json_encode($xmlstring),true);
	    return $val;
	}

	/**
	 * [arraytoxml 将数组转换成xml格式（简单方法）:]
	 * @param [type] $data [数组]
	 * @return [type]  [array 转 xml]
	 */
	function arraytoxml($data){
	    $str='<xml>';
	    foreach($data as $k=>$v) {
	        $str.='<'.$k.'>'.$v.'</'.$k.'>';
	    }
	    $str.='</xml>';
	    return $str;
	}

	/**
	 * [createNoncestr 生成随机字符串]
	 * @param integer $length [长度]
	 * @return [type]   [字母大小写加数字]
	 */
	function createNoncestr($length =32){
	    $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYabcdefghijklmnopqrstuvwxyz0123456789";
	    $str ="";

	    for($i=0;$i<$length;$i++){
	        $str.= substr($chars, mt_rand(0, strlen($chars)-1), 1);
	    }
	    return $str;
	}

}