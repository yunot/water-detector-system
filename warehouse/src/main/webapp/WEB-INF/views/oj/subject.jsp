<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>OJ题目管理</title>
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
	$("#subjectName").css("width", _gridWidth -129 +"px");
	$("#subjectName1").css("width", _gridWidth -129 +"px");
}

$(function()
{
	resizePageSize();
	var _columnWidth= (_gridWidth-150)/4;
	$("#flexiGridID").flexigrid({
		width : _gridWidth,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/subjectController/getSubjectlist",
		dataType : 'json',
		colModel : [ 
		   {display : 'ID',name : 'subjectId',width : 150,sortable : false,align : 'center',hide : 'true'}, 
	       {display : "题目名称",name : 'subjectName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "题目描述",name : 'subjectDesc',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "创建时间",name : 'createTime',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "修改时间",name : 'modifyTime',width : _columnWidth, sortable : true,align : 'center'}
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
	
	$("#querySubjectByName").click(function( event ) {
		var searchName = $("#searchName").val();
		query([{"name": "searchName","value":searchName}]);
	});
	
	$("#delBtn").click(function( event ) {
		var ids = searchTableColumn($("#flexiGridID"),0);
		if(ids.length > 0){
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/subjectController/deleteSubject',
				dataType : 'json',
				cache : false,
				data : [ {
					name : 'subjectIds',
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
			message("请选择的记录为空！");
		}
	});
	
	function rowDbclick(r){
		$(r).dblclick(
		 function() {
			 var columnsArray = $(r).attr('ch').split("_FG$SP_");
			 $("#subjectId").val(columnsArray[0]);
			 $("#subjectName").val(columnsArray[1]);
			 $("#subjectDesc").val(columnsArray[2]);
			 $("#subjectInput").val(columnsArray[3]);
			 $("#subjectOut").val(columnsArray[4]);
			 $("#sampleInput").val(columnsArray[5]);
			 $("#sampleOut").val(columnsArray[6]);
			 $("#unitInput").val(columnsArray[9]);
			 $("#unitOut").val(columnsArray[10]);
			 $("#updateSubject").dialog("open");
		 });
	}
	
	var subjectName = $("#subjectName");
	var subjectDesc = $("#subjectDesc");
	var subjectInput = $("#subjectInput");
	var subjectOut = $("#subjectOut");
	var sampleInput = $("#sampleInput");
	var sampleOut = $("#sampleOut");
	var unitInput = $("#unitInput");
	var unitOut = $("#unitOut");
	var allFields = $([]).add(subjectName).add(subjectDesc).add(subjectInput).add(subjectOut).add(sampleInput).add(sampleOut).add(unitInput).add(unitOut);
	allFields.removeClass("ui-state-error");
	$( "#updateSubject" ).dialog({
		autoOpen : false,
		width : _gridWidth,
		modal : true,
		resizable : false,
		title: '修改页面',
		buttons: [
			{
				text: "确定",
				click: function() {
					var bValid = true;
					allFields.removeClass("ui-state-error");
					bValid = bValid && checkLength(subjectName, 1, 128);
					bValid = bValid && checkLength(subjectDesc, 1, 512);
					bValid = bValid && checkLength(subjectInput, 1, 1024);
					bValid = bValid && checkLength(subjectOut, 1, 1024);
					bValid = bValid && checkLength(sampleInput, 1, 1024);
					bValid = bValid && checkLength(sampleOut, 1, 1024);
					bValid = bValid && checkLength(unitInput, 1, 8192);
					bValid = bValid && checkLength(unitOut, 1, 8192);
										
					if(!bValid){
						return;
					}
					$("#updateSubjectFormId").submit();
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
	
	$('#updateSubjectFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#updateSubject").dialog( "close" );
			message(data.msg);
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	$("#addBtn").click(function( event ) {
        //message("增加页面");
        $("#addSubjectFormId").resetForm();
        $("#addSubjectDialog").dialog( "open" );
	});
	
	var subjectName1 = $("#subjectName1");
	var subjectDesc1 = $("#subjectDesc1");
	var subjectInput1 = $("#subjectInput1");
	var subjectOut1 = $("#subjectOut1");
	var sampleInput1 = $("#sampleInput1");
	var sampleOut1 = $("#sampleOut1");
	var unitInput1 = $("#unitInput1");
	var unitOut1 = $("#unitOut1");
	var allFields = $([]).add(subjectName1).add(subjectDesc1).add(subjectInput1).add(subjectOut1).add(sampleInput1).add(sampleOut1).add(unitInput1).add(unitOut1);
	
	allFields.removeClass("ui-state-error");
	$( "#addSubjectDialog" ).dialog({
		autoOpen : false,
		width : _gridWidth,
		modal : true,
		resizable : false,
		title: '增加页面',
		buttons: [
			{
				text: "确定",
				click: function() {					
					var bValid = true;
					allFields.removeClass("ui-state-error");
					bValid = bValid && checkLength(subjectName1, 1, 128);
					bValid = bValid && checkLength(subjectDesc1, 1, 512);
					bValid = bValid && checkLength(subjectInput1, 1, 1024);
					bValid = bValid && checkLength(subjectOut1, 1, 1024);
					bValid = bValid && checkLength(sampleInput1, 1, 1024);
					bValid = bValid && checkLength(sampleOut1, 1, 1024);
					bValid = bValid && checkLength(unitInput1, 1, 8192);
					bValid = bValid && checkLength(unitOut1, 1, 8192);
										
					if(!bValid){
						return;
					}
					$("#addSubjectFormId").submit();
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
	
	$('#addSubjectFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#addSubjectDialog").dialog( "close" );
			message(data.msg);
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
    	url: '${pageContext.request.contextPath}/subjectController/getSubjectlist'
    }).flexReload();
}
</script>

</head>
<body>
<label> 题目名称:</label> <input type="text" id="searchName"/>

<a href="#" id="querySubjectByName" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-search"></span>查询</a>
<a href="#" id="delBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-minusthick"></span>删除</a>
<a href="#" id="addBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-plus"></span>增加</a>
    <div class="tbl">
         <table id="flexiGridID" style="display: block;margin: 0px;"></table>
    </div>
 <div id="updateSubject" style="display: none;">
	<form id="updateSubjectFormId" action="${pageContext.request.contextPath}/subjectController/updateSubject" method="post" >
	    <input type="hidden" id="subjectId" name="subjectId" />
         <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>题目名称*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="subjectName" name="subjectName" />
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>题目描述*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="subjectDesc" name="subjectDesc"></textarea>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>题目输入*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="subjectInput" name="subjectInput"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>题目输出*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="subjectOut" name="subjectOut"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>样例输入*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="sampleInput" name="sampleInput"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>样例输出*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="sampleOut" name="sampleOut"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>用例输入*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="unitInput" name="unitInput"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>用例输出*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="unitOut" name="unitOut"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 </table>
	   </form>  
   </div>
   
 <div id="addSubjectDialog" style="display: none;">
	<form id="addSubjectFormId" action="${pageContext.request.contextPath}/subjectController/addSubject" method="post" >
	    <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>题目名称*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="subjectName1" name="subjectName" />
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>题目描述*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;"  id="subjectDesc1" name="subjectDesc"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>题目输入*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="subjectInput1" name="subjectInput"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>题目输出*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="subjectOut1" name="subjectOut"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>样例输入*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="sampleInput1" name="sampleInput"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>样例输出*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="sampleOut1" name="sampleOut"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>用例输入*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="unitInput1" name="unitInput"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>用例输出*</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<textarea style="width : 100%;" id="unitOut1" name="unitOut"></textarea>
	   	 	  		
	   	 	  	</td>
	   	 	  </tr>
	   	 </table>
	   </form>  
   </div>
</body>
</html>