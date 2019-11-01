<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>供应商信息</title>
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
		 $("#supplierid").val(columnsArray[0]);
		 $("#sellerName").val(columnsArray[1]);
		 $("#linkman").val(columnsArray[2]);
		 $("#linktel").val(columnsArray[3]);
		 $("#address").val(columnsArray[4]);
		 $("#updateSellerInfoDailDialog").dialog("open");
	 });
	
}


$(function()
{
	resizePageSize();
	var _columnWidth= (_gridWidth-150)/4;
	
	$("#flexiGridID").flexigrid({
		width : _gridWidth,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/seller/getSellerlist",
		dataType : 'json',
		colModel : [ 
	       {display : '<spring:message code='supplierid'></spring:message>',name : 'supplierid',width : _columnWidth, sortable : true,align : 'center',hide : 'true'}, 
	       {display : "<spring:message code='sellerName'></spring:message>",name : 'sellerName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "<spring:message code='linkman'></spring:message>",name : 'linkman',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "<spring:message code='linktel'></spring:message>",name : 'linktel',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "<spring:message code='address'></spring:message>",name : 'address',width : _columnWidth, sortable : true,align : 'center'}
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
        $("#addSellerInfoDailFormId").resetForm();
        $("#addSellerInfoDailDialog").dialog( "open" );
        
	});
	
	$("#queryBtn").click(function( event ) {
		var searchName = $("#searchName").val();
		var searchMan = $("#searchMan").val();
		query([{"name": "searchName","value":searchName},
		       {"name": "searchMan","value":searchMan}]);
	});
	
	$("#delBtn").click(function( event ) {
		
		var ids = searchTableColumn($("#flexiGridID"),0);
		if(ids.length > 0){
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/seller/deleteSellerInfo',
				dataType : 'json',
				cache : false,
				data : [ {
					name : 'sellerIds',
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

	$( "#updateSellerInfoDailDialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: '修改页面',
		buttons: [
			{
				text: "确定",
				click: function() {
					$("#updateSellerInfoDailFormId").submit();
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
	
	$('#updateSellerInfoDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#updateSellerInfoDailDialog").dialog( "close" )
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	var sellerName1 = $("#sellerName1");
	var linkman1 = $("#linkman1");
	var linktel1 = $("#linktel1");
	var address1 = $("#address1");
	var allFields = $([]).add(sellerName1).add(linkman1).add(linktel1).add(address1);
	
	allFields.removeClass("ui-state-error");
	$( "#addSellerInfoDailDialog" ).dialog({
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
					bValid = bValid && checkLength(sellerName1, 1, 16);
					bValid = bValid && checkLength(linkman1, 1, 16);
					bValid = bValid && checkLength(linktel1, 1, 16);
					bValid = bValid && checkLength(address1, 1, 16);
										
					if(!bValid){
						return;
					}
					$("#addSellerInfoDailFormId").submit();
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
	
	$('#addSellerInfoDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#addSellerInfoDailDialog").dialog( "close" )
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	/* $("#address1").combobox();下拉框样式 */

});

function query(param1){
	$('#flexiGridID').flexOptions({
		newp: 1,
		extParam: param1||[],
    	url: '${pageContext.request.contextPath}/seller/getSellerlist'
    }).flexReload();
}
</script>

</head>
<body>
<label> 供应商名称:</label> <input type="text" id="searchName"/>
<label> 联系人:</label> <input type="text" id="searchMan"/>

<a href="#" id="queryBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-search"></span>查询</a>
<a href="#" id="delBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-minusthick"></span>删除</a>
<a href="#" id="addBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-plus"></span>增加</a>
    <div class="tbl">
         <table id="flexiGridID" style="display: block;margin: 0px;"></table>
    </div>
 <div id="updateSellerInfoDailDialog" style="display: none;">
	<form id="updateSellerInfoDailFormId" action="${pageContext.request.contextPath}/seller/updateSellerInfoDail" method="post" >
	    <input type="hidden" id="supplierid" name="supplierid" />
         <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>供应商名称</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="sellerName" name="sellerName" />
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>联系人</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="linkman" name="linkman"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>联系电话</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="linktel" name="linktel"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>地址</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="address" name="address" />
	   	 	  	</td>
	   	 	  </tr>
	 
	   	 </table>
	   </form>  
   </div>
   
 <div id="addSellerInfoDailDialog" style="display: none;">
	<form id="addSellerInfoDailFormId" action="${pageContext.request.contextPath}/seller/addSellerInfoDail" method="post" >
	    <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>供应商名称</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="sellerName1" name="sellerName" />
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>联系人</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="linkman1" name="linkman"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>联系电话</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="linktel1" name="linktel"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>地址</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="address1" name="address"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <!-- <tr>
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
	   	 	  </tr> -->
	   	 </table>
	   </form>  
   </div>
</body>
</html>