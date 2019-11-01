<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="dept.manage" /></title>
<style type="text/css">
#operation {
	height: 50px;
}

#departTree {
	width: 150px;
	height: 400px;
	float: left;
}

#list {
	width: 910px;
	float: left;
}

#deptIntroduce {
	width: 777px;
	height: 100px;
}

#deptStaff {
	width: 777px;
	height: 393px;
}
</style>
<script type="text/javascript">
	var _gridWidth;
	var _gridHeight;

	//页面自适应
	function resizePageSize() {
		_gridWidth = $(document).width() - 168;
		_gridHeight = $(document).height() - 1200;
		$("#list").css("width",_gridWidth +"px");
		$("#list").css("height",_gridHeight +"px");
	}

	//点击事件
	function onClick(event, treeId, treeNode) {
		$("#treeNodeDept").val(treeNode.name);
		$("#deptID").val(treeNode.id);
		
		//获取当前点击节点的父节点
		var parNode = treeNode.getParentNode();
		
		//判断点击节点是部门还是岗位
		$.ajax({
				data : {
					"deptName" : treeNode.name,
					"id":treeNode.id
				},
				url : "${pageContext.request.contextPath}/depart/queryDeptOrPostInfo",
				dataType : "json",
				success : function(data) {
					if(data != null){
						if (data.orgID == "post") {//岗位
							query([{"name": "id","value":treeNode.id},{"name":"deptId","value":parNode.id}]);
						}else{//部门
							query([{"name": "id","value":""},{"name":"deptId","value":treeNode.id}]);
						}
					}
				},
				error : function(data) {}
			});
		$.ajax({
			type:"post",
			data : {
				"id" : treeNode.id
			},
			url : "${pageContext.request.contextPath}/depart/queryDeptOrPostInfo",
			dataType : "json",
			success : function(data) {
				if(data != null){
					$("#deptDesc").find("span").text(data.depDesc);
				}
			},
			error : function(data) {}
		});
	}

	$(function() {
		resizePageSize();
		var _columnWidth = _gridWidth / 3;
		$("#deptStaff").flexigrid({
			width : _gridWidth,
			height : _gridHeight,
			url : "${pageContext.request.contextPath}/depart/queryUserList",
			dataType : 'json',
			colModel : [
				{
					display : '<spring:message code="staffID"/>',
					name : 'userId',
					width : _columnWidth,
					sortable : true,
					align : 'center',
					hide : 'true'
				},
				{
					display : "<spring:message code='user.name'/>",
					name : 'name',
					width : _columnWidth,
					sortable : true,
					align : 'center'
				},
				{
					display : "<spring:message code='work.account'/>",
					name : 'employeeid',
					width : _columnWidth,
					sortable : true,
					align : 'center'
				},
				{
					display : "<spring:message code='telephone'/>",
					name : 'telephone',
					width : _columnWidth,
					sortable : true,
					align : 'center'
				},
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
		
		var setting = {
			view : {
				dblClickExpand : false //双击不扩展
			},
			data : {
				simpleData : {
					enable : true //List集合转成Array而不是Json
				}
			},
			callback : {
				onClick : onClick
			}
		};
		
		$.fn.zTree.init($("#departTreeID"), setting, ${deparZTree});
		
		//增加部门
		$("#dept-add").click(function(event) {
			$("#addDept").dialog("open");
		});

		$("#addDept").dialog({
			autoOpen : false,
			width : 400,
			modal : true,
			resizable : false,
			title : "<spring:message code='addDept'/>",
			buttons : [
				{
					text : "<spring:message code='confirm'/>",
					click : function() {
						var orgName = $("#org").val();
						var deptParName = $("#dept").val();
						var deptName = $("#deptName").val();
						var deptEngName = $("#deptEngName").val();
						var deptDesc = $("#deptDesc").val();
						$.ajax({
							type : "post",
							data : {
								"orgName" : orgName,
								"deptParName" : deptParName,
								"deptName" : deptName,
								"deptEngName" : deptEngName,
								"deptDesc" : deptDesc
							},
							url : "${pageContext.request.contextPath}/depart/addDept",
							success : function(data) {
								alert(data.msg);
							},
							error : function() {}
						});
						$("#addDept").submit();
						$(this).dialog("close");
					}
				},
				{
					text : "<spring:message code='common'/>",
					click : function() {
						$(this).dialog("close");
					}
				}
			]
		});

		//修改部门
		$("#dept-update").click(function() {
			var depName = $("#treeNodeDept").val();
			var id = $("#deptID").val();
			$.ajax({
				data : {
					"deptName" : depName,
					"id":id
				},
				url : "${pageContext.request.contextPath}/depart/queryDeptOrPostInfo",
				dataType : "json",
				success : function(data) {
					if (data != null) {
						$("#updateDept").dialog("open");
						$("#up_deptName").val(data.depName);
						$("#up_deptDesc").val(data.depDesc);
						$("#up_deptEngName").val(data.sort);
					} else {
						alert("<spring:message code='choose.dept'/>");
					}
				},
				error : function(data) {}
			});
		});

		$("#updateDept").dialog({
			autoOpen : false,
			width : 400,
			modal : true,
			resizable : false,
			title : "<spring:message code='updateDept'/>",
			buttons : [
				{
					text : "<spring:message code='confirm'/>",
					click : function() {
						var deptName = $("#up_deptName").val();
						var deptDesc = $("#up_deptDesc").val();
						var deptEngName = $("#up_deptEngName").val();
						var id = $("#deptID").val();
						$.ajax({
							data : {
								"deptDesc" : deptDesc,
								"deptName" : deptName,
								"deptEngName" : deptEngName,
								"id" : id
							},
							type : "post",
							url : "${pageContext.request.contextPath}/depart/updateDept",
							success : function(data) {
								alert(data.msg);
								showDeptList();
							},
							error : function() {}
						});
						$("#updateDept").submit();
						$(this).dialog("close");
					}
				},
				{
					text : "<spring:message code='common'/>",
					click : function() {
						$(this).dialog("close");
					}
				}
			]
		});

		//删除部门
		$("#dept-delete").click(function() {
			var id = $("#deptID").val();
			var depName = $("#treeNodeDept").val();
			$.ajax({
				data : {
					"deptName" : depName
				},
				url : "${pageContext.request.contextPath}/depart/queryDeptOrPostInfo",
				dataType : "json",
				success : function(data) {
					if (data != null) {
						$.ajax({
							data : {
								"id" : id
							},
							type : "post",
							url : "${pageContext.request.contextPath}/depart/deleteDept",
							success : function(data) {
								if (data == true) {
									alert("<spring:message code='dept.delete.success'/>");
								} else {
									alert("<spring:message code='ban.delete.dept'/>");
								}
							},
							error : function() {}
						});
					} else {
						alert("<spring:message code='choose.dept'/>");
					}
				},
				error : function(data) {}
			});
		});

		//绑定部门
		$("#dept-lock").click(function() {
			$("#lockDept").dialog("open");
		});

		$("#lockDept").dialog({
			autoOpen : false,
			width : 400,
			modal : true,
			resizable : false,
			title : "<spring:message code='dept.lock'/>",
			buttons : [
				{
					text : "<spring:message code='confirm'/>",
					click : function() {
						var pardeptLock = $("#pardeptLock").val();
						var curdeptLock = $("#curdeptLock").val();
						$.ajax({
							data : {
								"pardeptLock" : pardeptLock,
								"curdeptLock" : curdeptLock
							},
							type : "post",
							url : "${pageContext.request.contextPath}/depart/lockDept",
							success : function(data) {
								if (data == true) {
									showDeptList();
								} else {
									alert("<spring:message code='system.abnormality'/>");
								}
							},
							error : function(data) {
								alert("<spring:message code='system.abnormality'/>");
							}
						});
						$("#lockDept").submit();
						$(this).dialog("close");
					}
				},
				{
					text : "<spring:message code='common'/>",
					click : function() {
						$(this).dialog("close");
					}
				}
			]
		});

		//解绑定部门
		$("#dept-unlock").click(function() {
			$("#unlockDept").dialog("open");
		});

		$("#unlockDept").dialog({
			autoOpen : false,
			width : 400,
			modal : true,
			resizable : false,
			title : "<spring:message code='unlock.dept'/>",
			buttons : [
				{
					text : "<spring:message code='confirm'/>",
					click : function() {
						var curdeptUnlock = $("#curdeptUnlock").val();
						$.ajax({
							data : {
								"curdeptUnlock" : curdeptUnlock
							},
							type : "post",
							url : "${pageContext.request.contextPath}/depart/unlockDept",
							success : function(data) {
								alert(data.msg);
								showDeptList();
							},
							error : function(data) {
								alert("<spring:message code='system.abnormality'/>");
							}
						});
						$("#unlockDept").submit();
						$(this).dialog("close");
					}
				},
				{
					text : "<spring:message code='common'/>",
					click : function() {
						$(this).dialog("close");
					}
				}
			]
		});

		//分配部门
		$("#dept-allocation").click(function() {
			var userIds = searchTableColumn($("#deptStaff"), 0);
			if (userIds.length > 0) {
				$("#userIDs").val(userIds);
				$("#alloDept").dialog("open");
			} else {
				alert("<spring:message code='norecord'/>");
			}
		});

		$("#alloDept").dialog({
			autoOpen : false,
			width : 400,
			modal : true,
			resizable : false,
			title : "<spring:message code='allocate.dept'/>",
			buttons : [
				{
					text : "<spring:message code='confirm'/>",
					click : function() {
						var newDeptName = $("#allocateDept").val();
						var ids = $("#userIDs").val();
						$.ajax({
							type : "post",
							data : {
								"ids" : ids,
								"dept" : newDeptName
							},
							url : "${pageContext.request.contextPath}/depart/allocateStaff",
							success : function(data) {
								alert(data.msg);
							},
							error : function(data) {
								alert("<spring:message code='system.abnormality'/>");
							}
						});
						$("#unlockDept").submit();
						$(this).dialog("close");
					}
				},
				{
					text : "<spring:message code='common'/>",
					click : function() {
						$(this).dialog("close");
					}
				}
			]
		});
		
		//部门切换
		$("#dept-change").click(function(){
			window.location.href="${pageContext.request.contextPath}/depart/switchDept";
		});
	});

	function query(param1) {
		$('#deptStaff').flexOptions({
			newp : 1,
			extParam : param1 || [],
			url : '${pageContext.request.contextPath}/depart/queryUserList'
		}).flexReload();
	}
</script>
</head>
<body>
	<!-- 单击树节点获取部门名 -->
	<input type="hidden" id="treeNodeDept" />
	<!-- 操作栏 -->
	<div id="operation">
		<shiro:hasPermission name="system:dept:add">
			<a href="#" id="dept-add"
				class="ui-state-default ui-corner-all cbe-button"><span
				class="ui-icon ui-icon-plus"></span> <spring:message code="addDept" /></a>
		</shiro:hasPermission>
		<shiro:hasPermission name="system:dept:delete">
			<a href="#" id="dept-delete"
				class="ui-state-default ui-corner-all cbe-button"><span
				class="ui-icon ui-icon-minus"></span> <spring:message
					code="deleteDept" /></a>
		</shiro:hasPermission>
		<shiro:hasPermission name="system:dept:update">
			<a href="#" id="dept-update"
				class="ui-state-default ui-corner-all cbe-button"><span
				class="ui-icon ui-icon-wrench"></span> <spring:message
					code="updateDept" /></a>
		</shiro:hasPermission>
		<shiro:hasPermission name="system:dept:allocate">
			<a href="#" id="dept-allocation"
				class="ui-state-default ui-corner-all cbe-button"><span
				class="ui-icon ui-icon-contact"></span> <spring:message
					code="allocateDept" /></a>
		</shiro:hasPermission>
		<shiro:hasPermission name="system:dept:change">
			<a href="#" id="dept-change"
				class="ui-state-default ui-corner-all cbe-button"><span
				class="ui-icon ui-icon-transfer-e-w"></span> <spring:message
					code="cut.dept" /></a>
		</shiro:hasPermission>
		<shiro:hasPermission name="system:dept:lock">
			<a href="#" id="dept-lock"
				class="ui-state-default ui-corner-all cbe-button"><span
				class="ui-icon ui-icon-locked"></span> <spring:message
					code="dept.lock" /></a>
		</shiro:hasPermission>
		<shiro:hasPermission name="system:dept:unlock">
			<a href="#" id="dept-unlock"
				class="ui-state-default ui-corner-all cbe-button"><span
				class="ui-icon ui-icon-unlocked"></span> <spring:message
					code="unlock.dept" /></a>
		</shiro:hasPermission>
	</div>
	<!-- 页面 -->
	<div id="showPage">
		<!-- 左侧显示部门树状图 -->
		<div id="departTree">
			<ul id="departTreeID" class="ztree"></ul>
		</div>
		<!-- 右侧在双击子部门后显示部门信息 -->
		<div class="tbl" id="list">
			<table id="deptDesc" style="display: block;margin: 0px;">
				<tr>
					<td><span><spring:message code="dept.desc" /></span></td>
				</tr>
			</table>
			<table id="deptStaff" style="display: block;margin: 0px;"></table>
		</div>

	</div>
	<!-- 新增部门 -->
	<div id="addDept" style="display:none;">
		<table>
			<tr>
				<td class="fileName"><label><spring:message
							code="organization" /></label></td>
				<td class="fileValue"><rsrs:Foreach dictType="sys_org"
						selectId="org" selectName="org" /></td>
			</tr>
			<tr>
				<td class="fileName"><label><spring:message
							code="superior.dept" /></label></td>
				<td class="fileValue"><rsrs:Foreach dictType="sys_dept"
						selectId="dept" selectName="dept" /></td>
			</tr>
			<tr>
				<td class="fileName"><label><spring:message code="dept" /></label></td>
				<td class="fileValue"><input type="text" id="deptName" /></td>
			</tr>
			<tr>
				<td class="fileName"><label><spring:message
							code="dept.english.name" /></label></td>
				<td class="fileValue"><input type="text" id="deptEngName" /></td>
			</tr>
			<tr>
				<td class="fileName"><label><spring:message
							code="dept.desc" /></label></td>
				<td class="fileValue"><input type="text" id="deptDesc" /></td>
			</tr>
		</table>
	</div>
	<!-- 修改部门 -->
	<div id="updateDept" style="display:none;">
		<input type="hidden" id="deptID" />
		<table>
			<tr>
				<td class="fileName"><label><spring:message code="dept" /></label></td>
				<td class="fileValue"><input type="text" id="up_deptName" /></td>
			</tr>
			<tr>
				<td class="fileName"><label><spring:message
							code="dept.english.name" /></label></td>
				<td class="fileValue"><input type="text" id="up_deptEngName" /></td>
			</tr>
			<tr>
				<td class="fileName"><label><spring:message
							code="dept.desc" /></label></td>
				<td class="fileValue"><input type="text" id="up_deptDesc" /></td>
			</tr>
		</table>
	</div>
	<!-- 绑定部门 -->
	<div id="lockDept" style="display:none;">
		<table>
			<tr>
				<td class="fileName"><label><spring:message
							code="superior.dept" /></label></td>
				<td class="fileValue"><rsrs:Foreach dictType="sys_dept"
						selectId="pardeptLock" selectName="dept" /></td>
			</tr>
			<tr>
				<td class="fileName"><label><spring:message
							code="currentdept" /></label></td>
				<td class="fileValue"><rsrs:Foreach dictType="sys_dept"
						selectId="curdeptLock" selectName="dept" /></td>
			</tr>
		</table>
	</div>
	<!-- 解绑定部门 -->
	<div id="unlockDept" style="display:none;">
		<table>
			<tr>
				<td class="fileName"><label><spring:message
							code="currentdept" /></label></td>
				<td class="fileValue"><rsrs:Foreach dictType="sys_dept"
						selectId="curdeptUnlock" selectName="dept" /></td>
			</tr>
		</table>
	</div>
	<!-- 分配部门 -->
	<div id="alloDept" style="display:none;">
		<input type="hidden" id="checkedStaff" /> <input type="hidden"
			id="userIDs" />
		<table>
			<tr>
				<td class="fileName"><label><spring:message code="dept" /></label></td>
				<td class="fileValue"><rsrs:Foreach dictType="sys_dept"
						selectId="allocateDept" selectName="dept" /></td>
			</tr>
		</table>
	</div>
</body>
</html>