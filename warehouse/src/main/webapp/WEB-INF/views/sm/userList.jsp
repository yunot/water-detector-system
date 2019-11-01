<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp"%>
<%@taglib prefix="resource" uri="http://www.project.com/myTag/resource"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='user.list'></spring:message></title>
<style type="text/css">
.fileName {
	width: 300px;
	background-color: #85B5D9;
	color: white;
}

.fileValue {
	width: 300px;
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
		 $("#userId").val(columnsArray[0]);
		 $("#employeeid").val(columnsArray[1]);
		 $("#name").val(columnsArray[2]);
		 $("#gender").val(columnsArray[3]);
		 $("#telephone").val(columnsArray[4]);
		 $("#updateUserDailDialog").dialog("open");
	 });
	
}


$(function()
{
	resizePageSize();
	var _columnWidth= (_gridWidth-150)/5;
	
	$("#flexiGridID").flexigrid({
		width : _gridWidth,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/user/getCommoditylist1",
		dataType : 'json',
		colModel : [ 
		   {display : 'ID',name : 'userId',width : 150,sortable : false,align : 'center',hide : 'true'}, 
		   {display : "<spring:message code='user.account'></spring:message>",name : 'account',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "<spring:message code='work.account'></spring:message>",name : 'employeeid',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "<spring:message code='user.name'></spring:message>",name : 'name',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "<spring:message code='gender'></spring:message>",name : 'gender',width : _columnWidth, sortable : true,align : 'center',process: function(v) {
				 return $('#gender1 option[value=' + v + ']').text();;
			 }},
	       {display : "<spring:message code='sm.user.telephone'></spring:message>",name : 'telephone',width : _columnWidth, sortable : true,align : 'center'}
		],
		resizable : false, //resizable table是否可伸缩
		usepager : true,
		useRp : true,
		usepager : true, //是否分页
		autoload : false, //自动加载，即第一次发起ajax请求
		hideOnSubmit : true, //是否在回调时显示遮盖
		showcheckbox : true, //是否显示多选框
		//rowhandler : rowDbclick, //是否启用行的扩展事情功能,在生成行时绑定事件，如双击，右键等
		rowbinddata : true,
		numCheckBoxTitle : "<spring:message code='common.selectall'/>"
	});	
	
	query();
	
	
	
	$("#addBtn").click(function( event ) {
        //message("增加页面");
        $("#addUserDailFormId").resetForm();
        $("#addUserDailDialog").dialog( "open" );
        
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
				url : '${pageContext.request.contextPath}/user/deleteUserInfo',
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
					message("<spring:message code='please.contact.the.administrator'></spring:message>");
				}
			});
			
		}else{
			
			message("<spring:message code='record.does.not.exist'></spring:message> ！");
		}


		//message(ids);
	});

	$( "#updateUserDailDialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: "<spring:message code='modify.the.page'></spring:message>",
		buttons: [
			{
				text: "<spring:message code='confirm'></spring:message>",
				click: function() {
					
					
					$("#updateUserDailFormId").submit();
					//$( this ).dialog( "close" );
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
	
	$('#updateUserDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#updateUserDailDialog").dialog( "close" )
	     },
	     error : function() {
	        message("<spring:message code='please.contact.the.administrator'></spring:message>");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	var account1 = $("#account1");
	var employeeid1 = $("#employeeid1");
	var name1 = $("#name1");
	var password1 =$("#password1")
	var email1 = $("#email1");
	var gender1 = $("#gender1");
	var telephone1 = $("#telephone1");
	var allFields = $([]).add(account1).add(employeeid1).add(name1).add(password1).add(email1).add(gender1).add(telephone1);
	
	allFields.removeClass("ui-state-error");
	$( "#addUserDailDialog" ).dialog({
		autoOpen : false,
		width : 410,
		modal : true,
		resizable : false,
		title: "<spring:message code='add.page'></spring:message>",
		buttons: [
			{
				text: "<spring:message code='confirm'></spring:message>",
				click: function() {					
					var bValid = true;
					allFields.removeClass("ui-state-error");
					bValid = bValid && checkLength(account1, 1, 16);
					bValid = bValid && checkLength(employeeid1, 1, 16);
					bValid = bValid && checkLength(name1, 1, 16);
					bValid = bValid && checkLength(password1, 1, 16);
					bValid = bValid && checkLength(email1, 1, 16);
					bValid = bValid && checkLength(gender1, 1, 16);
					bValid = bValid && checkLength(telephone1, 1, 16);
										
					if(!bValid){
						return;
					}
					
					$("#addUserDailFormId").submit();
	
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
	
	
	$('#addUserDailFormId').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#addUserDailDialog").dialog( "close" )
	     },
	     error : function() {
	        message("<spring:message code='please.contact.the.administrator'></spring:message>");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	$("#gender1").combobox();

	//权限树
		$("#dialog-power").click(function( event ) {
			
			var ids = searchTableColumn($("#flexiGridID"),0);
			if(ids.length > 0&&ids.length<2){
				//message(ids[0]);
				$.ajax({
					type : 'POST',
					url : '${pageContext.request.contextPath}/user/getZTreeData',
					dataType : 'json',
					cache : false,
					data : [ 
					         {
					 	   name : 'userId',
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
				
				message("<spring:message code='please.select.a.record'></spring:message> ！");
			}
	       
		});
		
		
		
		
		
	$( "#departmentTreeID" ).dialog({
			autoOpen : false,
			width : 370,
			modal : true,
			resizable : false,
			title: "<spring:message code='user.distribution.center'></spring:message>",
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
			 					url : '${pageContext.request.contextPath}/user/insertUserRefRole',
			 					dataType : 'json',
			 					cache : false,
			 					data : [ {
			 						name : 'roleIds',
			 						value : roleIdArray
			 					  },
			 					  {
			 						  name : 'userId',
				 					  value : ids[0]
				 				  }
			 					  ],
			 					success : function(data) { 					 						
			 						message('<spring:message code="role.distribute.sucess"></spring:message>');
			 						//message(ids[0]);
			 						$("#departmentTreeID").dialog( "close" );
			 					},
			 					error : function() {
			 						message("<spring:message code='system.exception.please.contact.the.administrator'></spring:message>");
			 					}
			 				});
							    
		 					}else{
		 						
		 						message("<spring:message code='please.select.a.record'></spring:message> ！");
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
		
		//分配岗位
		$("#dialog-post")
				.click(
						function(event) {

							var ids = searchTableColumn($("#flexiGridID"), 0);
							if (ids.length > 0) {
								//message(ids[0]);
								$
										.ajax({
											type : 'POST',
											url : '${pageContext.request.contextPath}/user/getPostZTreeData',
											dataType : 'json',
											cache : false,
											data : [ {
												name : 'userIds',
												value : ids
											} ],
											success : function(data) {
												if (data.list != null) {
													var setting = {
														check : {
															enable : true
														},
														data : {
															simpleData : {
																enable : true
															}
														},
														callback : {
															onCheck : onClickNode
														}
													};
													$.fn.zTree.init(
															$("#postTreeID"),
															setting, data.list);
													$("#departmentTreeID1")
															.dialog("open");

												}
											},
											error : function() {
												message("<spring:message code='system.exception.please.contact.the.administrator'></spring:message>");
											}
										});

							} else {

								message("<spring:message code='norecord'></spring:message> ！");
							}

						});

		$("#departmentTreeID1")
				.dialog(
						{
							autoOpen : false,
							width : 370,
							modal : true,
							resizable : false,
							title : "<spring:message code='post.allot'></spring:message>",
							buttons : [
									{
										text : "<spring:message code='confirm'></spring:message>",
										click : function() {
											var postIdArray = [];
											var ids = searchTableColumn(
													$("#flexiGridID"), 0);
											var treeObj = $.fn.zTree
													.getZTreeObj("postTreeID");
											//获取所有选中节点，不包括禁用
											var nodes = treeObj
													.getCheckedNodes(true);
											if (nodes && nodes.length == 1) {
												for ( var i = 0; i < nodes.length; i++) {
													postIdArray
															.push(nodes[i].id);
												}
											
											$.ajax({
														type : 'POST',
														url : '${pageContext.request.contextPath}/user/insertUserRefPost',
														dataType : 'json',
														cache : false,
														data : [
																{
																	name : 'postId',
																	value : postIdArray[0]
																},
																{
																	name : 'userIds',
																	value : ids
																} ],
														success : function(data) {
															message('<spring:message code="role.distribute.sucess"></spring:message>');
															$("#departmentTreeID1").dialog("close");
														},
														error : function() {
															message("<spring:message code='system.exception.please.contact.the.administrator'></spring:message>");
														}
													});
											} else{
												message("<spring:message code='please.select.a.post'></spring:message> ！");}
										}
									},
									{
										text : "<spring:message code='common'></spring:message>",
										click : function() {
											$(this).dialog("close");
										}
									} ]
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
    	url: '${pageContext.request.contextPath}/user/getCommoditylist'
    }).flexReload();
}
</script>

</head>
<body>
	<label><spring:message code='user.name'></spring:message>:</label>
	<input type="text" id="searchName" />
	<label><spring:message code='work.account'></spring:message>:</label>
	<input type="text" id="searchCount" />
	
	<shiro:hasPermission name="system:user:query">
	<a href="#" id="queryBtn" class="ui-state-default ui-corner-all cbe-button">
	<span class="ui-icon ui-icon-search"></span><spring:message code='query'></spring:message></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="system:user:delete">
	<a href="#" id="delBtn" class="ui-state-default ui-corner-all cbe-button">
		<span class="ui-icon ui-icon-minusthick"></span><spring:message code='delete'></spring:message></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="system:user:add">
	<a href="#" id="addBtn" class="ui-state-default ui-corner-all cbe-button">
		<span class="ui-icon ui-icon-plus"></span><spring:message code='add'></spring:message></a>
	</shiro:hasPermission>
	<shiro:hasPermission name="system:user:allocate">
    <a href="#" id="dialog-power" class="ui-state-default ui-corner-all cbe-button">
        <span class="ui-icon ui-icon-plus"></span><spring:message code='user.allocate'></spring:message></a> 
    </shiro:hasPermission>
    <shiro:hasPermission name=" system:user:post ">
		<a href="#" id="dialog-post"
			class="ui-state-default ui-corner-all cbe-button"> <span
			class="ui-icon ui-icon-plus"></span>
		<spring:message code='post.allot'></spring:message></a>
	</shiro:hasPermission>
	<div class="tbl">
		<table id="flexiGridID" style="display: block;margin: 0px;"></table>
	</div>
	<div id="updateUserDailDialog" style="display: none;">
		<form id="updateuserDailFormId"
			action="${pageContext.request.contextPath}/user/updateuserDail"
			method="post">
			<input type="hidden" id="userId" name="userId" />
			<table>
			
				<tr>
					<td class="fileName"><label><spring:message code='work.account'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="employeeid"
						name="employeeid" /></td>
				</tr>
				<tr>
					<td class="fileName"><label><spring:message code='user.name'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="name" name="name" /></td>
				</tr>
				<tr>
					<td class="fileName"><label><spring:message code='gender'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="gender"
						name="gender" /></td>
				</tr>
				<tr>
					<td class="fileName"><label><spring:message code='sm.user.telephone'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="telephone"
						name="telephone" /></td>
				</tr>

			</table>
		</form>
	</div>

	<div id="addUserDailDialog" style="display: none;">
		<form id="addUserDailFormId"
			action="${pageContext.request.contextPath}/user/addUserDail"
			method="post">
			<table>
				<tr>
				<tr>
					<td class="fileName"><label><spring:message code='user.account'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="account1"
						name="account" /><span class="mand">*</span></td>
				</tr>
					<td class="fileName"><label><spring:message code='work.account'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="employeeid1"
						name="employeeid" /> <span class="mand">*</span></td>
				</tr>
				<tr>
					<td class="fileName"><label><spring:message code='user.name'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="name1"
						name="name" /> <span class="mand">*</span></td>
				</tr>
				<tr>
					<td class="fileName"><label><spring:message code='sm.user.password'></spring:message></label></td>
					<td class="fileValue"><input type="password" id="password1"
						name="password" /> <span class="mand">*</span></td>
				</tr>
				<tr>
					<td class="fileName"><label><spring:message code='mailbox'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="email1"
						name="email" /> <span class="mand">*</span></td>
				</tr>
				<tr>
					<td class="fileName"><label><spring:message code='gender'></spring:message></label></td>
					<td class="fileValue">
					<rsrs:Foreach dictType="sys_user_sex" selectId="gender1" selectName="gender" selected=""/>
							<span class="mand">*</span></td>
				</tr>
				<tr>
					<td class="fileName"><label><spring:message code='sm.user.telephone'></spring:message></label></td>
					<td class="fileValue"><input type="text" id="telephone1"
						name="telephone" /><span class="mand">*</span></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="departmentTreeID" class="zTreeDemoBackground left" align="center" style="display: none;">
			<ul id="roleTreeID" class="ztree"></ul>
	</div>
	<div id="departmentTreeID1" class="zTreeDemoBackground left"
		align="center" style="display: none;">
		<ul id="postTreeID" class="ztree"></ul>
	</div>
   
</body>
</html>