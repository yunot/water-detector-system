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
		 $("#goodId").val(columnsArray[0]);
		 $("#goodName").val(columnsArray[1]);
		 $("#goodCount").val(columnsArray[2]);
		 $("#producer").val(columnsArray[3]);
		 $("#goodPrice").val(columnsArray[4]);
		 $("#updateWarehouseDailDialog").dialog("open");
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
		   {display : 'ID',name : 'goodId',width : 150,sortable : false,align : 'center',hide : 'true'}, 
	       {display : "商品名称",name : 'goodName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "商品数量",name : 'goodCount',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "生产厂商",name : 'producer',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "商品价格",name : 'goodPrice',width : _columnWidth, sortable : true,align : 'center'}
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
        $("#addWarehouseDailFormId").resetForm();
        $("#addWarehouseDailDialog").dialog( "open" );
        
	});
	
	$("#queryBtn").click(function( event ) {
		var searchName = $("#searchName").val();
		var searchCount = $("#searchCount").val();
		query([{"name": "searchName","value":searchName},
		       {"name": "searchCount","value":searchCount}]);
	});
	
	$("#delBtn").click(function( event ) {
		
		var ids = searchTableColumn($("#flexiGridID"),0);
		if(ids.length > 0){
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/warehouse/deleteWarehouseInfo',
				dataType : 'json',
				cache : false,
				data : [ {
					name : 'goodIds',
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

	$( "#updateWarehouseDailDialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: '修改页面',
		buttons: [
			{
				text: "确定",
				click: function() {
					$("#updateWarehouseDailFormId").submit();
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
	
	$('#updateWarehouseDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#updateWarehouseDailDialog").dialog( "close" )
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	var goodName1 = $("#goodName1");
	var goodCount1 = $("#goodCount1");
	var producer1 = $("#producer1");
	var goodPrice1 = $("#goodPrice1");
	var allFields = $([]).add(goodName1).add(goodCount1).add(producer1).add(goodPrice1);
	
	allFields.removeClass("ui-state-error");
	$( "#addWarehouseDailDialog" ).dialog({
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
					bValid = bValid && checkLength(goodName1, 1, 16);
					bValid = bValid && checkLength(goodCount1, 1, 16);
					bValid = bValid && checkLength(producer1, 1, 16);
					bValid = bValid && checkLength(goodPrice1, 1, 16);
										
					if(!bValid){
						return;
					}
					$("#addWarehouseDailFormId").submit();
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
	
	$('#addWarehouseDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#addWarehouseDailDialog").dialog( "close" )
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	$("#goodPrice1").combobox();

});

function query(param1){
	$('#flexiGridID').flexOptions({
		newp: 1,
		extParam: param1||[],
    	url: '${pageContext.request.contextPath}/warehouse/getCommoditylist'
    }).flexReload();
}
</script>

</head>
<body>
<label> 商品名称:</label> <input type="text" id="searchName"/>
<label> 商品数量:</label> <input type="text" id="searchCount"/>

<a href="#" id="queryBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-search"></span>查询</a>
<a href="#" id="delBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-minusthick"></span>删除</a>
<a href="#" id="addBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-plus"></span>增加</a>
    <div class="tbl">
         <table id="flexiGridID" style="display: block;margin: 0px;"></table>
    </div>
 <div id="updateWarehouseDailDialog" style="display: none;">
	<form id="updateWarehouseDailFormId" action="${pageContext.request.contextPath}/warehouse/updateWarehouseDail" method="post" >
	    <input type="hidden" id="goodId" name="goodId" />
         <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>商品名称</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="goodName" name="goodName" />
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>商品数量</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="goodCount" name="goodCount"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>生产厂商</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="producer" name="producer"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>商品价格</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="goodPrice" name="goodPrice" />
	   	 	  	</td>
	   	 	  </tr>
	 
	   	 </table>
	   </form>  
   </div>
   
 <div id="addWarehouseDailDialog" style="display: none;">
	<form id="addWarehouseDailFormId" action="${pageContext.request.contextPath}/warehouse/addWarehouseDail" method="post" >
	    <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>商品名称</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="goodName1" name="goodName" />
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>商品数量</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="goodCount1" name="goodCount"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>生产厂商</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="producer1" name="producer"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>商品价格</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
					 <select id="goodPrice1" name="goodPrice">
							<option value="">请选择</option>
							<option value="10">10元</option>
							<option value="20">20元</option>
							<option value="30">30元</option>
					</select>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 </table>
	   </form>  
   </div>
</body>
</html>