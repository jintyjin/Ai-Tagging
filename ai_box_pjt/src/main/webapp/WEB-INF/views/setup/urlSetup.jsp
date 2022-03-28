<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script type="text/javascript" src="/resources/js/translate.js"></script>
<style>
body {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
	background-color:#252525;
}
.container {
	margin-top:50px;
	width:600px;
}
input {
	background-color:transparent;
	border-color:#35353A;
}
input[type="text"] {
	width:500px;
}
input[type="button"] {
	width:100px;
}
.title {
	margin-bottom:10px;
}
.content {
	margin-top:30px;
	text-align:center;
}
</style>
</head>
<script>
window.onload = function () {
	var request_url = "${request_url}";
	var analyze_url = "${analyze_url}";
	
	$('#web_url').val(request_url);
	$('#analyze_url').val(analyze_url);
}

function changeUrl() {
	var request_url = $('#web_url').val();
	var analyze_url = $('#analyze_url').val();

	var obj = new Object();
	
	obj.request_url = request_url;
	obj.analyze_url = analyze_url;

	var jsonUrl = "/urlSetup";
	var jsonData = JSON.stringify(obj);
		
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",       
		data : jsonData,          		     		 
		success: function(data) {
			alert(getTranslate('completeSave'));
		},
		error: function(errorThrown) {
		}
	});
}
</script>
<body>
	<div class="container">
		<div class="content">
			<div class="title"><spring:message code="UrlSetup.webServerURL" /></div>
			<input type="text" id="web_url" />
		</div>
		<div class="content">
			<div class="title"><spring:message code="UrlSetup.analysisServerURL" /></div>
			<input type="text" id="analyze_url" />
		</div>
		<div class="content">
			<input type="button" id="subimt" value='<spring:message code="common.change" />' onclick="changeUrl();" />
		</div>
	</div>
</body>
</html>