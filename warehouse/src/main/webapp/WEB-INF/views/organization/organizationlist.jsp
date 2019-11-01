<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="../common/common.jsp" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>tree-table</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/treetable-lay/common.css"/>
</head>
<body>
<div class="layui-container layui-text">
    <br>
    <br>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <div class="layui-btn-group">
                <button class="layui-btn" id="btn-expand"><spring:message code="expand"/></button>
                <button class="layui-btn" id="btn-fold"><spring:message code="fold"/></button>
                <button class="layui-btn" id="btn-refresh"><spring:message code="flexigrid.tip.refresh"/></button>
            </div>
            <div class="layui-btn-group">
                <button class="layui-btn" data-type="btnAdd"><spring:message code="add"/></button>
                <button class="layui-btn" data-type="btnEdit"><spring:message code="modify"/></button>
                <button class="layui-btn" data-type="btnBind"><spring:message code="Binding.organization"/></button>
                <button class="layui-btn" data-type="btnUntied"><spring:message code="Untied.organization"/></button>
            </div>
        </div>
    </div>
    <table id="orgtable" class="layui-table" lay-filter="orgtable"></table>
</div>
<!-- 操作列 -->
<script type="text/html" id="oper-col">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><spring:message code="delete"/></a>
</script>

<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
<script>
    layui.config({
        base: '${pageContext.request.contextPath}/static/layui/'
    }).extend({
        treetable: 'treetable-lay/treetable'
    }).use(['layer', 'table', 'treetable'], function () {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var treetable = layui.treetable;
        var form = layui.form;

        // 渲染表格
        var renderTable = function () {
            layer.load(4);
            treetable.render({
                treeColIndex: 1,
                treeSpid: -1,
                treeIdName: 'id',
                treePidName: 'pId',
                treeDefaultClose: false,
                treeLinkage: false,
                elem: '#orgtable',
                url: '${pageContext.request.contextPath}/organization/orglist/showorg',
                page: false,
                cols: [[
                    {type: 'radio'},
                    {field: 'name', title: '<spring:message code="organization.name"/>'},
                    {field: 'type', title: '<spring:message code="type"/>', templet: '#typeBtn'},
                    {field: 'status', title: '<spring:message code="status"/>', templet: '#statusBtn'},
                    {templet: '#oper-col', title: '<spring:message code="oper"/>'}
                ]],
                done: function () {
                    layer.closeAll('loading');
                }
            });
        };

        renderTable();

        $('#btn-expand').click(function () {
            treetable.expandAll('#orgtable');
        });

        $('#btn-fold').click(function () {
            treetable.foldAll('#orgtable');
        });

        $('#btn-refresh').click(function () {
            renderTable();
        });

        table.on('tool(orgtable)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;

            if (layEvent === 'del') {
                if (data.type !== "organization" || data.isParent === true) {
                    layer.msg('<spring:message code="not.delete"/>');
                } else {
                    openDelete(data.id);
                }
            }
        });


        //打开新增按钮
        function openAdd() {
            layer.open({
                type: 2 //Page层类型
                , area: ['700px', '500px']
                , title: '<spring:message code="organization.add"/>'
                , shade: 0.6 //遮罩透明度
                , shadeClose: true
                , maxmin: true //允许全屏最小化
                , anim: 0 //0-6的动画形式，-1不开启
                , content: "${pageContext.request.contextPath}/organization/orglist/add",
                success: function () {
                    layui.layer.tips('<spring:message code="return.list"/>', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }
            });
        }

        //打开编辑按钮
        function openEdit(id) {
            layer.open({
                type: 2 //Page层类型
                , area: ['700px', '500px']
                , title: '<spring:message code="organization.edit"/>'
                , shade: 0.6 //遮罩透明度
                , shadeClose: true
                , maxmin: true //允许全屏最小化
                , anim: 0 //0-6的动画形式，-1不开启
                , content: "${pageContext.request.contextPath}/organization/orglist/edit/" + id,
                success: function () {
                    layui.layer.tips('<spring:message code="return.list"/>', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }
            });
        }

        function openBind(id) {
            layer.open({
                type: 2 //Page层类型
                , area: ['700px', '500px']
                , title: '<spring:message code="organization.edit"/>'
                , shade: 0.6 //遮罩透明度
                , shadeClose: true
                , maxmin: true //允许全屏最小化
                , anim: 0 //0-6的动画形式，-1不开启
                , content: "${pageContext.request.contextPath}/organization/orglist/bindOrganization/" + id,
                success: function () {
                    layui.layer.tips('<spring:message code="return.list"/>', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                }
            });
        }

        function openUntied(id) {
            layer.open({
                success: function () {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/organization/orglist/untied/' + id,
                        data: {
                            orgId: id
                        },
                        type: 'POST',
                        dataType: 'json',
                        success: function (data) {
                            layer.msg(data.msg);
                        }
                    });
                    //弹出loading
                    var index = layer.msg('<spring:message code="data.submit"/>', {icon: 16, time: false, shade: 0.8});
                    setTimeout(function () {
                        layer.close(index);
                        location.reload();
                    }, 1000);
                }
            });
        }


        //删除按钮
        function openDelete(id) {
            layer.open({
                success: function () {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/organization/orglist/delOrganization',
                        data: {
                            orgId: id
                        },
                        type: 'POST',
                        dataType: 'json',
                        success: function (data) {
                            layer.msg(data.msg);
                        }
                    });
                    //弹出loading
                    var index = layer.msg('<spring:message code="data.submit"/>', {icon: 16, time: false, shade: 0.8});
                    setTimeout(function () {
                        layer.close(index);
                        location.reload();
                    }, 1000);
                }
            });
        }

        var active = {
            btnAdd: function () { //新增操作
                openAdd();
            },
            btnBind: function () {
                var checkStatus = table.checkStatus('orgtable')
                    , data = checkStatus.data;
                var id = data[0].id;
                if (id === 1 || data[0].type !== 'organization') {
                    layer.msg('<spring:message code="not.bind"/>');
                } else {
                    openBind(id);
                }
            },
            btnUntied: function () {
                var checkStatus = table.checkStatus('orgtable')
                    , data = checkStatus.data;
                var id = data[0].id;
                if (id === 1 || data[0].type !== 'organization') {
                    layer.msg('<spring:message code="not.Untied"/>');
                } else {
                    openUntied(id);
                }
            },
            btnEdit: function () {
                var checkStatus = table.checkStatus('orgtable')
                    , data = checkStatus.data;
                var id = data[0].id;
                if (id === 1 || data[0].type !== 'organization') {
                    layer.msg('<spring:message code="not.edit"/>');
                } else {
                    openEdit(id);
                }
            }
        };

        $('.layui-btn-group .layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

    });
</script>
<script type="text/html" id="statusBtn">
    <span class="layui-badge  {{ d.status === '0' ? 'layui-bg-green' : 'layui-bg-red' }} ">{{d.status === '0' ? 'on' : 'off'}}</span>
</script>
<script type="text/html" id="typeBtn">
    <span class="layui-badge  {{ d.type === 'organization' ? 'layui-bg-green' : d.type === 'dept' ? 'layui-bg-orange' : 'layui-bg-cyan' }} ">{{d.type === 'organization' ? '<spring:message
            code="organization"/>' : d.type === 'dept' ? '<spring:message code="dept"/>' : '<spring:message
            code="post"/>'}}</span>
</script>
</body>
</html>