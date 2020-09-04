<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2019 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 小夏 < 449134904@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\validate;

use think\Validate;

class CourseValidate extends Validate
{
    protected $rule = [
        'supplier_id' => 'require|integer',//供应商
        'title'  => 'require',//短标题
        'long_title'  => 'require',//原标题
        'original_money'  => 'require|egt:0',//原价
        'sell_money'  => 'require|egt:0',//售价
        'commission'  => 'require',//佣金比
        'inventory_number'  => 'require|egt:0',//课程总量
        'basic_number'  => 'require|egt:0',//销量基数
        'age_stage_list'  => 'require',//年龄段
        'subject_list'  => 'require',//所属学科
        'course_label'  => 'require',//标签
        'tj_logo'  => 'require',//推荐图
        'zt_logo'  => 'require',//主图
        'xt_logo'  => 'require',//小图
        'js_logo'  => 'require',//介绍图
        'start_time'  => 'require',//开始时间    
        'sort'  => 'require|egt:0',//排序

        //第三期，课程发布
        'category_id' => 'require',//课程品类
        'postage' => 'require',//邮费
        'course_internal_label' => 'require',//推广标签

    ];
    protected $message = [
        'supplier_id.require' => '请选择课程供应商',
        'supplier_id.integer' => '请选择课程供应商，类型有误',
        'title.require'  => '请输入课程短标题',
        'long_title.require'  => '请输入课程原标题',
        'original_money.require'  => '请输入课程的原价',
        'original_money.egt'  => '课程的原价不能小于0元',
        'sell_money.require'  => '请输入课程的售价',
        'sell_money.egt'  => '课程的售价不能小于0元',
        'commission.require'  => '请输入课程的佣金比',
        'inventory_number.require'  => '请输入课程总量',
        'inventory_number.egt'  => '课程总量不能小于0',
        'basic_number.require'  => '请输入课程销量基数',
        'basic_number.egt'  => '课程销量基数不能小于0',
        'age_stage_list.require'  => '请选择课程年龄段',
        'subject_list.require'  => '请选择课程所属学科',
        'course_label.require'  => '请输入课程标签',
        'tj_logo.require'  => '请上传课程推荐图',
        'zt_logo.require'  => '请上传课程主图',
        'xt_logo.require'  => '请上传课程小图',
        'js_logo.require'  => '请上传课程介绍图',
        'start_time.require'  => '请选择课程开始时间',
        'sort.require'  => '请输入课程排序值',
        'sort.egt'  => '课程的排序不能小于0',

        //第三期，课程发布
        'category_id.require' => '请选择商品的品类',
        'postage.require' => '请输入课程的邮费',
        'course_internal_label.require' => '请输入推广标签',
    ];

    protected $scene = [
        'add'  => ['supplier_id', 'title', 'long_title', 'original_money', 'sell_money', 'commission', 'inventory_number', 'basic_number', 'age_stage_list', 'subject_list', 'course_label', 'tj_logo', 'zt_logo', 'xt_logo', 'js_logo', 'start_time', 'sort'],

        'edit' => ['supplier_id', 'title', 'long_title', 'original_money', 'sell_money', 'commission', 'inventory_number', 'basic_number', 'age_stage_list', 'subject_list', 'course_label', 'start_time', 'sort'],

        //第三版，课程发布
        'add_three'  => ['supplier_id', 'title', 'basic_number', 'age_stage_list', 'subject_list', 'course_label', 'tj_logo', 'zt_logo', 'xt_logo', 'js_logo', 'start_time', 'sort', 

            'category_id', 'postage', 'course_internal_label'],

        'edit_three' => ['supplier_id', 'title', 'basic_number', 'age_stage_list', 'subject_list', 'course_label', 'start_time', 'sort',

            'category_id', 'postage', 'course_internal_label'],
    ];
}