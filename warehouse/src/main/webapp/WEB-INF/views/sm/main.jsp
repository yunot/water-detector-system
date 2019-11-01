<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../common/common.jsp" %>
<%@ taglib uri="data.menu.name" prefix="m"%>
<%@ taglib uri="http://www.project.com/myTag/resource" prefix="resource" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/menu.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="common.system.title"></spring:message></title>
	<style>
	.ui-menu { width: 100%; }
	</style>
<script type="text/javascript">

var _gridWidth;
var _gridWidth;
var _left_menu_Width;
var _gridWidth;
//页面自适应
function resizePageSize(){
	var doc = $(document);
	_gridWidth = $(window).width();/*  -189 是去掉左侧 菜单的宽度，   -12 是防止浏览器缩小页面 出现滚动条 恢复页面时  折行的问题 */
	_gridHeight = $(window).height() - 101; /* -32 顶部主菜单高度，   -90 查询条件高度*/
	
	_left_menu_Width = _gridWidth/7*1.1;
	_mainFrame_whidth= _gridWidth/7*5.6;
	$(".heaerbox").css("width",_gridWidth/7*6.7 + 20 + "px");
	$("#mainFrame").css("width",_mainFrame_whidth + "px");
	$(".menu").css("width",_left_menu_Width+ "px");
	$(".dl-second-slib").css("left",_left_menu_Width+ "px");
	$("#mainFrame").css("height",_gridHeight -5+ "px");
	$(".menu").css("height",_gridHeight+ "px");
}

$(function(){
	resizePageSize();
	 $( "#manageCore" ).menu();	
	$(".dl-second-slib").bind("click",function(){
		if(parseFloat($(".menu").css("width"))>19){
			$(".menu").css("width",0);
			$(".menu").hide();
			$("#mainFrame").css("width",_gridWidth/7*6.7 + "px");
			$(".dl-second-slib").css("left","0").css("background","url('${pageContext.request.contextPath}/static/images/left-slib.gif') no-repeat -6px center transparent");
		}else{
			$(".menu").show();
			$(".menu").css("width",_left_menu_Width);
			$("#mainFrame").css("width",_mainFrame_whidth + "px");
			$(".dl-second-slib").css("left",_left_menu_Width).css("background","url('${pageContext.request.contextPath}/static/images/left-slib.gif') no-repeat 0px center transparent");
		}
	});
	
	$("#logouId").click(function( event ) {
		 location.href="${pageContext.request.contextPath}/logout";
        
	});
		
	 $(".topLink").mouseenter(function(){
	     $(".topLinkGo").css("display","block");
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

	function menuShowPage(obj,url){

		$(".menu3").removeClass("selected");
		$(obj).addClass("selected");
		if(url != null){
			$("#mainFrame").attr("src",url);
		}
	
		
	}
	
	//一级菜单
	function foldShowLabel1(obj){
		var flag = $(obj).attr("flag");
		var dom = $(obj).parent().find('.secondMeNu');
		var span = $(obj).find('span');
		var ul = $(obj).parent().find('ul');
		var firstDivs = $(obj).parent().parent().find('div[class="firstMeNu"]');
		$.each(firstDivs,function(){
			if($(obj).parent()!==$(this)){
				$(this).find('div[class="secondMeNu"]').hide();
				$(this).find("div:first").attr("flag","1");
				$(this).find('span').removeClass("ui-icon ui-icon-carat-1-s");
				$(this).find('span').addClass("ui-icon ui-icon-carat-1-n");
			}
		});
		if(flag === "1"){
			span.removeClass("ui-icon ui-icon-carat-1-n");
			span.addClass("ui-icon ui-icon-carat-1-s");
			dom.slideToggle();
			//只显示二级菜单
			ul.hide();
			flag = $(obj).attr("flag","0");
			dom.attr("flag","0");
		}else{
			span.removeClass("ui-icon ui-icon-carat-1-s");
			span.addClass("ui-icon ui-icon-carat-1-n");
			ul.hide();
			dom.hide();
			flag = $(obj).attr("flag","1");
			dom.attr("flag","1");
		}
	}
	//二级菜单
	function foldShowLabel(obj){
		var flag = $(obj).attr("flag");
		var dom = $(obj).parent().find('ul');
		var span = $(obj).find('span');
		var secondDivs = $(obj).parent().parent().find('div[class="secondMeNu"]');
		$.each(secondDivs,function(){
			if($(obj).parent()!==$(this)){
				$(this).find('ul').hide();
				$(this).find("div").attr("flag","1");
				$(this).find('span').removeClass("ui-icon ui-icon-triangle-1-s");
				$(this).find('span').addClass("ui-icon ui-icon-triangle-1-e");
			}
		});
		if(flag === "1"){
			flag = $(obj).attr("flag","0");
			span.removeClass("ui-icon ui-icon-triangle-1-e");
			span.addClass("ui-icon ui-icon-triangle-1-s");
			dom.slideToggle();
		}else{
			flag = $(obj).attr("flag","1");
			span.removeClass("ui-icon ui-icon-triangle-1-s");
			span.addClass("ui-icon ui-icon-triangle-1-e");
			dom.hide();	
		}

	}
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

<div class="heaerbox" >
	
	<div style="float: right;color: white; font-size: 20px;padding-right: 100px;padding-top: 20px;cursor: pointer;">
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
	<div class="menu" >
		<m:select list="${menuList }"/>
	</div>
    <div class="dl-second-slib" style="height: 524px;"></div>
	</div> 
	<div style="background-color: #f5f5f5;float:left;">
	    <iframe id="mainFrame" style="float: right; width: 1030px; height: 584px;padding-left:20px;padding-top: 5px;" frameborder="no" border="0" marginwidth="0" marginheight="0" src="${pageContext.request.contextPath}/static/images/loginbg/11.jpg">
	    </iframe>
    </div>
</body>
</html>