<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@taglib prefix="rsrs" uri="http://www.project.com/myTag/resource" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/jquery-ui-1.9.2.custom/css/redmond/jquery-ui-1.9.2.custom.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/grid/css/flexigrid2.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/common.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/Font-Awesome-master/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/zTree3.3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/static/images/logo-top.ico" type="image/x-icon"/>
<script language="javascript" type="text/javascript" src="${pageContext.request.contextPath}/static/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/grid/js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/grid/js/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/grid/js/jquery.flexigrid.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.js"></script>
<script src="${pageContext.request.contextPath}/static/amcharts_3.1.1/amcharts/amcharts.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/amcharts_3.1.1/amcharts/gauge.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/amcharts_3.1.1/amcharts/serial.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/amcharts_3.1.1/amcharts/pie.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/zTree3.3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/zTree3.3/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript">
var i18n_flexigrid_queryFail = "<spring:message code='flexigrid.tip.queryFail' />";
var i18n_flexigrid_recordDisplayFromTo = "<spring:message code='flexigrid.tip.recordDisplayFromTo' />";
var i18n_flexigrid_loading = "<spring:message code='flexigrid.tip.loading' />";
var i18n_flexigrid_noRecord = "<spring:message code='flexigrid.tip.noRecord' />";
var i18n_flexigrid_toFirstPage = "<spring:message code='flexigrid.tip.toFirstPage' />";
var i18n_flexigrid_toPreviousPage = "<spring:message code='flexigrid.tip.toPreviousPage' />";
var i18n_flexigrid_currentPage = "<spring:message code='flexigrid.tip.currentPage' />";
var i18n_flexigrid_totalPage = "<spring:message code='flexigrid.tip.totalPage' />";
var i18n_flexigrid_toNextPage = "<spring:message code='flexigrid.tip.toNextPage' />";
var i18n_flexigrid_toLastPage = "<spring:message code='flexigrid.tip.toLastPage' />";
var i18n_flexigrid_refresh = "<spring:message code='flexigrid.tip.refresh' />";
var i18n_flexigrid_everyPageCount = "<spring:message code='flexigrid.tip.everyPageCount' />";
var i18n_flexigrid_quickSearch = "<spring:message code='flexigrid.tip.quickSearch' />";
var i18n_flexigrid_queryError = "<spring:message code='flexigrid.tip.queryError' />";


//时间控件国际化
$.datepicker.setDefaults($.datepicker.regional['zh-CN']);

$(function(){
	
	$( ".cbe-button" ).hover(
			function() {
				$( this ).addClass( "ui-state-hover" );
			},
			function() {
				$( this ).removeClass( "ui-state-hover" );
			}
	);



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


});

function message(contends)
{
	$("#dialog").html(contends);
	$( "#dialog" ).dialog( "open" );

}

function searchTableColumn(obj,index){
	var ids = [];
	var selected = obj.find("tr.trSelected");
	selected.each(function(){
		var contents = $(this).attr("ch");
		var columnVal =contents.split("_FG$SP_");
		ids[ids.length] = columnVal[index];
	});
	return ids;
}


(function( $ ) {
    $.widget( "ui.combobox", {
        _create: function() {
            var self = this,
                select = this.element.hide(),
                selected = select.children( ":selected" ),
                value = selected.val() ? selected.text() : "";
            var input = this.input = $( "<input>" )
                .insertAfter( select )
                .val( value )
                .autocomplete({
                    delay: 0,
                    minLength: 0,
                    source: function( request, response ) {
                        var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
                        response( select.children( "option" ).map(function() {
                            var text = $( this ).text();
                            if ( this.value && ( !request.term || matcher.test(text) ) )
                                return {
                                    label: text.replace(
                                        new RegExp(
                                            "(?![^&;]+;)(?!<[^<>]*)(" +
                                            $.ui.autocomplete.escapeRegex(request.term) +
                                            ")(?![^<>]*>)(?![^&;]+;)", "gi"
                                        ), "<strong>$1</strong>" ),
                                    value: text,
                                    option: this
                                };
                        }) );
                    },
                    select: function( event, ui ) {
                        ui.item.option.selected = true;
                        self._trigger( "selected", event, {
                            item: ui.item.option
                        });
                        select.trigger("change");
                    },
                    change: function( event, ui ) {
                        if ( !ui.item ) {
                            var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
                                valid = false;
                            select.children( "option" ).each(function() {
                                if ( $( this ).text().match( matcher ) ) {
                                    this.selected = valid = true;
                                    return false;
                                }
                            });
                            if ( !valid ) {
                                // remove invalid value, as it didn't match anything
                                $( this ).val( "" );
                                select.val( "" );
                                input.data( "autocomplete" ).term = "";
                                return false;
                            }
                        }
                    }
                })
                .addClass( "ui-widget ui-widget-content ui-corner-left" );

            input.data( "autocomplete" )._renderItem = function( ul, item ) {
                return $( "<li></li>" )
                    .data( "item.autocomplete", item )
                    .append( "<a>" + item.label + "</a>" )
                    .appendTo( ul );
            };

            this.button = $( "<button type='button'>&nbsp;</button>" )
                .attr( "tabIndex", -1 )
                .attr( "title", "Show All Items" )
                .insertAfter( input )
                .button({
                    icons: {
                        primary: "ui-icon-triangle-1-s"
                    },
                    text: false
                })
                .removeClass( "ui-corner-all" )
                .addClass( "ui-corner-right ui-button-icon" )
                .click(function() {
                    // close if already visible
                    if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
                        input.autocomplete( "close" );
                        return;
                    }

                    // pass empty string as value to search for, displaying all results
                    input.autocomplete( "search", "" );
                    input.focus();
                });
        },

        destroy: function() {
            this.input.remove();
            this.button.remove();
            this.element.show();
            $.Widget.prototype.destroy.call( this );
        }
    });
})( jQuery );


