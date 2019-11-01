<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code='post.detail' /></title>
<script type="text/javascript">
	var _gridWidth;
	var _gridHeight;
	//页面自适应
	function resizePageSize() {
		_gridWidth = $(document).width() - 12;/*  -189 是去掉左侧 菜单的宽度，   -12 是防止浏览器缩小页面 出现滚动条 恢复页面时  折行的问题 */
		_gridHeight = $(document).height() - 32 - 80; /* -32 顶部主菜单高度，   -90 查询条件高度*/
	}
	$(function() {
		resizePageSize();
		var _columnWidth = (_gridWidth - 150) / 5;

		$("#flexiGridID")
				.flexigrid(
						{
							width : _gridWidth,
							height : _gridHeight - 20,
							url : "${pageContext.request.contextPath}/post/getCommoditylist",
							dataType : 'json',
							colModel : [
									{
										display : 'ID',
										name : 'userId',
										width : 150,
										sortable : false,
										align : 'center',
										hide : 'true'
									},
									{
										display : "<spring:message code='user.account'></spring:message>",
										name : 'account',
										width : _columnWidth,
										sortable : true,
										align : 'center'
									},
									{
										display : "<spring:message code='work.account'></spring:message>",
										name : 'employeeid',
										width : _columnWidth,
										sortable : true,
										align : 'center'
									},
									{
										display : "<spring:message code='user.name'></spring:message>",
										name : 'name',
										width : _columnWidth,
										sortable : true,
										align : 'center'
									},
									{
										display : "<spring:message code='gender'></spring:message>",
										name : 'gender',
										width : _columnWidth,
										sortable : true,
										align : 'center',
										process : function(v) {
											return $(
													'#gender1 option[value='
															+ v + ']').text();
											;
										}
									},
									{
										display : "<spring:message code='sm.user.telephone'></spring:message>",
										name : 'telephone',
										width : _columnWidth,
										sortable : true,
										align : 'center'
									} ],
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
		
		$("#delBtn").click(function( event ) {
			
			var userIDs = searchTableColumn($("#flexiGridID"),0);
			if(userIDs.length > 0){
				$.ajax({
					type : 'POST',
					url : '${pageContext.request.contextPath}/post/delPostUser',
					dataType : 'json',
					cache : false,
					data : [ {
						name : 'postID',
						value : ${postID} 
					         }
					,{   name : 'userIDs',
						value : userIDs 
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
				
				message("<spring:message code='record.select.one'></spring:message> ！");
			}
		});
		
		$("#flexiGridID").flexOptions({
			newp : 1,
			extParam : [ {
				"name" : "postID",
				"value" : "${postID}"
			} ] || [],
			url : '${pageContext.request.contextPath}/post/getCommoditylist'
		}).flexReload();

	});

	//${postList}
</script>


</head>
<body>
	<div style="display:none;">
		<rsrs:Foreach dictType="sys_user_sex" selectId="gender1"
			selectName="gender" selected="" />
	</div>
	<a href="#" id="returnBtn" style="float:right"
		class="ui-state-default ui-corner-all cbe-button"
		onClick="javascript :history.back(-1);"><spring:message
			code='post.return' /></a>
	<a href="#" id="delBtn" style="float:right"
		class="ui-state-default ui-corner-all cbe-button">
		<spring:message code='delete'/>
		</a>
	<div id="addroleDialog" style="display: block;">
		<form id="addroleForm" method="post">
			<table border="1">
				<tr style="background-color: #85B5D9;color: white;">
					<th class="fileName" style="width:100px"><spring:message
							code='post.name' /></th>
					<th class="fileName" style="width:100px"><spring:message
							code='post.dsc' /></th>
					<th class="fileName" style="width:200px"><spring:message
							code='post.creat' /></th>
					<th class="fileName" style="width:200px"><spring:message
							code='post.mdfct' /></th>
				</tr>
				<tr>
					<td>${postList.postName}</td>
					<td>${postList.postDescribe}</td>
					<td>${postList.creatTime}</td>
					<td>${postList.modifyTime}</td>
				</tr>
			</table>
		</form>
	</div>

	<div class="tbl">
		<table id="flexiGridID" style="display: block;margin: 0px;"></table>
	</div>


</body>
</html>