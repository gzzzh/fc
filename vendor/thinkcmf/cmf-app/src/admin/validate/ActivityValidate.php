<?php
namespace app\admin\validate;

use think\Validate;

class ActivityValidate extends Validate
{
    protected $rule = [
        'id' => 'require',
        'type' => 'require',
        'name'  => 'require',
        'logo' => 'require',
        'url' => 'require',
        'start_time' => 'require',
        'end_time' => 'require',
        'status' => 'require',
    ];
    protected $message = [
        'type.require' => '请选择活动类型',
        'name.require'  => '请输入活动名称',
        'logo.require'  => '请上传文件logo',
        'url.require'  => '请输入活动跳转地址',
        'start_time.require'  => '请输入活动开始时间',
        'end_time.require'  => '请输入活动结束时间',
        'status.require'  => '请选择活动状态',
       
    ];

    protected $scene = [
        'add'  => ['type', 'name', 'logo', 'url', 'start_time', 'end_time', 'status'],
        'edit' => ['id', 'type', 'name', 'url', 'start_time', 'end_time', 'status'],
    ];
}