/**
 * 校验长度
 * @param o 要校验的对象
 * @param min 最小长度
 * @param max 最大长度
 * @returns {Boolean} true：校验通过，false：校验失败。
 */
function checkLength( o, min, max ) {
	var _temp = o;
	if(o[0].tagName === 'SELECT' && $(o).data("combobox")) {
		_temp = o.next().find('input');
	}
	if ( $.trim(o.val()).length > ( max || 9999 ) || $.trim(o.val()).length < min ) {
		_temp.addClass( "ui-state-error" ).focus();
		return false;
	} else {
		_temp.removeClass( "ui-state-error" );
		return true;
	}
}

//校验是否是数字和小数
function checkDecimals(objField)
{
	  var patrn=/^([\d]+)([.]?)([\d]*)$/;

	  if (patrn.test(objField.val()))
	  {
		  objField.removeClass( "ui-state-error" );
		  return true;
	  }
	  else
	  {
		  objField.addClass( "ui-state-error" ).focus();
		  return false;
	  }
}

function checkEmpty(o,emptyValue) {
	var _temp = o;
	if(o[0].tagName === 'SELECT' && $(o).data("combobox")) {
		_temp = o.next().find('input');
	}
	if((emptyValue != null && $.trim(o.val()) == emptyValue) || $.trim(o.val()).length < 1){
		_temp.addClass( "ui-state-error" ).focus();
		return false;
	} else {
		_temp.removeClass( "ui-state-error" );
		return true;
	}
}

function checkLimit(o, min, max) {
	var v = $.trim(o.val()), flag = true;
	if(!v || isNaN(v)) {
		flag = false;
	} else {
		v = parseInt(v);
		//校验最小值
		if(flag && min != undefined){
			flag = !(v < min)
		}
		//校验最大值
		if(flag && max != undefined){
			flag = !(v > max)
		}
	}

	if(!flag) {
		o.addClass( "ui-state-error" ).focus();
	}else{
		o.removeClass( "ui-state-error" );
	}

	return flag;
}


/**
 * 校验正则
 * @param o 要校验的对象
 * @param regexp 要校验的正则
 * @param n 校验失败的提示语，可选
 * @returns {Boolean} true：校验通过，false：校验失败。
 */
function checkRegexp( o, regexp, n ) {
	if ( !( regexp.test( o.val() ) ) ) {
		o.addClass( "ui-state-error" );
		if(n && n != "")
		{
			o.attr("title",n);
		}
		o.focus();
		return false;
	} else {
		o.removeClass( "ui-state-error" );
		return true;
	}
}

/**
 * 检查端口
 * @param o 要校验的对象
 * @param n 校验失败的提示语，可选
 * @returns {Boolean} true：校验通过，false：校验失败。
 */
function checkPort(o, n)
{
	//先校验正则通过，值不大于65535
	if (checkLength(o, 1, 5) && checkRegexp(o, /^\d+$/, n) && o.val() < 65536 && o.val() > 0)
	{
		o.removeClass( "ui-state-error" );
		return true;
	}
	else
	{
		o.addClass( "ui-state-error" );
		if(n && n != "")
		{
			o.attr("title",n);
		}
		o.focus();
		return false;
	}
}


</script>
</head>
<body>
	<!-- ui-dialog -->
	<div id="dialog" style="display: none;">
	</div>

</body>
</html>