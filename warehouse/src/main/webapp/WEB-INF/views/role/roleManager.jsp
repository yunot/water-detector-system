<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.fileName {
	width: 15000px;
	background-color: #85B5D9;
	color: white;
}

.fileValue {
	width: 380px;
}
</style>

<script type="text/javascript">


var _gridWidth;
var _gridHeight;
var _columnWidth;
//页面自适应
function resizePageSize(){
	_gridWidth = $(document).width()-12;/*  -189 是去掉左侧 菜单的宽度，   -12 是防止浏览器缩小页面 出现滚动条 恢复页面时  折行的问题 */
	_gridHeight = $(document).height()-32-80; /* -32 顶部主菜单高度，   -90 查询条件高度*/
	_columnWidth = _gridWidth/5;
	$('#flexiGridID').flexReload();
}

function rowDbclick(r)
{
 	$(r).dblclick(function()
 	{
 		var columnsArray = $(r).attr("ch").split("_FG$SP_");
 		$("#roleId1").val(columnsArray[0]);
 		$("#roleName1").val(columnsArray[1]);
 		$("#roleDescribe1").val(columnsArray[2]);
 		$("#englishName1").val(columnsArray[5]);
 	
 		
 		$("#modifyroleDialog").dialog("open");
 		//message("修改页面");
 	});	
}

