<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.metro.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.arctic.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<script src="./resources/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap4-alpha3.min.css" />
<script src="./resources/js/jqwidgets/jqxcore.js"></script>
<script src="./resources/js/jqwidgets/jqxdata.js"></script>
<script src="./resources/js/jqwidgets/jqxbuttons.js"></script>
<script src="./resources/js/jqwidgets/jqxscrollbar.js"></script>
<script src="./resources/js/jqwidgets/jqxscrollbar.js"></script>
<script src="./resources/js/jqwidgets/jqxmenu.js"></script>
<script src="./resources/js/jqwidgets/jqxlistbox.js"></script>
<script src="./resources/js/jqwidgets/jqxdropdownlist.js"></script>
<script src="./resources/js/jqwidgets/jqxdatetimeinput.js"></script>
<script src="./resources/js/jqwidgets/jqxcalendar.js"></script>
<script src="./resources/js/jqwidgets/jqxcheckbox.js"></script>
<script src="./resources/js/jqwidgets/jqxlistbox.js"></script>
<script src="./resources/js/canvas/recent_canvasjs.min.js"></script>
<script src="./resources/js/tether.min.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
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
#update_info {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
#get_info {
	width:200px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.update {
	width:14px;
	height:14px;
	font-size:14px;
	font-weight: bold;
	color:white;
	margin-right:8px;
}
.get {
	width:14px;
	height:14px;
	font-size:14px;
	font-weight: bold;
	color:white;
	margin-right:8px;
}
#update_info:hover {
	color:#1c97ea;
}
#update_info:focus {
	color:#1c97ea;
	border:1px solid #35353A;
}
#get_info:hover {
	color:#1c97ea;
}
#get_info:focus {
	color:#1c97ea;
	border:1px solid #35353A;
}
button {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
	line-height: 1.5;
}
button:focus {
	outline:1px solid #35353A;
}
.div_100 {
	width:100%;
	display:flex;
	padding-top:5px;
	padding-bottom:5px;
}
.div_65 {
	width:62%;
	text-align:center;
}
.div_35 {
	width:35%;
	text-align:center;
}
#update_file {
	display:none;
}
#tmp_text {
	display:none;
}
</style>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
$(document).ready(function () {
	if (window.parent.userId == null) {
		location.replace('/index');
	}
	if (typeof window.parent.loginUser != 'function') {
		location.replace('/index');
	}
	var jsonUrl = "/get_license_info";

	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
	    success: function(data) {
	    	var data1 = JSON.parse(data);
	    	var version = data1.Version;
	    	var end_date = data1.License_Expiry_Date.str;
	    	var remain_date = data1.License_Left_Days;
	    	$('#version_text').text(version);
	    	$('#group_text').text(window.parent.userId);
	    	$('#end_text').text(end_date);
	    	$('#remain_text').text(remain_date + getTranslate('day'));
	    },
		error: function(errorThrown) {
			//alert('오류가 발생하였습니다.');
			//alert(errorThrown.statusText);
			//alert(jsonUrl2);
		}
	});
	
	$('#get_info').click(function () {
		var jsonUrl2 = "/get_license_request_code";

		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl2,                      		
		    success: function(data) {
				const a = document.createElement('a');
				a.setAttribute('download', data.substring(data.lastIndexOf('/') + 1));
				a.setAttribute('href', data);
				a.click();
		    },
			error: function(errorThrown) {
				//alert(errorThrown.statusText);
				//alert(jsonUrl2);
			}
		});
	});

	var websocketUrl = '/websocket';
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/renewal_license_date', function (data) {
	    	var data1 = JSON.parse(data.body);
	    	var version = data1.Version;
	    	var end_date = data1.License_Expiry_Date.str;
	    	var remain_date = data1.License_Left_Days;
	    	$('#version_text').text(version);
	    	$('#group_text').text(window.parent.userId);
	    	$('#end_text').text(end_date);
	    	$('#remain_text').text(remain_date + getTranslate('day'));
		});
	});
		
	$('#update_info').click(function () {
		$('#update_file').click();
	});
});
function sendFile(files) {
	if (files.length > 0) {
		for (var i = 0; i < files.length; i++) {
			var file = files[i];
			
			if (file.name.substring(file.name.lastIndexOf('.') + 1) != 'txt') {
				alert(getTranslate('setTextFile'));
			} else {
				var reader = new FileReader();

				reader.onload = function () {
            		var jsonUrl = "/set_license_code";

            		var jsonData = reader.result;
            		
            		$.ajax({
            			type : "POST",                        	 	     
            			url : jsonUrl,                      		
            			dataType : "text",                        	  
            			contentType : "application/json; charset=UTF-8",       
            			data : jsonData,          		     		 
            			success: function(data) {
            				$("#update_file").val("");
            				alert(getTranslate('completeResigtration'));		
            			},
            			error: function(errorThrown) {
            				alert(getTranslate('serverError'));
            				//alert(errorThrown.statusText);
            				//alert(JSON.stringify(data));
            			}
            		}); 
				};
				
				reader.readAsText(file, "UTF-8");
			}
		}
	} else {
		$("#update_file").val("");
		alert(getTranslate('setTextFile'));
	}
}
</script>
</head>
<body>
	<div class="container">
		<div class="col-md-5" style="float:none;margin-left:auto; margin-right:auto;border: 1px solid #35353A;">
			<div class="div_100">
				<div class="div_35"><spring:message code="common.versionInfo" /></div>
				<div class="div_65" id="version_text"></div>
			</div>
			<div class="div_100">
				<div class="div_35"><spring:message code="license.groupName" /></div>
				<div class="div_65" id="group_text"></div>
			</div>
			<div class="div_100">
				<div class="div_35"><spring:message code="license.expirationDate" /></div>
				<div class="div_65" id="end_text"></div>
			</div>
			<div class="div_100">
				<div class="div_35"><spring:message code="license.remainingPeriod" /></div>
				<div class="div_65" id="remain_text"></div>
			</div>
			<!-- <div class="div_100">
				<div class="div_35">담당자</div>
				<div class="div_65">홍길동</div>
			</div> -->
		</div>
	</div>
	<div class="container" style="margin-top:15px;">
		<div class="col-md-12">
			<div class="col-md-6" style="float:none; margin-right:auto; margin-left:auto; text-align:center;">
				<label for="update_file"></label>
				<button id="update_info"><span class="glyphicon glyphicon-send update" aria-hidden="true"></span><spring:message code="license.renewal" /></button>
				<input type="file" accept=".txt" id="update_file" onchange="sendFile(this.files);" />
				<button id="get_info"><span class="glyphicon glyphicon-floppy-save get" aria-hidden="true""></span><spring:message code="license.obtainAnalysisServerInformation" /></button>
			</div>
		</div>
	</div>
<div id='tmp_text'></div>
</body>
</html>