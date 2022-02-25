<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>AI</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1">
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->
<script src="./resources/js/bootstrap.bundle.min.js"></script>
<!-- <script src="./resources/js/bootstrap.min.js"></script> -->
<link rel="stylesheet" href="./resources/css/bootstrap-theme.min.css">
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style>
html, body {
	width:100%;
	height:100%;
	margin:0;
	padding:0;
}
table {
	background-color:#353535;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-weight: bold;
	color:white;
}
#menu {
	margin-top:34px;
}
#logo {
	/* float:left; */
	height:50px;
	padding:10px;
	margin-left:20px;
}
#logo img {
	width:30px;
	height:30px;
}
#logout {
	float:right;
}
#logout span {
	padding:10px;
}
#logout span:hover {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
a {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 20px;
	font-weight: bold;
	color:white;
}
a:focus {
	outline:none;
}
ul {
	padding:0px;
	list-style: none;
}

ul li {
	padding:15px 0px 15px 40px;
}

#new {
	padding:15px 50px 15px 50px;
}

.active {
	filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#929292', endColorstr='#535353');
	color: #007ACC;
	text-shadow: #454545 0px -1px 1px;
	text-decoration: none;
}
.tabMenu:hover {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
iframe {
	border:none;
	/* min-width:450px; */
}
.bottom_logo {
	float:right;
	padding-right:8px;
}
.downloadButton {
	display:none;
}
.downloadButton2 {
	display:none;
}
.downloadImage {
	left:10px;
	bottom:0;
	position:fixed;
	color:#007ACC;
	/* font-size:30px; */
	font-weight:500;
	line-height:40px;
	transform:translate3d(-310px, 0, 0);
	transition:transform 0.5s linear;
	background-color:#252525;
	border-radius:8px;
	text-align:center;
	border:1px solid #007ACC;
}
.dropdown-menu {
	max-width:233px;
	padding:0;
	background:linear-gradient(-45deg, #353535, #222222);
}
.dropdown-menu li {
	padding:0;
}
.dropdown a {
	font-size:32px;
}
.dropdown a:hover {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
.dropdown a:active {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
.dropdown a:focus {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
.dropdown-menu li a {
	/* background-color:#353535; */
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 16px;
	font-weight: bold;
	/* color:#353535; */
	color:white;
}
.dropdown-menu li a:hover {
	border-radius:4px;
	border-color:#007ACC;
	/* color: #007ACC; */
	/* text-shadow: #454545 0px -1px 1px; */
	/* background-color:#353535; */
	background-color:#007ACC;
	/* background-image:linear-gradient(to bottom, #353535 0, #353535 100%); */
	background-image:linear-gradient(to bottom, #007ACC 0, #007ACC 100%);
}
.dropdown-menu li a:active {
	border-radius:4px;
	border-color:#007ACC;
	/* color: #007ACC; */
	/* text-shadow: #454545 0px -1px 1px; */
	/* background-color:#353535; */
	background-color:#007ACC;
	/* background-image:linear-gradient(to bottom, #353535 0, #353535 100%); */
	background-image:linear-gradient(to bottom, #007ACC 0, #007ACC 100%);
}
.dropdown-menu li a:focus {
	border-radius:4px;
	border-color:#007ACC;
	/* color: #007ACC; */
	/* text-shadow: #454545 0px -1px 1px; */
	/* background-color:#353535; */
	background-color:#007ACC;
	/* background-image:linear-gradient(to bottom, #353535 0, #353535 100%); */
	background-image:linear-gradient(to bottom, #007ACC 0, #007ACC 100%);
}
#setup_ul {
	display:none;
}
#setup_ul li {
	padding:5px 0px 5px 40px;
}
#setup_ul li a {
	font-size:14px;
}
#setup_ul li a:hover {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
#setup_ul li a:active {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
#setup_ul li a:focus {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}

#device_ul li {
	padding:10px 0px 5px 40px;
}
#device_ul li a {
	font-size:14px;
}
#device_ul li a:hover {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
#device_ul li a:active {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
#device_ul li a:focus {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}

#log_ul li {
	padding:10px 0px 5px 40px;
}
#log_ul li a {
	font-size:14px;
}
#log_ul li a:hover {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
#log_ul li a:active {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
#log_ul li a:focus {
	color: #007ACC;
	text-decoration: none;
	cursor: pointer;
}
</style>
<script>
function isEmpty(str) {
	if(typeof str === "undefined" || str === null || str == "" || str == "undefined")
		return true;
	else
		return false;
}
function get(key) {
	return sessionStorage.getItem(key);
}
function del() {
	sessionStorage.clear();
}
var POPUP_MORE = 0;

