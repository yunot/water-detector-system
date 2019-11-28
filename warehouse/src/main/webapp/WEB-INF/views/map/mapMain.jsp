<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/common.jsp" %>
<%@ taglib uri="data.menu.name" prefix="m"%>
<%@ taglib uri="http://www.project.com/myTag/resource" prefix="resource" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>城市地表水浸水位监测系统</title>
	<style>
	body, html {width: 100%;height: 100%;overflow: hidden;margin:0;font-family:"微软雅黑";}
	#allmap {height: 100%;width: 90%;float: right;overflow: inherit;margin:0;font-family:"微软雅黑";}
	
.iframe-border {
    height: 865px;
    width: 1715px;
    left: 204px;
    top: 5px;
    position: absolute;
    background-color: lavender;
    border: 1px solid #99bce8;
}

	.map-menu-bg {
    position: relative;
    background-color: #DFE8F6;
    height: 84vh;
    width: 192px;
    left: 1px;
    top: 5px;
    border: 1px solid #99bce8;
}
	
	.map-menu {
    display: block;
    /* margin: 2px; */
    padding: 0;
    outline: 0;
    list-style: none;
    color: #515a6e;
    font-size: 14px;
    position: relative;
    z-index: 900;
    /* border-bottom: 1px solid #99bce8; */
}

.map-menu-item {
	display: block;
    outline: 0;
    list-style: none;
    font-size: 14px;
    padding: 14px 24px;
    position: relative;
    z-index: 1;
    cursor: pointer;
    transition: all .2s ease-in-out;
    border: 1px solid #99bce8;
    margin: 3px;
    text-align: center;
}
.map-menu-item-active{
    background: aquamarine;
    border-right: 2px solid;
}

.ui-icon {
    display: inline-block;
    text-indent: -99999px;
    overflow: hidden;
    background-repeat: no-repeat;
}
	</style>

	
	<script type="text/javascript">

