<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>OJ训练</title>

<script type="text/javascript">
var _gridWidth;
var _gridHeight;
//页面自适应
function resizePageSize(){
	_gridWidth = $(document).width()-200;/*  -189 是去掉左侧 菜单的宽度，   -12 是防止浏览器缩小页面 出现滚动条 恢复页面时  折行的问题 */
	_gridHeight = $(document).height()-32-80; /* -32 顶部主菜单高度，   -90 查询条件高度*/
}


$(function()
{
	resizePageSize();
	var _columnWidth= (_gridWidth-150)/4;
	$("#flexiGridID").flexigrid({
		width : _gridWidth-200,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/oj/getSubjectlist",
		dataType : 'json',
		colModel : [ 
		   {display : "题目编号",name : 'subjectId',width : 80,sortable : true,align : 'center'}, 
	       {display : "题目名称",name : 'subjectName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "题目描述",name : 'subjectDesc',width : _columnWidth+275, sortable : true,align : 'center'},	 
	       {display :"", name : 'operation',width : 100, sortable : true,align : 'center',process: function(v,_trid,_row) {				 
				var test ='<span style="color:blue;cursor:pointer;" onclick="startTest(' + _row.subjectId + ');">做题</span>';
				return test;
	       }},
		],		
		resizable : false, //resizable table是否可伸缩
		usepager : true,
		useRp : true,
		usepager : true, //是否分页
		autoload : false, //自动加载，即第一次发起ajax请求
		hideOnSubmit : true, //是否在回调时显示遮盖
		rowbinddata : true,
	});	
	query();
	
	$("#querySubjectByName").click(function( event ) {
		var searchName = $("#searchName").val();
		query([{"name": "searchName","value":searchName}]);
	});
});

function query(param1){
	$('#flexiGridID').flexOptions({
		newp: 1,
		extParam: param1||[],
    	url: '${pageContext.request.contextPath}/oj/getSubjectlist'
    }).flexReload();
}

function startTest(id){
	window.location.href = "${pageContext.request.contextPath}/oj/test?id="+id;
}
</script>

</head>
<body style="background-color:#d2f2b8;">
<div style="position:absolute;left:200px">
<label> 题目名称:</label> <input type="text" id="searchName"/>
<button id="querySubjectByName">查询</button>
   </div>
    <div class="tbl" style="position:absolute;left:200px;top:40px;">
         <table id="flexiGridID" style="display: block;margin: 0px;"></table>
    </div>

</body>
</html>