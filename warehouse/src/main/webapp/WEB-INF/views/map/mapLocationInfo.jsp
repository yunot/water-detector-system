<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>当前监测点</title>
<style type="text/css">
	.fileName{
		width:300px;background-color:#85B5D9;    color: white;
	}
	.fileValue{
		width:300px;

	}
	
</style>
<script type="text/javascript">
var _gridWidth;
var _gridHeight;
//页面自适应
function resizePageSize(){
	_gridWidth = $(document).width()-12;/*  -189 是去掉左侧 菜单的宽度，   -12 是防止浏览器缩小页面 出现滚动条 恢复页面时  折行的问题 */
	_gridHeight = $(document).height()-32-80; /* -32 顶部主菜单高度，   -90 查询条件高度*/
}
function rowDbclick(r){
	$(r).dblclick(
	 function() {
		 var columnsArray = $(r).attr('ch').split("_FG$SP_");
		 $("#locationId").val(columnsArray[0]);
		 $("#name").val(columnsArray[1]);
		 $("#lon").val(columnsArray[2]);
		 $("#lat").val(columnsArray[3]);
		 $("#city").val(columnsArray[4]);
		 $("#soak").val(columnsArray[5]);
		 $("#updateMapInfoDailDialog").dialog("open");
	 });
	
}


$(function()
{
	resizePageSize();
	var _columnWidth= (_gridWidth-240)/4;
	
	$("#flexiGridID").flexigrid({
		width : _gridWidth,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/mapInfo/getMapInfoList",
		dataType : 'json',
		colModel : [ 
	       {display : '监测点编号',name : 'locationId',width : _columnWidth, sortable : true,align : 'center',hide : 'true'}, 
	       {display : "监测点",name : 'name',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "经度",name : 'lon',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "纬度",name : 'lat',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "城市",name : 'city',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "是否水浸",name : 'soak',width : _columnWidth, sortable : true,align : 'center'}
		],
		resizable : false, //resizable table是否可伸缩
		usepager : true,
		useRp : true,
        usepager : true, //是否分页
		autoload : false, //自动加载，即第一次发起ajax请求
		hideOnSubmit : true, //是否在回调时显示遮盖
		showcheckbox : true, //是否显示多选框
		rowhandler : rowDbclick, //是否启用行的扩展事情功能,在生成行时绑定事件，如双击，右键等
		rowbinddata : true,
		numCheckBoxTitle : "<spring:message code='common.selectall'/>"
	});	
	
	query();
	
	
	$("#queryBtn").click(function( event ) {
		var searchCity = $("#searchCity").val();
		var searchSoak = $("#searchSoak").val();
		query([{"name": "searchCity","value":searchCity},
		       {"name": "searchSoak","value":searchSoak}]);
	});
	
	$("#delBtn").click(function( event ) {
		
		var ids = searchTableColumn($("#flexiGridID"),0);
		if(ids.length > 0){
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/mapInfo/deleteMapInfo',
				dataType : 'json',
				cache : false,
				data : [ {
					name : 'mapIds',
					value : ids
				} ],
				success : function(data) {
					$('#flexiGridID').flexReload();
					message(data.msg);
				    
				},
				error : function() {
					message("系统异常请联系管理员");
				}
			});
			
		}else{
			
			message("选择的记录为空！");
		}
		//message(ids);
	});

	$( "#updateMapInfoDailDialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: '修改页面',
		buttons: [
			{
				text: "确定",
				click: function() {
					$("#updateMapInfoDailFormId").submit();
					//$( this ).dialog( "close" );
				}
			},
			{
				text: "取消",
				click: function() {
					$( this ).dialog( "close" );
				}
			}
		]
	});
	
	$('#updateMapInfoDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#updateMapInfoDailDialog").dialog( "close" )
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	

});

function query(param1){
	$('#flexiGridID').flexOptions({
		newp: 1,
		extParam: param1||[],
    	url: '${pageContext.request.contextPath}/mapInfo/getMapInfoList'
    }).flexReload();
}
</script>

</head>
<body>
<label> 城市名称:</label> <input type="text" id="searchCity"/>
<label> 水浸情况:</label> <input type="text" id="searchSoak"/>

<a href="#" id="queryBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-search"></span>查询</a>
<a href="#" id="delBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-minusthick"></span>删除</a>

    <div class="tbl">
         <table id="flexiGridID" style="display: block;margin: 0px;"></table>
    </div>
   
</body>
</html>