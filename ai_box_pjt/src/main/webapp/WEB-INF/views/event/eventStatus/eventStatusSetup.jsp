<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metro.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.dark.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxcore.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxdata.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxbuttons.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxscrollbar.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxmenu.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.selection.js"></script> 
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.columnsresize.js"></script> 
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.pager.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxcheckbox.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxlistbox.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxdropdownlist.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxdatetimeinput.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxcalendar.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.sort.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.filter.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.edit.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxwindow.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxdata.export.js"></script> 
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.export.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxexport.js"></script> 
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<style>
body {
	background-color: #252525;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:white;
	line-height: 1.5;
}
.jqxgrid-center-jin {
	overflow: hidden; 
	text-overflow: ellipsis; 
	text-align: center; 
	line-height: 32px;
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
	color:#fff;
}
.jqx-widget-content-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:#fff;
}
.jqx-widget-content-metrodark:placeholder {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:#fff;
}
</style>
<script type="text/javascript">
function isEmpty(str) {
	if(typeof str === "undefined" || str === null || str == "" || str == "undefined")
		return true;
	else
		return false;
}
function get(key) {
	return sessionStorage.getItem(key);
}
var POPUP_MORE = 0;

var popup_window = new Array();
$(document).ready(function () {
	var jsonUrl = "/eventStatusSetup";

	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
	    success: function(data) {
	    	for (var i = 0; i < data.length; i++) {
	    		var event_name = data[i].model_name;
	    		console.log(event_name);
	    		var action = '';

				if (event_name.toLowerCase() == 'KWATER_Fire_Detection'.toLowerCase()) {
					action = '화재';
				}
				if (event_name.toLowerCase() == 'KWATER_Falldown_Detection'.toLowerCase()) {
					action = '쓰러짐';
				}
				if (event_name.toLowerCase() == 'KWATER_Flood_Detection'.toLowerCase()) {
					action = '침수';
				}
				if (event_name.toLowerCase() == 'KWATER_Glove_Detection'.toLowerCase()) {
					action = '장갑미착용';
				}
				if (event_name.toLowerCase() == 'KWATER_Invasion_Detection'.toLowerCase()) {
					action = '침입';
				}
				if (event_name.toLowerCase() == 'KWATER_Leak_Detection'.toLowerCase()) {
					action = '누수';
				}
				if (event_name.toLowerCase() == 'KWATER_Loitering_Detection'.toLowerCase()) {
					action = '배회';
				}
				if (event_name.toLowerCase() == 'KWATER_HandAction_Detection'.toLowerCase()) {
					action = '수신호';
				}
				if (event_name.toLowerCase() == 'KWATER_Spin_Detection'.toLowerCase()) {
					action = '약품미투입';
				}
				if (event_name.toLowerCase() == 'kwater_cmtank_leak'.toLowerCase()) {
					action = '약품탱크누액';
				}
				if (event_name.toLowerCase() == 'kwater_outtank_leak'.toLowerCase()) {
					action = '옥외탱크누액';
				}
				if (event_name.toLowerCase() == 'kwater_overflow'.toLowerCase()) {
					action = '배출수월류';
				}
				
				data[i].action = action;
	    	}
	    	
			var source = {
				dataType : "json",
				localdata: data,
				datafields: [
		        	{ name: 'action_source', type: 'string'},
		        	{ name: 'event_action', type: 'string'},
		        	{ name: 'dev_ch', type: 'string'},
		        	{ name: 'dev_title', type: 'string'},
		        	{ name: 'model_name', type: 'string'},
		        	{ name: 'pre_title', type: 'string'},
		        	{ name: 'dev_ip', type: 'string'},
		        	{ name: 'event_time', type: 'string'},
		        	{ name: 'dev_id', type: 'string'},
		        	{ name: 'dev_pwd', type: 'string'},
		        	{ name: 'login_id', type: 'string'},
		        	{ name: 'dev_web_port', type: 'string'},
		        	{ name: 'dev_mac_address', type: 'string'},
		        	{ name: 'action', type: 'string'}
				]
			};
				
			var dataAdapter = new $.jqx.dataAdapter(source);
			
			$("#grid").jqxGrid( {
				width: '100%',
				source: dataAdapter,
				height: 510,
				theme: 'metrodark',
				selectionmode: 'singlerow',
				//showfilterrow: true,
                sortable: true,
                filterable: true,
                filtermode: 'excel',
                columnsresize: true,
                autoshowfiltericon: true,
				editable: true,
				columns: [
					{ text: '이벤트 소스', datafield: 'action_source', width: '15%', editable: false },
					{ text: '장치 이름', datafield: 'dev_title', width: '15%', editable: false },
					{ text: 'IP/DDNS', datafield: 'dev_ip', width: '8%', editable: false, hidden:true },
					{ text: '이벤트', datafield: 'model_name', width: '18%', editable: false, hidden:true },
					{ text: '이벤트', datafield: 'action', width: '16%', editable: false },
					{ text: '동작', datafield: 'event_action', width: '10%', editable: false },
					{ text: '발생 시간', datafield: 'event_time', width: '28%', editable: false },
					{ datafield: 'dev_ch', editable: false, hidden:true },
					{ datafield: 'dev_id', editable: false, hidden:true },
					{ datafield: 'dev_pwd', editable: false, hidden:true },
					{ datafield: 'login_id', editable: false, hidden:true },
					{ datafield: 'dev_web_port', editable: false, hidden:true },
					{ datafield: 'dev_mac_address', editable: false, hidden:true },
					/* 
					{ datafield: 'dev_pwd', editable: false, hidden:true },
					{ datafield: 'dev_port', editable: false, hidden:true },
					{ datafield: 'dev_web_port', editable: false, hidden:true }, */
					{ text: '실행', columntype: 'button', align: 'center', width: '8%', editable: false, sortable: false, filterable: false, cellsrenderer: function (row) {
						var rowData = $('#grid').jqxGrid('getrowdata', row);
						
						var word = "무시";
						
						if (rowData.event_action == '프리셋') {
							word = "이동";
						}
						
						return word;
					},
					buttonclick: function (row) {
						var rowData = $('#grid').jqxGrid('getrowdata', row);
						//rowData.preset_name = "khome";
						rowData.pre_title = "khome";
						
						if (rowData.event_action == '프리셋') {
							var jsonUrl = "/runEventAction";
							var jsonData = JSON.stringify(rowData);
								
							$.ajax({
								type : "POST",                        	 	     
								url : jsonUrl,                      		
								dataType : "json",                        	  
								contentType : "application/json; charset=UTF-8",       
								data : jsonData,          		     		 
								success: function(data) {
									location.reload();
									//deleteRow(row);
								},
								error: function(errorThrown) {
								}
							});
						} else {
							if (get('userdata') != null) {
								if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed) {
									popup_window[POPUP_MORE].close();
								}
								var dev_ch = rowData.dev_ch;
								var dev_title = rowData.dev_title;
								var model_name = rowData.model_name;
								var event_time = rowData.event_time;
								
								popup_window[POPUP_MORE] = openWindow('/rejectTimeSetup?row=' + row + '&dev_ch=' + dev_ch + '&dev_title=' + dev_title + '&model_name=' + model_name + '&event_time=' + event_time, 'rejectTimeSetup', 200, 200);	// 1280 + 16, 720 + 68	
							}
						}
					}},
					{ text: '취소', columntype: 'button', align: 'center', width: '8%', editable: false, sortable: false, filterable: false, cellsrenderer: function () {
						return '삭제';
					},
					buttonclick: function (row) {
						var rowData = $('#grid').jqxGrid('getrowdata', row);
						
						var jsonUrl = "/cancelEventAction";
						var jsonData = JSON.stringify(rowData);

						$.ajax({
							type : "POST",                        	 	     
							url : jsonUrl,                      		
							dataType : "json",                        	  
							contentType : "application/json; charset=UTF-8",       
							data : jsonData,          		     		 
							success: function(data) {
								location.reload();
								//deleteRow(row);
							},
							error: function(errorThrown) {
							}
						});
					}}
				]
			});
			
	    },
		error: function(errorThrown) {
			/* alert(errorThrown.statusText);
			alert(jsonUrl); */
		}
	});
	
	var websocketUrl = '/websocket';
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/receiveEventStatus', function (message) {
			var obj = JSON.parse(message.body);
			var action_source = obj.action_source;
			var dev_ch = obj.dev_ch;
			var model_name = obj.model_name;
			var event_action = obj.event_action;
			var event_time = obj.event_time;
			
			if (!obj.isPresent) {
				var rows = $('#grid').jqxGrid('getrows');
				for (var i = 0; i < rows.length; i++) {
					if (rows[i].action_source == action_source && rows[i].dev_ch == dev_ch && rows[i].model_name == model_name
							&& rows[i].event_action == event_action) {
						$("#grid").jqxGrid('setcellvalue', i, "event_time", event_time);
					}
				}
			} else {
	    		var action = '';
	    		var event_name = obj.model_name;

				if (event_name.toLowerCase() == 'KWATER_Fire_Detection'.toLowerCase()) {
					action = '화재';
				}
				if (event_name.toLowerCase() == 'KWATER_Falldown_Detection'.toLowerCase()) {
					action = '쓰러짐';
				}
				if (event_name.toLowerCase() == 'KWATER_Flood_Detection'.toLowerCase()) {
					action = '침수';
				}
				if (event_name.toLowerCase() == 'KWATER_Glove_Detection'.toLowerCase()) {
					action = '장갑미착용';
				}
				if (event_name.toLowerCase() == 'KWATER_Invasion_Detection'.toLowerCase()) {
					action = '침입';
				}
				if (event_name.toLowerCase() == 'KWATER_Leak_Detection'.toLowerCase()) {
					action = '누수';
				}
				if (event_name.toLowerCase() == 'KWATER_Loitering_Detection'.toLowerCase()) {
					action = '배회';
				}
				if (event_name.toLowerCase() == 'KWATER_HandAction_Detection'.toLowerCase()) {
					action = '수신호';
				}
				if (event_name.toLowerCase() == 'KWATER_Spin_Detection'.toLowerCase()) {
					action = '약품미투입';
				}
				if (event_name.toLowerCase() == 'kwater_cmtank_leak'.toLowerCase()) {
					action = '약품탱크누액';
				}
				if (event_name.toLowerCase() == 'kwater_outtank_leak'.toLowerCase()) {
					action = '옥외탱크누액';
				}
				if (event_name.toLowerCase() == 'kwater_overflow'.toLowerCase()) {
					action = '배출수월류';
				}
				
				var row = { 
							action_source: obj.action_source, 
							event_action: obj.event_action, 
							dev_ch: obj.dev_ch, 
							dev_title: obj.dev_title, 
							model_name: obj.model_name, 
							action: action,
							pre_title: obj.pre_title, 
							dev_ip: obj.dev_ip, 
							event_time: obj.event_time,
							dev_id: obj.dev_id,
							dev_pwd: obj.dev_pwd,
							login_id: obj.login_id,
							dev_web_port: obj.dev_web_port,
							dev_mac_address: obj.dev_mac_address
						};
				$('#grid').jqxGrid('addrow', null, row, 'last');				
			}
		}); 
	});
});
function openWindow(page, pageName, width, height) {
	var popupX = (screen.availWidth - width) / 2;
	var popupY = (screen.availHeight - height) / 2;
	var scrollbars = (pageName == 'webNoticeAdd' || pageName == 'webNoticeModify') ? 'yes' : 'no';

	var popup_window = window.open(page, pageName, 'width=' + width + ', height=' + height + ', toolbar=no, location=no, status=no, menubar=no, scrollbars=' + scrollbars + ', resizable=no, left=' + popupX + ', top=' + popupY);

	//popup_window.focus();
	
	return popup_window;
}
function deleteRow(row) {
	$('#grid').jqxGrid('deleterow', row);
}
</script>
</head>
<body style="background-color:#252525;">
<div class="container" style="overflow:auto; margin-top:70px;">
		<div id="grid"></div>
</div>
</body>
</html>