<?php
namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;
use think\db\Query;


class CourseController extends AdminBaseController
{

    /**
    *课程列表
    **/
    public function index()
    {
        $content = hook_one('admin_user_index_view');

        if (!empty($content)) {
            return $content;
        }


        /**搜索条件**/
        $supplier_id = $this->request->param('supplier_id', '', 'intval');
        $id = $this->request->param('id');
        $title = trim($this->request->param('title'));
        $status = trim($this->request->param('status'));

        $users = Db::name('course')
            ->where(function (Query $query) use ($supplier_id, $id, $title, $status) {
                if ($supplier_id) {
                    $query->where('supplier_id', '=', $supplier_id);
                }

                if ($id) {
                    $query->where('id', '=', $id);
                }

                 if ($title) {
                    $query->where('title', 'like', "%$title%");
                }

                if ($status) {
                    $query->where('status', '=', $status);
                }
            })
            ->order("sort DESC, add_time DESC")
            ->paginate(10, false, ['query' => $this->request->param()]);
        $users->appends(['supplier_id' => $supplier_id, 'id' => $id, 'title' => $title]);
        // 获取分页显示
        $page = $users->render();

        $list = $users->toArray();
        foreach ($list['data'] as $key => $value) {
            //找到学科名称
            $sup_info = Db::name('supplier')->where('id', $value['supplier_id'])->field('id, name')->find();
            $list['data'][$key]['supplier_name'] = $sup_info['name'];

            //循环，找出该课程所属的年龄段
            $age_stage_count = Db::name('course_age_stage')->where('course_id', $value['id'])->column('age_stage_id');
            $age_stage_list = Db::name('age_stage')->where('id', 'in', $age_stage_count)->select();
            $list['data'][$key]['age_stage_list'] = $age_stage_list;

            //找出该课程所属的学科
            $subject_count = Db::name('course_subject')->where('course_id', $value['id'])->column('subject_id');
            $subject_list = Db::name('subject')->where('id', 'in', $subject_count)->select();
            $list['data'][$key]['subject_list'] = $subject_list;
        }


        //供应商信息
        $supplier_list = Db::name('supplier')->field('id, name')->select();

        //
        //echo '<pre>';
        //var_dump($list['data']);return;
        $this->assign("status", $status);
        $this->assign("supplier_id", $supplier_id);
        $this->assign("page", $page);
        $this->assign("list", $list['data']);
        $this->assign('supplier_list', $supplier_list);

        return $this->fetch();
    }



    /**
    *
    *根据品类，找出对应的学科
    **/
    public function categoryGetCourseSubject()
    {
        $id = $this->request->param('id', '', 'intval');
        if(empty($id)){
            return json(['code' => 100001, 'msg' => '请传递品类ID']);
        }

        $info = Db::name('course_category')->where('id', $id)->find();
        if(empty($info))
        {
            return json(['code' => 100001, 'msg' => '找不到对应的品类信息']);
        }

        //开始找品类对应的课程列表
        $list = Db::name('subject')->where('category_id', '=', $id)->select();


        return json(['code' => 0, 'msg' => 'ok', 'data' => $list]);
    }


