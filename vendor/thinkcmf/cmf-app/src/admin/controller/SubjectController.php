<?php
namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;
use think\db\Query;


class SubjectController extends AdminBaseController
{

    /**
    *学科列表
    **/
    public function index()
    {
        $content = hook_one('admin_user_index_view');

        if (!empty($content)) {
            return $content;
        }

        $list = Db::name('subject')->order("sort DESC")->paginate(20);
        
        // 获取分页显示
        $page = $list->render();

        $list = $list->toArray();

        foreach ($list['data'] as $key => $value) {
           $cate_info = Db::name('course_category')->where('id', $value['category_id'])->find();
           $list['data'][$key]['category_name'] = $cate_info['name'];
        }

       

        $this->assign("page", $page);
        $this->assign("list", $list['data']);
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
            $info = Db::name('subject')->where('id', '=', $id)->find();
            if(empty($info)){
                $this->error("不存在的学科，无法编辑");
            }
            $info['remark'] = htmlspecialchars_decode($info['remark']);
            $this->assign("info", $info);
        }

        //品类
        $category_list = Db::name('course_category')->select();
        $this->assign("category_list", $category_list);

        return $this->fetch();
    }


    /**
    *
    *保存学科信息
    **/
    public function save()
    {
        $data = $this->request->param();
        //添加学科
         if(empty($data['id']))
        {
            $add_data = [
                'name' => $data['name'],
                'sort' => $data['sort'],
                'remark' => htmlspecialchars($data['remark']),
                'category_id' => $data['category_id'],
            ];
            $res = Db::name('subject')->insertGetId($add_data);
            if(empty($res)){
                $this->error("添加学科失败，请稍后重试");
            }
        }else{
        //更新学科
            $info = Db::name('subject')->where('id', '=', $data['id'])->find();
            if(empty($info)){
                $this->error("不存在的学科，无法编辑");
            }

            //开始更新
            $add_data = [
                'name' => $data['name'],
                'sort' => $data['sort'],
                'remark' => htmlspecialchars($data['remark']),
                'category_id' => $data['category_id'],
            ];

            $res = Db::name('subject')->where('id', '=', $data['id'])->update($add_data);
            if($res === false){
                $this->error("编辑学科失败，请稍后重试");
            }
        }

        $this->success('成功', 'subject/index');
    }


    /**
    *
    *下架-学科
    **/
    public function del()
    {
        $id = $this->request->param('id');
        //添加学科
         if(empty($id))
        {
            $this->error("不存在的学科，无法操作");
        }


        $info = Db::name('subject')->where('id', '=', $id)->find();
        if(empty($info)){
            $this->error("不存在的学科，无法修改");
        }

        //开始下架
        $status = ($info['status'] == 1) ? 2 : 1; 
        $res = Db::name('subject')->where('id', '=', $id)->update(['status' => $status]);
        if(empty($res)){
            $this->error("修改状态失败，系统错误");
        }

        $this->success('成功', 'subject/index', '', 1);
    }
}