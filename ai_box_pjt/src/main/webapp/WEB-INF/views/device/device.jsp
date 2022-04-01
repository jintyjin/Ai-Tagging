<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.metro.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"> -->
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/jqwidgets/jqxcore.js"></script>
<script src="./resources/js/jqwidgets/jqxdata.js"></script>
<script src="./resources/js/jqwidgets/jqxbuttons.js"></script>
<script src="./resources/js/jqwidgets/jqxscrollbar.js"></script>
<script src="./resources/js/jqwidgets/jqxmenu.js"></script>
<script src="./resources/js/jqwidgets/jqxgrid.js"></script>
<script src="./resources/js/jqwidgets/jqxgrid.selection.js"></script> 
<script src="./resources/js/jqwidgets/jqxgrid.columnsresize.js"></script> 
<script src="./resources/js/jqwidgets/jqxgrid.pager.js"></script>
<script src="./resources/js/jqwidgets/jqxdropdownlist.js"></script>
<script src="./resources/js/jqwidgets/jqxdatetimeinput.js"></script>
<script src="./resources/js/jqwidgets/jqxcheckbox.js"></script>
<script src="./resources/js/jqwidgets/jqxlistbox.js"></script>
<script src="./resources/js/jqwidgets/jqxcalendar.js"></script>
<script src="./resources/js/jqwidgets/jqxgrid.sort.js"></script>
<script src="./resources/js/jqwidgets/jqxgrid.filter.js"></script>
<script src="./resources/js/jqwidgets/jqxgrid.edit.js"></script>
<script src="./resources/js/jqwidgets/jqxwindow.js"></script>
<script src="./resources/js/jqwidgets/jqxdata.export.js"></script> 
<script src="./resources/js/jqwidgets/jqxgrid.export.js"></script>
<script type="text/javascript" src="/resources/js/translate.js"></script>
<style>
body {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
	line-height: 1.5;
}
button {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
	line-height: 1.5;
}
button:focus {
	outline:none;
}
.excelExport {
	width:110px;
	height:30px;
	background-color:transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.excelExport:hover {
	color:#1c97ea;
}
.jqx-fill-state-normal-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.jqx-fill-state-hover-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.jqx-grid-metrodark .jqx-widget-header-metrodark, .jqx-grid-column-header-metrodark, .jqx-grid-cell-metrodark, .jqx-widget-metrodark .jqx-grid-cell-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.jqxgrid-center-jin {
	overflow: hidden; 
	text-overflow: ellipsis; 
	text-align: center; 
	line-height: 32px;
}
.btnDiv {
	width:1112px;
	margin-right:auto;
	margin-left:auto;
	text-align:right;
	padding-right:15px;
}
.button_modify {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
	margin-right:20px;
}
.modify {
	width:12px;
	height:14px;
	font-size:14px;
	font-weight:bold;
	margin-right:8px;
}
.button_modify:hover {
	color:#1c97ea;
}
.modify:active {
	box-shadow: 0 #666;
}
.button_delete {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.delete {
	width:12px;
	height:14px;
	font-size:14px;
	font-weight:bold;
	margin-right:8px;
}
.button_delete:hover {
	color:#1c97ea;
}
.delete:active {
	box-shadow: 0 #666;
}
</style>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
function openWindow(page, pageName, width, height) {
	var popupX = (screen.availWidth - width) / 2;
	var popupY = (screen.availHeight - height) / 2;
	var scrollbars = (pageName == 'webNoticeAdd' || pageName == 'webNoticeModify') ? 'yes' : 'no';

	var popup_window = window.open(page, pageName, 'width=' + width + ', height=' + height + ', toolbar=no, location=no, status=no, menubar=no, scrollbars=' + scrollbars + ', resizable=yes, left=' + popupX + ', top=' + popupY);

	return popup_window;
}
function setDevice(device) {
	sessionStorage.setItem('device', device);
}
$(document).ready(function(){
	$('#Progress_Loading').hide(); //첫 시작시 로딩바를 숨겨준다.
	$('#as_count').hide();
	$('#excelExport').hide();
	$('.button_check').hide();
	$('#type').hide();
})
.ajaxStart(function(){
	$('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.
	$('#as_count').hide();
	$('#excelExport').hide();
	$('.button_check').hide();
	$('#type').hide();
	$('#jqxgrid').hide();
})
.ajaxStop(function(){
	$('#Progress_Loading').hide(); //ajax종료시 로딩바를 숨겨준다.
	$('#as_count').show();
	//$('#excelExport').show();
	$('.button_check').show();
});

var POPUP_MORE = 0;

var popup_window = new Array();
var tmp = [];
$(document).ready(function () {
	if (window.parent.userId == null) {
		location.replace('/index');
	}
	if (typeof window.parent.loginUser != 'function') {
		location.replace('/index/device');
	}
	$('.type').click(function () {
		$('#type').find('.active').removeClass('active');
		$(this).removeClass("active");
		$(this).addClass("active");
	});
	
	var jsonUrl = "/deviceList";
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",
		success: function(data) {
			var source = {
				dataType : "json",
				localdata: data,
				datafields: [
		        	{ name: 'dev_idx', type: 'string'},
		        	{ name: 'dev_type', type: 'string'},
		        	{ name: 'dev_ch', type: 'string'},	
		        	{ name: 'dev_title', type: 'string'},	
		        	{ name: 'dev_ip', type: 'string'},	
		        	{ name: 'dev_web_port', type: 'string'},	
		        	{ name: 'dev_app_port', type: 'string'},	
		        	{ name: 'dev_enable_https', type: 'string'},	
		        	{ name: 'login_id', type: 'string'},	
		        	{ name: 'dev_pwd', type: 'string'},	
		        	{ name: 'dev_mac_address', type: 'string'},	
		        	{ name: 'dev_model_name', type: 'string'},	
		        	{ name: 'dev_join_time', type: 'string'} ,	
		        	{ name: 'dev_isconnect', type: 'string'}   	
				]
			};
			
			var dataAdapter = new $.jqx.dataAdapter(source);
			
		    $("#jqxgrid").jqxGrid({
		    	width: '1110px',
				source: dataAdapter,
				height: 600,
				theme: 'metrodark',
				sortable: true,
				pageable: true,
				pagesize: 15,
				pagesizeoptions: ['10', '15', '20', '50'],
				selectionmode: 'singlerow',
				showfilterrow: true,
				filterable: true,
				editable: true,
				ready: function () {  
				},
		        columns: [
		            { text: getTranslate('idx'), datafield: 'dev_idx', width: '10%', editable: false, hidden:true},
		            { text: getTranslate('device_type'), datafield: 'dev_type', width: '10%', editable: false,},
		            { text: getTranslate('device_channel'), datafield: 'dev_ch', width: '10%', editable: false, },
		            { text: getTranslate('device_title'), datafield: 'dev_title', width: '20%', editable: false, },
		            { text: getTranslate('device_model_name'), datafield: 'dev_model_name', width: '20%', editable: false, },
		            { text: getTranslate('device_ip'), datafield: 'dev_ip', width: '20%', editable: false, },
		            { text: getTranslate('device_web_port'), datafield: 'dev_web_port', width: '12%', editable: false, },
		            { text: getTranslate('device_isconnect'), datafield: 'dev_isconnect', width: '8%', editable: false, },
		            { text: getTranslate('device_login_id'), datafield: 'login_id', width: '10%', editable: false, hidden:true}
		            /* { text: 'More', columntype: 'button', align: 'center', width: '12%', editable: false, sortable: false, filterable: false, cellsrenderer: function () {
						return 'More';
					}, 
						buttonclick: function (row) {
							if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed)
								popup_window[POPUP_MORE].close();
	
							var rowData = $('#jqxgrid').jqxGrid('getrowdata', row);

							setDevice(rowData.dev_model_name);
							popup_window[POPUP_MORE] = openWindow('./deviceModify.htm?dev_ch=' + rowData.dev_ch, 'deviceModify', 1400, 880);
						}
		            } */
		        ]
		    });
		    
			if (window.parent.userId != 'admin') {
				$('.addButton').append('<button class="button_check" onclick="addInfo();"><span class="glyphicon glyphicon-plus check" aria-hidden="true"></span>추가</button>');
			}
			
			//$('#type').show();
			$('#jqxgrid').show();
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});
	var contextMenu = $("#Menu").jqxMenu({ width: 100, autoOpenPopup: false, mode: 'popup'});
    $("#jqxgrid").on('contextmenu', function () {
        return false;
    });
	/* $("#jqxgrid").on('rowclick', function (event) {
        if (event.args.rightclick) {
            $("#jqxgrid").jqxGrid('selectrow', event.args.rowindex);
            var scrollTop = $(window).scrollTop();
            var scrollLeft = $(window).scrollLeft();
            contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
            return false;
        }
    }); */
	var webSocket = new WebSocket("ws://" + "${address}");

	webSocket.onmessage = function(message) {
	// 콘솔 텍스트에 메시지를 출력한다.
		var data = JSON.parse(message.data);
		var command = data.command;
		var web_user = data.web_user;
		if (command == 'RF_SET_IPCAMERA_INFO') {
   			location.reload();
		}
	};
	
	
	$('#modify').click(function() {
        var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
        
        if (rowindex != -1) {
            var offset = $("#jqxgrid").offset();
            var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', rowindex);

    		
            //alert(dataRecord.dev_ch);
            var login_id = window.parent.userId;
            if (login_id == 'admin') {
            	login_id = dataRecord.login_id;
            }
            var dev_ch = dataRecord.dev_ch;
            popup_window[POPUP_MORE] = openWindow('./addDevice.htm?dev_ch=' + dev_ch + '&login_id=' + login_id, 'deviceModify', 1948, 880);
        }
	});
	
	$('#delete').click(function() {
        var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
        
        if (rowindex != -1) {
            var offset = $("#jqxgrid").offset();
            var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', rowindex);

       		var msg = {
    			command: 'RF_REQ_IPCAMERA_DELETE',
    			web_user: window.parent.userId,
    			sender: 'web',
    			dev_ch: dataRecord.dev_ch,
    			dev_title: dataRecord.dev_title
    		};

    		// Send the msg object as a JSON-formatted string.
    		webSocket.send(JSON.stringify(msg));

    		location.reload();
        }
        
	});
});
function closePopupChild() {
	for(var i = 0; i < popup_window.length; i++) {
		if(popup_window[i] && popup_window[i].open && !popup_window[i].closed)
			popup_window[i].close();
	}
}
function addInfo() {
	var url = "addDevice";

	if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed)
		popup_window[POPUP_MORE].close();

	popup_window[POPUP_MORE] = openWindow('./' + url + '.htm?login_id=' + window.parent.userId, url, 1400, 880);
}
</script>
</head>
<body onunload="closePopupChild();" style="background-color:#252525;">
	<div id="Progress_Loading" style="text-align:-webkit-center;"> <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" style="width:30%; margin-top:70px;" alt="loading"/>
	</div>
<div class="container" style="overflow:auto;margin-top:70px;">
	<div id="jqxgrid"></div>
	<div>
		<table style="margin-top: 10px; width: 100%">
			<tr>
				<!-- <td style="padding-left: 10px;" class="addButton"> -->
				<td style="padding-left: 10px; text-align:right;">
					<button class="excelExport" id="excelExport">Export to Csv</button>
				</td>
			</tr>
		</table>
	</div>
	<div id='Menu'>
		<ul>
			<li><spring:message code="common.modify" /></li>
			<li><spring:message code="common.delete" /></li>
		</ul>
	</div>
</div>
<div class="btnDiv">
	<button class="button_modify" id="modify">
		<span class="glyphicon glyphicon-edit modify" aria-hidden="true"></span><spring:message code="common.modify" />
	</button>
	<button class="button_delete" id="delete">
		<span class="glyphicon glyphicon-trash delete" aria-hidden="true"></span><spring:message code="common.delete" />
	</button>
</div>
</body>
</html>