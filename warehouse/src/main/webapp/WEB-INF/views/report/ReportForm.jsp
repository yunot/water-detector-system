<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 商品列表</title>
<style type="text/css">
	.fileName{
		width:300px;background-color:#85B5D9;    color: white;
	}
	.fileValue{
		width:300px;

	}
	
</style>
 <script type="text/javascript">
            var chart;
            var arrow;
            var axis;
            
            AmCharts.ready(function () {
                // create angular gauge
                chart = new AmCharts.AmAngularGauge();
                chart.addTitle("Speedometer");
            
                // create axis
                axis = new AmCharts.GaugeAxis();
                axis.startValue = 0;
				axis.axisThickness = 1;
                axis.endValue = 220;
                // color bands
                var band1 = new AmCharts.GaugeBand();
                band1.startValue = 0;
                band1.endValue = 90;
                band1.color = "#00CC00";
                
                var band2 = new AmCharts.GaugeBand();
                band2.startValue = 90;
                band2.endValue = 130;
                band2.color = "#ffac29";
                
                var band3 = new AmCharts.GaugeBand();
                band3.startValue = 130;
                band3.endValue = 220;
                band3.color = "#ea3838";
                band3.innerRadius = "95%";
                
                axis.bands = [band1, band2, band3];
                
                // bottom text
                axis.bottomTextYOffset = -20;
                axis.setBottomText("0 km/h");
                chart.addAxis(axis);
            
                // gauge arrow
                arrow = new AmCharts.GaugeArrow();
                chart.addArrow(arrow);
            
                chart.write("chartdiv");
                // change value every 2 seconds
                setInterval(randomValue, 2000);
            });
            
            // set random value
            function randomValue() {
            	$.ajax({
    				type : 'POST',
    				url : '${pageContext.request.contextPath}/report/getSpeed',
    				dataType : 'json',
    				cache : false,
    				data : [ {
    					name : 'cardId',
    					value : 123
    				} ],
    				success : function(data) {
    					if(data.speed != null){
        					arrow.setValue(data.speed);
        	                axis.setBottomText(data.speed + " km/h");
    					}
    				},
    				error : function() {
    					message("系统异常请联系管理员");
    				}
    			});
                              
            }					
			
</script>

</head>
<body>
  <div id="chartdiv" style="width:500px; height:400px;"></div>
</body>
</html>