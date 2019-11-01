<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="../common/common.jsp" %>
<%@ taglib uri="http://www.project.com/myTag/resource" prefix="resource" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<style type="text/css">
.fa {
    font-size: 25px;
}
</style>
 <title><spring:message code="login.page"></spring:message></title>
	
<script type="text/javascript">
console.log("${CAPTCHA_CODE_KEY}");

$("body").attr('style', "background-image: url(${pageContext.request.contextPath}/static/images/loginbg/09.jpg);");
var image = 1;
function change(){
		if(image>9)
			image = 1;
		$("body").attr('style', "background-image: url(${pageContext.request.contextPath}/static/images/loginbg/0"+image+".jpg);");
		$("body[background-image]").fadeIn("slow");
		image++;

}
setInterval(change,3000);
    
    if("${tip}" != null&&"${tip}" != ""){
    	alert("验证失败");
    }
    
    
$(function () {
	var url = window.location.search;
	var dom_zh = document.getElementById("change_language_zh");
	var dom_en = document.getElementById("change_language_en");
	if(url.length > 0) {
	 var theinx = url.indexOf("siteLanguage=");
	 if(theinx > 0) {
		 var temp = url.substring(theinx, theinx+17);
		 dom_zh.href = window.location.href.replace(temp, "siteLanguage=zh");
		 dom_en.href = window.location.href.replace(temp,"siteLanguage=en");
	 } else {
		 dom_zh.href = window.location.href+"?siteLanguage=zh";
		 dom_en.href = window.location.href+"?siteLanguage=en";
	 }
	} else {
	 dom_zh.href = window.location.href+"?siteLanguage=zh";
	 dom_en.href = window.location.href+"?siteLanguage=en";
	}

	$("#password1").blur(function () {
		var newpassword = $("#password1").val();
		var resetPassword = $("#resetPassword").val();
		if (newpassword != resetPassword) {
			$("#password1").next().html("<spring:message code='two.password.is.inconsistent'></spring:message>");
		} else {
			$("#password1").next().html("√");
		}
	});

	$( "#dialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: "<spring:message code='message.prompt'></spring:message>",
		buttons: [
			{
				text: "Ok",
				click: function() {
					$( this ).dialog( "close" );
				}
			}
		]
	});
	
	$("#updatepwDialog").dialog({
		autoOpen:false,
		width:400,
		modal: true,
		resizable: false,
		title: "<spring:message code='reset.password.page'></spring:message>",
		buttons: [
			{
				text: "<spring:message code='confirm'></spring:message>",
				click: function () {
					resetPWd();
					$("#updatepwForm").submit();
					$(this).dialog("close");
				}
			},
			{
				text: "<spring:message code='common'></spring:message>",
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
			message("<spring:message code='please.contact.the.administrator'></spring:message>");
		},
		complete: function (response, status) {
		}
	});

	$("#checkuserDialog").dialog({
		autoOpen: false,
		width: 400,
		modal: true,
		resizable: false,
		title: "<spring:message code='verify.page'></spring:message>",
		buttons: [
			{
				text: "<spring:message code='confirm'></spring:message>",
				click: function () {
					$("#checkuserForm").submit();
				}
			},
			{
				text: "<spring:message code='common'></spring:message>",
				click: function () {
					$(this).dialog("close");
				}
			}
		]
	});

	$('#checkuserForm').ajaxForm({
		dataType: "json",
		success: function (data) {
			message(data.msg);
			$("#checkuserDialog").dialog("close");
			if ("<spring:message code='verification.sucess'></spring:message>" == data.msg) {
				$("#updatepwDialog").dialog("open");
			}
		},
		error: function () {
			message("<spring:message code='please.contact.the.administrator'></spring:message>");
		},
		complete: function (response, status) {
		}
	});
	
    $("input[name='captcha']").blur(function(){
    	var validcode = document.getElementsByName("captcha")[0].value;
    	console.log(validcode);
				$.ajax({
					type : "POST",
					url : '${pageContext.request.contextPath}/validcodeCheck',
					dataType : "json",
					cache : false,
					data :{"validcode" : validcode},
					success : function(data) {
						
						//message(data.msg);
						$('#checkResult')[0].innerHTML = data.msg;
						
					},
					error : function() {
						message("系统异常请联系管理员");
					}
				});
     });

});