var popup_window = new Array();
var popup_width = 1280;
var popup_height = 720;
$(document).ready(function () {
	$('.tabMenu').click(function () {
		$('#menu').find('.active').addClass('tabMenu');
		$('#menu').find('.active').removeClass('active');
		$(this).removeClass("active");
		$(this).addClass("active");
	});
	if (isEmpty(get('userdata'))) {
	} else {
		$('span').css('display', '');
		$('#tab1').css('display', '');
		$('#tab2').css('display', '');
		$('#tab3').css('display', '');
		//$('#tab4').css('display', '');	// 모니터링
		$('#tab5').css('display', '');
		$('#tab6').css('display', '');
		$('#tab7').css('display', '');
		$('#tab8').css('display', '');
		$('#tab12').css('display', '');
		if (JSON.parse(get('userdata')).user_id == 'admin') {
			$('#tab9').css('display', '');
			$('#tab10').css('display', '');
			$('#tab11').css('display', '');
			$('#tab15').css('display', '');
		}
		$('#tab13').css('display', '');
		$('#tab14').css('display', '');
		$('#newMenu').css('display', '');
		$('#iframe').attr('src', './dashBoard.htm');
	}
	$('#logoutButton').on('click', function () {
		del();
		$(window.parent.location).attr('href', './index.htm');
	});
	
	$('#downloadButton').on('click', function () {
		location.href = '/webserver/cms_monitoring.zip';
	});
	
	var isDownload = true;
	$('.downloadButton').on('click', function () {
		//alert($("#iframe").contents().find('.afterChkV:eq(0)').attr('id'));
		if (isDownload) {
			isDownload = false;
			//$(top.document).find(".downloadImageHide").attr("class","downloadImage");
			//$('.downloadImageHide').attr('class','downloadImage');
			$('.downloadImage').css({"transform": "translate3d(0, 0, 0)"});
			var downloadTag = [];
			for (var d = 0; d < $("#iframe").contents().find('.afterChkV').length; d++) {
				downloadTag.push($("#iframe").contents().find('.afterChkV:eq(' + d + ')').attr('id').substring(0, $("#iframe").contents().find('.afterChkV:eq(' + d + ')').attr('id').length - 1));
			}

			$("#iframe").contents().find('.afterChkV').attr('class','hideChkV');
			$("#iframe").contents().find('.afterTitleChk').attr('class','hideTitleChk');
			$("#iframe").contents().find('.afterChkImage').attr('class','beforeChkImage');
			$("#iframe").contents().find('.searchHidden').attr('class','search');
			$("#iframe").contents().find('.menu').attr('class','menuHidden');
			
			var day = new Date();
	    	var year = day.getFullYear();
	    	var month = day.getMonth() + 1;
	    	var date = day.getDate();
	    	var hour = day.getHours();
	    	var min = day.getMinutes();
	    	var sec = day.getSeconds();
	    	
	    	if (month < 10) {
	    		month = '0' + month;
	    	} 
	    	if (date < 10) {
	    		date = '0' + date;
	    	}
	    	if (hour < 10) {
	    		hour = '0' + hour;
	    	}
	    	if (min < 10) {
	    		min = '0' + min;
	    	}
	    	if (sec < 10) {
	    		sec = '0' + sec;
	    	}
		
			var fileName = year + month + date + '_' + hour + min + sec + '.zip';
			
			var obj = new Object();
			
			obj.login_id = JSON.parse(get('userdata')).user_id;
			obj.downloadTag = downloadTag;
			obj.fileName = fileName;
			obj.event_name = $("#iframe").contents().find('#event_name').text();

			var jsonUrl = "/downloadImageGroup";
			var jsonData = JSON.stringify(obj);
				
			$.ajax({
				type : "POST",                        	 	     
				url : jsonUrl,                      		
				dataType : "text",                        	  
				contentType : "application/json; charset=UTF-8",       
				data : jsonData,          		     		 
				success: function(data) {
					var folder;
					if (data > 1) {
						folder = '/web_server';
						location.href = folder + '/download/' + fileName;
					} else if (data == 0) {
						alert('서버의 용량이 부족합니다.');
					} else {
						folder = '/webserver';
						location.href = folder + '/download/' + fileName;
					}
					/* $('.downloadButton').attr('disabled', false);
					$('.downloadButton').css('opacity', '1'); */
					isDownload = true;
					//$('.downloadImage').attr('class','downloadImageHide');
					//$(top.document).find(".downloadImage").attr("class","downloadImageHide");
					$('.downloadImage').css({"transform": "translate3d(-310px, 0, 0)"});
				},
				error: function(errorThrown) {
					alert("에러 = " + errorThrown.statusText);
					alert("메세지 = " + data);
				}
			});
		} else {
			alert('다운로드중입니다.');
		}
	});
	$('.downloadButton2').on('click', function () {
		if (isDownload) {
			isDownload = false;
			$('.downloadImage').css({"transform": "translate3d(0, 0, 0)"});
			var idxArr = [];
			for (var d = 0; d < $("#iframe").contents().find('.afterChkV').length; d++) {
				idxArr.push($("#iframe").contents().find('.afterChkV:eq(' + d + ')').attr('id').substring(0, $("#iframe").contents().find('.afterChkV:eq(' + d + ')').attr('id').length - 1));
			}

			$("#iframe").contents().find('.afterChkV').attr('class','hideChkV');
			$("#iframe").contents().find('.afterTitleChk').attr('class','hideTitleChk');
			$("#iframe").contents().find('.afterChkImage').attr('class','beforeChkImage');
			$("#iframe").contents().find('.searchHidden').attr('class','search');
			$("#iframe").contents().find('.menu').attr('class','menuHidden');
			
	    	var day = new Date();
	    	var year = day.getFullYear();
	    	var month = day.getMonth() + 1;
	    	var date = day.getDate();
	    	var hour = day.getHours();
	    	var min = day.getMinutes();
	    	var sec = day.getSeconds();
	    	
	    	if (month < 10) {
	    		month = '0' + month;
	    	} 
	    	if (date < 10) {
	    		date = '0' + date;
	    	}
	    	if (hour < 10) {
	    		hour = '0' + hour;
	    	}
	    	if (min < 10) {
	    		min = '0' + min;
	    	}
	    	if (sec < 10) {
	    		sec = '0' + sec;
	    	}
		
			var fileName = year + month + date + '_' + hour + min + sec + '.zip';
			
			var obj = new Object();
			
			obj.login_id = JSON.parse(get('userdata')).user_id;
			obj.idxArr = idxArr;
			obj.fileName = fileName;

			var jsonUrl = "/downloadImage";
			var jsonData = JSON.stringify(obj);
				
			 $.ajax({
				type : "POST",                        	 	     
				url : jsonUrl,                      		
				dataType : "text",                        	  
				contentType : "application/json; charset=UTF-8",       
				data : jsonData,          		     		 
				success: function(data) {
					var folder;
					if (data > 1) {
						folder = '/web_server';
						location.href = folder + '/download/' + fileName;
					} else if (data == 0) {
						alert('서버의 용량이 부족합니다.');
					} else {
						folder = '/webserver';
						location.href = folder + '/download/' + fileName;
					}
					/* $('.downloadButton').attr('disabled', false);
					$('.downloadButton').css('opacity', '1'); */
					isDownload = true;
					$('.downloadImage').css({"transform": "translate3d(-310px, 0, 0)"});
				},
				error: function(errorThrown) {
					alert("에러 = " + errorThrown.statusText);
					alert("메세지 = " + data);
				}
			}); 
		} else {
			alert('다운로드중입니다.');
		}
	});

	//$('#iframe').height($(window).innerHeight());
	//$('#iframe').height('2000px');
	var websocketUrl = '/websocket';
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		/* 
		stompClient.subscribe('/downloadZip', function (message) {
			location.href = '/web_server/' + JSON.parse(get('userdata')).user_id + '/download/' + message.body;
		});
		*/
		/* stompClient.subscribe('/tmpResponse', function (message) {
			var json = JSON.parse(message.body);
			var login_id = json.user_name;
			if (login_id == JSON.parse(get('userdata')).user_id) {
				alert(message.body);
			}
		}); */
		stompClient.subscribe('/showPopupImage', function (message) {
			var json = JSON.parse(message.body);
			var img_name = json.img_name;
			var width = json.width;
			var height = json.height;
			var event_name = json.event_name;
			var dev_ip = json.dev_ip;
			var login_id = json.login_id;
			console.log(get('userdata') != null);
			if (get('userdata') != null) {
				if (width < 1280 || height < 720) {
				} else {
					width = 1280;
					height = 720;
				}
				
				//if (popupWidth)
				
				console.log(width + "x" + height);
				
				// 포커싱 되지 않았으면 닫고 킴
				
				/* if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed)
					popup_window[POPUP_MORE].close(); */
				
				//popup_window[POPUP_MORE] = openWindow('/resources/image/test/KakaoTalk_20200406_150529630.jpg', 'image', 1400, 880);

				popup_window[POPUP_MORE] = openWindow('/popUpImage?src=' + img_name + '&width=' + width + '&height=' + height + '&event_name=' + event_name + "&dev_ip=" + dev_ip, event_name, 1280, 720);	// 1280 + 16, 720 + 68
				
				//alert("width = " + popup_window[POPUP_MORE].document.body.offsetWidth);
				//alert("height = " + popup_window[POPUP_MORE].document.body.offsetHeight);
				
				//popup_window[POPUP_MORE].resizeTo(width, height);
			}
		});
		/* stompClient.subscribe('/playAlarm', function (message) {
			var json = JSON.parse(message.body);

			if (get('userdata') != null) {
				var audio = document.getElementById('audio_play');
				
			    if (!audio.paused) { 
			    } else{ 
			        audio.pause(); 
			    }

		        audio.play();
			}
		}); */
		stompClient.subscribe('/eventStatus', function (message) {
			if (get('userdata') != null) {
				if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed) {
				} else {
					popup_window[POPUP_MORE] = openWindow('/eventStatusSetup', 'eventStatusSetup', 1280, 720);	// 1280 + 16, 720 + 68	
				}
			}
		});
	});
	$('#output_path').change(function (e) {
		$('#formUploadDir').submit();
	});
});
function menuClick(flag) {
	$('#iframe').attr('src', flag);
}
function newMenu() {
	var page = document.getElementById("newMenu").value;
	
	var popupX = (screen.availWidth - width) / 2;
	var popupY = (screen.availHeight - height) / 2;
	var scrollbars = (pageName == 'webNoticeAdd' || pageName == 'webNoticeModify') ? 'yes' : 'no';
	var width = '1400';
	var height = '800';
	var pageName = page;
	
	if (page != 'none') {
		var popup_window = window.open(page, pageName, 'width=' + width + ', height=' + height + ', toolbar=no, location=no, status=no, menubar=no, scrollbars=' + scrollbars + ', resizable=no, left=' + popupX + ', top=' + popupY);	
	}
}
function openWindow(page, pageName, width, height) {
	var popupX = (screen.availWidth - width) / 2;
	var popupY = (screen.availHeight - height) / 2;
	var scrollbars = (pageName == 'webNoticeAdd' || pageName == 'webNoticeModify') ? 'yes' : 'no';

	var popup_window = window.open(page, pageName, 'width=' + width + ', height=' + height + ', toolbar=no, location=no, status=no, menubar=no, scrollbars=' + scrollbars + ', resizable=no, left=' + popupX + ', top=' + popupY);

	//popup_window.focus();
	
	return popup_window;
}
function popupMenu(flag) {
	window.open(flag, flag, 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 500, left = 50, location = no')
}
function updateData() {
	var jsonUrl = "/updateData";
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		//dataType : "text",                        	  
		contentType : "application/json; charset=UTF-8",       
		success: function() {
			alert('데이터가 옯겨졌습니다.');		
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	}); 
}
function openUl() {
	var setup_ul = document.getElementById('setup_ul');
	setup_ul.style.display = (setup_ul.style.display == '' ? 'block' : '')
}
function saveTestImage() {
	$('#output_path').click();
}
function connectMonitoring(url) {
	location.href = url;
}
function networkTest() {
	var jsonUrl = "/sendSpeakerNumber";
	var obj = new Object();
	obj.num = 0;
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "text",                        	  
		contentType : "application/json; charset=UTF-8",
		data : jsonData,        		     		 
		success: function(data) {
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});
}
</script>
</head>
<body style="overflow-y:hidden;">
<table style="width:100%; height:100%;">
<tr><td id="tabMenu" style="width:13%; background:linear-gradient(-45deg, #252525, #424242)">
<div style="padding-top:12px; height:100%; min-width:245px;">
	<div id="logo">
		<img src="/resources/image/Police/logo_RECON.ico" alt="logo" />
		<span style="position:absolute; top:18px;">&nbsp;&nbsp;<spring:message code="tab.titleFirstName" /><br />&nbsp;&nbsp;<spring:message code="tab.titleSecondName" /></span>
	</div>
	<div id="menu">
		<ul>
			<li id="tab1" style="display:none;"><span onclick="menuClick('./dashBoard.htm');" class="tabMenu active" style="padding-left:1px;"><span class="glyphicon glyphicon-cloud" style="margin-right:0.7em;"></span><spring:message code="tab.dashboard"/></span></li>
			<li id="tab14" style="display:none;"><span onclick="connectMonitoring('kmonitoring://');" class="tabMenu"><span class="glyphicon glyphicon-bell" style="margin-right:0.7em;"></span><spring:message code="tab.liveMonitoring"/></span></li>
			<li id="tab5" style="display:none;"><span onclick="menuClick('./album.htm');" class="tabMenu"><span class="glyphicon glyphicon-book" style="margin-right:0.7em;"></span><spring:message code="tab.gallery"/></span></li>
			<li id="tab6" style="display:none;"><span onclick="menuClick('./log.htm');" class="tabMenu"><span class="glyphicon glyphicon-bell" style="margin-right:0.7em;"></span><spring:message code="tab.log"/></span>
			<li id="tab7" style="display:none;"><span onclick="menuClick('./eventStatusSetup.htm');" class="tabMenu"><span class="glyphicon glyphicon-list-alt" style="margin-right:0.7em;"></span><spring:message code="tab.eventStatus"/></span></li>
			<li id="tab2" style="display:none;"><span onclick="menuClick('./userList.htm');" class="tabMenu" style="padding-left:1px;"><span class="glyphicon glyphicon-user" style="margin-right:0.7em;"></span><spring:message code="tab.user"/></span></li>
			<li id="tab3" style="display:none;"><span onclick="menuClick('./device.htm');" class="tabMenu" style="padding-left:1px;"><span class="glyphicon glyphicon-blackboard" style="margin-right:0.7em;"></span><spring:message code="tab.device"/></span>
				<ul id="device_ul">
					<li><a href="#" class="tabMenu" onclick="menuClick('./deviceSearch.htm');"><spring:message code="tab.device.search"/></a></li>
					<!-- <li><a href="#" class="tabMenu" onclick="menuClick('./deviceJoin.htm');">등록</a></li> -->
					<li><a href="#" class="tabMenu" onclick="menuClick('./eventSetup.htm');"><spring:message code="tab.device.setup"/></a></li>
					<!-- <li><a href="#" class="tabMenu" onclick="menuClick('./eventActionSetup.htm');">이벤트 액션 설정</a></li> -->
					<li><a href="#" class="tabMenu" onclick="menuClick('./eventActionList.htm');"><spring:message code="tab.device.actionSetup"/></a></li>
					<!-- <li><a href="#" class="tabMenu" onclick="menuClick('./rejectSetup.htm');">이벤트 무시 설정</a></li> -->
					<li><a href="#" class="tabMenu" onclick="menuClick('./networkSpeakerList.htm');"><spring:message code="tab.device.networkSpeaker"/></a></li>
				</ul>
			</li>
			<li id="tab13" style="display:none;"><span onclick="location.href='http://10.15.32.150:18080';" class="tabMenu"><span class="glyphicon glyphicon-tint" style="margin-right:0.7em;"></span><spring:message code="tab.AISystemFirstName"/><br />&nbsp;&nbsp; <spring:message code="tab.AISystemSecondName"/></span></li>
			<!-- <li id="tab4" style="display:none;"><span onclick="menuClick('./image.htm');" class="tabMenu" style="padding-left:1px;"><span class="glyphicon glyphicon-facetime-video" style="margin-right:0.7em;"></span>모니터링</span></li> -->
			<!-- <li id="tab4" style="display:none;"><span onclick="menuClick('./monitor.htm');" class="tabMenu" style="padding-left:1px;"><span class="glyphicon glyphicon-facetime-video" style="margin-right:0.7em;"></span>모니터링</span></li> -->
				<!-- <ul id="log_ul">
					<li><a href="#" class="tabMenu" onclick="menuClick('./eventStatusSetup.htm');">이벤트 현황</a></li>
				</ul> -->
			<li id="tab9" style="display:none;"><span onclick="openUl();" class="tabMenu"><span class="glyphicon glyphicon-cog" style="margin-right:0.7em;"></span><spring:message code="tab.setup"/></span>
				<ul id="setup_ul">
					<li><a href="#" onclick="menuClick('./license.htm');"><spring:message code="tab.setup.license"/></a></li>
					<li><a href="#" onclick="menuClick('./driveSize.htm');"><spring:message code="tab.setup.storageSpace"/></a></li>
					<li><a href="#" onclick="menuClick('./oem.htm');"><spring:message code="tab.setup.about"/></a></li>
					<li><a href="#" onclick="menuClick('./urlSetup.htm');"><spring:message code="tab.setup.url"/></a></li>
					<!-- <li><a href="#">History</a></li> -->
					<!-- <li><a href="#">About</a></li> -->
					<!-- <li><a href="#">Contact</a></li> -->
				</ul>
			</li>
			<!-- <li id="tab15" style="display:none;"><span onclick="networkTest();" class="tabMenu"><span class="glyphicon glyphicon-list-alt" style="margin-right:0.7em;"></span>네트워크 스피커 테스트</span></li> -->
			<!-- <li id="tab10" style="display:none;"><span onclick="menuClick('./backupLog.htm');" class="tabMenu"><span class="glyphicon glyphicon-pencil" style="margin-right:0.7em;"></span>BackupLog</span></li> -->
			<!-- <li id="tab11" style="display:none;"><span onclick="menuClick('./errorLog.htm');" class="tabMenu"><span class="glyphicon glyphicon-remove" style="margin-right:0.7em;"></span>ErrorLog</span></li> -->
            <!-- <li id="tab12" style="display:none;"><span onclick="saveTestImage();" class="tabMenu"><span class="glyphicon glyphicon-remove" style="margin-right:0.7em;"></span>saveTestImage</span></li> -->
			<!-- <li id="tab9" style="display:none;"><span onclick="updateData();" class="tabMenu"><span class="glyphicon glyphicon-list-alt" style="margin-right:0.7em;"></span>test</span></li> -->
			<li id="tab8" class="dropdown nav-item" style="display:none;">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false" style="height:100%;">
				+
				</a>
				<ul class="dropdown-menu" role="menu">
	                <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="popupMenu('./dashBoard.htm');"><spring:message code="tab.dashboard"/></a></li>
	                <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="popupMenu('./userList.htm');"><spring:message code="tab.user"/></a></li>
	                <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="popupMenu('./device.htm');"><spring:message code="tab.device"/></a></li>
	                <!-- <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="popupMenu('./image.htm');">모니터링</a></li> -->
	                <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="popupMenu('./album.htm');"><spring:message code="tab.gallery"/></a></li>
	                <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="popupMenu('./log.htm');"><spring:message code="tab.log" /></a></li>
	                <li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="popupMenu('./eventActionList.htm');"><spring:message code="tab.device.actionSetup" /></a></li>
				</ul>
			</li>
			<!-- <li id="tab9" style="display:none;"><span onclick="updateData();" class="tabMenu"><span class="glyphicon glyphicon-list-alt" style="margin-right:0.7em;"></span>업데이트 데이터</span></li> -->
			<!-- <li id="tab8" style="display:none;"><span onclick="updateData();" class="tabMenu"><span class="glyphicon glyphicon-list-alt" style="margin-right:0.7em;"></span>데이터 업데이트</span></li>
			<li id="tab8" style="display:none;"><span onclick="menuClick('./test.htm');" class="tabMenu"><span class="glyphicon glyphicon-list-alt" style="margin-right:0.7em;"></span>테스트</span></li>
			<li id="tab9" style="display:none;"><span onclick="menuClick('./search.htm');" class="tabMenu"><span class="glyphicon glyphicon-list-alt" style="margin-right:0.7em;"></span>Search</span></li>
			<li id="tab10" style="display:none;"><a class="tabMenu" onclick="popupMenu('./image.htm');">모니터링(팝업)</a></li> -->
		</ul>
	</div>
	<!-- <div id="new">
		<select name="choice" class="form-control" id="newMenu" onchange="newMenu('page')" style="display:none;">
			<option value="none" selected>새 창 추가</option>
			<option value="./main.htm">Dashboard</option>
			<option value="./user.htm">User</option>
			<option value="./device.htm">Device</option>
			<option value="./image.htm">Monitoring</option>
			<option value="./album.htm">Gallery</option>
			<option value="./monitoring.htm">Log</option>
			<option value="eventAction">Event Action</option>
		</select>
	</div> -->
	<div id ="logout" style="width:100%; text-align:-webkit-right;">
		<span id="downloadButton" style="font-size:22px; display:none;" class="glyphicon glyphicon-circle-arrow-down"></span>
		<span id="logoutButton" style="font-size:22px; display:none;" class="glyphicon glyphicon-off"></span>
	</div>
	<div class="downloadImage" style="width:300px; max-width:300px; height:80px; max-height:80px;">
		<h2 class="">다운로드중...</h2>
		<!-- <img src="/resources/image/16.gif" width="100%" /> -->
	</div>
</div>
</td>
<td style="width:87%;">
	<iframe id="iframe" src="./login.htm" style="width:100%; height:100%;"></iframe>
</td></tr>
<tr style="background-color:#464646; height:3%;">
	<td colspan="2">
		<div>
			<div class="bottom_logo">
				<!-- Powered by  <img src="/resources/image/Police/GY.png"/> -->
			</div>
		</div>
	</td>
</tr>
</table>
<button class="downloadButton"></button>
<button class="downloadButton2"></button>
<audio id='audio_play' src='/resources/download/AlarmOut.mp3'></audio><label id="form_label" for="output_path" style="margin:0; display:none;">업로드 폴더를 선택해주세요.</label>
<form action="/saveTestImage" name="analyzeForm" method="post" enctype="multipart/form-data" id="formUploadDir" target="iframe" style="display:none;">
	<input type="file" accept=".jpg" id="output_path" name="file" webkitdirectory mozdirectory msdirectory odirectory directory multiple style="position:absolute; clip:rect(0,0,0,0); border: 0;width:1px; height:1px; padding:0; margin:-1px; overflow: hidden; "/>
</form>
</body>
</html>