    /**
    *
    *添加 or 编辑 页面
    **/
    public function add()
    {
        $id = $this->request->param('id', '', 'intval');

        //存在ID，就是编辑
        if (!empty($id)) {
            $info = Db::name('course')->where('id', '=', $id)->find();
            if(empty($info)){
                $this->error("不存在的数据，无法编辑");
            }

            //找出该课程的年龄段、学科、
            $age_stage_count = Db::name('course_age_stage')->where('course_id', $info['id'])->column('age_stage_id');
            $info['age_stage_list'] = $age_stage_count;


            $subject_count = Db::name('course_subject')->where('course_id', $info['id'])->column('subject_id');
            $info['subject_list'] = $subject_count;

            //该课程所有标签
            $label_count = Db::name('course_label')->where('course_id', $info['id'])->order('add_time')->column('label');
            $label_count = implode(',', $label_count);
            $info['course_label'] = $label_count;


            //课程，所有内部标签
            $label_count = Db::name('course_internal_label')->where('course_id', $info['id'])->order('add_time')->column('label');
            $label_count = implode(',', $label_count);
            $info['course_internal_label'] = $label_count;


            $info['buy_notice'] = htmlspecialchars_decode($info['buy_notice']);

            //主图转成数组，课程介绍图
            $info['zt_logo'] = json_decode($info['zt_logo']);
            $info['js_logo'] = json_decode($info['js_logo']);

            //开始时间，结束时间操作
            $date = date('Y-m-d',strtotime($info['start_time']));
            $time = date('H:i:s',strtotime($info['start_time']));
            $info['start_time'] = $date.'T'.$time;

            $date = date('Y-m-d',strtotime($info['end_time']));
            $time = date('H:i:s',strtotime($info['end_time']));
            $info['end_time'] = $date.'T'.$time;

            $this->assign("info", $info);
        }

        //找出所有供应商、学科、年龄段、
        $sup_info = Db::name('supplier')->where('status', '=', 1)->select();
        $age_stage_list = Db::name('age_stage')->where('status', '=', 1)->select();
        $subject_list = Db::name('subject')->where('status', '=', 1)->select();

        //品类
        $category_list = Db::name('course_category')->select();

        $this->assign("sup_info", $sup_info);
        $this->assign("age_stage_list", $age_stage_list);
        $this->assign("subject_list", $subject_list);
        $this->assign("category_list", $category_list);
        return $this->fetch();
    }



