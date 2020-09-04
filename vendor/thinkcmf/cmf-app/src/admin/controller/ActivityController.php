<?php
namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;
use think\db\Query;


class ActivityController extends AdminBaseController
{

    /**
    *活动列表
    **/
    public function index()
    {
        $content = hook_one('admin_user_index_view');

        if (!empty($content)) {
            return $content;
        }

        $name = $this->request->param('name', '');
        $type = $this->request->param('type', '');
        $status = $this->request->param('status', '');

        $list = Db::name('activity')
            ->where(function (Query $query) use ($name, $type, $status) {
                if ($status) {
                    $query->where('status', '=', $status);
                }

                if ($type) {
                    $query->where('type', '=', $type);
                }

                 if ($name) {
                    $query->where('name', 'like', "%$name%");
                }
            })
            ->order("add_time DESC")
            ->paginate(20);
       
        
        // 获取分页显示
        $page = $list->render();

        $this->assign("name", $name);
        $this->assign("type", $type);
        $this->assign("status", $status);
        $this->assign("page", $page);
        $this->assign("list", $list);
        return $this->fetch();
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
            $info = Db::name('activity')->where('id', '=', $id)->find();
            if(empty($info)){
                $this->error("不存在的活动，无法编辑");
            }

            //开始时间，结束时间操作
            $date = date('Y-m-d',strtotime($info['start_time']));
            $time = date('H:i:s',strtotime($info['start_time']));
            $info['start_time'] = $date.'T'.$time;

            $date = date('Y-m-d',strtotime($info['end_time']));
            $time = date('H:i:s',strtotime($info['end_time']));
            $info['end_time'] = $date.'T'.$time;
            $this->assign("info", $info);
        }

        return $this->fetch();
    }


    /**
    *
    *保存活动
    **/
    public function save()
    {
        $data = $this->request->param();
        //添加活动
         if(empty($data['id']))
        {
            $result = $this->validate($data, 'Activity.add');
                if ($result !== true) {
                    // 验证失败 输出错误信息
                    $this->error($result);
            }


            $add_data = [
                'type' => $data['type'],
                'name' => $data['name'],
                'logo' => $data['logo'],
                'url' => $data['url'],
                'start_time' => date('Y-m-d H:i:s', strtotime($data['start_time'])),
                'end_time' => date('Y-m-d H:i:s', strtotime($data['end_time'])),
                'status' => $data['status'],
            ];
            $res = Db::name('activity')->insertGetId($add_data);
            if(empty($res)){
                $this->error("添加活动失败，请稍后重试");
            }
        }else{
            //更新活动
            $result = $this->validate($data, 'Activity.edit');
                if ($result !== true) {
                    // 验证失败 输出错误信息
                    $this->error($result);
            }


            $info = Db::name('activity')->where('id', '=', $data['id'])->find();
            if(empty($info)){
                $this->error("不存在的活动，无法编辑");
            }

            //开始更新
            $add_data = [
                'type' => $data['type'],
                'name' => $data['name'],
                'url' => $data['url'],
                'start_time' => date('Y-m-d H:i:s', strtotime($data['start_time'])),
                'end_time' => date('Y-m-d H:i:s', strtotime($data['end_time'])),
                'status' => $data['status'],
            ];

            if($data['logo'])
            {
                $add_data['logo'] = $data['logo'];
            }

            $res = Db::name('activity')->where('id', '=', $data['id'])->update($add_data);
            if($res === false){
                $this->error("编辑活动失败，请稍后重试");
            }
        }

        $this->success('成功', 'activity/index');
    }
}