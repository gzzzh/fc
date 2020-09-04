<?php
namespace app\home\model;
use think\Model;

class SubjectModel extends Model
{
	protected $table  = 'qm_subject';


	/**
	*
	*查找所有学科
	**/
	public function getSubjectAll($field = '*')
	{
		$list = $this->field($field)->select();
		if(!empty($list))
		{
			$list = $list->toArray();
		}

		return $list;
	}
}
