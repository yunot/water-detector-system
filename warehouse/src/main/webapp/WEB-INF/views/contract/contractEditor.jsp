<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
a{text-decoration:none}
</style>
<script type="text/javascript">
	var _gridWidth;
	var _gridHeight;
	function resizePageSize() {
		_gridWidth = $(document).width() - 12;
		_gridHeight = $(document).height() - 32; 
		$("#personDoc").attr("height",_gridHeight +"px");
	}
$(function(){
	resizePageSize();
	getHtmlContents('${docutmentHeadDataId}','${docutmentBodyDataId}');
	
	$("#save").click(function( event ) {
		var iframe = document.getElementById("personDoc");
		var doc = iframe.contentWindow.document;
		var body = doc.getElementsByTagName('body')[0].outerHTML;
		var docutmentBodyDataId = '${docutmentBodyDataId}';
		$.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/contract/save',
			dataType : 'json',
			cache : false,
			data : {
				body:body,
				docutmentBodyDataId : docutmentBodyDataId,
			},
			success : function(data) {
				message("成功");
			},
			error : function() {
				message("系统异常请联系管理员");
			}
		});
	});
	
});


function getHtmlContents(docutmentHeadDataId,docutmentBodyDataId){
		$.ajax({
			type: 'POST',
			url: '${pageContext.request.contextPath}/contract/editHtmlContents',
			dataType:'json',
			cache:false,
			data:{
			docutmentHeadDataId : docutmentHeadDataId,
			docutmentBodyDataId : docutmentBodyDataId},
			success:function(data){
				var iframe = document.getElementById("personDoc");
				var doc = iframe.contentWindow.document;
				doc.open();
				var temp=data.msg;
				var chang=$('<div/>').html(temp).text();
							
				doc.write(temp);
							
				doc.close();
				
				var docContents = [];
				$("p", doc).each(function() {
							var findFlag = false;
							$(this).find("a[name]").each(function() {
								var name1 = $(this).attr('name');
								if (name1.indexOf('_Toc') > -1) {
									findFlag = true;
								}
							});
							if (findFlag) {
								docContents.push($(this).clone());
							}
						});
				$("#leftContentsView").html("");
						$.each(docContents, function() {
							$("#leftContentsView").append($(this));
						});
						$("#leftContentsView").find('p a[name]').each(function() {
							var name1 = $(this).attr('name');
							if (name1.indexOf('_Toc') > -1) {
								$(this).attr('href', '#' + name1);
								$(this).attr('name', '');
								$(this).attr('target', 'docname12');
							}
						});								
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
		<table>
			<tr>

				<td valign="top" nowrap="nowrap"  id="leftContentaa">
					<div id="leftContentsView" style="width:180px;font-size:10px;line-height:1px;under-line:none"  >
						
					</div>
				</td>
		
				<td valign="top" nowrap="nowrap" width="100%">	
				<button id="save">保存</button>
				<iframe id="personDoc"
						name="docname12" scrolling="yes" width="100%" 
						frameborder="0">	
						</iframe></td>
			</tr>
		</table>
	</div>

</body>
</html>