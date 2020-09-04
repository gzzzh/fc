<?php
namespace app\admin\controller;

use cmf\controller\AdminBaseController;
use think\Db;
use think\db\Query;


class MemberController extends AdminBaseController
{

    /**
    *会员列表
    **/
    public function index()
    {
        $content = hook_one('admin_user_index_view');

        if (!empty($content)) {
            return $content;
        }


        /**搜索条件**/
        $member_id = $this->request->param('member_id');
        $invite = $this->request->param('invite');
        $parent = trim($this->request->param('parent'));

        $users = Db::name('member')
            ->where(function (Query $query) use ($member_id, $parent, $invite) {
                if ($member_id) {
                    $query->where('member_id', '=', $member_id);
                }

                if ($invite) {
                    $query->where('invite', '=', $invite);
                }

                if ($parent) {
                    $query->where('parent', '=', $parent);
                }
            })
            ->order("member_id DESC")
            ->paginate(10);
        $users->appends(['member_id' => $member_id, 'parent' => $parent, 'invite' => $invite]);
        // 获取分页显示
        $page = $users->render();

        $this->assign("page", $page);
        $this->assign("users", $users);
        return $this->fetch();
    }


    /**
    *
    *拉黑用户 or 解禁用户
    **/
    public function editStatus()
    {
        $member_id = $this->request->param('member_id', '', 'intval');
        if (empty($member_id)) {
            $this->error("请传递要操作的用户ID");
        }

        $info = Db::name('member')->where('member_id', '=', $member_id)->field('member_id,status')->find();
        if(empty($info)){
            $this->error("不存在的用户，无法操作");
        }

        //开始操作
        $updata['status'] = $info['status'] == 1 ? 2 : 1;
        $res = Db::name('member')->where('member_id', $member_id)->update($updata);


        if (!empty($res)) {
            $this->success("操作成功！");
        } else {
            $this->error("操作失败！");
        }
    }
}