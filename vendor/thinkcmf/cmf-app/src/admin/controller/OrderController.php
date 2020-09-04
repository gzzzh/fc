<?php
namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;
use think\db\Query;

class OrderController extends AdminBaseController
{

    /**
    *订单列表
    **/
    public function index()
    {
        $content = hook_one('admin_user_index_view');

        if (!empty($content)) {
            return $content;
        }


        /**搜索条件**/
        $supplier_id = $this->request->param('supplier_id', '');
        $member_id = $this->request->param('member_id', '');
        $course_id = $this->request->param('course_id', '');
        $status = $this->request->param('status', '');
        $if_entity = $this->request->param('if_entity', '');
        $order_number = $this->request->param('order_number', '');

        //开始查找
        $where = [];
        if($supplier_id)
        {
            $where['c.supplier_id'] = $supplier_id;
        }

        if($member_id)
        {
            $where['o.member_id'] = $member_id;
        }

        if($course_id)
        {
            $where['o.course_id'] = $course_id;
        }

        if($status)
        {
            $where['o.status'] = $status;
        }

        if($if_entity !== '')
        {
            $where['c.if_entity'] = $if_entity;
        }

        if($order_number !== '')
        {
            $where['o.order_number'] = $order_number;
        }

        /*if($supplier_id || $if_entity !== '')
        {
            $list = Db::name('order')->alias('o')->where($where)->join('course c', 'o.course_id = c.id')->order("o.add_time DESC")->paginate(10);
        }else{
            $list = Db::name('order')->alias('o')->where($where)->join('course c', 'o.course_id = c.id')->order("o.add_time DESC")->paginate(10);
        }*/
        $list = Db::name('order')->alias('o')->where($where)->join('course c', 'o.course_id = c.id')
                ->field('o.*, c.supplier_id, c.title, c.attend_type, c.if_entity')
                ->order("o.add_time DESC")->paginate(10, false, ['query' => $this->request->param()]);
        
        // 获取分页显示
        $page = $list->render();

        $list = $list->toArray();
        foreach ($list['data'] as $key => $value) 
        {
            if(!empty($value['courier_code']))
            {
                $er_info = Db::name('courier')->where('shipper_code', $value['courier_code'])->find();
                $list['data'][$key]['courier_name'] = $er_info['name'];
            }
            
        }
        
        


        //找出所有供应商信息
        $supplier_list = Db::name('supplier')->field('id, name')->select();

        $this->assign("supplier_id", $supplier_id);
        $this->assign("member_id", $member_id);
        $this->assign("course_id", $course_id);
        $this->assign("status", $status);
        $this->assign("if_entity", $if_entity);
        $this->assign("order_number", $order_number);

        $this->assign("page", $page);
        $this->assign("list", $list['data']);
        $this->assign("supplier_list", $supplier_list);
        return $this->fetch();
    }


    /**
    *
    *订单详情
    **/
    public function particulars()
    {
        $order_id = $this->request->param('order_id', '', 'intval');
        if (empty($order_id)) {
            $this->error("请传递要查看的订单ID");
        }

       $info = Db::name('order')->alias('o')->where('o.order_id', '=', $order_id)->join('course c', 'o.course_id = c.id')
        ->field('o.*, c.supplier_id, c.title, c.attend_type, c.if_entity, c.sell_money')
        ->find();
        if(empty($info)){
            $this->error("不存在的订单信息");
        }

        //找出所有供应商信息
        $supplier_list = Db::name('supplier')->field('id, name')->select();

        $this->assign("info", $info);
        $this->assign("supplier_list", $supplier_list);
        return $this->fetch();
    }


