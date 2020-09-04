<?php
namespace app\home\model;
use think\Model;

class AgeStageModel extends Model
{
	protected $table  = 'qm_age_stage';


	/**
	*
	*查找所有年龄段
	**/
	public function getAgeAll($field = '*')
	{
		$list = $this->field($field)->select();
		if(!empty($list))
		{
			$list = $list->toArray();
		}

		return $list;
	}
}
