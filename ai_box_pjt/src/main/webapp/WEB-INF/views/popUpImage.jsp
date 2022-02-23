<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title}</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<style>
html, body {
	width:100%;
	height:100%;
	margin:0;
	padding:0;
}
img {
	width: 100%;
	object-fit: contain;
	-webkit-transition: all .1s ease-in-out;
	-moz-transition: all .1s ease-in-out;
	transition: all .1s ease-in-out;
}
#popUpImage {
	height:100%;
	margin:0;
	padding:0;
}
</style>
<script>
$(document).ready(function () {
	var bodyHeight = document.body.scrollHeight;
	var height = "${height}";
	var src = "${src}";
	var src2 = src.replace('web_server', 'webserver');
	var topHeight = (bodyHeight - height) / 2;

	$("#popUpImage").append('<div style="height:100%; background-color:#252525;"><img id="image" onError="this.src=' + "'" + src2 + "'" + '" src="' + src + '" width="' + "${width}" + 'px" height="' + "${height}" + 'px" style="position:absolute; top:' + topHeight + 'px; padding:0; margin:0;"></div>');
  	///resources/image/test/KakaoTalk_20200406_150529630.jpg
});
window.addEventListener('resize', function(event) {
	var bodyHeight = document.body.scrollHeight;
	var height = document.getElementById('image').offsetHeight;
	var topHeight = (bodyHeight - height) / 2;
	
	document.getElementById("image").style.top = topHeight + "px";
	//document.getElementById("popUpImage").style.paddingLeft = paddingWidth + "px";
});
</script>
</head>
<body onload="window.self.focus();" style="overflow:hidden;">
	<div id="popUpImage">
		
	</div>
</body>
</html>