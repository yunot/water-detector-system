<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
	body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	#allmap {height: 90%;bottom: -10%;}
	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aN9G7RoGgFolZKSZAE1knWt43ZV52xnW"></script>
	<title>毕业设计</title>
</head>
<body>
	<div>南京邮电大学毕业设计展示</div>
	<div id="allmap"></div>
	<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("allmap");    // 创建Map实例
	map.centerAndZoom(new BMap.Point("${lon}", "${lat}"), 11);  // 初始化地图,设置中心点坐标和地图级别
	//添加地图类型控件
	map.addControl(new BMap.MapTypeControl({
		mapTypes:[
            BMAP_NORMAL_MAP,
            BMAP_HYBRID_MAP
        ]}));	  
	//map.setCurrentCity("北京");          // 设置地图显示的城市 此项是必须设置的
	map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
	
	var bottom_right_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT});// 右下角，添加比例尺
	//添加控件和比例尺
		map.addControl(bottom_right_control);        
	
	
	// 添加定位控件
	var geolocationControl = new BMap.GeolocationControl();
  	geolocationControl.addEventListener("locationSuccess", function(e){
		// 定位成功事件
		var address = '';
		address += e.addressComponent.province;
		address += e.addressComponent.city;
		address += e.addressComponent.district;
		address += e.addressComponent.street;
		address += e.addressComponent.streetNumber;
		alert("当前定位地址为：" + address);
	});
  	
	geolocationControl.addEventListener("locationError",function(e){
		// 定位失败事件
		alert(e.message);
	});
	map.addControl(geolocationControl);
	
	//添加城市列表控件
	var size = new BMap.Size(10, 20);
	map.addControl(new BMap.CityListControl({
	    anchor: BMAP_ANCHOR_TOP_LEFT,
	    offset: size,
/* 	    // 切换城市之间事件
	    onChangeBefore: function(){
	       alert('before');
	    },
	    // 切换城市之后事件
	    onChangeAfter:function(){
	      alert('after');
	    } */
	}));
	
	function addClickHandler(content,marker){
		marker.addEventListener("click",function(e){
			openInfo(content,e)}
		);
	}
	
	function openInfo(content,e){
		var p = e.target;
		var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
		var infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象 
		map.openInfoWindow(infoWindow,point); //开启信息窗口
	}
	
	var opts = {
			width : 250,     // 信息窗口宽度
			height: 80,     // 信息窗口高度
			title : "监测点信息" , // 信息窗口标题
			enableMessage:true//设置允许信息窗发送短息
		   };
	
	var marker = new BMap.Marker(new BMap.Point("${lon}", "${lat}")); // 创建点
	map.addOverlay(marker);//增加点
	var p = marker.getPosition();       //获取marker的位置
	var content = "lon:"+p.lng+"<br>lat:"+p.lat;
	addClickHandler(content,marker);
	
	//创建小狐狸
/* 	var pt = new BMap.Point(116.417, 39.909);
	var myIcon = new BMap.Icon("http://lbsyun.baidu.com/jsdemo/img/fox.gif", new BMap.Size(150,157));
	var marker2 = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
	map.addOverlay(marker2);              // 将标注添加到地图中
	marker2.enableDragging();// 可拖拽 */
	
	//获取覆盖物信息
/* 	marker.addEventListener("click",getAttr);
	function getAttr(){
		var p = marker.getPosition();       //获取marker2的位置
		alert("marker的位置是" + p.lng + "," + p.lat);   
		//marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
	} */
	
	// 编写自定义函数,创建标注
	function addMarker(point){
	  var marker3 = new BMap.Marker(point);
	  p = marker3.getPosition();       //获取marker的位置
	  content = "lon:"+p.lng+"<br>lat:"+p.lat;
		addClickHandler(content,marker3);
	  /* marker3.addEventListener("click",function (){
			var p = marker3.getPosition();       //获取marker2的位置
			alert("marker的位置是" + p.lng + "," + p.lat);   
		}); */
	  map.addOverlay(marker3);
	}
	// 随机向地图添加5个标注
	var bounds = map.getBounds();
	var sw = bounds.getSouthWest();
	var ne = bounds.getNorthEast();
	var lngSpan = Math.abs(sw.lng - ne.lng);
	var latSpan = Math.abs(ne.lat - sw.lat);
	for (var i = 0; i < 5; i ++) {
		var point = new BMap.Point(sw.lng + lngSpan * (Math.random() * 0.7), ne.lat - latSpan * (Math.random() * 0.7));
		addMarker(point);
	}
	
	
</script>
</body>
</html>