    /**
    *保存课程
    *
    **/
    public function save()
    {

            //保存课程
            $data = $this->request->param();
            echo '<pre>';
            var_dump($data);return;

            //---------------------------------------------添加课程-------------------------------------------------------
            if(empty($data['id']))
            {
                $result = $this->validate($data, 'Course.add_three');
                if ($result !== true) {
                    // 验证失败 输出错误信息
                    $this->error($result);
                }

                //开始组装数据，进行添加
                $add_data = [
                    'supplier_id' => $data['supplier_id'],
                    'title' => $data['title'],

                    //第二期-废弃
                    //'long_title' => $data['long_title'],
                    //'sell_money' => $data['sell_money'],
                    //'original_money' => $data['original_money'],
                    //'commission' => $data['commission'],
                    //'inventory_number' => $data['inventory_number'],


                    'basic_number' => $data['basic_number'],
                    'explain' => htmlspecialchars($data['explain']),
                    'attend_type' => $data['attend_type'],
                    'if_entity' => $data['if_entity'],
                    'activate_method' => htmlspecialchars($data['activate_method']),
                    'activate_time' => htmlspecialchars($data['activate_time']),
                    'refund' => $data['refund'],
                    'if_seckill' => $data['if_seckill'],
                    'tj_logo' => $data['tj_logo'],
                    'xt_logo' => $data['xt_logo'],
                    'start_time' => date('Y-m-d H:i:s', strtotime($data['start_time'])),
                    'end_time' => date('Y-m-d H:i:s', strtotime($data['end_time'])),
                    'status' => $data['status'],
                    'sort' => $data['sort'],
                    'if_collection' => $data['if_collection'],

                    //第三期，课程发布
                    'category_id' => $data['category_id'],
                    'postage' => $data['postage'],
                    'if_birthday' => $data['if_birthday'],
                    'if_nickname' => $data['if_nickname'],
                    'if_site' => $data['if_site'],

                ];
                if($data['editorValue'])
                {
                    $add_data['buy_notice'] = htmlspecialchars(str_replace('"', '\'',$data['editorValue']));
                }

                $add_data['zt_logo'] = json_encode($data['zt_logo']);
                $add_data['js_logo'] = json_encode($data['js_logo']);

                //开始添加
                Db::startTrans();
                $res_id = DB::name('course')->insertGetId($add_data);
                if(empty($res_id)){
                    Db::rollback();
                    $this->error("添加课程失败！");
                }

                //开始添加课程年龄段、学科、标签
                foreach ($data['age_stage_list'] as $key => $value) {
                   $res = Db::name('course_age_stage')->insert(['course_id' => $res_id, 'age_stage_id' => $value]);
                   if(empty($res)){
                        Db::rollback();
                        $this->error("添加课程年龄段失败！");
                        break;
                    }
                }


                foreach ($data['subject_list'] as $key => $value) {
                   $res = Db::name('course_subject')->insert(['course_id' => $res_id, 'subject_id' => $value]);
                   if(empty($res)){
                        Db::rollback();
                        $this->error("添加课程学科失败！");
                        break;
                    }
                }


                //标签转数组
                $label = explode(',', $data['course_label']);
                foreach ($label as $key => $value) {
                    //因为标签不好排序，所以用时间来去区分
                    $add_time = date('Y-m-d H:i:s', (time() + $key));
                    $res = Db::name('course_label')->insert(['course_id' => $res_id, 'label' => $value, 'add_time' => $add_time]);
                    if(empty($res)){
                        Db::rollback();
                        $this->error("添加推广标签失败！");
                        break;
                    }
                }

                //内部标签
                $label2 = explode(',', $data['course_internal_label']);
                foreach ($label2 as $key => $value) {
                    //因为标签不好排序，所以用时间来去区分
                    $add_time = date('Y-m-d H:i:s', (time() + $key));
                    $res = Db::name('course_internal_label')->insert(['course_id' => $res_id, 'label' => $value, 'add_time' => $add_time]);
                    if(empty($res)){
                        Db::rollback();
                        $this->error("添加内部标签失败！");
                        break;
                    }
                }

                Db::commit();
                
                $this->success("保存成功！");
            }else{
                //------------------------------------------编辑保存课程-------------------------------------------------
                $result = $this->validate($data, 'Course.edit_three');
                if ($result !== true) {
                    // 验证失败 输出错误信息
                    $this->error($result);
                }


                $info = DB::name('course')->where('id', $data['id'])->field('id,title')->find();
                if(empty($info)){
                     $this->error("不存在的课程信息，请确认后操作");
                }

                $add_data = [
                    'supplier_id' => $data['supplier_id'],
                    'title' => $data['title'],

                    //第二期废弃
                    //'long_title' => $data['long_title'],
                    //'sell_money' => $data['sell_money'],
                    //'original_money' => $data['original_money'],
                    //'commission' => $data['commission'],
                    //'inventory_number' => $data['inventory_number'],


                    'basic_number' => $data['basic_number'],
                    'explain' => htmlspecialchars($data['explain']),
                    'attend_type' => $data['attend_type'],
                    'if_entity' => $data['if_entity'],
                    'activate_method' => htmlspecialchars($data['activate_method']),
                    'activate_time' => htmlspecialchars($data['activate_time']),
                    'refund' => $data['refund'],
                    'if_seckill' => $data['if_seckill'],
                    'start_time' => date('Y-m-d H:i:s', strtotime($data['start_time'])),
                    'end_time' => date('Y-m-d H:i:s', strtotime($data['end_time'])),
                    'status' => $data['status'],
                    'sort' => $data['sort'],
                    'if_collection' => $data['if_collection'],

                    //第三期，课程发布
                    'category_id' => $data['category_id'],
                    'postage' => $data['postage'],
                    'if_birthday' => $data['if_birthday'],
                    'if_nickname' => $data['if_nickname'],
                    'if_site' => $data['if_site'],
                ];

                if($data['editorValue'])
                {
                    $add_data['buy_notice'] = htmlspecialchars(str_replace('"', '\'',$data['editorValue']));
                }

                if(!empty($data['tj_logo'])){
                    $add_data['tj_logo'] = $data['tj_logo'];
                }
                if(!empty($data['zt_logo'])){
                    $add_data['zt_logo'] = json_encode($data['zt_logo']);
                }
                if(!empty($data['xt_logo'])){
                    $add_data['xt_logo'] = $data['xt_logo'];
                }
                if(!empty($data['js_logo'])){
                    $add_data['js_logo'] = json_encode($data['js_logo']);
                }

                //开始修改
                Db::startTrans();
                $res_id = DB::name('course')->where('id', $data['id'])->update($add_data);
                if($res_id === false){
                    Db::rollback();
                    $this->error("编辑课程失败！");
                }

                //开始添加课程年龄段、学科、标签
                Db::name('course_age_stage')->where('course_id', $data['id'])->delete();
                foreach ($data['age_stage_list'] as $key => $value) {
                   $res = Db::name('course_age_stage')->insert(['course_id' => $data['id'], 'age_stage_id' => $value]);
                   if(empty($res)){
                        Db::rollback();
                        $this->error("编辑课程年龄段失败！");
                        break;
                    }
                }


                Db::name('course_subject')->where('course_id', $data['id'])->delete();
                foreach ($data['subject_list'] as $key => $value) {
                   $res = Db::name('course_subject')->insert(['course_id' => $data['id'], 'subject_id' => $value]);
                   if(empty($res)){
                        Db::rollback();
                        $this->error("编辑课程学科失败！");
                        break;
                    }
                }


                //标签转数组
                $label = explode(',', $data['course_label']);
                Db::name('course_label')->where('course_id', $data['id'])->delete();
                foreach ($label as $key => $value) {
                    $add_time = date('Y-m-d H:i:s', (time() + $key));
                    $res = Db::name('course_label')->insert(['course_id' => $data['id'], 'label' => $value, 'add_time' => $add_time]);
                    if(empty($res)){
                        Db::rollback();
                        $this->error("编辑推广标签失败！");
                        break;
                    }
                }


                 //内部标签转数组
                $label = explode(',', $data['course_internal_label']);
                Db::name('course_internal_label')->where('course_id', $data['id'])->delete();
                foreach ($label as $key => $value) {
                    $add_time = date('Y-m-d H:i:s', (time() + $key));
                    $res = Db::name('course_internal_label')->insert(['course_id' => $data['id'], 'label' => $value, 'add_time' => $add_time]);
                    if(empty($res)){
                        Db::rollback();
                        $this->error("编辑内部标签失败！");
                        break;
                    }
                }

                Db::commit();
                $this->success("保存成功！");
            }
    }



