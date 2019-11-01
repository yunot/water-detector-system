<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src='<c:url value="/static/grid/js/jquery-1.6.2.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/static/grid/js/jquery.form.js"></c:url>'></script>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

$(function(){
	$('#getList11').ajaxForm({
		dataType: "json",
		success : function(data) {
	   	  	$("#query11").html("msg:"+data.description);
	     },
	     error : function() {
	           	alert("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
});



	</script>
</head>
<body>

  <spring:message code="welcome" arguments="辛,JAVA"/>
  
  	<form id="getList11"  action="${pageContext.request.contextPath}/aaa/getList" method="post">

		<input type="submit" value="查询">
	</form>
	<div id="query11"> </div>

</body>
</html>