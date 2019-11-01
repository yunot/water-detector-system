<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var chart;

	AmCharts.ready(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/report/drawIncome",
			dataType : "json",
			success : function(data) {
				var chartData = data;

				// SERIAL CHART
				chart = new AmCharts.AmSerialChart();
				chart.dataProvider = chartData;
				chart.categoryField = "year";
				// this single line makes the chart a bar chart, 
				// try to set it to false - your bars will turn to columns                
				chart.rotate = true;
				// the following two lines makes chart 3D
				chart.depth3D = 20;
				chart.angle = 30;

				// AXES
				// Category
				var categoryAxis = chart.categoryAxis;
				categoryAxis.gridPosition = "start";
				categoryAxis.axisColor = "#DADADA";
				categoryAxis.fillAlpha = 1;
				categoryAxis.gridAlpha = 0;
				categoryAxis.fillColor = "#FAFAFA";

				// value
				var valueAxis = new AmCharts.ValueAxis();
				valueAxis.axisColor = "#DADADA";
				valueAxis.title = "Income in millions, USD";
				valueAxis.gridAlpha = 0.1;
				chart.addValueAxis(valueAxis);

				// GRAPH
				var graph = new AmCharts.AmGraph();
				graph.title = "Income";
				graph.valueField = "income";
				graph.type = "column";
				graph.balloonText = "Income in [[category]]:[[value]]";
				graph.lineAlpha = 0;
				graph.fillColors = "#bf1c25";
				graph.fillAlphas = 1;
				chart.addGraph(graph);

				// WRITE
				chart.write("chartdiv");
			}
		});

	});
</script>
</head>
<body>
	<shiro:hasPermission name="BASE_MENU_109">
		<div>
			<input type="button" value="权限显示" />
		</div>
	</shiro:hasPermission>
	<div id="chartdiv" style="width: 500px; height: 600px;"></div>
</body>
</html>