<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/11/30 0030
  Time: 上午 9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/lib/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/lib/css/metroStyle/metroStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/lib/css/demo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css" media="all"/>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/zTree3.3/js/jquery-1.4.4.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/zTree3.3/js/jquery.ztree.all-3.5.js"></script>
    <style type="text/css">
        .layui-form-item .layui-inline {
            width: 33.333%;
            float: left;
            margin-right: 0;
        }

        @media (max-width: 1240px) {
            .layui-form-item .layui-inline {
                width: 100%;
                float: none;
            }
        }
    </style>
</head>
<body class="childrenBody">
<form type="post" class="layui-form" style="width:80%;" id="organization">
    <!-- 权限提交隐藏域 -->
    <input type="hidden" id="m" name="parentId"/>
    <div class="layui-form-item">
        <label class="layui-form-label"><spring:message code="organization.name"/> </label>
        <div class="layui-input-block">
            <input type="text" id="orgName" class="layui-input userName" lay-verify="required"
                   placeholder="<spring:message code="organization.name"/>"
                   name="orgName">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label"><spring:message code="organization.type"/></label>
        <div class="layui-input-block">
            <resourse:Foreach selectId="orgType" selectName="orgType" dictType="sys_organization_type"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label"><spring:message code="modifierid.name"/></label>
        <div class="layui-input-block">
            <input type="text" id="modifierid" class="layui-input userName" lay-verify="required"
                   placeholder="<spring:message code="modifierid.name"/>"
                   name="modifier" value="${userInfo.account}">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label"><spring:message code="organization.description"/></label>
        <div class="layui-input-block">
            <textarea placeholder="<spring:message code="organization.description"/>" class="layui-textarea linksDesc"
                      lay-verify="required"
                      name="description"></textarea>
        </div>
    </div>
    <!--权限树xtree  -->
    <div class="layui-form-item">
        <label class="layui-form-label"><spring:message code="Binding.organization"/>
            <div class="zTreeDemoBackground">
                <ul id="tree" class="ztree"></ul>
            </div>
        </label>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="add"><spring:message code="submit"/></button>
        </div>
    </div>
</form>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/layui/lib/jquery-3.3.1.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/layui/lib/jquery.ztree.core.min.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/layui/lib/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript">
    var setting = {
        view: {
            selectedMulti: false
        },
        check: {
            enable: true,
            chkStyle: "radio"
        },
        data: {
            simpleData: {
                enable: true,//是否采用简单数据模式
                idKey: "id",//树节点ID名称
                pIdKey: "pId",//父节点ID名称
                rootPId: 0,//根节点ID
            }
        }
    };
    $(function () {
        //加载后端构建的ZTree树（节点的数据格式已在后端格式化好了）
        $.ajax({
            url: '${pageContext.request.contextPath}/organization/orglist/orgTreeData',
            type: 'get',
            dataType: "json",
            success: (data) => {
                $.fn.zTree.init($("#tree"), setting, data);//初始化树节点时，添加同步获取的数据
            }
        });
    });

    layui.use(['form', 'layer', 'jquery'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : parent.layer;
        var $ = layui.jquery;
        form.on("submit(add)", function (data) {
            var treeObj = $.fn.zTree.getZTreeObj("tree");
            var list = treeObj.getCheckedNodes(true);
            //组织id
            var mStr = "";
            for (var i = 0; i < list.length; i++) {
                mStr = list[i].id;
            }
            var m = $("#m");
            m.val(mStr);
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/organization/orglist/addOrganization",
                data: $("#organization").serialize(),
                success: function (data) {
                }
            });
            //弹出loading
            var index = layer.msg('<spring:message code="data.submit"/>', {icon: 16, time: false, shade: 0.8});
            setTimeout(function () {
                layer.close(index);
                layer.closeAll("iframe");
                parent.location.reload();
            }, 1000);
            return false;
        })

    })
</script>
</body>
</html>
