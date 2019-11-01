.<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>采购商信息</title>
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
		 $("#buyerid").val(columnsArray[0]);
		 $("#name").val(columnsArray[1]);
		 $("#linkman").val(columnsArray[2]);
		 $("#linktel").val(columnsArray[3]);
		 $("#address").val(columnsArray[4]);
		 $("#updateBuyerDailDialog").dialog("open");
	 });
	
}


$(function()
{
	resizePageSize();
	var _columnWidth= (_gridWidth-150)/4;
	
	$("#flexiGridID").flexigrid({
		width : _gridWidth,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/buyer/getBuyerlist",		dataType : 'json',
		colModel : [ 
		   {display : 'ID',name : 'buyerid',width : 150,sortable : false,align : 'center',hide : 'true'}, 
	       {display : "<spring:message code='buyer'></spring:message>",name : 'name',width : _columnWidth, sortable : true,align : 'center'}, 
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
        $("#addBuyerDailFormId").resetForm();
        $("#addBuyerDailDialog").dialog( "open" );
        
	});
	
	$("#queryBtn").click(function( event ) {
		var searchName = $("#searchName").val();
		var searchAddress = $("#searchAddress").val();
		query([{"name": "searchName","value":searchName},
		       {"name": "searchAddress","value":searchAddress}]);
	});
	
	$("#delBtn").click(function( event ) {
		
		var ids = searchTableColumn($("#flexiGridID"),0);
		if(ids.length > 0){
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/buyer/deleteBuyerInfo',
				dataType : 'json',
				cache : false,
				data : [ {
					name : 'buyerids',
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
			
			message("<spring:message code='norecord'></spring:message>!");
		}
		//message(ids);
	});

	var name = $("#name");
	var linkman = $("#linkman");
	var linktel = $("#linktel");
	var address = $("#address");
	var allFields = $([]).add(name).add(linkman).add(linktel).add(address);
	
	allFields.removeClass("ui-state-error");
	$( "#updateBuyerDailDialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: '<spring:message code='updatePage'></spring:message>',
		buttons: [
			{
				text: "<spring:message code='confirm'></spring:message>",
				click: function() {
					var bValid = true;
					allFields.removeClass("ui-state-error");
					bValid = bValid && checkLength(name, 1, 16);
					bValid = bValid && checkLength(linkman, 1, 16);
					bValid = bValid && checkLength(linktel, 1, 16);
					bValid = bValid && checkLength(address, 1, 16);
										
					if(!bValid){
						return;
					}
					$("#updateBuyerDailFormId").submit();
					//$( this ).dialog( "close" );
				}
			},
			{
				text: "<spring:message code='cancel'></spring:message>",
				click: function() {
					$( this ).dialog( "close" );
				}
			}
		]
	});
	
	$('#updateBuyerDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#updateBuyerDailDialog").dialog( "close" )
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	var name1 = $("#name1");
	var linkman1 = $("#linkman1");
	var linktel1 = $("#linktel1");
	var address1 = $("#address1");
	var allFields = $([]).add(name1).add(linkman1).add(linktel1).add(address1);
	
	allFields.removeClass("ui-state-error");
	$( "#addBuyerDailDialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: '<spring:message code='addPage'></spring:message>',
		buttons: [
			{
				text: "<spring:message code='confirm'></spring:message>",
				click: function() {					
					var bValid = true;
					allFields.removeClass("ui-state-error");
					bValid = bValid && checkLength(name1, 1, 16);
					bValid = bValid && checkLength(linkman1, 1, 16);
					bValid = bValid && checkLength(linktel1, 1, 16);
					bValid = bValid && checkLength(address1, 1, 16);
										
					if(!bValid){
						return;
					}
					$("#addBuyerDailFormId").submit();
				}
			},
			{
				text: "<spring:message code='cancel'></spring:message>",
				click: function() {
					$( this ).dialog( "close" );
				}
			}
		]
	});
	
	$('#addBuyerDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#addBuyerDailDialog").dialog( "close" )
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
    	url: '${pageContext.request.contextPath}/buyer/getBuyerlist'
    }).flexReload();
}
</script>

</head>
<body>
<label> <spring:message code='buyer'></spring:message>:</label> <input type="text" id="searchName"/>
<label> <spring:message code='address'></spring:message>:</label> <input type="text" id="searchAddress"/>

<a href="#" id="queryBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-search"></span><spring:message code='query'></spring:message></a>
<a href="#" id="delBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-minusthick"></span><spring:message code='delete'></spring:message></a>
<a href="#" id="addBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-plus"></span><spring:message code='add'></spring:message></a>
    <div class="tbl">
         <table id="flexiGridID" style="display: block;margin: 0px;"></table>
    </div>
 <div id="updateBuyerDailDialog" style="display: none;">
	<form id="updateBuyerDailFormId" action="${pageContext.request.contextPath}/buyer/updateBuyerDail" method="post" >
	    <input type="hidden" id="buyerid" name="buyerid" />
         <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label><spring:message code='buyer'></spring:message></label>	   	 	  		
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="name" name="name" />
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label><spring:message code='linkman'></spring:message></label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="linkman" name="linkman"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label><spring:message code='linktel'></spring:message></label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="linktel" name="linktel"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label><spring:message code='address'></spring:message></label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="address" name="address" />
	   	 	  	</td>
	   	 	  </tr>
	 
	   	 </table>
	   </form>  
   </div>
   
 <div id="addBuyerDailDialog" style="display: none;">
	<form id="addBuyerDailFormId" action="${pageContext.request.contextPath}/buyer/addBuyerDail" method="post" >
	    <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label><spring:message code='buyer'></spring:message></label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="name1" name="name" />
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label><spring:message code='linkman'></spring:message></label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="linkman1" name="linkman"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label><spring:message code='linktel'></spring:message></label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="linktel1" name="linktel"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label><spring:message code='address'></spring:message></label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
					<input type="text" id="address1" name="address"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 </table>
	   </form>  
   </div>
</body>
</html>