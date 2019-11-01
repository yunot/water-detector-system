<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 合同导入</title>


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
	resizePageSize();
	var _columnWidth= (_gridWidth-150)/7;
	
	$("#flexiGridID").flexigrid({
		width : _gridWidth,
		height : _gridHeight,
		url : "${pageContext.request.contextPath}/file/getFilelist",
		dataType : 'json',
		colModel : [ 
		   {display : 'ID',name : 'fileId',width : 150,sortable : false,align : 'center',hide : 'true'}, 
	       {display : "合同名称",name : 'fileName',width : _columnWidth, sortable : true,align : 'center'}, 
	       {display: "操作", name: 'fileId', width: _columnWidth, sortable: false, align: 'center', process: function(v,_trid,_row) {
				var htmlContents = 	'<span style="color:blue;cursor:pointer;" onclick="window.open(\'${pageContext.request.contextPath}/file/download/' + _row.fileId + '\');">下载</span>';
				htmlContents += "&nbsp;	&nbsp;";
				htmlContents = htmlContents +'<span style="color:blue;cursor:pointer;" onclick="toDelete(\'' + _row.fileId + '\'';
				htmlContents = htmlContents + ');"><spring:message code="common.del"/></span>';
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
	
	$("#addBtn").click(function( event ) {
        //message("增加页面");
        $("#addFileDialog").dialog( "open" );
        
	});
	
	var srcFile = $("#srcFile");
	//allFields.removeClass("ui-state-error");
	$( "#addFileDialog" ).dialog({
		autoOpen : false,
		width : 400,
		modal : true,
		resizable : false,
		title: '增加页面',
		buttons: [
			{
				text: "确定",
				click: function() {	
					var valt = srcFile.val(); 
					if(valt.length==0){
						message("请选择文件");
						return;
					} 
					/*
					if(srcFile.length==0){
						message("请选择文件");
						return;
					}
					*/
					$("#uploadContractForm").submit();
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
	
	$('#uploadContractForm').ajaxForm({
		dataType: "json",
		success : function(data) {
			$('#uploadContractForm').resetForm();
			message(data.msg);
			query();
			$("#addFileDialog").dialog( "close" )
	     },
	     error : function() {
	        message("请联系管理员");
	     },
		complete : function(response, status) {
	     
		}
	});
	
	
	$("#detail").dialog({
		title:'查看标题 ',
		autoOpen:false,
		width:$(window).width()-4,
		height:$(window).height()+2,
		modal:true,
		resizable:false,
		buttons:{
			
		},
		close:function(){
			$(this).dialog('close');
		}
	});
	
});
function query(param1){
	$('#flexiGridID').flexOptions({
		newp: 1,
		extParam: param1||[],
    	url: '${pageContext.request.contextPath}/file/getFilelist'
    }).flexReload();
}

function toDelete(fileId){

			$.ajax({
				type : 'POST', 
	            url : '${pageContext.request.contextPath}/file/deleteFile',   
	            dataType : 'json',  
	            cache : false,
	            data : [{name : 'fileId', value : fileId}],
	            success : function(data) {
	            	//不管成功还是失败，刷新列表
	            	$(".pReload").click();
	            	//弹出提示信息
			    	message(data.msg);
	            },
	            error : function () {
	            	message({
	            		html: '<spring:message code="common.op.error"/>',
	            		showConfirm: true
	            	});
		        }
			});

}
</script>			

</head>
<body>
<input  type="text" size="50" />
<a href="#"  class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-search"></span>搜索</a>
<a href="#" id="addBtn" class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-plus"></span>增加</a>
<a href="#"  class="ui-state-default ui-corner-all cbe-button"><span class="ui-icon ui-icon-minusthick"></span>删除</a>
    <div class="tbl">
         <table id="flexiGridID" style="display: block;margin: 0px;"></table>
    </div>
    
    <div id="detail" style="display:none"> 
      <ifram > </ifram>
    </div>
	<div id="addFileDialog" style="display: none;">
		<form id="uploadContractForm" action="${pageContext.request.contextPath}/contractUpload/addContract" method="post" enctype="multipart/form-data">
			<input type="file" id="srcFile" name="srcFile" accept="application/msword" />
		</form>  
	</div>
				
</body>
</html>