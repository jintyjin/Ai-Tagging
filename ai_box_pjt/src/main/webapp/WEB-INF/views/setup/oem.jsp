<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metro.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.arctic.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<script src="./resources/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/css/bootstrap4-alpha3.min.css" />
<script src="/resources/js/jqwidgets/jqxcore.js"></script>
<script src="/resources/js/jqwidgets/jqxdata.js"></script>
<script src="/resources/js/jqwidgets/jqxbuttons.js"></script>
<script src="/resources/js/jqwidgets/jqxscrollbar.js"></script>
<script src="/resources/js/jqwidgets/jqxscrollbar.js"></script>
<script src="/resources/js/jqwidgets/jqxmenu.js"></script>
<script src="/resources/js/jqwidgets/jqxlistbox.js"></script>
<script src="/resources/js/jqwidgets/jqxdropdownlist.js"></script>
<script src="/resources/js/jqwidgets/jqxdatetimeinput.js"></script>
<script src="/resources/js/jqwidgets/jqxcalendar.js"></script>
<script src="/resources/js/jqwidgets/jqxcheckbox.js"></script>
<script src="/resources/js/jqwidgets/jqxlistbox.js"></script>
<script src="/resources/js/canvas/recent_canvasjs.min.js"></script>
<script src="/resources/js/tether.min.js"></script>
<script type="text/javascript" src="/resources/js/translate.js"></script>
<style>
body {
	width:100%;
	height:100%;
	margin:0;
	color:#fff;
	font-size:14px;
	font-weight:bold;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	background-color:#252525;
	padding-top:70px;
}
.div_100 {
	width:100%;
	display:flex;
	padding-top:5px;
	padding-bottom:5px;
}
.div_65 {
	width:50%;
	text-align:center;
}
.div_35 {
	width:50%;
	text-align:center;
}
</style>
<script>
$(document).ready(function () {
	if (window.parent.userId == null) {
		location.replace('/index');
	}
	if (typeof window.parent.loginUser != 'function') {
		location.replace('/index/oem');
	}
});
</script>
</head>
<body>
	<div class="container">
		<div class="col-md-5" style="float:none;margin-left:auto; margin-right:auto;border: 1px solid #35353A;">
			<div class="div_100">
				<div class="div_35"><spring:message code="common.versionInfo" /></div>
				<div class="div_65"><spring:message code="common.version" /></div>
			</div>
			<!-- <div class="div_100">
				<div class="div_35">회사명</div>
				<div class="div_65">
					<img src="/resources/image/version_logo/version_logo.jpg" style="height:21px;"/>
				</div>
			</div> -->
		</div>
		<div class="col-md-6" style="float:none;margin-left:auto; margin-right:auto; text-align:center; margin-top:15px;">
			<img src="/resources/image/Police/logo_RECON.ico" alt="logo" />
		</div>
	</div>
</body>
</html>