    /**
    *
    *课程兑换码列表
    **/
    public function codeIndex()
    {
        $content = hook_one('admin_user_index_view');

        if (!empty($content)) {
            return $content;
        }

        //查找课程
        $course_id = $this->request->param('id');
        if(empty($course_id))
        {
            $this->error("请输入课程ID");
        }

        $info = DB::name('course')->where('id', $course_id)->field('id,title')->find();
        if(empty($info)){
             $this->error("不存在的课程信息，请确认后操作");
        }

        $list = Db::name('course_code')->where('course_id', '=', $course_id)->order("status")->paginate(20);
        // 获取分页显示
        $page = $list->render();

        $list = $list->toArray();
        foreach ($list['data'] as $key => $value) {
            //找到订单的编号
            $sup_info = Db::name('order')->where('order_id', $value['order_id'])->field('order_id, order_number')->find();
            $list['data'][$key]['order_number'] = $sup_info['order_number'];
        }

        $this->assign("id", $course_id);
        $this->assign("page", $page);
        $this->assign("list", $list['data']);
        return $this->fetch();
    }


    /**
    *
    *添加课程兑换码
    **/
    public function addCode()
    {
        //查找课程
        $course_id = $this->request->param('id');
        if(empty($course_id))
        {
            $this->error("请输入课程ID");
        }

        $info = DB::name('course')->where('id', $course_id)->field('id,title')->find();
        if(empty($info)){
             $this->error("不存在的课程信息，请确认后操作");
        }

        //展示添加页面
        $this->assign("id", $course_id);
        return $this->fetch();
    }


