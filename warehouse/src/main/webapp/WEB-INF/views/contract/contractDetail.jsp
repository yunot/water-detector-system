<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
a {
	text-decoration: none
}
</style>
<script type="text/javascript">
	var _gridWidth;
	var _gridHeight;
	function resizePageSize() {
		_gridWidth = $(document).width() - 12;
		_gridHeight = $(document).height() - 32;
		$("#personDoc").attr("height", _gridHeight + "px");
	}
	$(function() {
		resizePageSize();
		getHtmlContents('${docutmentHeadDataId}', '${docutmentBodyDataId}')
	});

	function getHtmlContents(docutmentHeadDataId, docutmentBodyDataId) {
		$
				.ajax({
					type : 'POST',
					url : '${pageContext.request.contextPath}/contract/getHtmlContents',
					dataType : 'json',
					cache : false,
					data : {
						docutmentHeadDataId : docutmentHeadDataId,
						docutmentBodyDataId : docutmentBodyDataId
					},
					success : function(data) {
						var iframe = document.getElementById("personDoc");
						var doc = iframe.contentWindow.document;
						doc.open();
						var temp = data.msg;
						var chang = $('<div/>').html(temp).text();
						doc.write("<!DOCTYPE html><html>");
						doc.write(temp);
						doc.write("</html>");
						doc.close();

						var docContents = [];
						$("a[name]", doc).each(function() {
							var findFlag = false;
							//$(this).find("a[name]").each(function() {
							var name1 = $(this).attr('name');
							if (name1.indexOf('_Toc') > -1) {
								findFlag = true;
							}
							//});
							if (findFlag) {
								var domItem = $('<p/>');
								var item = $(this).clone();
								item.find('img').remove();
								domItem.append(item);
								docContents.push(domItem);
							}
						});
						$("#leftContentsView").html("");
						$.each(docContents, function() {
							$("#leftContentsView").append($(this));
						});
						$("#leftContentsView").find('p a[name]').each(
								function() {
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

				<td valign="top" nowrap="nowrap" id="leftContentaa">
					<div id="leftContentsView"
						style="width:250px;font-size:10px;line-height:1.5px;under-line:none">

					</div>
				</td>

				<td valign="top" nowrap="nowrap" width="100%"><iframe
						id="personDoc" name="docname12" scrolling="yes" width="100%"
						frameborder="0"></iframe></td>
			</tr>
		</table>
	</div>

</body>
</html>