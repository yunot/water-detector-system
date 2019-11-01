<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>合同管理</title>

<script type="text/javascript">
var _gridWidth;
var _gridHeight;
//页面自适应
function resizePageSize(){
	_gridWidth = $(document).width()-12;/*  -189 是去掉左侧 菜单的宽度，   -12 是防止浏览器缩小页面 出现滚动条 恢复页面时  折行的问题 */
	_gridHeight = $(document).height()-32-80; /* -32 顶部主菜单高度，   -90 查询条件高度*/
}

$(function()
{
	$('#uploadContractForm').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#uploadContractForm').resetForm();
			message(data.msg);
			query();
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	resizePageSize();
	var _columnWidth= (_gridWidth-150)/7;
	
	$("#flexiGridID").flexigrid({
		width : _gridWidth,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/contractUpload/getContractlist",
		dataType : 'json',
		colModel : [ 
		   {display : 'ID',name : 'docutmentInfoId',width : 150,sortable : false,align : 'center',hide : 'true'}, 
	       {display : "合同名称",name : 'docutmentInfoName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : 'docutmentHeadDataId',name : 'docutmentHeadDataId',width : _columnWidth, sortable : false,align : 'center',hide:'true'}, 
	       {display : 'docutmentBodyDataId',name : 'docutmentBodyDataId',width : _columnWidth, sortable : false,align : 'center',hide:'true'}, 
	       {display : "创建时间",name : 'createTime',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "修改时间",name : 'modifyTime',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "操作",name : 'operation',width : _columnWidth, sortable : true,align : 'center',process: function(v,_trid,_row) {				 
				var htmlContents ='<span style="color:blue;cursor:pointer;" onclick="toQuery(\''+_row.docutmentInfoId+'\','
						+'\''+_row.docutmentHeadDataId+'\',\''+_row.docutmentBodyDataId+'\',\''+_row.docutmentInfoName+'\');">查看</span>';
			    return htmlContents;
	       }},
	       {display: "操作", name: 'docutmentHeadDataId', width: _columnWidth, sortable: false, align: 'center', process: function(v,_trid,_row) {
				var htmlContents = 	'<span style="color:blue;cursor:pointer;" onclick="window.open(\'${pageContext.request.contextPath}/downloadContract/${localPath}/' + v + '\');">下载</span>';
				 return htmlContents;
			}},
		],
		resizable : false, //resizable table是否可伸缩
		usepager : true,
		useRp : true,
		usepager : true, //是否分页
		autoload : false, //自动加载，即第一次发起ajax请求
		hideOnSubmit : true, //是否在回调时显示遮盖
		showcheckbox : true, //是否显示多选框
/* 		rowhandler : rowDbclick, //是否启用行的扩展事情功能,在生成行时绑定事件，如双击，右键等 */
		rowbinddata : true,
		numCheckBoxTitle : "<spring:message code='common.selectall'/>"
	});	
	query();
	
	$("#detail").dialog({
		title:'查看标题 ',
		autoOpen:false,
		width:$(window).width()-4,
		height:$(window).height()+2,
		modal:true,
		resizable:false,
		buttons:{
			
		},
		close:function(){
			$(this).dialog('close');
		}
	});
	
});
function query(param1){
	$('#flexiGridID').flexOptions({
		newp: 1,
		extParam: param1||[],
    	url: '${pageContext.request.contextPath}/contract/getContractlist'
    }).flexReload();
}




function toQuery(ID,headID,bodyID,name){
	var src='${pageContext.request.contextPath}/contract/queryDetail?docutmentInfoId='+ID;
	src=src+'&docutmentHeadDataId='+headID;
	src=src+'&docutmentBodyDataId='+bodyID;
	$('#detail').dialog({
		title:name
	}).dialog('open').find('iframe').attr('src',src);
}

</script>

</head>
<body>
<input  type="text" size="50" />
<a href="#"  class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-search"></span>搜索</a>
<form id="uploadContractForm" action="${pageContext.request.contextPath}/contractUpload/addContract" method="post" enctype="multipart/form-data">
   <input type="file" name="srcFile" accept="aplication/msword" />
   <input type="submit" value="导入合同" class="ui-state-default ui-corner-all cbe-button" > </input>
</form>
<a href="#"  class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-plus"></span>导入合同</a>
<a href="#"  class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-minusthick"></span>删除</a>
    <div class="tbl">
         <table id="flexiGridID" style="display: block;margin: 0px;"></table>
    </div>
    
    <div id="detail" style="display:none"> 
      <ifram > </ifram>
    </div>
</body>
</html>