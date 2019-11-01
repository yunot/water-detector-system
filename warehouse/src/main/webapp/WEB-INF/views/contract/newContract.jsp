<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	var _gridWidth;
	var _gridHeight;
	//页面自适应
	function resizePageSize() {
		_gridWidth = $(document).width() - 12;/*  -189 是去掉左侧 菜单的宽度，   -12 是防止浏览器缩小页面 出现滚动条 恢复页面时  折行的问题 */
		_gridHeight = $(document).height() - 32; /* -32 顶部主菜单高度，   -90 查询条件高度*/
		$("#personDoc").attr("height",_gridHeight +"px");
	}
$(function(){
	resizePageSize();
	var headDataId = '${headDataId}';
	getHtmlContents('${headDataId}','${docutmentInfoName}')
	$("#saveBtn").click(function( event ) {
		var iframe = document.getElementById("personDoc");
		var doc = iframe.contentWindow.document;
		var head = doc.getElementsByTagName("head")[0];
		var body = doc.getElementsByTagName("body")[0].outerHTML;
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath}/contract/newContractContent',
			dataType:'json',
			cache:false,
			data:[{'name':"contractName",'value' : "新建文档"},
			      {'name':"body",'value' : body},
					{'name':"headDataId",'value' : headDataId}
				],
			success:function(data){
				message(data.msg);
				},
				error : function() {
			        message("<spring:message code='please.contact.the.administrator'></spring:message>");
			     }
			});
	});
});

function getHtmlContents(headDataId,docutmentInfoName){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath}/contract/newContract',
			dataType:'json',
			cache:false,
			data:{
				headDataId : headDataId,
				docutmentInfoName : docutmentInfoName},
			success:function(data){
				var iframe = document.getElementById("personDoc");
				var doc = iframe.contentWindow.document;
				doc.open();
				doc.write("<html xmlns='http://www.w3.org/19999/xhtml'>");
				doc.write(data.msg);
				
				doc.write("<body contenteditable='true'></body>");
				doc.write("</html>");
				doc.close();
				
		
				},
				error : function() {
			        message("<spring:message code='please.contact.the.administrator'></spring:message>");
			     }
			});
		}
			
</script>
</head>
<body>

	<div>
		<iframe id="personDoc" name="docname12" scrolling="yes" width="100%" heigth="100%" frameborder="0">
		</iframe>
		<a href="#" id="saveBtn" class="ui-state-default ui-corner-all cbe-button">保存</a>
	</div>
	
</body>









</html>