    /**
    *
    *课程-手机号课程发货
    *
    **/
    public function mobileSend()
    {
        $order_id = $this->request->param('order_id', '', 'intval');
        if (empty($order_id)) {
            $this->error("请传递要查看的订单ID");
        }

        $info = Db::name('order')->where('order_id', '=', $order_id)->field('order_id, order_number, member_id, course_id, mobile, status, site, add_time')->find();
        if(empty($info)){
            $this->error("不存在的订单信息");
        }

        if($info['status'] != 1){
            $this->error("订单状态已变动,请刷新确认");
        }

        //查看订单课程
        $cinfo = Db::name('course')->where('id', '=', $info['course_id'])->field('id, attend_type')->find();
        if(empty($cinfo)){
            $this->error("不存在的课程信息");
        }

        if($cinfo['attend_type'] != 1){
            $this->error("该课程不能进行手机号发货");
        }

        Db::startTrans();
        //开始匹配当前手机号为兑换码
        $code_add = [
            'course_id' => $info['course_id'],
            'code_name' => $info['mobile'],
            'start_time' => date('Y-m-d H:i:s'),
            'end_time' => date('Y-m-d H:i:s', (time() + 86400 * 10)),
            'status' => 2,
            'order_id' => $info['order_id'],
            'issue_time' => date('Y-m-d H:i:s'),
        ];
        $res = DB::name('course_code')->insertGetId($code_add);
        if(empty($res)){
            Db::rollback();
            $this->error("绑定兑换码失败，系统错误");
        }


        //绑定到订单上
        $update = [
            'status' => 2,
            'course_code_id' => $res,
            'dispatch_time' => date('Y-m-d H:i:s'),
        ];
        $res = Db::name('order')->where('order_id', '=', $order_id)->where('status', '=', 1)->update($update);
        if(empty($res)){
            Db::rollback();
            $this->error("发货失败，系统错误");
        }

        Db::commit();


        //发货成功，通知消息
        $notice_contro = new NoticeController();
        $send_data = [
            'first' => ['value'=>'您的订单已发货', 'color'=>"#173177"],
            'keyword1' => ['value'=> $info['order_number'], 'color'=>'#173177'],
            'keyword2' => ['value'=> $info['add_time'], 'color'=>'#173177'],
            'keyword3' => ['value'=> '无', 'color'=>'#173177'],
            'keyword4' => ['value'=> '无', 'color'=>'#173177'],
            'keyword5' => ['value'=> $info['site'], 'color'=>'#173177'],
            'remark' => ['value'=>'您的课程已开通，点击查看上课详情', 'color'=>'#173177']
        ];

        $return_url = WEB_URL."/order";
        $notice_contro->sendNoticeMessage('fh', $send_data, $return_url, '', $info['member_id']);
        
        $this->success('发货成功', 'Order/index','1');
    }





    /**
    *
    *快递发货页面
    *
    **/
    public function getCourierAll()
    {
        $order_id = $this->request->param('order_id', '', 'intval');
        if (empty($order_id)) {
            $this->error("请传递要查看的订单ID");
        }

        $str = 'order_id, order_number, course_id, recipients, mobile, province, city, district, site, courier_code, express_number, member_id, course_id, mobile, status, site, add_time';
        $info = Db::name('order')->where('order_id', '=', $order_id)->field($str)->find();
        if(empty($info)){
            $this->error("不存在的订单信息");
        }

        //查看订单课程
        $cinfo = Db::name('course')->where('id', '=', $info['course_id'])->field('id, title, attend_type')->find();
        if(empty($cinfo)){
            $this->error("不存在的课程信息");
        }


        /*if($cinfo['attend_type'] != 3){
            $this->error("该课程不能快递发货");
        }*/

        if(!empty($info['courier_code']) && !empty($info['express_number']))
        {
            //开始调用物流查看
            $check_data = [
                'ShipperCode' => $info['courier_code'],
                'LogisticCode' => $info['express_number'],
            ];
            $res = getOrderTracesByJson($check_data);
            $wl_info = json_decode($res, true);

            //有物流信息
           
            if($wl_info['Success'] == true)
            {
                $max = count($wl_info['Traces']) - 1;
                $new_traces = [];
                for ($i=$max; $i >= 0; $i--) { 
                    $new_traces[] = $wl_info['Traces'][$i];
                }
                $wl_info['Traces'] = $new_traces;
                $this->assign("wl_info", $wl_info);
            }   
        }



        $list = Db::name('courier')->select();
        $this->assign("list", $list);

        $this->assign("info", $info);
        $this->assign("cinfo", $cinfo);
        $this->assign("order_id", $order_id);
      
        return $this->fetch();
    }

