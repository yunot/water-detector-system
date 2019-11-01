<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<ul>
       <li>
            <a href="#" id="change_language_zh" style="padding-right: 1px">中文</a>
        </li>
        <li style="margin-top: 10px">
            |
        </li>
        <li>
            <a href="#" id="change_language_en" style="padding-left: 1px">Engilsh</a>
        </li>
</ul>
       <script type="text/javascript">
            var url = window.location.search;
            var dom_zh = document.getElementById("change_language_zh");
            var dom_en = document.getElementById("change_language_en");
            if(url.length > 0) {
                var theinx = url.indexOf("choiceLanguage=");
                if(theinx > 0) {
                    var temp = url.substring(theinx, theinx+17);
                    dom_zh.href = window.location.href.replace(temp, "choiceLanguage=zh");
                    dom_en.href = window.location.href.replace(temp,"choiceLanguage=en");
                } else {
                    dom_zh.href = window.location.href+"?choiceLanguage=zh";
                    dom_en.href = window.location.href+"?choiceLanguage=en";
                }
            } else {
                dom_zh.href = window.location.href+"?choiceLanguage=zh";
                dom_en.href = window.location.href+"?choiceLanguage=en";
            }
        </script>
</body>
</html>