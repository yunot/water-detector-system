<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="../common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

var _gridWidth;
var _gridHeight;
//页面自适应
function resizePageSize(){
	_gridWidth = $(document).width()-12;/*  -189 是去掉左侧 菜单的宽度，   -12 是防止浏览器缩小页面 出现滚动条 恢复页面时  折行的问题 */
	_gridHeight = $(document).height()-32-80; /* -32 顶部主菜单高度，   -90 查询条件高度*/
}


$(function()
{
	resizePageSize();
	var _columnWidth= _gridWidth/7.3;
	
	$("#flexiGridID").flexigrid({
		width : _gridWidth,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/post/getPostDataList",
		dataType : 'json',
		colModel : [ 
		   {display : 'postID',name : 'postID',width : _columnWidth, sortable : true,align : 'center',hide : 'true'}, 
	       {display : "<spring:message code='roleName'/>",name : 'roleName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "<spring:message code='organization.name'/>",name : 'orgID',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "<spring:message code='post.name'/>",name : 'postName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "<spring:message code='post.dsc'/>",name : 'postDescribe',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : "<spring:message code='post.creat'/>",name : 'creatTime',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "<spring:message code='post.mdfct'/>",name : 'modifyTime',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "",name : 'postDetail',width : _columnWidth, sortable : true,align : 'center',process: function(v,_trid,_row) {				 
				 var postDetail = 	'<span style="color:blue;cursor:pointer;" onclick="queryDetail(' + _row.postID + ');"><spring:message code='post.detail'/></span>';
					return postDetail;
			 }},
	        
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
        $("#addpostForm").resetForm();
        $("#addpostDialog").dialog( "open" );
        });
	
	
	var postName = $("#postName");
	var postDescribe = $("#postDescribe");
	var postDetail = $("#postDetail");
	var creatTime = $("#creatTime");
	var allFields = $([]).add(postName).add(postDescribe).add(postDetail).add(creatTime);
	allFields.removeClass("ui-state-error");
	$( "#addpostDialog" ).dialog({
		autoOpen : false,
		width : 390,
		modal : true,
		resizable : false,
		title: '<spring:message code='post.add'/>',
		buttons: [
			{
				text: "<spring:message code='confirm'></spring:message>",
				click: function() {
				var bValid = true;
				allFields.removeClass("ui-state-error");
				bValid = bValid && checkLength(postName, 1, 16);
				bValid = bValid && checkLength(postDescribe, 1, 16);
									
				if(!bValid){
					return;
				}
				
				$("#addpostForm").submit();

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
	$('#addpostForm').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#flexiGridID').flexReload();
			$("#addpostDialog").dialog( "close" )
	     },
	     error : function() {
	        message("<spring:message code='please.contact.the.administrator'></spring:message>");
	     },
		complete : function(response, status) {
	     
		}
	});
	
$("#delBtn").click(function( event ) {
		
		var ids = searchTableColumn($("#flexiGridID"),0);
		if(ids.length > 0){
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/post/delPostDail',
				dataType : 'json',
				cache : false,
				data : [ {
					name : 'postIDs',
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
	});
	
	$("#queryBtn").click(function( event ) {
		var searchName = $("#searchName").val();
		var searchCount = $("#searchCount").val();
		query([{"name": "searchName","value":searchName}]);
	});

});

function query(param1){
	$('#flexiGridID').flexOptions({
		newp: 1,
		extParam: param1||[],
    	url: '${pageContext.request.contextPath}/post/getPostDataList'
    }).flexReload();
}

//页面跳转
function queryDetail(id){
	window.location.href = "${pageContext.request.contextPath}/post/queryDetail?id=" +id ;
	
}


</script>
</head>
<body>
<label> <spring:message code='post.name'/>
	<input type="text" id="searchName" />

		<a href="#" id="queryBtn"
			class="ui-state-default ui-corner-all cbe-button">
			<span class="ui-icon ui-icon-search"></span><spring:message code='query'/>
		</a>
		<a href="#" id="addBtn"
			class="ui-state-default ui-corner-all cbe-button">
			<span class="ui-icon ui-icon-plus"></span><spring:message code='add'/>
		</a>
		<a href="#" id="delBtn"
			class="ui-state-default ui-corner-all cbe-button">
			<span class="ui-icon ui-icon-minusthick"></span><spring:message code='delete'/>
		</a>
		
	<div id="addpostDialog" style="display: none;">
		<form id="addpostForm"
			action="${pageContext.request.contextPath}/post/addPostDail"
			method="post">
			<table>
				<tr>
				<td class="fileName">
					<label><spring:message code='roleId'/></label>
				</td>
				<td class="fileValue">
				  <resourse:Foreach selectName="roleId" selectId="roleId" baseSelectBean="${rolelist}">
				  </resourse:Foreach>
				</td>
			</tr>
			
			<tr>
				<td class="fileName"><label><spring:message code='organizationID'/></label></td>
				<td class="fileValue">
				   <input type="text" id="orgID" name="orgID" />
				</td>
			</tr>
			
			<tr>
				<td class="fileName"><label><spring:message code='post.name'/></label></td>
				<td class="fileValue">
				   <input type="text" id="postName" name="postName" />
				</td>
			</tr>
				
				<tr>
					<td class="fileName"><label><label><spring:message code='post.detail'/></label></td>
					<td class="fileValue"><input type="text" id="postDescribe"
						name="postDescribe" /></td>
				</tr>

			</table>
		</form>
	</div>		
      
	<div class="tbl">
		<table id="flexiGridID" style="display: block;margin: 0px;"></table>
	</div>
	
</body>
</html>