    /**
    *
    *课程-快递课程发货
    *
    **/
    public function courierSend()
    {
        $send_data = $this->request->param();

        $order_id = $send_data['order_id'];
        if (empty($order_id)) {
            $this->error("请传递要操作的订单ID");
        }

        if(empty($send_data['courier_code']) || empty($send_data['express_number']))
        {
            $this->error("请选择快递公司和快递单号");
        }

        $info = Db::name('order')->where('order_id', '=', $order_id)->field('order_id, order_number, member_id, course_id, mobile, status, site, add_time')->find();
        if(empty($info)){
            $this->error("不存在的订单信息");
        }

        //查看订单课程
        $cinfo = Db::name('course')->where('id', '=', $info['course_id'])->field('id, attend_type')->find();
        if(empty($cinfo)){
            $this->error("不存在的课程信息");
        }

        /*if($cinfo['attend_type'] != 3){
            $this->error("该课程不能手动发货");
        }*/

        //快递类型+已付款状态，才更新状态
        if($cinfo['attend_type'] == 3 && $info['status'] == 1)
        {
                    Db::startTrans();
                    //修改订单状态
                    $update = [
                        'status' => 2,
                        //'course_code_id' => $res,
                        'courier_code' => $send_data['courier_code'],
                        'express_number' => $send_data['express_number'],
                        'dispatch_time' => date('Y-m-d H:i:s'),
                    ];
                    $res = Db::name('order')->where('order_id', '=', $order_id)->where('status', '=', 1)->update($update);
                    if(empty($res)){
                        Db::rollback();
                        $this->error("发货失败，系统错误");
                    }

                    Db::commit();   
        }



        //发货成功，通知消息
        $notice_contro = new NoticeController();
        $send_data = [
            'first' => ['value'=>'您的订单已发货', 'color'=>"#173177"],
            'keyword1' => ['value'=> $info['order_number'], 'color'=>'#173177'],
            'keyword2' => ['value'=> $info['add_time'], 'color'=>'#173177'],
            'keyword3' => ['value'=> '无', 'color'=>'#173177'],
            'keyword4' => ['value'=> '无', 'color'=>'#173177'],
            'keyword5' => ['value'=> $info['site'], 'color'=>'#173177'],
            'remark' => ['value'=>'您的课程已开通，点击查看订单详情', 'color'=>'#173177']
        ];

        $return_url = WEB_URL."/order";
        $notice_contro->sendNoticeMessage('fh', $send_data, $return_url, '', $info['member_id']);
        
        $this->success('发货成功', 'Order/index','1');
    }




    //导出订单页面
    public function exportOrder()
    {
        return $this->fetch();
    }




