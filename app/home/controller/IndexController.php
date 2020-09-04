<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2018 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Released under the MIT License.
// +----------------------------------------------------------------------
// | Author: 老猫 <thinkcmf@126.com>
// +----------------------------------------------------------------------

namespace app\home\controller;

use cmf\controller\HomeBaseController;

class IndexController extends HomeBaseController
{
	/**
	*
	*首页
	**/
    public function index()
    {

    	//首页数据展示
    	$ageModel = new \app\home\model\AgeStageModel();
    	$subjectModel = new \app\home\model\SubjectModel();
    	$activityModel = new \app\home\model\ActivityModel();
    	$courseModel = new \app\home\model\CourseModel();
    	$coulabelModel = new \app\home\model\CourseLabelModel();


    	//获得所有年龄段、学科、轮播图、常驻活动、
    	$age_list = $ageModel->getAgeAll('id, name');

    	$subject_list = $subjectModel->getSubjectAll('id, name');

    	$banner_list = $activityModel->getActivityBannerList();

    	$rukou_list = $activityModel->getActivityBannerList();


    	//默认展示排序最前的三个课程
    	$course_list = $courseModel->getIndexCourseList('id, title, sell_money, original_money, basic_number, sales_number, tj_logo');
    	foreach ($course_list as $key => $value) {
    		$course_list[$key]['label'] = $coulabelModel->getCourseLabelList($value['id']);
    		$course_list[$key]['tj_logo'] = '/upload/'.$value['tj_logo'];
    	}

    	$this->assign('age_list', $age_list);
    	$this->assign('subject_list', $subject_list);
    	$this->assign('banner_list', $banner_list);
    	$this->assign('rukou_list', $rukou_list);
    	$this->assign('course_list', $course_list);

        return $this->fetch('index/index');
    }

    public function ws()
    {
        return $this->fetch(':ws');
    }
}
