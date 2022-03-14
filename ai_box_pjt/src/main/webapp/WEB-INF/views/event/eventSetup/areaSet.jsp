<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script type="text/javascript" src="/resources/js/translate.js"></script>
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
#btnDiv {
	text-align:center;
	margin-left:auto;
	margin-right:auto;
	margin-bottom:20px;
}
.button_modify {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
#reload {
	width:135px;
}
.button_modify:hover {
	color:#1c97ea;
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
// 1. 우클릭 시 찍힌 원을 연결한 선의 좌표들
var arr = new Array();
// 2. 모든 좌표가 들어가 있는 배열
var totalArr = new Array();
$(document).ready(function () {
	var area_event = "${area_event}";
	var dev_ch = "${dev_ch}";
	var dev_title = "${dev_title}";
	var isImg = "${isImg}";
	var path = "${path}";
	var width = "${width}";
	var height = "${height}";

	var ctx;
	var canvas = document.getElementById('canvas');
	if (canvas.getContext) {
		ctx = canvas.getContext("2d");
	}
	
	if (isImg) {
		$("#imgDiv").css("background-image", "url(" + path + ")");
		$('#btnDiv').width(width);
		$('#imgDiv').width(width);
		$('#imgDiv').height(height);
		canvas.width = width;
		canvas.height = height;
	} else {
		$('#btnDiv').width(1280);
		$('#imgDiv').width(1280);
		$('#imgDiv').height(720);
		canvas.width = 1280;
		canvas.height = 720;
	}
	
	ctx.lineWidth = 1;
	ctx.fillStyle = 'rgba(0, 0, 255, 0.5)';
	ctx.strokeStyle = 'rgba(0, 0, 255, 0.5)';

/* 	var background = new Image();
	background.src = "http://i.imgur.com/yf6d9SX.jpg";

	background.onload = function(){
	    ctx.drawImage(background, 0, 0, canvas.width, canvas.height);
	} */
	
	var jsonUrl = "/areaSet";
	
	var obj = new Object();
	obj.dev_ch = dev_ch;  
	obj.area_event = area_event;
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",       
		data : jsonData,          		     		 
		success: function(data) {
			/* if (data.base64 != null) {
				$("#imgDiv").css("background-image", "url(data:image/jpg;base64," + data.base64 + ")");
			} */
			
			if (data.result == 'success') {
				totalArr = JSON.parse(data.area_total);
				arr = JSON.parse(data.area_now);
				
			    ctx.beginPath();
				for (var i = 0; i < totalArr.length; i++) {
					var data = totalArr[i];
					if (data.r == null) {
						arr = new Array();
						ctx.fill();
					    ctx.beginPath();
					}
					arr.push(data);
					ctx.arc(data.x, data.y, data.r, 0, Math.PI * 2, true);
					ctx.stroke();
				}
			}
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});

	var webSocket = new WebSocket("ws://" + "${address}");
	
	$(canvas).on('click', function (e) {
		if (canvas.getContext) {
			var i = $(this).offset().left;
			var t = $(this).offset().top;
			var x = e.pageX - i;
			var y = e.pageY - t;
			var r = 3;
			
			ctx.beginPath();
			//ctx.fillstyle = "transparent";
			ctx.arc(x, y, r, 0, Math.PI * 2, true);
			var obj = new Object();
			obj.x = x;
			obj.y = y;
			arr.push(obj);
			obj.r = r;
			totalArr.push(obj);
			ctx.stroke();
			ctx.fill();
		}
	});
	
	$(canvas).contextmenu(function () {
		/* if (canvas.getContext) {
			var length = arr.length;
		    ctx.beginPath();
			for (var i = 0; i < length; i++) {
				var obj = arr.shift();
				ctx.lineTo(obj.x, obj.y);
			}

			//ctx.closePath();
			totalArr.push(new Object);
		    console.log(totalArr);
		    ctx.fill();
		} */

		totalArr.push(new Object);
		ctx.clearRect(0, 0, canvas.width, canvas.height);
	    ctx.beginPath();
		for (var i = 0; i < totalArr.length; i++) {
			var data = totalArr[i];
			if (data.r == null) {
				arr = new Array();
				ctx.fill();
			    ctx.beginPath();
			}
			arr.push(data);
			ctx.arc(data.x, data.y, data.r, 0, Math.PI * 2, true);
			ctx.stroke();
		}
		ctx.fill();
	});

	$('#reload').click(function () {
		var msg = {
			command: 'RF_REQ_STILL_IMAGE',
			sender: 'web',
			ch: dev_ch
		};

		// Send the msg object as a JSON-formatted string.
		webSocket.send(JSON.stringify(msg));
		
		wait(1);
		
		location.reload();
	});
	
	$('#clear').click(function () {
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		totalArr = new Array();
		arr = new Array();
	});
	
	$('#undo').click(function () {
		ctx.clearRect(0, 0, canvas.width, canvas.height);
		totalArr.pop();
	    ctx.beginPath();
		for (var i = 0; i < totalArr.length; i++) {
			var data = totalArr[i];
			if (data.r == null) {
				arr = new Array();
				ctx.fill();
			    ctx.beginPath();
			}
			arr.push(data);
		    console.log("totalArr = " + totalArr);
			ctx.arc(data.x, data.y, data.r, 0, Math.PI * 2, true);
			ctx.stroke();
		}
	    /* ctx.beginPath();
		for (var i = 0; i < totalArr.length; i++) {
			var data = totalArr[i];
			if (data.r == null) {
				ctx.fill();
			    ctx.beginPath();
			}
		} */
	});
	
	$('#save').click(function () {
		var jsonUrl = "/setAreaSet";
		
		var obj = new Object();
		
		console.log(arr);
		
		obj.dev_ch = dev_ch;  
		obj.area_event = area_event;
		obj.area_total = totalArr;
		obj.area_now = arr;
		obj.dev_title = dev_title;
		
		var jsonData = JSON.stringify(obj);
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",       
			data : jsonData,          		     		 
			success: function(data) {
				alert(getTranslate('completeModification'));			
				self.close();
			},
			error: function(errorThrown) {
				alert(errorThrown.statusText);
				alert(JSON.stringify(data));
			}
		});
	});
});
function wait(sec) {
    let start = Date.now(), now = start;
    while (now - start < sec * 1000) {
        now = Date.now();
    }
}
</script>
<body oncontextmenu="return false;">
<div id="btnDiv">
	<button class="button_modify" id="reload"><spring:message code="area.imageRefresh" /></button>
	<button class="button_modify" id="undo"><spring:message code="common.goBack" /></button>
	<button class="button_modify" id="clear"><spring:message code="common.clearAll" /></button>
	<button class="button_modify" id="save"><spring:message code="common.doSave" /></button>
</div>
<div id="imgDiv">
	<canvas id="canvas"></canvas>
</div>

</body>
</html>