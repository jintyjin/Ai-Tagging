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
#type {
	margin-bottom:20px;
	margin-left:1px;
}
.type {
	font-weight:normal;
}
.type:hover {
	cursor:pointer;
	color:#1C97EA;
}
.active {
	font-weight:bolder;
	text-decoration:underline;
}
.btnDiv {
	width:1112px;
	margin-right:auto;
	margin-left:auto;
	text-align:right;
	padding-right:15px;
}
.button_check {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0; margin-right:20px;
	padding:0;
	border:1px solid #35353A;
}
.check {
	width:14px;
	height:14px;
	font-size:14px;
	font-weight: bold;
	margin-right:8px;
}
.button_check:hover {
	color:#1c97ea;
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
	$('.type').click(function () {
		$('#type').find('.active').removeClass('active');
		$(this).removeClass("active");
		$(this).addClass("active");
	});
	
	var jsonUrl = "/networkSpeakerSetup";
	var obj = new Object();
	
	obj.login_id = JSON.parse(get('userdata')).user_id;
	obj.dev_type = 'ipc';
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",
		data : jsonData,        		     		 
		success: function(data) {
			var source = {
				dataType : "json",
				localdata: data,
				datafields: [
		        	{ name: 'network_idx', type: 'string'},
		        	{ name: 'network_title', type: 'string'},
		        	{ name: 'network_ip', type: 'string'},	
		        	{ name: 'network_port', type: 'string'},	
		        	{ name: 'network_id', type: 'string'},	
		        	{ name: 'network_pwd', type: 'string'},	
		        	{ name: 'network_falldown', type: 'string'},	
		        	{ name: 'network_fire', type: 'string'},	
		        	{ name: 'network_flood', type: 'string'},	
		        	{ name: 'network_glove', type: 'string'},	
		        	{ name: 'network_invasion', type: 'string'},	
		        	{ name: 'network_leak', type: 'string'},	
		        	{ name: 'network_loitering', type: 'string'},	
		        	{ name: 'network_handaction', type: 'string'},  	
		        	{ name: 'network_spin', type: 'string'},
		        	{ name: 'network_cmtank', type: 'string'},
		        	{ name: 'network_outtank', type: 'string'},
		        	{ name: 'network_overflow', type: 'string'}
				]
			};
			
			var dataAdapter = new $.jqx.dataAdapter(source);
			
		    $("#jqxgrid").jqxGrid({
		    	width: '1110px',
				source: dataAdapter,
				height: 600,
				theme: 'metrodark',
				sortable: true,
				selectionmode: 'singlerow',
				showfilterrow: true,
				filterable: true,
				editable: false,
				ready: function () {  
				},
		        columns: [
		            { text: getTranslate('idx'), datafield: 'network_idx', width: '10%', editable: false, hidden:true},
		            { text: getTranslate('speakerName'), datafield: 'network_title', width: '25%', editable: false,},
		            { text: getTranslate('speakerIP'), datafield: 'network_ip', width: '25%', editable: false, },
		            { text: getTranslate('speakerPort'), datafield: 'network_port', width: '25%', editable: false, },
		            { text: getTranslate('speakerID'), datafield: 'network_id', width: '25%', editable: false, },
		            { text: getTranslate('speakerPassword'), datafield: 'network_pwd', width: '10%', editable: false, hidden:true}
		        ]
		    });
		    
			$('.addButton').append('<button class="button_check" onclick="addInfo();"><span class="glyphicon glyphicon-plus check" aria-hidden="true"></span>' + getTranslate('add') + '</button>');
			
			//$('#type').show();
			$('#jqxgrid').show();
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});
	
	$('#modify').click(function() {
        var args = event.args;
        var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');

        if (rowindex != -1) {
            var offset = $("#jqxgrid").offset();
            var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', rowindex);
            var speakerIdx = dataRecord.network_idx;
            popup_window[POPUP_MORE] = openWindow('./addNetworkSpeaker.htm?status=modify&speakerIdx=' + speakerIdx, 'addNetworkSpeaker', 1400, 1200);
        }
	});
	
	$('#delete').click(function() {
        var args = event.args;
        var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
        if (rowindex != -1) {
            var offset = $("#jqxgrid").offset();
            var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', rowindex);
            var speakerIdx = dataRecord.network_idx;
            
        	var jsonUrl = "/deleteNetworkSpeaker";
        	var obj = new Object();
        	obj.idx = speakerIdx;
        		
        	var jsonData = JSON.stringify(obj);
        	
        	$.ajax({
        		type : "POST",                        	 	     
        		url : jsonUrl,                      		
        		dataType : "json",                        	  
        		contentType : "application/json; charset=UTF-8",
        		data : jsonData,        		     		 
        		success: function(data) {
           			location.reload();
        		},
        		error: function(errorThrown) {
        			alert(errorThrown.statusText);
        		}
        	});
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
	var url = "./addNetworkSpeaker.htm?status=add";

	if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed)
		popup_window[POPUP_MORE].close();

	popup_window[POPUP_MORE] = openWindow(url, url, 1400, 1200);
}
function chkType(type) {
	$('#jqxgrid').jqxGrid('clear');

	var jsonUrl = "/deviceListByType";
	var obj = new Object();
	
	obj.login_id = JSON.parse(get('userdata')).user_id;
	obj.dev_type = type;
		
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",
		data : jsonData,        		     		 
		success: function(data) {
			if (data.length > 0) {
				for (var i = 0; i < data.length; i++) {
					var row = { 
							dev_idx: data[i].dev_idx, 
							dev_type: data[i].dev_type, 
							dev_ch: data[i].dev_ch, 
							dev_title: data[i].dev_title, 
							dev_model_name: data[i].dev_model_name,
							dev_ip: data[i].dev_ip, 
							dev_web_port: data[i].dev_web_port,
							dev_isconnect: data[i].dev_isconnect
					};
					//var rows = $('#jqxgrid').jqxGrid('getrows');
					//var rowID = $('#jqxgrid').jqxGrid('getrowid', rows.length-1);
					$('#jqxgrid').jqxGrid('addrow', null, row);
				}
			}
			$('#type').show();
			$('#jqxgrid').show();
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
		}
	});
}
</script>
</head>
<body onunload="closePopupChild();" style="background-color:#252525;">
	<div id="Progress_Loading" style="text-align:-webkit-center;"> <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" style="width:30%; margin-top:70px;" alt="loading"/>
	</div>
<div class="container" style="overflow:auto;margin-top:70px;margin-bottom:10px;">
	<div id="type">
		<span id="ipc" class="type active" onclick="chkType('ipc');">ipc</span>
		/
		<span id="nvr" class="type" onclick="chkType('nvr');">nvr</span>
	</div>
	<div id="jqxgrid"></div>
</div>
<div class="btnDiv">
	<button class="button_check" onclick="addInfo();">
		<span class="glyphicon glyphicon-plus check" aria-hidden="true"></span><spring:message code="common.add" />
	</button>
	<button class="button_modify" id="modify">
		<span class="glyphicon glyphicon-edit modify" aria-hidden="true"></span><spring:message code="common.modify" />
	</button>
	<button class="button_delete" id="delete">
		<span class="glyphicon glyphicon-trash delete" aria-hidden="true"></span><spring:message code="common.delete" />
	</button>
</div>
</body>
</html>