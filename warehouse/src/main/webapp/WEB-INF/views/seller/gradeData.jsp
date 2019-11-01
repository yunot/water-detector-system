<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>供应商评级</title>
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
		 $("#id").val(columnsArray[0]);
		 $("#sysResCode").val(columnsArray[1]);
		 $("#buyrCode").val(columnsArray[2]);
		 $("#itemValueFact").val(columnsArray[3]);
		 $("#itemValueReport").val(columnsArray[4]);
		 $("#itemValueApprove").val(columnsArray[5]);
		 $("#stateId").val(columnsArray[6]);
		 $("#remarks").val(columnsArray[7]);
		 $("#updateGradeDataDailDialog").dialog("open");
	 });
}

$(function()
{
	resizePageSize();
	var _columnWidth= (_gridWidth-150)/7;
	$("#flexiGridID").flexigrid({
		width : _gridWidth,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/gradeData/getCommoditylist",
		dataType : 'json',
		colModel : [ 
		   {display : 'ID',name : 'id',width : 150,sortable : false,align : 'center',hide : 'true'}, 
	       {display : "机构编码",name : 'sysResCode',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "采购商编码",name : 'buyrCode',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "实际值",name : 'itemValueFact',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "上报值",name : 'itemValueReport',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "审批值",name : 'itemValueApprove',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "当前状态",name : 'stateId',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "备注",name : 'remarks',width : _columnWidth, sortable : true,align : 'center'}
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
        $("#addGradeDataDailFormId").resetForm();
        $("#addGradeDataDailDialog").dialog( "open" );
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
				url : '${pageContext.request.contextPath}/gradeData/deleteGradeData',
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
	});
	$( "#updateGradeDataDailDialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: '修改页面',
		buttons: [
			{
				text: "确定",
				click: function() {
					$("#updateGradeDataDailFormId").submit();
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
	
	$('#updateGradeDataDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#updateGradeDataDailDialog").dialog( "close" );
			message(data.msg);
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	var sysResCode1 = $("#sysResCode1");
	var buyrCode1 = $("#buyrCode1");
	var itemValueFact1 = $("#itemValueFact1");
	var itemValueReport1 = $("#itemValueReport1");
	var itemValueApprove1 = $("#itemValueApprove1");
	var stateId1 = $("#stateId1");
	var remarks1 = $("#remarks1");
	var allFields = $([]).add(sysResCode1).add(buyrCode1).add(itemValueFact1).add(itemValueReport1).add(itemValueApprove1).add(stateId1).add(remarks1);
	
	allFields.removeClass("ui-state-error");
	$( "#addGradeDataDailDialog" ).dialog({
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
					bValid = bValid && checkLength(sysResCode1, 1, 16);
					bValid = bValid && checkLength(buyrCode1, 1, 16);
					bValid = bValid && checkLength(itemValueFact1, 1, 16);
					bValid = bValid && checkLength(itemValueReport1, 1, 16);
					bValid = bValid && checkLength(itemValueApprove1, 1, 16);
					bValid = bValid && checkLength(stateId1, 1, 16);
					bValid = bValid && checkLength(remarks1, 1, 16);
										
					if(!bValid){
						return;
					}
					$("#addGradeDataDailFormId").submit();
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
	
	$('#addGradeDataDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#addGradeDataDailDialog").dialog( "close" );
			message(data.msg);
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	/* $("#itemValueReport1").combobox(); */

});

function query(param1){
	$('#flexiGridID').flexOptions({
		newp: 1,
		extParam: param1||[],
    	url: '${pageContext.request.contextPath}/gradeData/getCommoditylist'
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
 <div id="updateGradeDataDailDialog" style="display: none;">
	<form id="updateGradeDataDailFormId" action="${pageContext.request.contextPath}/gradeData/updateGradeData" method="post" >
	    <input type="hidden" id="id" name="id" />
         <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>机构编码</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="sysResCode" name="sysResCode" />
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>采购商编码</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="buyrCode" name="buyrCode"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>实际值</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="pritemValueFactoducer" name="itemValueFact"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>上报值</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="itemValueReport" name="itemValueReport" />
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>审批值</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="itemValueApprove" name="itemValueApprove"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>当前状态</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="stateId" name="stateId"/>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>备注</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="remarks" name="remarks" />
	   	 	  	</td>
	   	 	  </tr>
	 
	   	 </table>
	   </form>  
   </div>
   
 <div id="addGradeDataDailDialog" style="display: none;">
	<form id="addGradeDataDailFormId" action="${pageContext.request.contextPath}/gradeData/addGradeData" method="post" >
	    <table >
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>机构编码</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="sysResCode1" name="sysResCode" />
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>采购商编码</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="buyrCode1" name="buyrCode"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>实际值</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="itemValueFact1" name="itemValueFact"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>上报值</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="itemValueReport1" name="itemValueReport" />
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>审批值</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="itemValueApprove1" name="itemValueApprove"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>当前状态</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="stateId1" name="stateId"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 	  <tr>
	   	 	  	<td class="fileName">
	   	 	  		<label>备注</label>
	   	 	  	</td>
	   	 	  	<td class="fileValue" >
	   	 	  		<input type="text" id="remarks1" name="remarks"/>
	   	 	  		<span class="mand">*</span>
	   	 	  	</td>
	   	 	  </tr>
	   	 </table>
	   </form>  
   </div>
</body>
</html>