    /**
    *
    *保存-兑换码
    **/
    public function saveCode()
    {
        //查找课程
        $data = $this->request->param();

        if(empty($data['id']))
        {
            $this->error("请输入课程ID");
        }

        $info = DB::name('course')->where('id', $data['id'])->field('id,title')->find();
        if(empty($info)){
             $this->error("不存在的课程信息，请确认后操作");
        }

        //开始添加数据
        if(empty($data['start_time']))
        {
            $this->error("请选择开始时间");
        }
        if(empty($data['end_time']))
        {
            $this->error("请选择结束时间");
        }
        //日期处理

        $start_time = date('Y-m-d H:i:s', strtotime($data['start_time']));
        $end_time = date('Y-m-d H:i:s', strtotime($data['end_time']));
        if(strtotime($data['start_time']) >= strtotime($data['end_time']))
        {
            $this->error("开始时间不能大于结束时间");
        }

        if(empty($data['code_name']))
        {
            $this->error("请输入兑换码");
        }

        //处理，添加。
        $code_name = explode(',', $data['code_name']);
        //var_dump($code_name);return;
        $res = [true];
        foreach($code_name as $key => $val)
        {
            $info = DB::name('course_code')->where('course_id', '=', $data['id'])->where('code_name', '=', $val)->field('id,code_name')->find();
            if(!empty($info)){
                 continue;
            }


            //开始添加兑换码
            $add_data = [
                'course_id' => $data['id'],
                'code_name' => $val,
                'start_time' => $start_time,
                'end_time' => $end_time,
            ];
            $res[] = DB::name('course_code')->insertGetId($add_data);
        }

        if(in_array(false, $res))
        {
            $this->error("添加失败，请稍后再操作");
        }

        $this->success("保存成功！");
    }


    /**
    *
    *管理-课程分佣
    *
    **/
    public function courseRebate()
    {
        //查找课程
        $course_id = $this->request->param('id');
        if(empty($course_id))
        {
            $this->error("请输入课程ID");
        }

        $info = DB::name('course')->where('id', $course_id)->field('id, sell_money, commission, one_rebate, two_rebate, cultivate_rebate, bonus_rebate')->find();
        if(empty($info)){
             $this->error("不存在的课程信息，请确认后操作");
        }

        //课程利润率
        $info['qmyx_rate'] = 1 - $info['one_rebate'] - $info['two_rebate'] - $info['cultivate_rebate'] - $info['bonus_rebate'];

        $this->assign('info', $info);
        return $this->fetch();
    }


    /**
    *
    *保存-课程分佣
    *
    **/
    public function saveCourseRebate()
    {
        //查找课程
        $data = $this->request->param();
        if(empty($data['id']))
        {
            $this->error("请输入课程ID");
        }

        $info = DB::name('course')->where('id', $data['id'])->field('id, sell_money')->find();
        if(empty($info)){
             $this->error("不存在的课程信息，请确认后操作");
        }

        //接收其他参数
        $result = $this->validate($data,
            [
                'one_rebate'  => 'require|float',
                'two_rebate'   => 'require|float',
                'cultivate_rebate'   => 'require|float',
                'bonus_rebate'   => 'require|float',
            ]
        );

        if(true !== $result){
            // 验证失败 输出错误信息
            $this->error($result);
        }

        //开始修改
        $update = [
            'one_rebate'  => $data['one_rebate'],
            'two_rebate'   => $data['two_rebate'],
            'cultivate_rebate'   => $data['cultivate_rebate'],
            'bonus_rebate'   => $data['bonus_rebate'],
        ];
        $res = DB::name('course')->where('id', $data['id'])->update($update);
        if($res === false)
        {
            $this->error('更新课程分佣比例失败，系统错误');
        }

        //如果佣金是纯数字，就更新课程的佣金
        if(is_numeric($data['commission']))
        {
            $res = DB::name('course')->where('id', $data['id'])->update(['commission' => $data['commission']]);
            if($res === false)
            {
                $this->error('更新课程佣金失败，系统错误');
            }
        }

        $this->success("保存成功！");
    }




    /**
    *
    *小课转大课列表
    *
    **/
    public function littleBecomeBigCourseList()
    {
        $course_id = $this->request->param('id');
        if(empty($course_id))
        {
            $this->error("请输入课程ID");
        }

        $info = DB::name('course')->where('id', $course_id)->field('id, sell_money, commission, one_rebate, two_rebate, cultivate_rebate, bonus_rebate')->find();
        if(empty($info)){
             $this->error("不存在的课程信息，请确认后操作");
        }

        //找出课程的达成列表
        $list = DB::name('course_conversion')->where('course_id', $course_id)->select();

        $this->assign('info', $info);
        $this->assign('list', $list);
        return $this->fetch();
    }


