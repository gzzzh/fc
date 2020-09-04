/**
 * 添加sku表格
 * author:君
 * date:2020年9月3日
 */
$(function(){
	//添加销售属性
	var aindex = 0;
	$('.addOneAttributeItem').click(function(){
		aindex ++;
		var htm = `<div class="attributeItem flex">
				<div class="attributeName">
					<input type="text" data-name="title" data-index="`+aindex+`" placeholder="请输入属性名称..." class="attrInput">
					<span>：</span>
				</div>
				<div class="attributeValList">
					<div class="attributeValItem fl flex alitemCenter">
						<input type="text" data-name="val" data-index="`+aindex+`" placeholder="请输入属性值..." class="attrInput">
						<img src="/static/images/closeAttr.png" alt="" class="delOneVal">
					</div>
					<div class="attrBar fl flex alitemCenter">
						<span class="addOneAttributeVal" data-index="0" data-aindex="`+aindex+`">添加属性值</span>
						<a class="delOneItem" href="javascript:;">删除整行</a>
					</div>
				</div>
			</div>`;
		$('.attributeBox').append(htm)
	})

	//添加属性值
	$('.attributeBox').on('click','.addOneAttributeVal',function(){
		var thisIndex = Number($(this).attr('data-index'))+1;
		var attrindex = $(this).attr('data-aindex');
		$(this).attr('data-index',thisIndex);
		var htm = `<div class="attributeValItem fl flex alitemCenter">
						<input type="text" data-name="val" data-index="`+attrindex+`" placeholder="请输入属性值..." class="attrInput">
						<img src="/static/images/closeAttr.png" alt="" class="delOneVal">
					</div>`;
		$(this).parents('.attrBar').before(htm);
	})

	//删除销售属性
	$('.attributeBox').on('click','.delOneItem',function(){
		$(this).parents('.attributeItem').remove();
	})
	//删除销售属性值
	$('.attributeBox').on('click','.delOneVal',function(){
		$(this).parents('.attributeValItem').remove();
	})

	//生成或刷新sku
	$('#creadOrRefreshSku').click(function(){
		var titleList = [];
		var valList = [];
		var rowspan = 1;
		$('.attrInput').each(function(k,v) {
			var name = $(this).attr('data-name');
			if(name.indexOf('title') != -1){
				titleList.push({key:$(this).attr('data-index'),val:$(this).val(),list:[]})
			}
			if(name.indexOf('val') != -1){
				valList.push({key:$(this).attr('data-index'),val:$(this).val()})
			}
        });
        for(let i=0;i<titleList.length;i++){
        	var list = [];
        	for(let o=0;o<valList.length;o++){
        		if(titleList[i].key == valList[o].key){
        			list.push(valList[o].val);
        		}
        	}
        	titleList[i].list = list;
        }
        for (var i = 0; i<titleList.length; i++) {
        	rowspan = rowspan * titleList[i].list.length;
        }

		var skuTable = "";//sku表格数据
        skuTable += "<table class='skuTable'><tr>";
		//创建表头
		for(var t = 0 ; t < titleList.length ; t ++){
			skuTable += '<th>'+titleList[t].val+'</th>';
		}
		skuTable += '<th>售价</th><th>原价</th><th>佣金比例</th><th>佣金</th><th>库存总量</th><th>操作</th>';
		skuTable += "</tr>";
		//循环处理表体
		for(var i = 0 ; i < rowspan ; i ++){//总共需要创建多少行
			var currRowDoms = "";
			var rowCount = 1;//记录行数
			for(var j = 0 ; j < titleList.length ; j ++){//sku列
				var skuValues = titleList[j].list;//sku值数组
				var skuValueLen = skuValues.length;//sku值长度
				rowCount = (rowCount * skuValueLen);//目前的生成的总行数
				var anInterBankNum = (rowspan / rowCount);//跨行数
				var point = ((i / anInterBankNum) % skuValueLen);
				if(0  == (i % anInterBankNum)){//需要创建td
					currRowDoms += '<td rowspan='+anInterBankNum+'>'+skuValues[point]+'</td>';
				}
			}

			skuTable += '<tr class="sku_table_tr">'+currRowDoms+'<td><input type="text" class="shoujia" /></td><td><input type="text"/></td><td><input type="text" class="yjbili" /></td><td><input type="text" class="yongjinval" disabled /></td><td><input type="text"/></td><td><a href="">兑换码管理</a></td></tr>';
		}
		skuTable += "</table>";

		$('.skuListBox').html(skuTable)
	})

	$('.skuListBox').on('blur','.yjbili',function(){
		console.log(1)
		var sj = $(this).parents('tr').find('.shoujia').val();
		var yjbili = $(this).val();
		var yongjinval = '';
		if(sj || yjbili){
			yongjinval = Number(sj*yjbili);
		}
		$(this).parents('tr').find('.yongjinval').val(yongjinval);
	});
})