String.prototype.equalsIgnoreCase = function(anotherString) {
	if(this === anotherString){  //如果两者相同   否则判端两个的大小写是否为null
		return true;
	}
	//因为 typeof(null) = object  typeof(undefined) = undefined  实际上也是判端了这两个不为空
	if(typeof(anotherString)==='string'){ //this!=null&&this!=undefined &&anotherString!=null&& anotherString!=undefined
		return this.toLowerCase() == anotherString.toLowerCase(); //
	}
	return false;
}

        //表单提交前进行的校验
        function check() {
        	if($('#checkResult')[0].innerHTML == "验证成功"){
        		return true;
        	}
        	return false;
        }
        
        function onClickCode() {
            $("#onCode_id").attr('src', "${pageContext.request.contextPath}/captchaCode?_dc=" + (new Date()).getTime());
            $('#checkResult')[0].innerHTML = " ";
        }

        //忘记密码进行校验
        function redirect_resetPw() {
            $("#checkuserDialog").dialog("open");
        }

        function send() {
            var email = $("#email").val();
            $.ajax({
                type: 'POST',
                dataType: "json",
                url: '${pageContext.request.contextPath}/check/sendMail',
                cache: false,
                data: {
                    email: email
                },
                success: function (data) {
                    message(data.msg);
                },
                error: function () {
                    message("<spring:message code='system.abnormality'></spring:message>");
                }
            });
        }


        

        function resetPWd() {
            var email = $("#email").val();
            var resetemail = $("#resetemail").val();
            resetemail = email;
            var resetPassword = $("#resetPassword").val();
            $.ajax({
                url: '${pageContext.request.contextPath}/check/resetPassword',
                type: 'post',
                dataType: 'json',
                data: {
                    resetemail: resetemail,
                    resetPassword: resetPassword
                },
                cache: false,
                error: erryFunction, //错误执行方法
                success: succFunction //成功执行方法
            })

            function erryFunction() {
                message("<spring:message code='system.abnormality'></spring:message>");
            }

            function succFunction(data) {
                message(data.msg);
            }
        };

        
        //注册
        function redirect_reset() {
            $("#reg").dialog({
                width: 320,
                modal: true,
                resizable: false,
                title: '<spring:message code="register"></spring:message>',
                buttons: [
                    {
                        text: "<spring:message code='confirm'></spring:message>",
                        click: function () {
                           var inputs = $("#reg").find("input");
						var values = new Array();
						$.each(inputs, function(i) {
							values.push(inputs[i].value);
						});

						var flag = true;
						$.each(values, function(i) {
							var id = inputs[i].getAttribute("id");
							if (values[i] == "" || values[i] == null) {
								$("#" + id).next().css("display", "block");
								flag = false;
							} else {
								$("#" + id).next().css("display", "none");
							}
						});

						if (flag == false) {
							return;
						}

						//电话
						var telReg = /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
						if (values[2].length != 11 || telReg.test(values[2]) == false) {
							var id = inputs[2].getAttribute("id");
							$("#" + id).next().css("display", "block");
							$("#" + id).next().text("<spring:message code='formatting.error'></spring:message>");
							return;
						}
						
						//邮箱地址
						var emailReg = /^\w+@[a-zA-Z0-9]{2,10}(?:\.[a-z]{2,4}){1,3}$/;
						if (emailReg.test(values[3]) == false) {
							var id = inputs[3].getAttribute("id");
							$("#" + id).next().css("display", "block");
							$("#" + id).next().text("<spring:message code='formatting.error'></spring:message>");
							return;
						}

						var gender = $("#reg_gender").val();
						$.ajax({
							type : "post",
							url : "${pageContext.request.contextPath}/sm/regUser",
							dataType : 'json',
							data : {
								"account" : values[0],
								"name" : values[1],
								"telephone" : values[2],
								"email" : values[3],
								"gender" : gender,
								"password" : values[5]
							},
							success : function(data) {
								message(data.msg);
							},
							error : function() {
								message("<spring:message code='system.exception.please.contact.the.administrator'></spring:message>");
							}
						});
						$(this).dialog("close");
						$("#reg_account").val("");
						$("#reg_name").val("");
						$("#reg_tel").val("");
						$("#reg_email").val("");
						$("#reg_gender").val("");
						$("#reg_password").val("");
                        }
                    },
                    {
                        text: "<spring:message code='common'></spring:message>",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }
        
       
        
    </script>
</head>

<body>

     <a href="" id="change_language_zh" style="POSITION: absolute;left: 1180px; top: 28px; Z-INDEX:4; font-size: 10px; COLOR: #307096; width:87px; height: 26px; padding-right: 0px"></a>
     <a href="" id="change_language_en" style="POSITION: absolute;left: 1180px; top: 46px; Z-INDEX:4; font-size: 10px; COLOR: #307096; width:87px; height: 26px; padding-left: 0px"></a>
<div style="
    position: relative;
    font-size: -webkit-xxx-large;
    text-align: center;
    top: 110px;
    color: cornflowerblue;
">基于云平台的城市地表水浸水位监测系统设计</div>
<div id="checkuserDialog" style="display: none;">
    <form id="checkuserForm"
          action="${pageContext.request.contextPath}/check/checkuser"
          method="post">
        <table>
            <tr>
                <td class="fileName"></td>
                <td class="fileValue">
                     <input type="text" placeholder="<spring:message code='mailbox'/>" id="email" name="email"/>
                     <input type="button" value="<spring:message code='send.verification.code'/>" onclick="send()" ></input>
                 </td>
            </tr>
            <tr>
                <td class="fileName"></td>
                <td class="fileValue"><input type="text" placeholder="<spring:message code='verification.code'/>" id="inputCode" name="inputCode"/> <span class="mand">*</span></td>
            </tr>
        </table>
    </form>
</div>
<div id="updatepwDialog" style="display: none;">
    <form id="updatepwForm"
          action="${pageContext.request.contextPath}/check/resetPassword"
          method="post">
        <input type="hidden" id="resetemail" name="resetemail"/>
        <table>
            <tr>
                <td class="fileName"><label><spring:message code="new.password"></spring:message></label></td>
                <td class="fileValue"><input type="password" id="resetPassword" name="resetPassword"/><span class="mand">*</span>
                </td>
            </tr>
            <tr>
                <td class="fileName"><label><spring:message code="confirm.password"></spring:message></label></td>
                <td class="fileValue"><input type="password" id="password1"/>
                <span class="mand">*</span></td>
            </tr>
        </table>
    </form>
</div>
<div>

    <div class="login-form ">
        <div class="form">

            <form action="${pageContext.request.contextPath}/sm/vldtlogon" method="post" onsubmit="return check()">

                <p class="item_1 input_border">
                    <input type="text" class="pass-label"  name="userName"  placeholder="<spring:message code='sm.user.tips'/>"/> 
                    <span> <i class="icon fa fa-user"></i></span>
                </p>
                <p class="item_1">
                    <input type="password" placeholder="<spring:message code='sm.user.password'/>" class="pass-label" name="password"/> 
                    <span><i class="myeye fa fa-eye-slash"></i></span>
                </p>

                <p class="item_1" style="height: 100px;">
                    <input type="text" placeholder="<spring:message code='verification.code'/>" class="pass-label" name="captcha"/> 
                    <img id="onCode_id" style="margin: 10px;" src="${pageContext.request.contextPath}/captchaCode" onClick="onClickCode();"/>
                </p>
                <p class="item_1">
                	<span style="left: 10px;position: relative;" id="checkResult"></span>
                    <a id="registerUser" style="float: right;padding-right: 10px"
                       href="javascript:;"
                       onclick="redirect_resetPw(); "><spring:message code="forget.password"></spring:message>
                    </a> 
                    <a style="float: right;padding-right: 10px" href="javascript:;" onclick="redirect_reset();"><spring:message code="register"></spring:message>
                </a>
                </p>
                <p class="item_1">
                    <button type="submit" class="btn btn-danger"><spring:message code="sign.in"></spring:message></button>
                    
                </p>
            </form>
        </div>
    </div>
</div>

<!-- 注册 -->
<div id="reg" style="display:none;">
    <p class="item_1">
         <input type="text" placeholder="<spring:message code='sm.user.account'/>" class="pass-label" id="reg_account" value=""/>
         <span class="mand">*</span>
    </p>
    <p class="item_1">
         <input type="text" placeholder="<spring:message code='sm.user.name'/>" class="pass-label" id="reg_name" value=""/>
         <span class="mand">*</span>
    </p>
    <p class="item_1">
        <input type="text" placeholder="<spring:message code='sm.user.telephone'/>" class="pass-label" id="reg_tel" value=""/>
        <span class="mand">*</span>
    </p>
    <p class="item_1">
        <input type="text" placeholder="<spring:message code='mailbox'/>" class="pass-label" id="reg_email" value=""/>
        <span class="mand">*</span>
    </p>
    <p class="item_1">
       <rsrs:Foreach dictType="sys_user_sex" selectId="reg_gender" selectName="gender" selected=""/> 
       <span class="mand">*</span>
    </p>
    <p class="item_1">
        <input type="password" placeholder="<spring:message code='sm.user.password'/>" class="pass-label" id="reg_password" value=""/>
        <span class="mand">*</span>
    </p>
</div>
</body>
</html>
