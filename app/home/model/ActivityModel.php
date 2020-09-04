<?php
namespace app\home\model;
use think\Model;

class ActivityModel extends Model
{
	protected $table  = 'qm_activity';


	/**
	*
	*查找banner列表
	**/
	public function getActivityBannerList($field = '*')
	{
		$date = date('Y-m-d H:i:s');
		$where = [
			['type', '=', 1],
			['status', '=', 1],
			['start_time', '<=', $date],
			['end_time', '>=', $date],
		];

		$list = $this->where($where)->field($field)->select();
		if(!empty($list))
		{
			$list = $list->toArray();
			foreach ($list as $key => $value) {
    			$list[$key]['logo'] = '/upload/'.$value['logo'];
    		}
		}

		//$list = $this->getLastSql();
		return $list;
	}



	/**
	*
	*查找常驻入口列表
	**/
	public function getActivityRukouList($field = '*')
	{
		$date = date('Y-m-d H:i:s');
		$where = [
			['type', '=', 1],
			['status', '=', 2],
			['start_time', '<=', $date],
			['end_time', '>=', $date],
		];


		$list = $this->where($where)->field($field)->select();
		if(!empty($list))
		{
			$list = $list->toArray();
			foreach ($list as $key => $value) {
    			$list[$key]['logo'] = '/upload/'.$value['logo'];
    		}
		}
		return $list;
	}
}