    /**
    *
    *添加-小转大页面
    *
    **/
    public function addCourseBecome()
    {
        $data = $this->request->param();

        $course_id = $data['id'];
        if(empty($course_id))
        {
            $this->error("请输入课程ID");
        }

        //课程比例
        $cinfo = DB::name('course')->where('id', $course_id)->field('id, sell_money, commission, one_rebate, two_rebate, cultivate_rebate, bonus_rebate')->find();
        if(empty($cinfo)){
             $this->error("不存在的课程信息，请确认后操作");
        }
        $this->assign('cinfo', $cinfo);



        //如果是编辑
        if(!empty($data['conversion_id']))
        {
            $info = DB::name('course_conversion')->where('id', $data['conversion_id'])->find();
            $this->assign('info', $info);
        }

        $this->assign('id', $course_id);
        return $this->fetch();
    }


    /**
    *
    *添加-课程小课转大课信息
    *
    **/
    public function saveCourseBecome()
    {
        $data = $this->request->param();

        $course_id = $data['id'];
        if(empty($course_id))
        {
            $this->error("请输入课程ID");
        }

        $info = DB::name('course')->where('id', $course_id)->field('id, sell_money, commission, one_rebate, two_rebate, cultivate_rebate, bonus_rebate')->find();
        if(empty($info)){
             $this->error("不存在的课程信息，请确认后操作");
        }

        //保存
        $add_data = [
            'course_id' => $course_id,
            'explain' => $data['explain'],
            'rebate' => $data['rebate'],
            'one_rebate' => $data['one_rebate'],
            'two_rebate' => $data['two_rebate'],
        ];

        //添加或者编辑
        if(empty($data['con_id']))
        {
            $res = DB::name('course_conversion')->insertGetId($add_data);
            if(empty($res))
            {
                $this->error("添加失败小课转大课信息失败，系统错误");
            }
        }else{
            $cinfo = DB::name('course_conversion')->where('id', $data['con_id'])->find();
            if(empty($cinfo)){
                $this->error("不存在的小课转大课信息，请确认后操作");
            }

            //开始更新
            $res = DB::name('course_conversion')->where('id', $data['con_id'])->update($add_data);
            if($res === false){
                $this->error("编辑小课转大课失败");
            }
        }

        $this->success("保存成功！");
    }


    /**
    *
    *删除-小课转大课
    *
    **/
    public function delCourseBecome()
    {
        $id = $this->request->param('conversion_id');

        if(empty($id))
        {
            $this->error("请传递ID");
        }

        //开始删除
        $res = DB::name('course_conversion')->where('id', $id)->delete();
        if($res === false){
                $this->error("删除小课转大课失败");
        }

        $this->success("删除成功！");
    }




    /**
    *
    *课程品类列表
    *
    **/
    public function categoryIndex()
    {
        $list = Db::name('course_category')->order("add_time DESC")->select();
        $this->assign("list", $list);
        return $this->fetch();
    }


    //添加品类
    public function addCategory()
    {
        $id = $this->request->param('id');

        //编辑
        if(!empty($id))
        {
            $info = DB::name('course_category')->where('id', $id)->find();
            $this->assign('info', $info);
        }
        $this->assign('id', $id);
        return $this->fetch();
    }


    //保存课程品类
    public function saveCategory()
    {
        $data = $this->request->param();

        $add = [
            'name' => $data['name']
        ];

        //如果没ID，就是添加
        if(empty($data['id']))
        {
            $res = DB::name('course_category')->insertGetId($add);
            if(empty($res))
            {
                $this->error("添加课程品类失败，系统错误");
            }

            $this->success("添加课程品类成功！");

        }else{

            //否则，就是编辑
            $res = DB::name('course_category')->where('id', $data['id'])->update($add);
            if($res === false)
            {
                $this->error("添加课程品类失败，系统错误");
            }

            $this->success("更新课程品类成功！");
        }
    } 



    //删除课程品类
    public function delCategory()
    {
        $id = $this->request->param('id');
        if(empty($id))
        {
            $this->error("参数非法，无法删除");
        }

        //品类是否对应有课程
        $counts = DB::name('course')->where('category_id', $id)->count('*');
        if($counts > 0)
        {
            $this->error("该品类下存在课程，无法删除");
        }

        //开始删除
        $res = DB::name('course_category')->where('id', $id)->delete();
        if(empty($res))
        {
            $this->error("删除失败，系统错误");
        }

        $this->success("删除成功！");
    }  


}