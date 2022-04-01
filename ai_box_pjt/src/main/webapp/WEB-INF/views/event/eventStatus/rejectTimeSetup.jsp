<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title><spring:message code="common.registration" /></title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script type="text/javascript" src="/resources/js/translate.js"></script>
<style>
html, body {
	width:100%;
	margin:0;
	padding:0;
}
input[type="text"] {
	width:30px;
}
div {
	margin:auto;
	width:150px;
}
#title {
	margin-top:20px;
	text-align:center;
}
#time {
	text-align:center;
}
#top {
	margin-top:20px;
	text-align:center;
}
#warning {
	margin-top:10px;
	text-align:center;
}
#bottom {
	margin-top:20px;
	text-align-last:justify;
	width:130px;
}
#dev_ch {
	display:none;
}
</style>
</head>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
var row;
window.onload = function () {
	if (parent.opener.window.parent.userId == null) {
		self.close();
		parent.opener.location.replace('/index');
	}
	if (typeof parent.opener.window.parent.loginUser != 'function') {
		self.close();
		parent.opener.location.replace('/index/eventStatusSetup');
	}
	var dev_title = "${dev_title}";
	var model_name = "${model_name}";
	var event_time = "${event_time}";
	var dev_ch = "${dev_ch}";
	
	row = "${row}"; 
	
	console.log(row);
	
	$('#title').text(dev_title + " / " + getTranslate(model_name.split('_')[1].toLowerCase()));
	$('#time').text(event_time);
	$('#dev_ch').text(dev_ch);
}
function submit() {
	var datetime = document.getElementById('datetime'); 
	var warning = document.getElementById('warning'); 
	var top = document.getElementById('top'); 
	var value = datetime.value;
	var dev_ch = $('#dev_ch').text();
	var model_name = $('#title').text().split(" / ")[1];

	if (value == null || value == '' || !(value > 0 && value < 25)) {
		datetime.style.borderColor = 'red';
		top.style.color = 'red';
		/* warning.innerText = '1 ~ 24를 입력하세요.'; */
		/* warning.style.color = 'red'; */
	} else {
		var obj = new Object();
		
		obj.login_id = window.parent.userId;
		obj.datetime = value;
		obj.dev_ch = dev_ch;
		obj.model_name = model_name;
		obj.event_action = '무시';
		obj.event_time = $('#time').text();

		var jsonUrl = "/rejectTimeSetup";
		var jsonData = JSON.stringify(obj);
			
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",       
			data : jsonData,          		     		 
			success: function(data) {
				//alert('설정되었습니다.');
				self.close();
				//parent.opener.deleteRow(row);
				parent.opener.location.reload();
			},
			error: function(errorThrown) {
				//alert("에러 = " + errorThrown.statusText);
				//alert("메세지 = " + data);
			}
		});
	}
}
function cancel() {
	self.close();	
}
</script>
<body>
	<div id="title"></div>
	<div id="time"></div>
	<div id="top">
		<input type="text" id="datetime" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" /> <spring:message code="common.hours" /> (1 ~ 24)
	</div>
	<!-- <div id="warning"></div> -->
	<div id="bottom">
		<input type="button" id="check" value='<spring:message code="common.confirm"/>' onclick="submit();"/>
		<input type="button" id="cancel" value='<spring:message code="common.cancel"/>' onclick="cancel();" />
	</div>
	<div id="dev_ch"></div>
</body>
</html>