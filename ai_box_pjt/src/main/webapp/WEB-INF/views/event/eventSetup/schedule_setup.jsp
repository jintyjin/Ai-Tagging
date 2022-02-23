<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<style>
html, body {
	width:100%;
	height:100%;
	margin:0;
	padding:35px 10px 10px 10px;
	color:#fff;
	font-size:14px;
	font-weight:bold;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	background-color:#252525;
}
#imgDiv {
	display:table;
	margin-left:auto;
	margin-right:auto;
}
.day {
	display:table-row;
}
.time {
	display:table-cell;
	border:1px solid #35353A;
	width:4%;
	text-align:center;
	vertical-align:middle;
}
.time:hover {
	background-color:#1C97EA;
}
.date {
	background-color:#1C97EA;
}
#btnDiv {
	text-align:center;
	margin-left:auto;
	margin-right:auto;
	margin-bottom:20px;
}
.button {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.button:hover {
	color:#1c97ea;
}
</style>
<title>Insert title here</title>
</head>
<script>
var event_name = "${event_name}";
var dev_ch = "${dev_ch}";
var dev_title = "${dev_title}";
var schedule_str = '';
var scheduleArr = [];
scheduleArr.push('시');
scheduleArr.push('일');
scheduleArr.push('월');
scheduleArr.push('화');
scheduleArr.push('수');
scheduleArr.push('목');
scheduleArr.push('금');
scheduleArr.push('토');
/* scheduleArr.push('휴일'); */

$(document).ready(function() {
	$('#imgDiv').width(1280);
	$('#imgDiv').height(720);

	var jsonUrl2 = "/schedule_setup";
	
	var obj2 = new Object();
	
	obj2.event_name = event_name;
	obj2.dev_ch = dev_ch;
	
	var jsonData = JSON.stringify(obj2);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl2,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",       
		data : jsonData,          		     		 
		success: function(data) {
			var arr = [];
			if (data.schedule_content != null && data.schedule_content != '') {
				arr = data.schedule_content.split(', ');
			}
			for (var i = 0; i < 8; i++) {
				var dayArr = [];
				var titleStr = scheduleArr[i];
				schedule_str += '<div class="day"><div></div>';
				for (var j = 0; j < 25; j++) {
					var idStr = '';
					var dayStr = '';
					var classStr = '';
					var functionStr = '';
					if (i == 0 && j > 0) {
						dayStr = j - 1;
					}
					if (i > 0) {
						if (j > 0) {
							idStr = titleStr + '_' + (j - 1);
						}
						if (j == 0) {
							dayStr = titleStr;
						}
						functionStr = ' onclick="checkDate(this);"';
						if (arr.length > 0 && arr[arr.length - 1] == idStr) {
							arr.pop();
							classStr = ' date';
						}
					}
					
					schedule_str += '<div class="time' + classStr + '" id="' + idStr + '"' + functionStr + '>' + dayStr + '</div>'
				}
				schedule_str += '</div>'
			}
			$('#btnDiv').append('<button class="button" id="save" onclick="saveAll();">저장</button><button class="button" id="select" onclick="selectAll();">전체 선택</button><button class="button" id="clear" onclick="clearAll();">전체 지우기</button>');
			$('#imgDiv').append(schedule_str);

		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});
});
function saveAll() {
	var data = document.getElementsByClassName('date');
	var arr = [];
	for (var i = data.length - 1; i >= 0 ; i--) {
		arr.push(data[i].id);
	}
	
	var jsonUrl = "/saveSchedule";
	
	var obj = new Object();
	
	obj.event_name = event_name;
	obj.dev_ch = dev_ch;
	obj.dev_title = dev_title;
	obj.id_list = arr;
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",       
		data : jsonData,          		     		 
		success: function(data) {
			if (data == null || data.status == null || data.status != 'success') {
				alert('저장이 실패했습니다.');
			} else {
				alert('저장되었습니다.');
			}
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});
}
function clearAll() {
	var data = document.getElementsByClassName('date');
	for (var i = data.length - 1; i >= 0 ; i--) {
		$('#' + data[i].id).removeClass("date");
	}
}
function selectAll() {
	var data = document.getElementsByClassName('time');
	for (var i = data.length - 1; i >= 0 ; i--) {
		if (data[i].id != '') {
			$('#' + data[i].id).addClass("date");
		}
	}
}

function checkDate(div) {
	if ($(div).hasClass('date')) {
		$(div).removeClass("date");
	} else {
		$(div).addClass("date");
	}
}
</script>
<body>
<div id="btnDiv">
</div>
<div id="imgDiv">
</div>
</body>
</html>