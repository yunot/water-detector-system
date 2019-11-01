<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="cut.dept" /></title>
<script type="text/javascript">
	var _gridWidth;
	var _gridHeight;

	//页面自适应
	function resizePageSize() {
		_gridWidth = $(document).width() - 17;
		_gridHeight = $(document).height() - 105;
	}

	$(function() {
		resizePageSize();
		var _columnWidth = _gridWidth / 3;
		$("#staffApplyRst").flexigrid({
			width : _gridWidth,
			height : _gridHeight,
			url : "${pageContext.request.contextPath}/depart/applyCondition",
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
					display : "<spring:message code='currentdept'/>",
					name : 'depId',
					width : _columnWidth,
					sortable : true,
					align : 'center'
				},
				{
					display : "<spring:message code='appalydept'/>",
					name : 'depApplyId',
					width : _columnWidth,
					sortable : true,
					align : 'center'
				},
				{
					display : "<spring:message code='handlingSuggestion'/>",
					name : 'status',
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

		var userId = $("#userID").val();
		query([ {
			"name" : "userID",
			"value" : userId
		} ]);

		//页面跳转
		$("#back").click(function() {
			window.location.href = "${pageContext.request.contextPath}/depart/depList";
		});

		//员工申请
		$("#apply-cut").click(function() {
			$.ajax({
				type : "post",
				data : {
					"userID" : userId
				},
				url : "${pageContext.request.contextPath}/depart/queryStaffDept",
				dataType : "json",
				success : function(data) {
					$("#curDept").text(data);
				},
				error : function() {}
			});
			$("#apply").dialog("open");
		});

		$("#apply").dialog({
			autoOpen : false,
			width : 400,
			modal : true,
			resizable : false,
			title : "<spring:message code='appalydept'/>",
			buttons : [
				{
					text : "<spring:message code='application'/>",
					click : function() {
						var applyDept = $("#applyDept").val();
						$.ajax({
							type : "post",
							data : {
								"userID" : userId,
								"applyDept" : applyDept
							},
							url : "${pageContext.request.contextPath}/depart/apply",
							success : function(data) {
								alert(data.msg);
							},
							error : function(data) {
								alert("<spring:message code='system.abnormality'/>");
							}
						});
						$("#applyDept").submit();
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

		//部门管理员审批
		$("#approve").click(function() {
			$("#approval").show();
			$("#apply_result").hide();
			resizePageSize();
			var _columnWidth = _gridWidth / 4;
			$("#approvalRst").flexigrid({
				width : _gridWidth,
				height : _gridHeight,
				url : "${pageContext.request.contextPath}/depart/approveApply",
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
						display : '<spring:message code="user.account"/>',
						name : 'status',
						width : _columnWidth,
						sortable : true,
						align : 'center',
					},
					{
						display : "<spring:message code='currentdept'/>",
						name : 'depId',
						width : _columnWidth,
						sortable : true,
						align : 'center'
					},
					{
						display : "<spring:message code='appalydept'/>",
						name : 'depApplyId',
						width : _columnWidth,
						sortable : true,
						align : 'center'
					},
					{
						display : "<spring:message code='handlingSuggestion'/>",
						name : 'status',
						width : _columnWidth,
						sortable : true,
						align : 'center',
						process : function(v, _trid, _row) {
							var htmlContents = "<input type='button' value='<spring:message code='pass'/>' onclick='pass(" + _row.userId + ")'/>"
								+ " <input type='button' value='<spring:message code='refuse'/>' onclick='refuse(" + _row.userId + ")'/>";
							return htmlContents;
						}
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
			queryApplyCondition([ {
				"name" : "userID",
				"value" : userId
			} ]);
		});

		//部门管理员代申请
		$("#apply-replace").click(function() {
			$("#replace").show();
			$("#approval").hide();
			$("#apply_result").hide();
			resizePageSize();
			var _columnWidth = _gridWidth / 4;
			$("#replace").flexigrid({
				width : _gridWidth,
				height : _gridHeight,
				url : "${pageContext.request.contextPath}/depart/replaceStaffList",
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
						display : '<spring:message code="user.account"/>',
						name : 'status',
						width : _columnWidth,
						sortable : true,
						align : 'center',
					},
					{
						display : "<spring:message code='currentdept'/>",
						name : 'depId',
						width : _columnWidth,
						sortable : true,
						align : 'center'
					},
					{
						display : "<spring:message code='appalydept'/>",
						name : 'depApplyId',
						width : _columnWidth,
						sortable : true,
						align : 'center',
						process : function(v, _trid, _row) {
							var id = _row.userId;
							var domId = "applyDeptr" + id;
							$("#test").find("select").attr("name", "deptr" + id);
							var reg = new RegExp("applyDeptr", "g");
							var htmlContents = $("#test").find("select").html().replace(reg, domId);
							return "<script type=\"text/javascript\">$(function () " +
								"{$(\"#" + domId + "\").combobox(); });" +
								"<\/script><div><select id='" + domId + "'>" + htmlContents + "</select></div>";
						}
					},
					{
						display : "<spring:message code='handlingSuggestion'/>",
						name : 'status',
						width : _columnWidth,
						sortable : true,
						align : 'center',
						process : function(v, _trid, _row) {
							var htmlContents = "<script type=\"text/javascript\">$(function(){" +
								"$(\"#" + _row.userId + "\").click(function(){" +
								"repPass(\"" + _row.userId + "\",$(\"#applyDeptr" + _row.userId + "\").val());" +
								"});});<\/script>" +
								"<input type='button' value='<spring:message code='application'/>' id='" + _row.userId + "'></input>";
							return htmlContents;
						}
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
			queryRepApply([ {
				"name" : "userID",
				"value" : userId
			} ]);
		});

		//管理员直接切换部门
		$("#dept-cut").click(function() {
			$("#cut").show();
			$("#replace").hide();
			$("#approval").hide();
			$("#apply_result").hide();
			resizePageSize();
			var _columnWidth = _gridWidth / 4;
			$("#replace").flexigrid({
				width : _gridWidth,
				height : _gridHeight,
				url : "${pageContext.request.contextPath}/depart/cutStaffList",
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
						display : '<spring:message code="user.account"/>',
						name : 'status',
						width : _columnWidth,
						sortable : true,
						align : 'center',
					},
					{
						display : "<spring:message code='currentdept'/>",
						name : 'depId',
						width : _columnWidth,
						sortable : true,
						align : 'center'
					},
					{
						display : "<spring:message code='appalydept'/>",
						name : 'depApplyId',
						width : _columnWidth,
						sortable : true,
						align : 'center',
						process : function(v, _trid, _row) {
							var id = _row.userId;
							var domId = "applyDeptr" + id;
							$("#test").find("select").attr("name", "deptr" + id);
							var reg = new RegExp("applyDeptr", "g");
							var htmlContents = $("#test").find("select").html().replace(reg, domId);
							return "<script type=\"text/javascript\">$(function () " +
								"{$(\"#" + domId + "\").combobox(); });" +
								"<\/script><div><select id='" + domId + "'>" + htmlContents + "</select></div>";
						}
					},
					{
						display : "<spring:message code='handlingSuggestion'/>",
						name : 'status',
						width : _columnWidth,
						sortable : true,
						align : 'center',
						process : function(v, _trid, _row) {
							var htmlContents = "<script type=\"text/javascript\">$(function(){" +
								"$(\"#" + _row.userId + "\").click(function(){" +
								"repManagerPass(\"" + _row.userId + "\",$(\"#applyDeptr" + _row.userId + "\").val());" +
								"});});<\/script>" +
								"<input type='button' value='<spring:message code='confirm'/>' id='" + _row.userId + "'></input>";
							return htmlContents;
						}
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
			queryRepCut();
		});
	});

	//员工申请情况页面
	function query(param1) {
		$('#staffApplyRst').flexOptions({
			newp : 1,
			extParam : param1 || [],
			url : '${pageContext.request.contextPath}/depart/applyCondition'
		}).flexReload();
	}

	//部门管理员操作申请页面
	function queryApplyCondition(param) {
		$('#approvalRst').flexOptions({
			newp : 1,
			extParam : param || [],
			url : '${pageContext.request.contextPath}/depart/approveApply'
		}).flexReload();
	}

	//部门管理员代申请
	function queryRepApply(param) {
		$('#replace').flexOptions({
			newp : 1,
			extParam : param || [],
			url : '${pageContext.request.contextPath}/depart/replaceStaffList'
		}).flexReload();
	}

	//管理员直接切换
	function queryRepCut() {
		$('#managerCut').flexOptions({
			newp : 1,
			extParam : [],
			url : '${pageContext.request.contextPath}/depart/cutStaffList'
		}).flexReload();
	}

	//代申请
	function repPass(userId, depApplyId) {
		$.ajax({
			type : "post",
			data : {
				"userID" : userId,
				"applyDept" : depApplyId
			},
			url : "${pageContext.request.contextPath}/depart/apply",
			success : function(data) {
				alert(data);
			},
			error : function() {}
		});
	}

	//管理员直接操作
	function repManagerPass(userId, depApplyId) {
		$.ajax({
			type : "post",
			data : {
				"userID" : userId,
				"applyDept" : depApplyId
			},
			url : "${pageContext.request.contextPath}/depart/managerOperation",
			success : function(data) {
				alert(data.msg);
			},
			error : function() {}
		});
	}

	//审批通过事件
	function pass(obj) {
		$.ajax({
			data : {
				"staffID" : obj
			},
			type : "post",
			url : "${pageContext.request.contextPath}/depart/applyPass",
			success : function(data) {
				alert(data.msg);
				queryApplyCondition([ {
					"name" : "userID",
					"value" : $("#userID").val()
				} ]);
			},
			error : function() {
				alert("<spring:message code='system.abnormality'/>");
			}
		});
	}

	//审批拒绝事件
	function refuse(obj) {
		$.ajax({
			data : {
				"staffID" : obj
			},
			type : "post",
			url : "${pageContext.request.contextPath}/depart/applyRefuse",
			success : function(data) {
				alert(data.msg);
				queryApplyCondition([ {
					"name" : "userID",
					"value" : $("#userID").val()
				} ]);
			},
			error : function() {
				alert("<spring:message code='system.abnormality'/>");
			}
		});
	}
</script>
</head>
<body>
	<input type="hidden" value="${userInfo.userId }" id="userID" />
	<div id="operation">
		<shiro:hasPermission name="system:apply:applyCut">
			<a href="#" id="apply-cut"
				class="ui-state-default ui-corner-all cbe-button"><span
				class="ui-icon ui-icon-transfer-e-w"></span><spring:message
				code='applyForChange' /></a>
		</shiro:hasPermission>
		<shiro:hasPermission name="system:apply:apply">
			<a href="#" id="approve"
				class="ui-state-default ui-corner-all cbe-button"><span
				class="ui-icon ui-icon-pencil"></span> <spring:message
				code='approve' /></a>
		</shiro:hasPermission>
		<shiro:hasPermission name="system:apply:replaceApply">
			<a href="#" id="apply-replace"
				class="ui-state-default ui-corner-all cbe-button"><span
				class="ui-icon ui-icon-person"></span> <spring:message
				code='replaceToApply' /></a>
		</shiro:hasPermission>
		<shiro:hasPermission name="system:apply:cut">
			<a href="#" id="dept-cut"
				class="ui-state-default ui-corner-all cbe-button"><span
				class="ui-icon ui-icon-transferthick-e-w"></span> <spring:message
				code='cut' /></a>
		</shiro:hasPermission>
		<a href="#" id="back"
			class="ui-state-default ui-corner-all cbe-button"><span
			class="ui-icon ui-icon-arrowthick-1-w"></span> <spring:message
				code='post.return' /></a>
	</div>
	<!-- 申请 -->
	<div id="apply" style="display:none;">
		<table>
			<tr>
				<td class="fileName"><label><spring:message
							code='currentdept' /></label></td>
				<td class="fileValue"><label id="curDept"></label></td>
			</tr>
			<tr>
				<td class="fileName"><label><spring:message
							code='appalydept' /></label></td>
				<td class="fileValue"><rsrs:Foreach dictType="sys_dept"
						selectId="applyDept" selectName="dept" /></td>
			</tr>
		</table>
	</div>
	<!-- 员工申请结果 -->
	<br />
	<div id="apply_result">
		<table id="staffApplyRst" style="display: block;margin: 0px;"></table>
	</div>
	<!-- 审批 -->
	<div id="approval" style="display:none;">
		<table id="approvalRst" style="display: block;margin: 0px;"></table>
	</div>
	<!-- 代申请 -->
	<div id="replaceApply">
		<table id="replace" style="display: block;margin: 0px;"></table>
	</div>
	<!-- 切换 -->
	<div id="cut">
		<table id="managerCut" style="display: block;margin: 0px;"></table>
	</div>
	<!-- 下拉框选择部门 -->
	<div id="test" style="display: none;">
		<rsrs:Foreach dictType="sys_dept" selectId="applyDeptr"
			selectName="deptr"></rsrs:Foreach>
	</div>
</body>
</html>