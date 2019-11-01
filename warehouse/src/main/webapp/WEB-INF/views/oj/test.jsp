<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${subject.subjectName }</title>
<style type="text/css">
  p{
    color:grey;
    word-wrap:break-word;
    word-break:break-all;
    line-height:20px;
  }

</style>
<script type="text/javascript">


$(function()
{
	$("#save").click(function( event ) {
		var code=$("textarea").val();
		$.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/subjectController/addUserSubject',
			dataType : 'json',
			cache : false,
			data : {
				code:code,
			},
			success : function(data) {
				
			},
			error : function() {
				
			}
		});
		$.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/oj/getCode',
			dataType : 'json',
			cache : false,
			data : {
				code:code,
			},
			success : function(data) {
				
			},
			error : function() {
				
			}
		});
	});
	
	
});



</script>

</head>
<body style="background-color:#d2f2b8;margin:0">

<div style="width:100%;height:670px">
<div style="margin:0px 0px 0px 20px;float:left;padding:15px 15px 0px 15px;background-color:white;width:42%;height:655px">
<div style="height:370px;overflow-y:scroll">
<h2><b>题目描述</b></h2>
<p>${subject.subjectDesc }</p>

<h4>输入描述</h4>
<p>${subject.subjectInput }</p>
    

<h4>输出描述</h4>
<p>${subject.subjectOut }</p>

</div>

<div style="padding:10px;margin:0px ;background-color:#d5f9ed;line-height:50%;height:245px;overflow-y:scroll">
<h4 style="margin-top:0;margin-bottom:40px">示例1</h4>
<h5>输入</h5>
<p style="padding:15px;background-color:white">${subject.sampleInput }</p>

<h5>输出</h5>
<p style="padding:15px;background-color:white">${subject.sampleOut }</p>
</div>
</div>

<div style="float:left;">
<textarea style="background-color:#51514c;color:#f9d88a;width:720px;height:490px"></textarea>
</div>

<div style="float:left;margin: 0px; background-color:black; width:725px; height: 170px;overflow-y:scroll">
<button id="save">保存并调试</button>
<p style="color:rgb(0, 188, 155)">保存并调试之后，这里将会显示运行结果</p>
</div>
</div>
</body>
</html>