    /**
    *
    *导出订单
    *
    **/
    public function exportOrderStart()
    {   

        set_time_limit(0);//设置脚本最大执行时间，0=无限时
        ini_set('memory_limit', '1024M');//使用内存

        $data = $this->request->param();
        if (empty($data['start_time']) || empty($data['end_time']) || ($data['start_time'] == 'undefined') || ($data['end_time'] == 'undefined')) {
            // $data['start_time'] = '2020-08-06 00:00:00';
            //$data['end_time'] = '2020-08-08 00:00:00';
            $this->error("请选择导出订单的时间段，开始时间和结束时间都要选择");
        }

        if(empty($data['type'])) $this->error("请选中要导出的类型");
        

        include_once CMF_ROOT.'vendor/phpexcel/Classes/PHPExcel.php';
        include_once CMF_ROOT.'vendor/phpexcel/Classes/PHPExcel/Writer/Excel5.php';
        include_once CMF_ROOT.'vendor/phpexcel/Classes/PHPExcel/Writer/Excel2007.php';
        include_once CMF_ROOT.'vendor/phpexcel/Classes/PHPExcel/IOFactory.php';
     
        if($data['type'] == 1)
        {

            //按时间查找订单，并导出
            $where = [
                ['o.add_time', '>=', $data['start_time']],
                ['o.add_time', '<=', $data['end_time']],
                ['o.status', 'in', [1,2,3,4,5]]
            ];
            $list = Db::name('order')->alias('o')->where($where)->join('course c', 'o.course_id = c.id')
                    ->field('o.*, c.supplier_id, c.title, c.attend_type, c.if_entity, c.sell_money')
                    ->order("o.add_time DESC")->select();
            $list = !empty($list) ? $list->toArray() : [];

            //循环查找课程的供应商、订单的兑换码
            foreach($list as $key => $val)
            {
                $gys = Db::name('supplier')->where('id', '=', $val['supplier_id'])->field('id, name')->find();
                $list[$key]['gys_name'] = $gys['name'];

                if(!empty($val['course_code_id']))
                {
                    $code = Db::name('course_code')->where('id', '=', $val['course_code_id'])->field('id, code_name')->find();
                    $list[$key]['code_name'] = $code['code_name'];
                }
            }

            $fileName = '订单导出'."_" . date("Y_m_d") . ".xls";
            $obj = new \PHPExcel();
            $objWriter = new \PHPExcel_Writer_Excel5($obj);
            $objWriter = new \PHPExcel_Writer_Excel2007($obj);

            $obj->getProperties();
         
            //设置表头
            $obj->setActiveSheetIndex(0)->setCellValue('A1', '订单编号');
            $obj->setActiveSheetIndex(0)->setCellValue('B1', '供应商');
            $obj->setActiveSheetIndex(0)->setCellValue('C1', '课程标题');
            $obj->setActiveSheetIndex(0)->setCellValue('D1', '课程售价');
            $obj->setActiveSheetIndex(0)->setCellValue('E1', '付款金额');
            $obj->setActiveSheetIndex(0)->setCellValue('F1', '收货人');
            $obj->setActiveSheetIndex(0)->setCellValue('G1', '手机号码');
            $obj->setActiveSheetIndex(0)->setCellValue('H1', '收货地址');
            $obj->setActiveSheetIndex(0)->setCellValue('I1', '订单状态');
            $obj->setActiveSheetIndex(0)->setCellValue('J1', '上课方式');
            $obj->setActiveSheetIndex(0)->setCellValue('K1', '发货信息');
            $obj->setActiveSheetIndex(0)->setCellValue('L1', '付款时间');
            $obj->setActiveSheetIndex(0)->setCellValue('M1', '退货完成时间');
            $obj->setActiveSheetIndex(0)->setCellValue('N1', '宝宝年龄');
         
            $column = 2;
            $objActSheet = $obj->getActiveSheet();
         
            foreach ($list as $key => $value) { // 行写入
                $string = ($value['status'] == 1) ? '待发货' : ($value['status'] == 2 ? '已发货' : ($value['status'] == 3 ? '申请退款' : ($value['status'] == 4 ? '已完成' : '已退款')));
                $sk = ($value['attend_type'] == 1) ? '手机号' : '兑换码';
                $objActSheet->setCellValue('A'.$column, $value['order_number']);
                $objActSheet->setCellValue('B'.$column, $value['gys_name']);
                $objActSheet->setCellValue('C'.$column, $value['title']);
                $objActSheet->setCellValue('D'.$column, $value['sell_money']);
                $objActSheet->setCellValue('E'.$column, $value['pay_money']);
                $objActSheet->setCellValue('F'.$column, $value['recipients']);
                $objActSheet->setCellValue('G'.$column, $value['mobile']);
                $objActSheet->setCellValue('H'.$column, $value['province'].$value['city'].$value['district'].$value['site']);
                $objActSheet->setCellValue('I'.$column, $string);
                $objActSheet->setCellValue('J'.$column, $sk);
                $value['code_name'] = !empty($value['code_name']) ? $value['code_name'] : '';
                $objActSheet->setCellValue('K'.$column, $value['code_name']);
                $objActSheet->setCellValue('L'.$column, $value['pay_time']);
                $objActSheet->setCellValue('M'.$column, $value['refund_time']);
                $objActSheet->setCellValue('N'.$column, $value['baby_age']);
         
                $column++;
         
            }

        }else{

            //-----------------------------区分供应商导出------------------------------

            $fileName = '订单导出'."_" . date("Y_m_d") . ".xls";
            $obj = new \PHPExcel();
            $objWriter = new \PHPExcel_Writer_Excel2007($obj);
            $obpe_pro = $obj->getProperties();


            //找出所有供应商
            $id_counts = $supplier_list = Db::name('supplier')->column('id');

            //分供应商导出
            $number = 0;
            $b = 0;
            for ($i=0; $i < count($id_counts); $i++) { 


                //按时间查找订单，并导出
                $where = [
                    ['o.add_time', '>=', $data['start_time']],
                    ['o.add_time', '<=', $data['end_time']],
                    ['o.status', 'in', [1,2,3,4,5]],
                    ['c.supplier_id', '=', $id_counts[$i]],
                ];
                $list = Db::name('order')->alias('o')->where($where)->join('course c', 'o.course_id = c.id')
                        ->field('o.*, c.supplier_id, c.title, c.attend_type, c.if_entity, c.sell_money')
                        ->order("o.add_time DESC")->select()->toArray();
                
                //如果存在
                if(!empty($list))
                {
                    //循环查找课程的供应商、订单的兑换码
                    foreach($list as $key => $val)
                    {
                        $gys = Db::name('supplier')->where('id', '=', $val['supplier_id'])->field('id, name')->find();
                        $list[$key]['gys_name'] = $gys['name'];

                        if(!empty($val['course_code_id']))
                        {
                            $code = Db::name('course_code')->where('id', '=', $val['course_code_id'])->field('id, code_name')->find();
                            $list[$key]['code_name'] = $code['code_name'];
                        }
                    }

                    //如果不是第一个
                    if($number == 0)
                    {   
                        $number = $number + 1;

                        $obj->setactivesheetindex(0);
                        //设置表头
                        $obj->setActiveSheetIndex(0)->setCellValue('A1', '订单编号');
                        $obj->setActiveSheetIndex(0)->setCellValue('B1', '供应商');
                        $obj->setActiveSheetIndex(0)->setCellValue('C1', '课程标题');
                        $obj->setActiveSheetIndex(0)->setCellValue('D1', '课程售价');
                        $obj->setActiveSheetIndex(0)->setCellValue('E1', '付款金额');
                        $obj->setActiveSheetIndex(0)->setCellValue('F1', '收货人');
                        $obj->setActiveSheetIndex(0)->setCellValue('G1', '手机号码');
                        $obj->setActiveSheetIndex(0)->setCellValue('H1', '收货地址');
                        $obj->setActiveSheetIndex(0)->setCellValue('I1', '订单状态');
                        $obj->setActiveSheetIndex(0)->setCellValue('J1', '上课方式');
                        $obj->setActiveSheetIndex(0)->setCellValue('K1', '发货信息');
                        $obj->setActiveSheetIndex(0)->setCellValue('L1', '付款时间');
                        $obj->setActiveSheetIndex(0)->setCellValue('M1', '退货完成时间');
                        $obj->setActiveSheetIndex(0)->setCellValue('N1', '宝宝年龄');

                        $column = 2;
                        $objActSheet = $obj->getActiveSheet();
                     
                        foreach ($list as $key => $value) { // 行写入
                            $string = ($value['status'] == 1) ? '待发货' : ($value['status'] == 2 ? '已发货' : ($value['status'] == 3 ? '申请退款' : ($value['status'] == 4 ? '已完成' : '已退款')));
                            $sk = ($value['attend_type'] == 1) ? '手机号' : '兑换码';
                            $objActSheet->setCellValue('A'.$column, $value['order_number']);
                            $objActSheet->setCellValue('B'.$column, $value['gys_name']);
                            $objActSheet->setCellValue('C'.$column, $value['title']);
                            $objActSheet->setCellValue('D'.$column, $value['sell_money']);
                            $objActSheet->setCellValue('E'.$column, $value['pay_money']);
                            $objActSheet->setCellValue('F'.$column, $value['recipients']);
                            $objActSheet->setCellValue('G'.$column, $value['mobile']);
                            $objActSheet->setCellValue('H'.$column, $value['province'].$value['city'].$value['district'].$value['site']);
                            $objActSheet->setCellValue('I'.$column, $string);
                            $objActSheet->setCellValue('J'.$column, $sk);
                            $value['code_name'] = !empty($value['code_name']) ? $value['code_name'] : '';
                            $objActSheet->setCellValue('K'.$column, $value['code_name']);
                            $objActSheet->setCellValue('L'.$column, $value['pay_time']);
                            $objActSheet->setCellValue('M'.$column, $value['refund_time']);
                            $objActSheet->setCellValue('N'.$column, $value['baby_age']);
                     
                            $column++;
                        }
                    }else{

                        if($number == 1 && $b == 0)
                        {
                            $b = $number;
                        }else{
                            $b = $b + 1;
                        }
                        
                        $obj->createSheet();
                        $obj->setactivesheetindex($number);

                        WL(['msg' => $b, 'sql' => Db::name('order')->getLastSql()], 'daochu');

                        //设置表头
                        $obj->setActiveSheetIndex($b)->setCellValue('A1', '订单编号');
                        $obj->setActiveSheetIndex($b)->setCellValue('B1', '供应商');
                        $obj->setActiveSheetIndex($b)->setCellValue('C1', '课程标题');
                        $obj->setActiveSheetIndex($b)->setCellValue('D1', '课程售价');
                        $obj->setActiveSheetIndex($b)->setCellValue('E1', '付款金额');
                        $obj->setActiveSheetIndex($b)->setCellValue('F1', '收货人');
                        $obj->setActiveSheetIndex($b)->setCellValue('G1', '手机号码');
                        $obj->setActiveSheetIndex($b)->setCellValue('H1', '收货地址');
                        $obj->setActiveSheetIndex($b)->setCellValue('I1', '订单状态');
                        $obj->setActiveSheetIndex($b)->setCellValue('J1', '上课方式');
                        $obj->setActiveSheetIndex($b)->setCellValue('K1', '发货信息');
                        $obj->setActiveSheetIndex($b)->setCellValue('L1', '付款时间');
                        $obj->setActiveSheetIndex($b)->setCellValue('M1', '退货完成时间');
                        $obj->setActiveSheetIndex($b)->setCellValue('N1', '宝宝年龄');

                        $column = 2;
                        $objActSheet = $obj->getActiveSheet();
                     
                        foreach ($list as $key => $value) { // 行写入
                            $string = ($value['status'] == 1) ? '待发货' : ($value['status'] == 2 ? '已发货' : ($value['status'] == 3 ? '申请退款' : ($value['status'] == 4 ? '已完成' : '已退款')));
                            $sk = ($value['attend_type'] == 1) ? '手机号' : '兑换码';
                            $objActSheet->setCellValue('A'.$column, $value['order_number']);
                            $objActSheet->setCellValue('B'.$column, $value['gys_name']);
                            $objActSheet->setCellValue('C'.$column, $value['title']);
                            $objActSheet->setCellValue('D'.$column, $value['sell_money']);
                            $objActSheet->setCellValue('E'.$column, $value['pay_money']);
                            $objActSheet->setCellValue('F'.$column, $value['recipients']);
                            $objActSheet->setCellValue('G'.$column, $value['mobile']);
                            $objActSheet->setCellValue('H'.$column, $value['province'].$value['city'].$value['district'].$value['site']);
                            $objActSheet->setCellValue('I'.$column, $string);
                            $objActSheet->setCellValue('J'.$column, $sk);
                            $value['code_name'] = !empty($value['code_name']) ? $value['code_name'] : '';
                            $objActSheet->setCellValue('K'.$column, $value['code_name']);
                            $objActSheet->setCellValue('L'.$column, $value['pay_time']);
                            $objActSheet->setCellValue('M'.$column, $value['refund_time']);
                            $objActSheet->setCellValue('N'.$column, $value['baby_age']);
                     
                            $column++;
                        }
                    }


                }
                
            }
    
        }
       
        
        ob_end_clean();
        //9.设置浏览器窗口下载表格

        //生成excel文件
        $objWriter = \PHPExcel_IOFactory::createWriter($obj, 'Excel5');

        header("Pragma: public");
        header("Expires: 0");
        header("Cache-Control:must-revalidate,post-check=0,pre-check=0");
        header("Content-Type:application/force-download");
        header("Content-Type:application/vnd.ms-execl;charset=UTF-8");
        header("Content-Type:application/octet-stream");
        header("Content-Type:application/download");
        header("Content-Disposition:attachment;filename=" . $fileName . ".xls");
        header("Content-Transfer-Encoding:binary");
        //下载文件在浏览器窗口
        $objWriter->save('php://output');
        exit;
        }
}