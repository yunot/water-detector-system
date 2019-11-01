<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>合同管理</title>

<script type="text/javascript">
var _gridWidth;
var _gridHeight;
//页面自适应
function resizePageSize(){
	_gridWidth = $(document).width()-12;/*  -189 是去掉左侧 菜单的宽度，   -12 是防止浏览器缩小页面 出现滚动条 恢复页面时  折行的问题 */
	_gridHeight = $(document).height()-32-80; /* -32 顶部主菜单高度，   -90 查询条件高度*/
}

$(function()
{
	
	$('#uploadContractForm').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#uploadContractForm').resetForm();
			message(data.msg);
			query();
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	resizePageSize();
	var _columnWidth= (_gridWidth-150)/4;
	
	
	$("#flexiGridID").flexigrid({
		width : _gridWidth,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/contract/getContractlist",
		dataType : 'json',
		colModel : [ 
		   {display : 'ID',name : 'docutmentInfoId',width : 150,sortable : false,align : 'center',hide : 'true'}, 
	       {display : "合同名称",name : 'docutmentInfoName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display : 'docutmentHeadDataId',name : 'docutmentHeadDataId',width : _columnWidth, sortable : false,align : 'center',hide:'true'}, 
	       {display : 'docutmentBodyDataId',name : 'docutmentBodyDataId',width : _columnWidth, sortable : false,align : 'center',hide:'true'}, 
	       {display : "创建时间",name : 'createTime',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "修改时间",name : 'modifyTime',width : _columnWidth, sortable : true,align : 'center'},
	       {display : "操作",name : 'operation',width : _columnWidth, sortable : true,align : 'center',process: function(v,_trid,_row) {				 
				var htmlContents ='<span style="color:blue;cursor:pointer;" onclick="toQuery(\''+_row.docutmentInfoId+'\','
						+'\''+_row.docutmentHeadDataId+'\',\''+_row.docutmentBodyDataId+'\',\''+_row.docutmentInfoName+'\');">查看</span>';
					htmlContents += "&nbsp;&nbsp;";
					htmlContents = htmlContents+'<span style="color:blue;cursor:pointer;" onclick="toEdit(\''+_row.docutmentInfoId+'\','
					+'\''+_row.docutmentHeadDataId+'\',\''+_row.docutmentBodyDataId+'\',\''+_row.docutmentInfoName+'\');">编辑</span>';
					htmlContents += "&nbsp;&nbsp;";
					htmlContents +='<span style="color:blue;cursor:pointer;" onclick="window.open(\'${pageContext.request.contextPath}/contractDownload/downloadContract/' +_row.docutmentInfoId+ '\');">下载</span>';
			    return htmlContents;
	       }},
	       
		],
		resizable : false, //resizable table是否可伸缩
		usepager : true,
		useRp : true,
		usepager : true, //是否分页
		autoload : false, //自动加载，即第一次发起ajax请求
		hideOnSubmit : true, //是否在回调时显示遮盖
		showcheckbox : true, //是否显示多选框
/* 		rowhandler : rowDbclick, //是否启用行的扩展事情功能,在生成行时绑定事件，如双击，右键等 */
		rowbinddata : true,
		numCheckBoxTitle : "<spring:message code='common.selectall'/>"
	});	
	query();
	
	$("#detail").dialog({
		title:'查看标题 ',
		autoOpen:false,
		width:$(window).width()-4,
		height:$(window).height()+2,
		modal:true,
		resizable:false,
		close:function(){
			$(this).dialog('close');
		}
	});

	$("#addBtn").click(function( event ) {
        $("#addNewContractDialog").dialog( "open" ).find('iframe');
	});

		$("#editor").dialog({
		title:'查看标题 ',
		autoOpen:false,
		width:$(window).width()-4,
		height:$(window).height()+2,
		modal:true,
		resizable:false,
		
		/* close:function(){
			$(this).dialog('close');
		} */
	
	});
	$( "#addNewContractDialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: '增加页面',
		buttons: [
			{
				text: "确定",
				click : function() {
					var headDataId = $("#headDataId").val();
					var docutmentInfoName = $("#docutmentInfoName").val();
					var src='${pageContext.request.contextPath}/contract/newContractInfo';
					src=src+'?headDataId='+headDataId;
					$('#detail').dialog({
						title:"新建页面"
					}).dialog('open').find('iframe').attr('src',src);
					$( this ).dialog( "close" );
				}
			},
			{
				text: "取消",
				click: function() {
					$( this ).dialog( "close" );
				}
			}
		]
	});

	$("#delBtn").click(function( event ) {
		
		var infoID = searchTableColumn($("#flexiGridID"),0);
		if(infoID.length == 1){
			$.ajax({
				type : 'POST',
				url : '${pageContext.request.contextPath}/contractDelete/delContractInfo',
				dataType : 'json',
				cache : false,
				data : [ {
					name : 'infoID',
					value : infoID
				}],
				success : function(data) {
					$('#flexiGridID').flexReload();
					message(data.msg);
				    
				},
				error : function() {
					message("<spring:message code='please.contact.the.administrator'></spring:message>");
				}
			});
			
		}else{
			
			message("<spring:message code='record.select.one'></spring:message> ！");
		}
	});
});
function query(param1){
	$('#flexiGridID').flexOptions({
		newp: 1,
		extParam: param1||[],
    	url: '${pageContext.request.contextPath}/contract/getContractlist'
    }).flexReload();
}


function toEdit(ID,headID,bodyID,name){
	var src='${pageContext.request.contextPath}/contract/editContract?docutmentInfoId='+ID;
	src=src+'&docutmentHeadDataId='+headID;
	src=src+'&docutmentBodyDataId='+bodyID;
	$('#detail').dialog({
		title:name
	}).dialog('open').find('iframe').attr('src',src);
}


function toQuery(ID,headID,bodyID,name){
	var src='${pageContext.request.contextPath}/contract/queryDetail?docutmentInfoId='+ID;
	src=src+'&docutmentHeadDataId='+headID;
	src=src+'&docutmentBodyDataId='+bodyID;
	$('#detail').dialog({
		title:name
	}).dialog('open').find('iframe').attr('src',src);
}

</script>


</head>
<body>
<input  type="text" size="50" />
<a href="#"  class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-search"></span>搜索</a>
<a href="#" id="addBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-plus"></span>新建合同</a>

<a href="#" id="delBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-minusthick"></span><spring:message code='delete'/></a>
    <div class="tbl">
         <table id="flexiGridID" style="display: block;margin: 0px;"></table>
    </div>
    
    <div id="detail" style="display:none"> 
      <iframe width="100%" height="100%" frameborder="no"> </iframe>
    </div>
    
    <div id="addNewContractDialog" style="display:none;">
    
		<table>
			<tr>
				<td class="fileName"><label>选择模板</label></td>
				<td class="fileValue">
				  <rsrs:Foreach selectName="docutmentInfoName" selectId="headDataId" baseSelectBean="${contractlist}"/>
				</td>
			</tr>
		</table>
	</div>
    <div id="editor" style="display:none"> 
      <iframe width="100%" height="100%" frameborder="no"> </iframe>
    </div>
</body>
</html>