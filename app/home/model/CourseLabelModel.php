<?php
namespace app\home\model;
use think\Model;

class CourseLabelModel extends Model
{
	protected $table  = 'qm_course_label';


	/**
	*
	*获得课程的标签
	**/
	public function getCourseLabelList($course_id, $field = '*')
	{
		$list = $this->where('course_id', '=', $course_id)->select();
		if(!empty($list))
		{
			$list = $list->toArray();
		}
		return $list;
	}


}
