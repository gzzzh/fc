<?php
namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;
use think\db\Query;


class SupplierController extends AdminBaseController
{

    /**
    *供应商列表
    **/
    public function index()
    {
        $content = hook_one('admin_user_index_view');

        if (!empty($content)) {
            return $content;
        }

        $name = $this->request->param('name', '');

        if($name)
        {
            $list = Db::name('supplier')->where('name', 'like', "%{$name}%")->order("add_time DESC")->paginate(20);
        }else{
            $list = Db::name('supplier')->order("add_time DESC")->paginate(20);
        }
        
        // 获取分页显示
        $page = $list->render();

        $this->assign("name", $name);
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
            $info = Db::name('supplier')->where('id', '=', $id)->find();
            if(empty($info)){
                $this->error("不存在的供应商，无法编辑");
            }
            $info['remark'] = htmlspecialchars_decode($info['remark']);
            $this->assign("info", $info);
        }

        return $this->fetch();
    }


    /**
    *
    *保存供应商信息
    **/
    public function save()
    {
        $data = $this->request->param();
        //添加供应商
         if(empty($data['id']))
        {
            $add_data = [
                'name' => $data['name'],
                'company_name' => $data['company_name'],
                'linkman' => $data['linkman'],
                'mobile' => $data['mobile'],
                'qq' => $data['qq'],
                'remark' => htmlspecialchars($data['remark'])
            ];
            $res = Db::name('supplier')->insertGetId($add_data);
            if(empty($res)){
                $this->error("添加供应商失败，请稍后重试");
            }
        }else{
        //更新供应商
            $info = Db::name('supplier')->where('id', '=', $data['id'])->find();
            if(empty($info)){
                $this->error("不存在的供应商，无法编辑");
            }

            //开始更新
            $add_data = [
                'name' => $data['name'],
                'company_name' => $data['company_name'],
                'linkman' => $data['linkman'],
                'mobile' => $data['mobile'],
                'qq' => $data['qq'],
                'remark' => htmlspecialchars($data['remark'])
            ];

            $res = Db::name('supplier')->where('id', '=', $data['id'])->update($add_data);
            if($res === false){
                $this->error("编辑供应商失败，请稍后重试");
            }
        }

        $this->success('成功', 'supplier/index');
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
            $this->error("不存在的供应商ID，无法操作");
        }


        $info = Db::name('supplier')->where('id', '=', $id)->find();
        if(empty($info)){
            $this->error("不存在的供应商，无法修改");
        }

        //开始下架
        $status = ($info['status'] == 1) ? 2 : 1; 
        $res = Db::name('supplier')->where('id', '=', $id)->update(['status' => $status]);
        if(empty($res)){
            $this->error("修改状态失败，系统错误");
        }

        $this->success('成功', 'supplier/index', '', 1);
    }
}