$(function(){
	
	 $(".topLink").mouseenter(function(){
	     $(".topLinkGo").css("display","block");
	     $(".topLinkGo").css("color","white");
	     $(this).css("position","absolute");
	     $(this).css("margin-left","-90px");
	 }).mouseleave(function(){
	     $(".topLinkGo").css("display","none");
	     $(this).css("position","absolute");
	     $(this).css("margin-left","-90px"); 
	 });
	 
    $(".topLinkGo").mouseover(function(){
    	$(this).css("background-color","#b7caf2");
    }).mouseout(function(){
    	$(this).css("background-color","#1961b9");
    });
	
    $("#logouId").click(function (event) {
		 location.href="${pageContext.request.contextPath}/logout";
       
	});
    
	$("#updateUserId").click(function (event) {
            {          	
                $("#updateUserDialog").dialog("open");
            }
        });
        $("#updateUserDialog").dialog({
            autoOpen: false,
            width: 410,
            modal: true,
            resizable: false,
            title: "<spring:message code='modify.user.information.page'></spring:message>",
            buttons: [
                {
                    text: "<spring:message code='confirm'></spring:message>",
                    click: function () {
                        $("#updateUserinfoForm").submit();                       
                        $(this).dialog("close");

                    }
                },
                {
                    text: "<spring:message code='common'></spring:message>",
                    click: function () {
                        $(this).dialog("close");
                        $("#updateUserinfoForm").resetForm();
                    }
                }
            ]
        });
        
});

	
	$('#updateUserinfoForm').ajaxForm({
        dataType: "json",
        success: function (data) {
            message(data.msg);
            $("#updateUserDialog").dialog("close")
        },
        error: function () {
            message("<spring:message code='please.contact.the.administrator'></spring:message>");
        },
        complete: function (response, status) {
        }
    });
	     $(function () {
	         $("#updatepwdId").click(function (event) {
	             {
	                 $("#updatepwDialog").dialog("open");
	             }
	         }); 
	          $("#updatepwDialog").dialog({
	             autoOpen: false,
	             width: 400,
	             modal: true,
	             resizable: false,
	             title: '修改密码页面',
	             buttons: [
	                 {
	                     text: "确定",
	                     click: function () {
	                         resetPWd();
	                         $("#updatepwForm").submit();
	                         $(this).dialog("close");
	                     }
	                 },
	                 {
	                     text: "取消",
	                     click: function () {
	                         $(this).dialog("close");
	                     }
	                 }
	             ]
	         });
	          $('#updatepwForm').ajaxForm({
	              dataType: "json",
	              success: function (data) {
	                  message(data.msg);
	                  $("#updatepwDialog").dialog("close");
	              },
	              error: function () {
	                  message("请联系管理员");
	              },
	              complete: function (response, status) {
	              }
	          });
	     });
	 

	     function resetPWd() {
	         var userId = $("#userId").val();
	         var resetPassword = $("#resetPassword").val();
	         $.ajax({
	             url: '${pageContext.request.contextPath}/user/updatePwd',
	             type: 'post',
	             dataType: 'json',
	             data: {
	             	"userId": userId,
	                 "password": resetPassword
	             },
	             cache: false,
	             beforeSend: LoadFunction, //加载执行方法
	             error: erryFunction, //错误执行方法
	             success: succFunction //成功执行方法
	         })
	         function LoadFunction() {
	         }
	         function erryFunction() {
	             message("系统异常");
	         }
	         function succFunction(data) {
	             message(data.msg);
	         }
	     }; 
	     $("#oldPassword").blur(function () {
	         var oldPasswordV = $("#oldPasswordV").val();
	         var oldPassword = $("#oldPassword").val();
	         //要MD5解密，需要加载MD5的js文件
	         if (oldPassword != oldPasswordV) {
	             $("#oldPassword").next().html("密码错误");
	             $("#oldPassword").next().css("color", "red");
	         } else {
	             $("#oldPassword").next().html("√");
	             $("#oldPassword").next().css("color", "purple");
	         }
	     });
	     $("#resetPassword").blur(function () {
	         var oldPassword = $("#oldPassword").val();
	         var resetPassword = $("#resetPassword").val();
	         if (resetPassword != oldPassword) {
	             $("#resetPassword").next().html("√");
	         } else {
	             $("#resetPassword").next().html("新密码与旧密码相同");
	         }
	     });
	     $("#password1").blur(function () {
	         var newpassword = $("#password1").val();
	         var resetPassword = $("#resetPassword").val();
	         if (newpassword != resetPassword) {
	             $("#password1").next().html("两次密码不一致");
	         } else {
	             $("#password1").next().html("√");
	         }
	     });    
	     function showThirdMenu(obj){
			var status = $(obj).next().css("display");
			$(obj).next().css("display",status=="block"?"none":"block");
		} 
	</script>
</head>
<body>
	<div id="updatepwDialog" style="display: none;">
			<form id="updatepwForm">
				<input type="hidden" id="oldPasswordV" value="${userInfo.password}" />
				<input type="hidden" id="userId" name="userId" value="${userInfo.userId}"/> 
	        <table>
	            <tr>
	                <td class="fileName"><label>原密码</label></td>
	                <td class="fileValue">
	                <input type="password" id="oldPassword" name="oldPassword"/>
	                 <span class="mand">*</span></td>
	            </tr>
	            <tr>
	                <td class="fileName"><label>新密码</label></td>
	                <td class="fileValue">
	                <input type="password"id="resetPassword" name="password"/>
	                <span class="mand">*</span></td>
	            </tr>
	            <tr>
	                <td class="fileName"><label>确认密码</label></td>
	                <td class="fileValue"><input type="password" id="password1"/>
	                    <span class="mand">*</span></td>
	            </tr>
	        </table>
	    </form>
	</div>
	
	<div id="updateUserDialog" style="display: none;">
    <form id="updateUserinfoForm"
          action="${pageContext.request.contextPath}/user/updateUserinfo"
          method="post">
        <table>
           <!--  <input type="hidden" name="account" value="${userInfo.account}"/>  -->
           <input type="hidden" name="userId" value="${userInfo.userId}"/>
            <tr>
                <td class="fileName"><label><spring:message code='user.account'></spring:message></label></td>
                <td class="fileValue"><input type="text" id="account" name="account" value="${userInfo.account}"/>
                <span class="mand">*</span></td>
            </tr>
            <tr>
                <td class="fileName"><label><spring:message code='work.account'></spring:message></label></td>
                <td class="fileValue"><input type="text" id="employeeid" name="employeeid" value="${userInfo.employeeid}"/>
                <span class="mand">*</span></td>
            </tr>
            <tr>
                <td class="fileName"><label><spring:message code='user.name'></spring:message></label></td>
                <td class="fileValue"><input type="text" id="name" name="name" value="${userInfo.name}"/>
                <span class="mand">*</span></td>
            </tr>
            <tr>
                <td class="fileName"><label><spring:message code='gender'></spring:message></label></td>
                <td class="fileValue">
                <rsrs:Foreach dictType="sys_user_sex" selectId="gender" selectName="4" selected="${userInfo.gender}"/>
                <span class="mand">*</span></td>
            </tr>
            <tr>
                <td class="fileName"><label><spring:message code='telephone'></spring:message></label></td>
                <td class="fileValue"><input type="text" id="telephone" name="telephone" value="${userInfo.telephone}"/>
                <span class="mand">*</span></td>
            </tr>
        </table>
    </form>