$(function()
{
	$(window).resize(function(){
		resizePageSize();
	});
	
	resizePageSize();
	_columnWidth= _gridWidth/5;
	
	$("#flexiGridID").flexigrid({
		width : 'auto',
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/role/getRoleDataShowList",
		dataType : 'json',
		colModel : [ 
		   {display : '<spring:message code='roleId'></spring:message>',name : 'roleId',width : _columnWidth, sortable : true,align : 'center',hide : 'true'}, 
	       {display : "<spring:message code='roleName'></spring:message>",name : 'roleName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "<spring:message code='role.english.name'></spring:message>",name : 'englishName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "<spring:message code='roleDescribe'></spring:message>",name : 'roleDescribe',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "<spring:message code='creatTime'></spring:message>",name : 'creatTime',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "<spring:message code='modifyTime'></spring:message>",name : 'modifyTime',width : _columnWidth, sortable : true,align : 'center'}    	   
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
	
		$("#dialog-add").click(function( event ) {
        
        $("#addroleForm").resetForm();
        $("#addroleDialog").dialog( "open" );
             
	});
	
		
		var roleName = $("#roleName");
		var roleDescribe = $("#roleDescribe");
		var englishName = $("#englishName");
		var creatTime = $("#creatTime");
		var allFields = $([]).add(roleName).add(roleDescribe).add(englishName).add(creatTime);
		allFields.removeClass("ui-state-error");
		$( "#addroleDialog" ).dialog({
			autoOpen : false,
			width : 390,
			modal : true,
			resizable : false,
			title: '<spring:message code='add.role'></spring:message>',
			buttons: [
				{
					text: "<spring:message code='confirm'></spring:message>",
					click: function() {
					var bValid = true;
					allFields.removeClass("ui-state-error");
					bValid = bValid && checkLength(roleName, 1, 16);
					bValid = bValid && checkLength(roleDescribe, 1, 16);
					bValid = bValid && checkLength(englishName, 1, 16);
										
					if(!bValid){
						return;
					}
					
					$("#addroleForm").submit();

					}				
				},
				{
					text: "<spring:message code='common'></spring:message>",
					click: function() {
						$( this ).dialog( "close" );
					}
				}
			]
		});
		
		$("#queryBtn").click(function( event ) {
			var searchName = $("#searchName").val();
			query([{"name": "searchName","value":searchName}]);
		});
		
		$('#addroleForm').ajaxForm({
			dataType: "json",
			success : function(data) {
				$('#flexiGridID').flexReload();
				message("<spring:message code='role.add.sucess'></spring:message>");
				$("#addroleDialog").dialog( "close" )
		     },
		     error : function() {
		           	alert("<spring:message code='system.exception.please.contact.the.administrator'></spring:message>");
		     },
			complete : function(response, status) {
		     
			}
		});
		
		var roleName1 = $("#roleName1");
		var roleDescribe1 = $("#roleDescribe1");
		var englishName1 = $("#englishName1");
		var creatTime1 = $("#creatTime1");
		$( "#modifyroleDialog" ).dialog({
 			autoOpen : false,
 			width : 370,
 			modal : true,
 			resizable : false,
 			title: '<spring:message code='modify.page'></spring:message>',
 			buttons: [
 				{
 					text: "<spring:message code='confirm'></spring:message>",
 					click: function() {
 						var bValid = true;
 						allFields.removeClass("ui-state-error");
 						bValid = bValid && checkLength(roleName1, 1, 16);
 						bValid = bValid && checkLength(roleDescribe1, 1, 16);
 						bValid = bValid && checkLength(englishName1, 1, 16);
 											
 						if(!bValid){
 							return;
 						}
 			$("#modifyroleForm").submit();
 					}
 				},
 				{
 					text: "<spring:message code='common'></spring:message>",
 					click: function() {
 						$( this ).dialog( "close" );
 					}
 				}
 			]
 		});
 		
 		$('#modifyroleForm').ajaxForm({
 			dataType: "json",
 			success : function(data) {
 				$('#flexiGridID').flexReload();
 				message("<spring:message code='role.modify.sucess'></spring:message>");
 				$("#modifyroleDialog").dialog( "close" )
 		     },
 		     error : function() {
 		           	alert("<spring:message code='system.exception.please.contact.the.administrator'></spring:message>");
 		     },
 			complete : function(response, status) {
 		     
 			}
 		});
 		
 		$("#dialog-delete").click(function( event ) {
 			
 			var ids = searchTableColumn($("#flexiGridID"),0);
 			if(ids.length > 0){
 				$.ajax({
 					type : 'POST',
 					url : '${pageContext.request.contextPath}/role/deleteRole',
 					dataType : 'json',
 					cache : false,
 					data : [ {
 						name : 'roleId',
 						value : ids
 					} ],
 					success : function(data) {
 						$('#flexiGridID').flexReload();
 						message(data.msg);
 					    
 					},
 					error : function() {
 						message("<spring:message code='system.exception.please.contact.the.administrator'></spring:message>");
 					}
 				});
 				
 			}else{
 				
 				message("<spring:message code='please.select.a.record'></spring:message>");
 			}


 			//message(ids);
 		});
 		
 		
 		//权限树
		$("#dialog-power").click(function( event ) {
			
			var ids = searchTableColumn($("#flexiGridID"),0);
			if(ids.length > 0&&ids.length<2){
				//message(ids[0]);
				$.ajax({
					type : 'POST',
					url : '${pageContext.request.contextPath}/role/getZTreeData',
					dataType : 'json',
					cache : false,
					data : [ 
					        {
		 						  name : 'roleId',
			 					  value : ids[0]
			 				  }
					        ],
					success : function(data) {
						if(data.list != null){
							var setting = {
									check: {
											enable: true
									},
									data: {
											simpleData: {
											enable: true
									}
								},
								callback : {
									onCheck : onClickNode
								}
						 };
				 		 $.fn.zTree.init($("#roleTreeID"), setting, data.list);
				 		 $("#departmentTreeID").dialog( "open" );

						}
					},
					error : function() {
						message("<spring:message code='system.exception.please.contact.the.administrator'></spring:message>");
					}
				});
						 
						
			}else{
				
				message("<spring:message code='please.select.a.record'></spring:message>");
			}
	       
		});
		
		
		
		
		
	$( "#departmentTreeID" ).dialog({
			autoOpen : false,
			width : 370,
			modal : true,
			resizable : false,
			title: '<spring:message code='Role.authorization.center'></spring:message>',
			buttons: [
		 				{
		 					text: "<spring:message code='confirm'></spring:message>",
		 					click: function() {
		 						var roleIdArray = [];
		 						var ids = searchTableColumn($("#flexiGridID"),0);
		 					
		 						var treeObj = $.fn.zTree.getZTreeObj("roleTreeID");
								//获取所有选中节点，不包括禁用
								//message(ids[0]);
							if(ids.length > 0&&ids.length<2){	
								//message(ids[0]);
								var nodes = treeObj.getCheckedNodes(true);
								if(nodes && nodes.length >0){
									for(var i=0; i < nodes.length; i++){
										roleIdArray.push(nodes[i].id);
									}
							}
						
		 								 						
						
							$.ajax({
			 					type : 'POST',
			 					url : '${pageContext.request.contextPath}/role/insertMenuRefRole',
			 					dataType : 'json',
			 					cache : false,
			 					data : [ {
			 						name : 'roleIds',
			 						value : roleIdArray
			 					  },
			 					  {
			 						  name : 'roleId',
				 					  value : ids[0]
				 				  }
			 					  ],
			 					success : function(data) { 					 						
			 						message("<spring:message code='Role.authorization.succeeded'></spring:message>");
			 						//message(ids[0]);
			 						$("#departmentTreeID").dialog( "close" );
			 					},
			 					error : function() {
			 						message("<spring:message code='system.exception.please.contact.the.administrator'></spring:message>");
			 					}
			 				});
							    
		 					}else{
		 						
		 						message("<spring:message code='please.select.a.record'></spring:message>");
		 					}
		 				  }
		 				},
		 				{
		 					text: "<spring:message code='common'></spring:message>",
		 					click: function() {
		 						$( this ).dialog( "close" );
		 					}
		 				}
		 			]
		});
	
});

function onClickNode(event, treeId, treeNode)
{
   rolePrivilege = '';
	$.each($.fn.zTree.getZTreeObj("roleTreeID").getCheckedNodes(),function(index, node) {
		rolePrivilege += node.id + ","
	});
}




function query(param1){
	$('#flexiGridID').flexOptions({
		newp: 1,
		extParam: param1||[],
    	url: '${pageContext.request.contextPath}/role/getRoleDataList'
    }).flexReload();
}



</script>

</head>
<body>
	<label> <spring:message code='roleName'></spring:message></label>
	<input type="text" id="searchName" />

	<shiro:hasPermission name="system:role:query">
		<a href="#" id="queryBtn"
			class="ui-state-default ui-corner-all cbe-button"><span
			class="ui-icon ui-icon-search"></span> <spring:message
				code='query.role'></spring:message></a>
	</shiro:hasPermission>

	<shiro:hasPermission name="system:role:add">
		<a href="#" id="dialog-add"
			class="ui-state-default ui-corner-all cbe-button"><span
			class="ui-icon ui-icon-plus"></span> <spring:message code='add.role'></spring:message></a>
	</shiro:hasPermission>

	<shiro:hasPermission name="system:role:privilege">
		<a href="#" id="dialog-power"
			class="ui-state-default ui-corner-all cbe-button"><span
			class="ui-icon ui-icon-plus"></span> <spring:message
				code='role.authorization'></spring:message></a>
	</shiro:hasPermission>

	<shiro:hasPermission name="system:role:delete">
		<a href="#" id="dialog-delete"
			class="ui-state-default ui-corner-all cbe-button"><span
			class="ui-icon ui-icon-minusthick"></span>
		<spring:message code='delete.role'></spring:message></a>
	</shiro:hasPermission>

	<div class="tbl">
		<table id="flexiGridID" style="display: block;margin: 0px;"></table>
	</div>
	<div id="addroleDialog" style="display: none;">
		<form id="addroleForm"
			action="${pageContext.request.contextPath}/role/addRole"
			method="post">
			<table>
				<tr>
					<td class="fileName"><label><spring:message
								code='roleName'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="roleName"
						name="roleName" /></td>
				</tr>
				
				<tr>
					<td class="fileName"><label><spring:message
								code='role.english.name'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="englishName"
						name="englishName" /></td>
				</tr>
				
				<tr>
					<td class="fileName"><label><spring:message
								code='roleDescribe'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="roleDescribe"
						name="roleDescribe" /></td>
				</tr>



			</table>
		</form>
	</div>

	<div id="modifyroleDialog" style="display: none;">
		<form id="modifyroleForm"
			action="${pageContext.request.contextPath}/role/modifyRole"
			method="post">
			<input type="hidden" id="roleId1" name="roleId" />
			<table style="width:350px">
				<tr>
					<td class="fileName"><label><spring:message
								code='roleName'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="roleName1"
						name="roleName" /></td>
				</tr>
				
				<tr>
					<td class="fileName"><label><spring:message
								code='role.english.name'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="englishName1"
						name="englishName" /></td>
				</tr>

				<tr>
					<td class="fileName"><label><spring:message
								code='roleDescribe'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="roleDescribe1"
						name="roleDescribe" /></td>
				</tr>

			</table>
		</form>
	</div>

	<!-- 权限树 -->
	<div id="departmentTreeID" class="zTreeDemoBackground left"
		align="center" style="display: none;">
		<ul id="roleTreeID" class="ztree"></ul>
	</div>

</body>
</html>