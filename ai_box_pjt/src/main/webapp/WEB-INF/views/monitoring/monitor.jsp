<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<style>
html, body {
	margin:0;
	padding:0;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-weight: bold;
	color:white;
	background-color:#252525;
}
body {
	height:1050px;
	/* overflow:hidden; */
}
#bottom {
	margin:80px 432px 24px 72px;
	width:1723px;
}
.chImage {
	width:280px;
	height:210px;
	float:left;
}
img {
	width:100%;
	height:100%;
}
.container {
	width:1723px;
}
.dev_title {
	position:absolute;
}
#theModal {
    background-color: rgba(37, 37, 37, 0.5);
	transition: all 0.5s linear;
}
.modal-dialog {
	margin:0;
}
canvas {
	width:280px;
	height:210px;
	border: 1px solid white;
}
</style>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
window.addEventListener('DOMContentLoaded', function() {
	for (var i = 1; i < 65; i++) {
		$("#bottom").append('<div class="chImage" id="ch' + i + '"><div class="dev_title" id="dev_title_' + i + '" ></div><a id="a_' + i + '"><img id="' + i + '" onError="noImage(this);"/></a></div>');
	}

	var jsonUrl = "/monitor";
	
	var obj = new Object();
	obj.obj = "test";
	
	var jsonData = JSON.stringify(obj);

	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",   
		data : jsonData,          		   
	    success: function(data) {
	    	for (var j = 0; j < data.length; j++) {
	    		var dev_ch = data[j].dev_ch;
	    		document.getElementById(dev_ch).src = data[j].monitor_src;
	    		document.getElementById('dev_title_' + dev_ch).innerText = data[j].dev_title;
	    		document.getElementById('a_' + dev_ch).style.cursor = 'pointer';
	    		$('#a_' + dev_ch).attr('onClick', 'clickModal(' + dev_ch + ');');
	    	}
		},
		error: function(errorThrown) {
			console.log(errorThrown);
		}
	});

	var websocketUrl = '/websocket';

	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/showMonitor', function (message) {
			if (JSON.parse(get('userdata')) != null) {
				var data = JSON.parse(message.body);
				var dev_ch = data.dev_ch;
				var dev_title = data.dev_title;
				var src = data.src;
				
	    		document.getElementById(dev_ch).src = src;
	    		document.getElementById('dev_title_' + dev_ch).innerText = dev_title;
			}
		}); 
		stompClient.subscribe('/showBase64', function (message) {
			if (JSON.parse(get('userdata')) != null) {
				var data = JSON.parse(message.body);
				var dev_ch = data.dev_ch;
				var img_data = data.img_data;
				
				/* var canvas = document.getElementById(18);
				var ctx = canvas.getContext('2d');
				var image = new Image();
				image.onload = function() {
					ctx.drawImage(this, 0, 0, this.width, this.height, 0, 0, canvas.width, canvas.height);
				};
				image.src = "data:image/jpg;base64," + img_data; */
	    		document.getElementById(18).src = "data:image/jpg;base64," + img_data;
	    		
	    		//document.getElementById('dev_title_' + dev_ch).innerText = dev_title;
			} 
		}); 
	});
});
function noImage(data) {
	var src = data.src;
	document.getElementById(data.id).src = src.replace('web_server', 'webserver');
}
function clickModal(ch) {
   	var day = new Date();
   	
	var url = "showImageInfo.htm?ch=" + ch;
	
	$(".modal-content").load(url, function(e) {
		$('#theModal').modal('show');
	});
}
</script>
</head>
<body>
<div id="bottom" class="container">
</div>
<div>
<div class="modal fade" id="theModal">
    <div class="modal-dialog">
		<div class="modal-content">
	    </div>
    </div>
</div>
</div>
</body>
</html>