</div>
	<div style="position: relative;z-index: 1;height: 100px;background-color: #DFE8F6;border: 1px solid #99bce8;">

<img id="onCode_id" style="margin: 10px;" src="${pageContext.request.contextPath}/static/images/logo.png"/>

	<div style="float: right;color: #316ac5; font-size: 20px;padding-right: 100px;padding-top: 20px;cursor: pointer;">
 		  <ul  class="topLink" style="position: absolute; margin-left: -90px;list-style: none;">
	        		<li style="height:32px;list-style: none;">
	        			<a class="cbe-menu">
	        			<span class="ui-icon ui-icon-triangle-1-s"></span>
	        			${userInfo.name}
	        			<i class="arrow-down"></i>
	        			</a>
                     </li>
                     <li  id="updateUserId" class="topLinkGo" style="display: none;background-color: rgb(25, 97, 185);">
						<a><spring:message code="user.indo.update"/></a>
                     </li>
                            <li class="topLinkGo" style="display: none;background-color: rgb(25, 97, 185);">
						<a  id="updatepwdId"> <spring:message code="password.update"/></a>
                     </li>
                     <li class="topLinkGo"  style="display: none;background-color: rgb(25, 97, 185);">
						<a id="logouId"><spring:message code="log.off"/></a>
                     </li>
             </ul> 
	</div>


</div>

	<div style="position: fixed;top: 102px;height: 90%;width: 100%;background-color: #b1c9ef;">
	<div class="map-menu-bg">
		<div style="margin: 10px 64px 0;">系统功能</div>
			<ul class="map-menu" style="">
				<li class="map-menu-item">地图展示</li>
				<li class="map-menu-item">当前监测点</li>
				<li
					class="map-menu-item ">预警日志</li>
<%--                <li class="map-menu-item">监测图表分析</li>--%>

			</ul>
		</div>
		<div class="iframe-border">
			<iframe id="mapFrame" style="width: 85vw;height: 84vh;" 
			frameborder="no" border="0" marginwidth="0" marginheight="0" 
			src="${pageContext.request.contextPath}/map/welcome">
		    </iframe>
	    </div>
			
	<script type="text/javascript">
	
	 $(".map-menu-item").mouseenter(function(){
	     $(this).addClass("ivu-menu-item-active");
	 }).mouseleave(function(){
	     //$(this).removeClass("ivu-menu-item-active");
	 });
	
	 $(".map-menu-item").click(function(){
		  $(this).addClass("ivu-menu-item-active");
		  if(!this.innerText.localeCompare('地图展示')){
			  document.getElementsByTagName('iframe').mapFrame.src = "${pageContext.request.contextPath}/map/mapView";
		  }else if(!this.innerText.localeCompare('当前监测点')){
			  document.getElementsByTagName('iframe').mapFrame.src = "${pageContext.request.contextPath}/map/mapLocationInfo";
		  }else if(!this.innerText.localeCompare('预警日志')){
			  document.getElementsByTagName('iframe').mapFrame.src = "${pageContext.request.contextPath}/map/mapLocationLog";
		  }else{
              document.getElementsByTagName('iframe').mapFrame.src = "${pageContext.request.contextPath}/map/mapLocationCharts";
          }
		});
	 
	</script>
</body>
</html>

