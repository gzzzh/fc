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

namespace app\demo\controller;

use cmf\controller\HomeBaseController;

class IndexController extends HomeBaseController
{

	/**
	*
	*html - 首页数据
	**/
    public function index()
    {
        return $this->fetch('./index/index');
    }

    public function ws()
    {
        return $this->fetch(':ws');
    }
}
