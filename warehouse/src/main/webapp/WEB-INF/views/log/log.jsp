<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品列表</title>
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
	function resizePageSize() {
		_gridWidth = $(document).width() - 12;
		/*  -189 是去掉左侧 菜单的宽度，   -12 是防止浏览器缩小页面 出现滚动条 恢复页面时  折行的问题 */
		_gridHeight = $(document).height() - 32 - 80;
		/* -32 顶部主菜单高度，   -90 查询条件高度*/
	}

	$(function() {
		resizePageSize();
		changeSubSystem();
		var _columnWidth = (_gridWidth - 150) / 6;

		$("#flexiGridID").flexigrid({
			width : _gridWidth,
			height : _gridHeight,
			url : "${pageContext.request.contextPath}/monitor/log/list",
			dataType : 'json',
			colModel : [ {
				display : 'ID',
				name : 'operId',
				width : 150,
				sortable : false,
				align : 'center',
				hide : 'true'
			}, {
				display : "<spring:message code='log.systemmodule'/>",
				name : 'title',
				width : _columnWidth,
				sortable : true,
				align : 'center',
				process : function(v) {
					return $('#title option[value=' + v + ']').text();
				}
			}, {
				display : "<spring:message code='log.operationType'/>",
				name : 'businessType',
				width : _columnWidth,
				sortable : true,
				align : 'center',
				process : function(v) {
					return $('#businessType option[value=' + v + ']').text();
				}
			}, {
				display : "<spring:message code='log.operName'/>",
				name : 'operName',
				width : _columnWidth,
				sortable : true,
				align : 'center'
			}, {
				display : "<spring:message code='log.operIp'/>",
				name : 'operIp',
				width : _columnWidth,
				sortable : true,
				align : 'center'
			}, {
				display : "<spring:message code='log.status'/>",
				name : 'status',
				width : _columnWidth,
				sortable : true,
				align : 'center',
				process : function(v) {
					return $('#status option[value=' + v + ']').text();
				}
			}, {
				display : "<spring:message code='log.operTime'/>",
				name : 'operTime',
				width : _columnWidth,
				sortable : true,
				align : 'center'
			} ],
			resizable : false, //resizable table是否可伸缩
			useRp : true,
			usepager : true, //是否分页
			autoload : false, //自动加载，即第一次发起ajax请求
			hideOnSubmit : true, //是否在回调时显示遮盖
			showcheckbox : true, //是否显示多选框
			rowhandler : "", //是否启用行的扩展事情功能,在生成行时绑定事件，如双击，右键等
			rowbinddata : true,
			numCheckBoxTitle : "<spring:message code='common.selectall'/>"
		});
		query();

		$("#queryBtn").click(function(event) {
			//校验日期范围是否正确
			var beginTime = $.trim($('#beginTime').val());
			var endTime = $.trim($('#endTime').val());
			if (beginTime !== '' && endTime !== '' && beginTime > endTime) {
				message({
					html : '<spring:message code="timeRangeError"/>',
					showConfirm : true
				});
				return false;
			}
			var businessType = $("#businessType").val();
			var operName = $("#operName").val();
			var title = $("#title").val();
			var status = $("#status").val();
			query([ {
				"name" : "businessType",
				"value" : businessType
			}, {
				"name" : "operName",
				"value" : operName
			}, {
				"name" : 'startTime',
				"value" : beginTime
			}, {
				"name" : 'endTime',
				"value" : endTime
			}, {
				"name" : 'title',
				"value" : title
			}, {
				"name" : 'status',
				"value" : status
			} ]);
		});

		$("#delBtn")
				.click(
						function(event) {
							var ids = searchTableColumn($("#flexiGridID"), 0);
							if (ids.length > 0) {
								$
										.ajax({
											type : 'POST',
											url : '${pageContext.request.contextPath}/monitor/log/remove',
											dataType : "json",
											data : [ {
												name : 'operIds',
												value : ids
											} ],
											success : function(data) {
												message(data.msg);
												$('#flexiGridID').flexReload();
											},
											error : function() {
												message("系统异常请联系管理员");
											}
										});
							} else {
								message("请选择的记录为空！");
							}
						});
	});

	function query(param1) {
		$('#flexiGridID').flexOptions({
			newp : 1,
			extParam : param1 || [],
			url : '${pageContext.request.contextPath}/monitor/log/list'
		}).flexReload();
	}

	function changeSubSystem() {
		var title = $("#title").children("option:selected").val();
		$.ajax({
					type : 'POST',
					dataType : "json",
					url : '${pageContext.request.contextPath}/monitor/log/queryModuleBySystem',
					data : {
						"title" : title
					},
					success : function(data) {
						$("#businessType").empty();
						$("#businessType")
								.append('<option value=" "></option>');
						for ( var i = 0; i < data.length; i++) {
							$("#businessType").append(
									'<option value="' + data[i].dictValue + '">'
											+ data[i].dictLabel + '</option>');
						}
					},
					error : function() {
						message("切换子系统异常");
					}
				});
		$("#businessType").combobox();
	}
</script>

</head>
<body>
	<div>
		<label> <spring:message code='log.operName' />:
		</label> <input type="text" id="operName" />
	</div>
	<div>
		<label> <spring:message code='log.systemmodule' />:
		</label>
		<rsrs:Foreach dictType="sys_manger" onchange="changeSubSystem()"
			selectId="title" selectName="title" />
	</div>

	<div>
		<label> <spring:message code='log.operationType' />:
		</label> <select id="businessType" name="businessType"></select>
	</div>
	<div>
		<label> <spring:message code='log.status' />:
		</label>
		<rsrs:Foreach dictType="sys_operate_status" selectId="status"
			selectName="status" />

	</div>
	<!-- 开始时间 -->
	<label class="tit"><spring:message code="common.beginTime" /></label>
	<input id="beginTime"
		onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',readOnly:true, maxDate:'#F{$dp.$D(\'endTime\')}'})"
		readonly="readonly" />
	<!-- 结束时间 -->
	<label class="tit"><spring:message code="common.endTime" /></label>
	<input id="endTime"
		onclick="WdatePicker({dateFmt:'yyyy-MM-dd ',readOnly:true, minDate:'#F{$dp.$D(\'beginTime\')}'})"
		readonly="readonly" />
	<a href="#" id="queryBtn"
		class="ui-state-default ui-corner-all cbe-button"><span
		class="ui-icon ui-icon-search"></span>
	<spring:message code='query' /></a>
	<a href="#" id="delBtn"
		class="ui-state-default ui-corner-all cbe-button"><span
		class="ui-icon ui-icon-minusthick"></span>
	<spring:message code='delete' /></a>

	<div class="tbl">
		<table id="flexiGridID" style="display: block;margin: 0px;"></table>
	</div>
</body>
</html>