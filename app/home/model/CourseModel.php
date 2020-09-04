<?php
namespace app\home\model;
use think\Model;

class CourseModel extends Model
{
	protected $table  = 'qm_course';


	/**
	*
	*首页默认3个课程
	**/
	public function getIndexCourseList($field = '*')
	{
		$date = date('Y-m-d H:i:s');
		$where = [
			'status' => 1,
			'start_time' => ['egt', $date],
			'end_time' => ['elt', $date],
		];

		$list = $this->where($where)->field($field)->order('sort ASC')->limit(3)->select();
		if(!empty($list))
		{
			$list = $list->toArray();
		}
		return $list;
	}


}
