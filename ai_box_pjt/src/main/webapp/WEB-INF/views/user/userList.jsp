<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
.button_check {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
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
function setUsers(rowid) {
	sessionStorage.setItem('rowid', rowid);
}
$(document).ready(function(){
	$('#Progress_Loading').hide(); //첫 시작시 로딩바를 숨겨준다.
	$('#as_count').hide();
	$('#excelExport').hide();
	$('.button_check').hide();
})
.ajaxStart(function(){
	$('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.
	$('#as_count').hide();
	$('#excelExport').hide();
	$('.button_check').hide();
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
	var jsonUrl = "/userList";
	var ascount = 0;
	var jsonData = "Y";
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",       
		data : jsonData,          		     		 
		success: function(data) {
			var arr = new Array();
			for(var i = 0; i < data.length; i++) {
				if (JSON.parse(get('userdata')).user_id == 'admin' || data[i].user_id == JSON.parse(get('userdata')).user_id) {
					ascount = ascount + 1;
					var month = data[i].user_joindate.monthValue;
					var day = data[i].user_joindate.dayOfMonth;
					
					var hour = data[i].user_joindate.hour;
					var minute = data[i].user_joindate.minute;
					var second = data[i].user_joindate.second;
					
					if (month < 10) {
						month = '0' + month;
					}
					if (day < 10) {
						day = '0' + day;
					}
					if (hour < 10) {
						hour = '0' + hour;
					}
					if (minute < 10) {
						minute = '0' + minute;
					}
					if (second < 10) {
						second = '0' + second;
					}
					
					data[i].user_joindate = data[i].user_joindate.year + '-' + month + '-' + day + " " + hour + ":" + minute + ":" + second;

					month = data[i].user_logindate.monthValue;
					day = data[i].user_logindate.dayOfMonth;
					
					hour = data[i].user_logindate.hour;
					minute = data[i].user_logindate.minute;
					second = data[i].user_logindate.second;
					
					if (month < 10) {
						month = '0' + month;
					}
					if (day < 10) {
						day = '0' + day;
					}
					if (hour < 10) {
						hour = '0' + hour;
					}
					if (minute < 10) {
						minute = '0' + minute;
					}
					if (second < 10) {
						second = '0' + second;
					}

					data[i].user_logindate = data[i].user_logindate.year + '-' + month + '-' + day + " " + hour + ":" + minute + ":" + second;
					
					tmp.push(data[i]);
				}
	    	}
			
			if (ascount > 1) {
		    	$('#as_count').text(getTranslate('user_count') + ' : ' + ascount);
			} 
	    	
			var source = {
				dataType : "json",
				localdata: tmp,
				datafields: [
		        	{ name: 'user_id', type: 'string'},
		        	{ name: 'user_name', type: 'string'},
		        	{ name: 'user_phone', type: 'string'},
		        	{ name: 'user_tokken', type: 'string'},
		        	{ name: 'user_email', type: 'string'},
		        	{ name: 'user_logindate', type: 'string'},
		        	{ name: 'user_joindate', type: 'string'},
		        	{ name: 'user_isUse', type: 'string'},
		        	{ name: 'user_isadmin', type: 'string'},
		        	{ name: 'user_level', type: 'string'}
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
		            { text: getTranslate('user_id'), datafield: 'user_id', width: '9%', editable: false,},
		            { text: getTranslate('user_name'), datafield: 'user_name', width: '9%', editable: false, },
		            { text: getTranslate('user_phone'), datafield: 'user_phone', width: '9%', editable: false, },
		            { text: getTranslate('user_tokken'), datafield: 'user_tokken', width: '15%', editable: false, },
		            { text: getTranslate('user_email'), datafield: 'user_email', width: '13%', editable: false, },
		            { text: getTranslate('user_logindate'), datafield: 'user_logindate', width: '14%', editable: false, },
		            { text: getTranslate('user_joindate'), datafield: 'user_joindate', width: '14%', editable: false, },
		            { text: getTranslate('user_isUse'), datafield: 'user_isUse', width: '6%', editable: false, hidden:true},
		            { text: getTranslate('user_isadmin'), datafield: 'user_isadmin', width: '7%', editable: false, },
		            { text: getTranslate('user_level'), datafield: 'user_level', width: '4%', editable: false, hidden:true},
		            { text: getTranslate('more'), columntype: 'button', align: 'center', width: '10%', editable: false, sortable: false, filterable: false, cellsrenderer: function () {
						return getTranslate('more');
					}, 
						buttonclick: function (row) {
							if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed)
								popup_window[POPUP_MORE].close();
	
							var rowData = $('#jqxgrid').jqxGrid('getrowdata', row);

							setUsers(rowData.user_id);
							popup_window[POPUP_MORE] = openWindow('./userInfo.htm', 'userModify', 1400, 880);
						}
		            }
		        ]
		    });
		    
		    var val = "'" + "user" + "'"
		    
			if (JSON.parse(get('userdata')).user_id == 'admin') {
				$('.addButton').append('<button class="button_check" onclick="addInfo(' + val + ');"><span class="glyphicon glyphicon-plus check" aria-hidden="true"></span>' + getTranslate('add') + '</button>');
			}
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			//alert(JSON.stringify(data));
		}
	});
	/* $("#excelExport").jqxButton({
    	theme: 'metrodark'
	}); */
	/* $("#add").jqxButton({
    	theme: 'metrodark'button_check
	}); */
});
function closePopupChild() {
	for(var i = 0; i < popup_window.length; i++) {
		if(popup_window[i] && popup_window[i].open && !popup_window[i].closed)
			popup_window[i].close();
	}
}
function addInfo(val) {
	var url = "";
	if (val == "user") {
		url = "addUser";
	} else if(val == 'device') {
		url = 'addDevice';
	}

	if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed)
		popup_window[POPUP_MORE].close();

	popup_window[POPUP_MORE] = openWindow('./' + url + '.htm', url, 1400, 880);
}
</script>
</head>
<body onunload="closePopupChild();" style="background-color:#252525;">
	<div id="Progress_Loading" style="text-align:-webkit-center;"> <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" style="width:30%; margin-top:70px;" alt="loading" />
	</div>
<div class="container" style="overflow:auto;margin-top:70px;">
	<div id="jqxgrid"></div>
	<div>
		<table style="margin-top: 10px; width:1112px;">
			<tr>
				<td id="as_count" style="width:80%"></td>
				<td style="text-align:right;" class="addButton">
				<!-- <td style="padding-left:10px; text-align:right;">
					<button class="excelExport" id="excelExport">Export to Csv</button>
				</td> -->
			</tr>
		</table>
	</div>
</div>
</body>
</html>