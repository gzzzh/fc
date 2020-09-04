<?php
namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;
use think\db\Query;


class ArticleTypeController extends AdminBaseController
{

    /**
    *文章类型列表
    **/
    public function index()
    {
        $content = hook_one('admin_user_index_view');

        if (!empty($content)) {
            return $content;
        }

        $list = Db::name('article_type')->order("add_time DESC")->paginate(20);
        
        // 获取分页显示
        $page = $list->render();

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
            $info = Db::name('article_type')->where('id', '=', $id)->find();
            if(empty($info)){
                $this->error("不存在的文章类型，无法编辑");
            }
            $this->assign("info", $info);
        }

        return $this->fetch();
    }


    /**
    *
    *保存文章类型
    **/
    public function save()
    {
        $data = $this->request->param();
        //添加学科
         if(empty($data['id']))
        {
            $add_data = [
                'name' => $data['name'],
            ];
            $res = Db::name('article_type')->insertGetId($add_data);
            if(empty($res)){
                $this->error("添加文章类型失败，请稍后重试");
            }
        }else{
        //更新学科
            $info = Db::name('article_type')->where('id', '=', $data['id'])->find();
            if(empty($info)){
                $this->error("不存在的文章类型，无法编辑");
            }

            //开始更新
            $add_data = [
                'name' => $data['name'],
            ];

            $res = Db::name('article_type')->where('id', '=', $data['id'])->update($add_data);
            if($res === false){
                $this->error("编辑文章类型失败，请稍后重试");
            }
        }

        $this->success('成功', 'age/index');
    }

}