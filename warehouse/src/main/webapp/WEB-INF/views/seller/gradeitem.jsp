<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品列表</title>
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
		 $("#itemId").val(columnsArray[0]);
		 $("#itemName").val(columnsArray[1]);
		 $("#itemCode").val(columnsArray[2]);
		 $("#precision").val(columnsArray[3]);
		 $("#weight").val(columnsArray[5]);
		 $("#remark").val(columnsArray[6]);
		 $("#updateGradeItemDailDialog").dialog("open");
	 });
	
}


$(function()
{
	resizePageSize();
	var _columnWidth= (_gridWidth-150)/4;
	
	$("#flexiGridID").flexigrid({
		width : _gridWidth,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/warehouse/getCommoditylist",
		dataType : 'json',
		colModel : [ 
		   {display : 'ID',name : 'itemId',width : 150,sortable : false,align : 'center',hide : 'true'}, 
	       {display : "指标名称",name : 'itemName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "指标代码",name : 'itemCode',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "精度",name : 'precision',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "权重",name : 'weight',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "备注",name : 'remark',width : _columnWidth, sortable : true,align : 'center'}
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
	
	
	
	$("#addBtn").click(function( event ) {
        //message("增加页面");
        $("#addGradeItemDailFormId").resetForm();
        $("#addGradeItemDailDialog").dialog( "open" );
        
	});
	
	$("#queryBtn").click(function( event ) {
		var searchName = $("#searchName").val();
		var searchCode = $("#searchCode").val();
		query([{"name": "searchName","value":searchName},
		       {"name": "searchCode","value":searchCode}]);
	});
	
	$("#delBtn").click(function( event ) {
		
		var ids = searchTableColumn($("#flexiGridID"),0);
		if(ids.length > 0){
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/gradeitem/deleteGradeItemInfo',
				dataType : 'json',
				cache : false,
				data : [ {
					name : 'itemIds',
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
		//message(ids);
	});

	$( "#updateGradeItemDailDialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: '修改页面',
		buttons: [
			{
				text: "确定",
				click: function() {
					$("#updateGradeItemDailFormId").submit();
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
	
	$('#updateGradeItemDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#updateGradeItemDailDialog").dialog( "close" );
			message(data.msg);
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	var itemName1 = $("#itemName1");
	var itemCode1 = $("#itemCode1");
	var precision1 = $("#precision1");
	var weight1 = $("#weight1");
	var remark1 = $("#remark1");
	var allFields = $([]).add(itemName1).add(itemCode1).add(precision1).add(weight1).add(remark1);
	
	allFields.removeClass("ui-state-error");
	$( "#addGradeItemDailDialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: '增加页面',
		buttons: [
			{
				text: "确定",
				click: function() {					
					var bValid = true;
					allFields.removeClass("ui-state-error");
					bValid = bValid && checkLength(itemName1, 1, 16);
					bValid = bValid && checkLength(itemCode1, 1, 16);
					bValid = bValid && checkLength(precision1, 1, 16);
					bValid = bValid && checkLength(weight1, 1, 16);
					bValid = bValid && checkLength(remark1, 1, 16);
										
					if(!bValid){
						return;
					}
					$("#addGradeItemDailFormId").submit();
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
	
	$('#addGradeItemDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#addGradeItemDailDialog").dialog( "close" );
			message(data.msg);
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	//$("#weight1").combobox();

});

function query(param1){
	$('#flexiGridID').flexOptions({
		newp: 1,
		extParam: param1||[],
    	url: '${pageContext.request.contextPath}/gradeitem/getGradeItemlist'
    }).flexReload();
}
</script>

</head>
<body>
<label> 指标名称:</label> <input type="text" id="searchName"/>
<label> 指标代码:</label> <input type="text" id="searchCode"/>

<a href="#" id="queryBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-search"></span>查询</a>
<a href="#" id="delBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-minusthick"></span>删除</a>
<a href="#" id="addBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-plus"></span>增加</a>
    <div class="tbl">
         <table id="flexiGridID" style="display: block;margin: 0px;"></table>
    </div>
 <div id="updateGradeItemDailDialog" style="display: none;">
	<form id="updateGradeItemDailFormId" action="${pageContext.request.contextPath}/gradeitem/updateGradeItemDail" method="post" >
	    <input type="hidden" id="itemId" name="itemId" />
         <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>指标名称</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="itemName" name="itemName" />
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>指标代码</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="itemCode" name="itemCode"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>精度</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="precision" name="precision"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>权重</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="weight" name="weight" />
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>备注</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="remark" name="remark" />
	   	 	  	</td>
	   	 	  </tr>
	 
	   	 </table>
	   </form>  
   </div>
   
 <div id="addGradeItemDailDialog" style="display: none;">
	<form id="addGradeItemDailFormId" action="${pageContext.request.contextPath}/gradeitem/addGradeItemDail" method="post" >
	    <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>指标名称</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="itemName1" name="itemName" />
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>指标代码</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="itemCode1" name="itemCode"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>精度</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="precision1" name="precision"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>权重</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
					<input type="text" id="weight1" name="weight"/>		
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>备注</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
					<input type="text" id="remark1" name="remark"/>		
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 </table>
	   </form>  
   </div>
</body>
</html>