<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
	margin-left:auto;
	margin-right:auto;
	background-size:100% 100%;
}
#canvas {
	background-size: 100% 100%;
	background-color:rgba(255, 0, 0, 0.2);
}
</style>
</head>
<script>
$(document).ready(function () {
	var image_name = "${image_name}";
	var width = "${width}";
	var height = "${height}";
	
	$("#imgDiv").css("background-image", "url(" + image_name + "), url(" + image_name.replace('web_server', 'webserver') + "), url(" + image_name.replace('webserver', 'web_server') + ")");
	$('#imgDiv').width(width);
	$('#imgDiv').height(height);

});
</script>
<body>
<div id="imgDiv">
</div>

</body>
</html>