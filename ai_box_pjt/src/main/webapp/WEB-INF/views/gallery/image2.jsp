<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<script src="./resources/js/imagesloaded.pkgd.min.js"></script>
<script src="./resources/js/imagesloaded.pkgd.js"></script>
<style>
button:focus {outline:0;}
html {
	/* height:100%; */
}
body {
	/* height:100%; */
	-webkit-font-smoothing:antialiased;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:#fff;
	background-color:#252525;
	margin:0;
	text-size-adjust:100%;
}
* {
	-webkit-tap-highlight-color:transparent;
}
.topInfo {	/* 상단 메뉴 전체  */
	left:0;
	right:0;
	top:0;
	height:72px;
	position:absolute;
	z-index:1;
	transition:all 0.5s linear;
}
.topDiv {	/* 상단 메뉴 전체 64px */
	background-image:linear-gradient(0deg,rgba(0,0,0,0),rgba(0,0,0,0.4));
	box-shadow:none;
	top:0;
	left:0;
	width:100%;
	height:64px;
	opacity:1;
	transform:translateZ(0);
	position:absolute;
	transition:all 0.5s linear;
}
.menu3 {		/* 상단 메뉴 좌우 패딩 14px */
	align-items:center;
	display:flex;
	justify-content:space-between;
	background-color:transparent;
	color:#fff;
	height:64px;
	left:0;
	padding:0 14px;
	position:absolute;
	right:0;
	top:0;
	z-index:200;
	transform:translateZ(0);
	transition:all 0.5s linear;
}
.preDiv {
	display:flex;
	flex:0 1 auto;
	transition:all 0.5s linear;
}
.pre {
	flex-shrink:0;
	align-self:flex-start;
	margin:8px 0;
	display:inline-block;
	min-width:0;
	vertical-align:bottom;
}
.arrowDiv {
	text-align:center;
	vertical-align:bottom;
	z-index:0;
	display:inline-block;
	position:relative;
	box-sizing:border-box;
	border:none;
	outline:none;
	background-color:transparent;
	fill:currentColor;
	font-size:24px;
	text-decoration:none;
	cursor:pointer;
	width:48px;
	height:48px;
	padding:12px;
	--mdc-ripple-fg-size:0x;
	--mdc-ripple-left:0;
	--mdc-ripple-top:0;
	--mdc-ripple-fg-scale:1;
	--mdc-ripple-fg-translate-end:0;
	--mdc-ripple-fg-translate-start:0;
	-webkit-tap-highlight-color:rgba(0,0,0,0);
	will-change:transform,opacity;
	transition:all 0.5s linear;
	color:#fff;
}
a {
	color:white;
}
a:hover {
	text-decoration:none;
	color:#007ACC;
}
.arrow {
	height:100%;
	left:0;
	/* position:absolute; */
	top:0;
	width:100%;
	outline:none;
}
.arrowDiv:hover{
	background-color:rgba(150,150,150,0.1);
	border-radius:50%;
}
.arrowDiv:active{
	background-color:rgba(150,150,150,1);
	border-radius:50%;
}
.arrowSpan {
	width:24px;
	height:24px;
	color:#fff;
}
.menu2 {
	color:#fff;
	display:flex;
	flex:1 1 auto;
	justify-content:flex-end;
	transition:all 0.5s linear;
}
.iconInfo {
	align-items:center;
	display:inline-flex;
	transition:all 0.5s linear;
}
.infoIcon {
	margin:8px 0;
	display:inline-block;
	min-width:0;
	transition:all 0.5s linear;
	/* vertical-align:bottom; */
}
.infoBtn {
	/* vertical-align:bottom; */
	color:#fff;
	z-index:0;
	display:inline-block;
	position:relative;
	box-sizing:border-box;
	border:none;
	outline:none;
	background-color:transparent;
	fill:currentColor;
	/* font-size:24px; */
	text-decoration:none;
	cursor:pointer;
	width:48px;
	height:48px;
	padding:12px;
	--mdc-ripple-fg-size:28px;
	--mdc-ripple-left:10px;
	--mdc-ripple-top:10px;
	--mdc-ripple-fg-scale:1.71429;
	--mdc-ripple-fg-translate-end:0;
	--mdc-ripple-fg-translate-start:0;
	-webkit-tap-highlight-color:rgba(0,0,0,0);
	will-change:transform,opacity;
	transition:all 0.5s linear;
	color:#fff;
}
.infoBtn:hover{
	background-color:rgba(150,150,150,0.1);
	border-radius:50%;
}
.infoBtn:active{
	background-color:rgba(150,150,150,1);
	border-radius:50%;
}
.bottomInfo {
	/* position:absolute; */
	bottom:0;
	left:0;
	right:0;
	top:0;
	overflow:hidden;
}
.bottomDiv {
	/* 클래스값  */

	position:absolute;
	overflow:hidden;
	/* 클래스값이 아닌 직접 값  */
	
	/* top:0px;
	left:;
	width:;
	height:;
	transform-origin:50% center;
	transform:matrix(1, 0, 0, 1, 0, 0); */
	transition:all 0.5s linear;
}
.bottomImageDiv {
	transition:all 0.5s linear;
}
.imageDiv2 {
	align-items:center;
	display:flex;
	justify-content:center;
	transform:translateZ(0);
	opacity:1;
	position:absolute;
	transition:all 0.5s linear;
}
.image {
	position:absolute;
	top:0;
	left:0;
	transition:all 0.5s linear;
}
img {
	border:none;
}
.showInfo {
	position:absolute;
	top:0;
	/* bottom:0; */
	right:0;
	min-width:360px;
	max-width:360px;
	/* background:#252525; */
	overflow-y:auto;
	transform:translate3d(360px, 0, 0);
	transition:transform 0.5s linear;
}
.infoTitle {
	display:flex;
	align-items:center;
	flex-direction:row-reverse;
	justify-content:flex-end;
	padding:8px;
}
.closeTitle {
	z-index:0;
	-webkit-tap-highlight-color:rgba(0,0,0,0);
	will-change:transform,opacity;
	display:inline-block;
	position:relative;
	box-sizing:border-box;
	border:none;
	outline:none;
	background-color:transparent;
	fill:currentColor;
	color:inherit;
	font-size:24px;
	text-decoration:none;
	cursor:pointer;
	width:48px;
	height:48px;
	padding:12px;
}
.closeTitle:hover{
	background-color:rgba(150,150,150,0.1);
	border-radius:50%;
}
.closeTitle:active{
	background-color:rgba(150,150,150,1);
	border-radius:50%;
}
.infoSvg {
	vertical-align:top;
	fill:currentColor;
}
.detail {
	color:#fff;
	display:flex;
	padding:14px 24px;
	letter-spacing:0.7272727em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	text-transform:uppercase;
}
.detailInfo {
	margin:0;
	padding:0;
}
.IP {
	/* cursor:pointer; */
	position:relative;
	display:flex;
	align-items:center;
	padding:18px 24px;
	min-height:36px;
}
.IP:hover {
	background-color:rgba(150,150,150,0.1);
}
.IPDt {
	height:24px;
	min-width:40px;
	width:40px;
}
.IPSvg {
	fill:#fff;
}
.IPDd {
	margin:0;
	overflow:hidden;
}
.IPDiv {
	color:#fff;
	letter-spacing:.00625em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
}
.chDiv {
	align-items:center;
	color:#fff;
	display:flex;
	flex-wrap:wrap;
	margin-top:0;
	letter-spacing:.01428571em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
}
.chSpan {
	margin-right:12px;
	margin-top:0;
}
.dateTime {
	/* cursor:pointer; */
	position:relative;
	display:flex;
	align-items:center;
	padding:18px 24px;
	min-height:36px;
}
.dateTime:hover {
	background-color:rgba(150,150,150,0.1);
}
.dateDt {
	height:24px;
	min-width:40px;
	width:40px;
}
.dateSvg {
	fill:#fff;
}
.dateDd {
	margin:0;
	overflow:hidden;
}
.dateDiv {
	color:#fff;
	letter-spacing:.00625em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
}
.timeDiv {
	align-items:center;
	color:#fff;
	display:flex;
	flex-wrap:wrap;
	margin-top:0;
	letter-spacing:.01428571em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
}
.timeSpan {
	margin-right:12px;
	margin-top:0;
}
.tagCount {
	/* cursor:pointer; */
	position:relative;
	display:flex;
	align-items:center;
	padding:18px 24px;
	min-height:36px;
}
.tagCount:hover {
	background-color:rgba(150,150,150,0.1);
}
.tagDt {
	height:24px;
	min-width:40px;
	width:40px;
}
.tagSvg {
	fill:#fff;
}
.tagDd {
	margin:0;
	overflow:hidden;
}
.tagDiv {
	color:#fff;
	letter-spacing:.00625em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
}
.countDiv {
	align-items:center;
	color:#fff;
	display:flex;
	flex-wrap:wrap;
	margin-top:0;
	letter-spacing:.01428571em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
}
.countSpan {
	margin-right:12px;
	margin-top:0;
}
#theModal {
	padding:0;
}
.modal-dialog {
	margin:0;
}
</style>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
var marginTop;
var marginLeft;

var width;
var height;

var realWidth;
var realHeight;
var imgWidth;
var imgHeight;

var imgSrc;
var IPinfo;
var chInfo;
var dateInfo;
var timeInfo;
var tagInfo;
var tagArr = [];
var counInfo;

var widthPer;
var heightPer;
var inverse;

var isImageWidth = false;
var isWidth = false;
var isInfo = false;
var changeWidth;
var changeHeight;
var changeTopWidth;
var changeLeft;
var leftVal;
$(document).ready(function () {
	//alert(get('ModalInfoArr'));
  	
   	var day = new Date();
	$('#theModal').css("padding", '0');

	var monitor_size = "${monitor_size}";
	
	var monitor_src = "${monitor_src}";
	
	var event_time = "${event_time}";
	
	var dev_title = "${dev_title}";
	
	var tags = "${tags}";

	var tags = tags.substring(1, tags.length - 1);

	var tagInfo = '';

	for (var i = 0; i < tags.split(', ').length; i++) {
		var spTag = tags.split(', ')[i];
		
		if (spTag.toLowerCase() == 'KWATER_Fire_Detection'.toLowerCase()) {
			tagInfo += '화재';
		}
		if (spTag.toLowerCase() == 'KWATER_Falldown_Detection'.toLowerCase()) {
			tagInfo += '쓰러짐';
		}
		if (spTag.toLowerCase() == 'KWATER_Flood_Detection'.toLowerCase()) {
			tagInfo += '침수';
		}
		if (spTag.toLowerCase() == 'KWATER_Glove_Detection'.toLowerCase()) {
			tagInfo += '장갑미착용';
		}
		if (spTag.toLowerCase() == 'KWATER_Invasion_Detection'.toLowerCase()) {
			tagInfo += '침입';
		}
		if (spTag.toLowerCase() == 'KWATER_Leak_Detection'.toLowerCase()) {
			tagInfo += '누수';
		}
		if (spTag.toLowerCase() == 'KWATER_Loitering_Detection'.toLowerCase()) {
			tagInfo += '배회';
		}
		if (spTag.toLowerCase() == 'KWATER_HandAction_Detection'.toLowerCase()) {
			tagInfo += '수신호';
		}
		if (spTag.toLowerCase() == 'KWATER_Spin_Detection'.toLowerCase()) {
			tagInfo += '약품미투입';
		}
		if (spTag.toLowerCase() == 'KWATER_Cmtank_Leak'.toLowerCase()) {
			tagInfo = '약품탱크누액';
		}
		if (spTag.toLowerCase() == 'KWATER_Outtank_Leak'.toLowerCase()) {
			tagInfo = '옥외탱크누액';
		}
		if (spTag.toLowerCase() == 'KWATER_Overflow'.toLowerCase()) {
			tagInfo = '배출수월류';
		}
		
		if (i < tags.split(', ').length - 1) {
			tagInfo += ', ';
		}
	}

	realWidth = parseInt(monitor_size.split('-')[0]);
	realHeight = parseInt(monitor_size.split('-')[1]);
	imgSrc = monitor_src;
   	chInfo = dev_title;
   	
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
   	var day = new Date(event_time);
   	var year = day.getFullYear();
   	var month = day.getMonth() + 1;
   	var date = day.getDate();
   	var hour = day.getHours();
   	var min = day.getMinutes();
   	var second = day.getSeconds();
   	
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
   	
   	if (second < 10) {
   		second = '0' + second;
   	} 
   	
   	dateInfo = year + "년 " + month + '월 ' + date + "일 " + week[day.getDay()] + "요일";
	timeInfo = hour + "시 " + min + "분 " + second + "초";
	
	/* for (var w = 0; w < tags.split(', ').length; w++) {
		if (w == 0) {
			tagInfo = (tags.split(', ')[w]);
		} else {
			tagInfo += ', ' + (tags.split(', ')[w]);
		}
	} */
	
	imgWidth = parseInt(realWidth);
	imgHeight = parseInt(realHeight);
	
	height = $(window).height();
	width = $(window).width();
	/* height = $(window).height();
	width = $(window).width(); */

	marginTop = (height - imgHeight) / 2;
	marginLeft = (width - imgWidth) / 2;
	
	if (imgWidth > imgHeight) {		// 가로가 더 넓을 때
		widthPer = imgWidth / imgHeight;
		heightPer = imgHeight / imgWidth;
		
		if (!(width > imgWidth)) {
			imgWidth = width;
			marginLeft = 0;
			imgHeight = Math.round(heightPer * imgWidth);
			marginTop = (height - imgHeight) / 2;
		}
		if (!(height > imgHeight)) {
			imgHeight = height;
			marginTop = 0;
			imgWidth = Math.round(widthPer * imgHeight);
			marginLeft = (width - imgWidth) / 2;
		}
		if (imgWidth > width) {
			imgWidth = width;
			marginLeft = 0;
			imgHeight = Math.round(heightPer * imgWidth);
			marginTop = (height - imgHeight) / 2;
		}
	} else if (imgHeight > imgWidth) {		// 세로가 더 넓을 때
		widthPer = imgWidth / imgHeight;
		heightPer = imgHeight / imgWidth;
		
		if (!(height > imgHeight)) {
			imgHeight = height;
			marginTop = 0;
			imgWidth = Math.round(imgWidth / imgWidth * imgHeight);
			marginLeft = (width - imgWidth) / 2;
		}
		if (!(width > imgWidth)) {
			imgWidth = width;
			marginLeft = 0;
			imgHeight = Math.round(imgHeight / imgWidth * imgWidth);
			marginTop = (height - imgHeight) / 2;
		}
		if (imgHeight > height) {
			imgHeight = height;
			marginTop = 0;
			imgWidth = Math.round(widthPer * imgHeight);
			marginLeft = (width - imgWidth) / 2;
		}
	} else {	// 정사각형일 때
		if (!(height > imgHeight) || !(width > imgWidth)) {
			if (height > width) {
				imgHeight = width;
				imgWidth = width;
				marginLeft = 0;
				marginTop = (height - imgHeight) / 2;
			} else {
				imgHeight = height;
				imgWidth = height;
				marginTop = 0;
				marginLeft = (width - imgWidth) / 2;
			}
		}
	}
	
	$('.topInfo').after('<div class="bottomInfo"><div class="bottomDiv" style="top:' + marginTop + 'px; left:' + marginLeft + 'px; width:' + imgWidth + 'px; height:' + imgHeight + 'px;"><div class="bottomImageDiv" style="width:' + imgWidth + 'px; height:' + imgHeight + 'px;"><div class="imagediv2" style="width:' + imgWidth + 'px; height:' + imgHeight + 'px;"><img class="image" id="img" width="' + imgWidth + '" height="' + imgHeight + '" src="' + imgSrc.replace('_thumb', '') + '" style="transform: translate3d(0px, 0px, 0px) rotate(0deg); background-image:url(' + imgSrc + ');" onError="this.src=' + "'" + imgSrc.replace('webserver', 'web_server').replace('_thumb', '') + "'" + '" /></div></div></div></div>');
	//$('.IPDiv').text(IPinfo + ' ch' + chInfo);
	$('.IPDiv').text(chInfo);
	//$('.chSpan').text('ch' + chInfo);
	$('.dateDiv').text(dateInfo);
	$('.timeSpan').text(timeInfo);
	$('.tagDiv').text(tagInfo);
	/* $('.bottomInfo').after(''); */
	
	//$('.bottomDiv').width();
	/* alert($('#img').width());
	alert($('#img').height()); */
	var day2 = new Date();
	$(window).resize(function() {
		$('#theModal').css("padding", '0');
		
		if(!isInfo) {
			height = $(window).height();
			width = $(window).width();
			
			imgWidth = realWidth;
			imgHeight = realHeight;
			/* height = $(window).height();
			width = $(window).width(); */

			marginTop = (height - imgHeight) / 2;
			marginLeft = (width - imgWidth) / 2;
			
			if (imgWidth > imgHeight) {		// 가로가 더 넓을 때
				widthPer = imgWidth / imgHeight;
				heightPer = imgHeight / imgWidth;
				if (!(width > imgWidth)) {
					imgWidth = width;
					marginLeft = 0;
					imgHeight = Math.round(heightPer * imgWidth);
					marginTop = (height - imgHeight) / 2;
				}
				if (!(height > imgHeight)) {
					imgHeight = height;
					marginTop = 0;
					imgWidth = Math.round(widthPer * imgHeight);
					marginLeft = (width - imgWidth) / 2;
				}
				if (imgWidth > width) {
					imgWidth = width;
					marginLeft = 0;
					imgHeight = Math.round(heightPer * imgWidth);
					marginTop = (height - imgHeight) / 2;
				}
				
			} else if (imgHeight > imgWidth) {		// 세로가 더 넓을 때
				widthPer = imgWidth / imgHeight;
				heightPer = imgHeight / imgWidth;
				
				if (!(height > imgHeight)) {
					imgHeight = height;
					marginTop = 0;
					imgWidth = Math.round(imgWidth / imgWidth * imgHeight);
					marginLeft = (width - imgWidth) / 2;
				}
				if (!(width > imgWidth)) {
					imgWidth = width;
					marginLeft = 0;
					imgHeight = Math.round(imgHeight / imgWidth * imgWidth);
					marginTop = (height - imgHeight) / 2;
				}
				if (imgHeight > height) {
					imgHeight = height;
					marginTop = 0;
					imgWidth = Math.round(widthPer * imgHeight);
					marginLeft = (width - imgWidth) / 2;
				}
			} else {	// 정사각형일 때
				if (!(height > imgHeight) || !(width > imgWidth)) {
					if (height > width) {
						imgHeight = width;
						imgWidth = width;
						marginLeft = 0;
						marginTop = (height - imgHeight) / 2;
					} else {
						imgHeight = height;
						imgWidth = height;
						marginTop = 0;
						marginLeft = (width - imgWidth) / 2;
					}
				}
			}

			$(".bottomDiv").css("top", marginTop);
			$(".bottomDiv").css("left", marginLeft);

			$('.topInfo').width(width);
			
			$('.bottomDiv').width(imgWidth);
			$('.bottomDiv').height(imgHeight);
			
			$('.bottomImageDiv').width(imgWidth);
			$('.bottomImageDiv').height(imgHeight);
			
			$('.imagediv2').width(imgWidth);
			$('.imagediv2').height(imgHeight);
			
			$('.image').width(imgWidth);
			$('.image').height(imgHeight);
			
		} else {
			height = $(window).height();
			width = $(window).width() - 360;
			
			imgWidth = parseInt(realWidth);
			imgHeight = parseInt(realHeight);
			/* height = $(window).height();
			width = $(window).width(); */

			marginTop = (height - imgHeight) / 2;
			marginLeft = (width - imgWidth) / 2;
	        
			if (!(width > 500)) {
				imgWidth = 0;
				imgHeight = 0;
				
				$('.topInfo').css('display', 'none');
				
				$(".bottomDiv").css("top", 0);
				$(".bottomDiv").css("left", 0);

				$('.topInfo').width(imgWidth);
				$('.topInfo').height(imgHeight);
				
				$('.bottomDiv').width(imgWidth);
				$('.bottomDiv').height(imgHeight);
				
				$('.bottomImageDiv').width(imgWidth);
				$('.bottomImageDiv').height(imgHeight);
				
				$('.imagediv2').width(imgWidth);
				$('.imagediv2').height(imgHeight);
				
				$('.image').width(imgWidth);
				$('.image').height(imgHeight);
				
			} else {
				imgWidth = parseInt(realWidth);
				imgHeight = parseInt(realHeight);
				/* height = $(window).height();
				width = $(window).width(); */

				marginTop = (height - imgHeight) / 2;
				marginLeft = (width - imgWidth) / 2;
				

				if (imgWidth > imgHeight) {		// 가로가 더 넓을 때
					widthPer = imgWidth / imgHeight;
					heightPer = imgHeight / imgWidth;
					if (!(width > imgWidth)) {
						imgWidth = width;
						marginLeft = 0;
						imgHeight = Math.round(heightPer * imgWidth);
						marginTop = (height - imgHeight) / 2;
					}
					if (!(height > imgHeight)) {
						imgHeight = height;
						marginTop = 0;
						imgWidth = Math.round(widthPer * imgHeight);
						marginLeft = (width - imgWidth) / 2;
					}
					if (imgWidth > width) {
						imgWidth = width;
						marginLeft = 0;
						imgHeight = Math.round(heightPer * imgWidth);
						marginTop = (height - imgHeight) / 2;
					}
					
				} else if (imgHeight > imgWidth) {		// 세로가 더 넓을 때
					widthPer = imgWidth / imgHeight;
					heightPer = imgHeight / imgWidth;
					
					if (!(height > imgHeight)) {
						imgHeight = height;
						marginTop = 0;
						imgWidth = Math.round(imgWidth / imgWidth * imgHeight);
						marginLeft = (width - imgWidth) / 2;
					}
					if (!(width > imgWidth)) {
						imgWidth = width;
						marginLeft = 0;
						imgHeight = Math.round(imgHeight / imgWidth * imgWidth);
						marginTop = (height - imgHeight) / 2;
					}
					if (imgHeight > height) {
						imgHeight = height;
						marginTop = 0;
						imgWidth = Math.round(widthPer * imgHeight);
						marginLeft = (width - imgWidth) / 2;
					}
				} else {	// 정사각형일 때
					if (!(height > imgHeight) || !(width > imgWidth)) {
						if (height > width) {
							imgHeight = width;
							imgWidth = width;
							marginLeft = 0;
							marginTop = (height - imgHeight) / 2;
						} else {
							imgHeight = height;
							imgWidth = height;
							marginTop = 0;
							marginLeft = (width - imgWidth) / 2;
						}
					}
				}

				$(".bottomDiv").css("top", marginTop);
				$(".bottomDiv").css("left", marginLeft);

				if ($('.topInfo').css('display') == 'none') {
					$('.topInfo').css('display', '');
				}
				
				$('.topInfo').width(width);
				
				$('.bottomDiv').width(imgWidth);
				$('.bottomDiv').height(imgHeight);
				
				$('.bottomImageDiv').width(imgWidth);
				$('.bottomImageDiv').height(imgHeight);
				
				$('.imagediv2').width(imgWidth);
				$('.imagediv2').height(imgHeight);
				
				$('.image').width(imgWidth);
				$('.image').height(imgHeight);
			}
		}
		
		//alert($(this).width());
		//alert($(this).height());
	
	});

	$('.arrow').click(function () {
        $('.showInfo').css({"transform": "translate3d(360px, 0, 0)"});
		$('#theModal').removeClass('show');
		$('#theModal').modal('hide');        
		$('#theModal').css("display", "none");
		$('body').removeClass('modal-open');
		$('body').css("padding", "0");
		$(".modal-backdrop").remove();
		if(isInfo) {
			$('.showInfo').css({"transform": "translate3d(360px, 0, 0)"});
			
			var tmpLeft = $('.bottomDiv').offset().left;
			
			$(".bottomDiv").css("top", marginTop);
			$(".bottomDiv").css("left", marginLeft);
			
			$('.bottomDiv').width(imgWidth);
			$('.bottomDiv').height(imgHeight);
			
			$('.bottomImageDiv').width(imgWidth);
			$('.bottomImageDiv').height(imgHeight);
			
			$('.imagediv2').width(imgWidth);
			$('.imagediv2').height(imgHeight);
			
			$('.image').width(imgWidth);
			$('.image').height(imgHeight);
			      
			$('.topInfo').width($(window).width());
				isInfo = false;
			}
	});

	$('.infoBtn').click(function () {
		if (!isInfo) {
	        $('.showInfo').css({"transform": "translate3d(0, 0, 0)"});
			
	        leftVal = $('.bottomDiv').offset().left;
	        
	        if (leftVal > 360) {
	        	leftVal = leftVal - 360;
	        	changeWidth = imgWidth;
	        	
		        $(".bottomDiv").css("left", leftVal);
		        
	        } else {
	        	changeWidth = imgWidth - (360 - leftVal);
	        	leftVal = (360 - leftVal);

		        $(".bottomDiv").css("left", 0);
	        }
	        
	        if (width > 500) {
	        	changeTopWidth = width - 360;
	        } else {
	        	$('.topInfo').css('display', 'none');
	        	changeTopWidth = 0;
	        	changeWidth = 0;
	        }

	        if (changeWidth > 0) {
	        	changeHeight = Math.round(heightPer * changeWidth); 
		        $(".bottomDiv").css("top", (height - changeHeight) / 2);
	        } else {
	        	changeHeight = 0;
		        $(".bottomDiv").css("top", 0);
	        }
	        
			$('.topInfo').width(changeTopWidth);
			
			$('.bottomDiv').width(changeWidth);
			$('.bottomDiv').height(changeHeight);
			
			$('.bottomImageDiv').width(changeWidth);
			$('.bottomImageDiv').height(changeHeight);
			
			$('.imagediv2').width(changeWidth);
			$('.imagediv2').height(changeHeight);
			
			$('.image').width(changeWidth);
			$('.image').height(changeHeight);
			
			isInfo = true;
			
		} else {
	       $('.showInfo').css({"transform": "translate3d(360px, 0, 0)"});
			height = $(window).height();
			width = $(window).width();
			
			imgWidth = realWidth;
			imgHeight = realHeight;
			/* height = $(window).height();
			width = $(window).width(); */

			marginTop = (height - imgHeight) / 2;
			marginLeft = (width - imgWidth) / 2;
			
			if (imgWidth > imgHeight) {		// 가로가 더 넓을 때
				widthPer = imgWidth / imgHeight;
				heightPer = imgHeight / imgWidth;
				if (!(width > imgWidth)) {
					imgWidth = width;
					marginLeft = 0;
					imgHeight = Math.round(heightPer * imgWidth);
					marginTop = (height - imgHeight) / 2;
				}
				if (!(height > imgHeight)) {
					imgHeight = height;
					marginTop = 0;
					imgWidth = Math.round(widthPer * imgHeight);
					marginLeft = (width - imgWidth) / 2;
				}
				if (imgWidth > width) {
					imgWidth = width;
					marginLeft = 0;
					imgHeight = Math.round(heightPer * imgWidth);
					marginTop = (height - imgHeight) / 2;
				}
				
			} else if (imgHeight > imgWidth) {		// 세로가 더 넓을 때
				widthPer = imgWidth / imgHeight;
				heightPer = imgHeight / imgWidth;
				
				if (!(height > imgHeight)) {
					imgHeight = height;
					marginTop = 0;
					imgWidth = Math.round(imgWidth / imgWidth * imgHeight);
					marginLeft = (width - imgWidth) / 2;
				}
				if (!(width > imgWidth)) {
					imgWidth = width;
					marginLeft = 0;
					imgHeight = Math.round(imgHeight / imgWidth * imgWidth);
					marginTop = (height - imgHeight) / 2;
				}
				if (imgHeight > height) {
					imgHeight = height;
					marginTop = 0;
					imgWidth = Math.round(widthPer * imgHeight);
					marginLeft = (width - imgWidth) / 2;
				}
			} else {	// 정사각형일 때
				if (!(height > imgHeight) || !(width > imgWidth)) {
					if (height > width) {
						imgHeight = width;
						imgWidth = width;
						marginLeft = 0;
						marginTop = (height - imgHeight) / 2;
					} else {
						imgHeight = height;
						imgWidth = height;
						marginTop = 0;
						marginLeft = (width - imgWidth) / 2;
					}
				}
			}

			$(".bottomDiv").css("top", marginTop);
			$(".bottomDiv").css("left", marginLeft);

			$('.topInfo').width(width);
			
			$('.bottomDiv').width(imgWidth);
			$('.bottomDiv').height(imgHeight);
			
			$('.bottomImageDiv').width(imgWidth);
			$('.bottomImageDiv').height(imgHeight);
			
			$('.imagediv2').width(imgWidth);
			$('.imagediv2').height(imgHeight);
			
			$('.image').width(imgWidth);
			$('.image').height(imgHeight);
			
	        isInfo = false;
		}
	});

	$('.closeTitle').click(function () {
	       $('.showInfo').css({"transform": "translate3d(360px, 0, 0)"});

			height = $(window).height();
			width = $(window).width();
			
			imgWidth = realWidth;
			imgHeight = realHeight;
			/* height = $(window).height();
			width = $(window).width(); */

			marginTop = (height - imgHeight) / 2;
			marginLeft = (width - imgWidth) / 2;
			
			if (imgWidth > imgHeight) {		// 가로가 더 넓을 때
				widthPer = imgWidth / imgHeight;
				heightPer = imgHeight / imgWidth;
				if (!(width > imgWidth)) {
					imgWidth = width;
					marginLeft = 0;
					imgHeight = Math.round(heightPer * imgWidth);
					marginTop = (height - imgHeight) / 2;
				}
				if (!(height > imgHeight)) {
					imgHeight = height;
					marginTop = 0;
					imgWidth = Math.round(widthPer * imgHeight);
					marginLeft = (width - imgWidth) / 2;
				}
				if (imgWidth > width) {
					imgWidth = width;
					marginLeft = 0;
					imgHeight = Math.round(heightPer * imgWidth);
					marginTop = (height - imgHeight) / 2;
				}
				
			} else if (imgHeight > imgWidth) {		// 세로가 더 넓을 때
				widthPer = imgWidth / imgHeight;
				heightPer = imgHeight / imgWidth;
				
				if (!(height > imgHeight)) {
					imgHeight = height;
					marginTop = 0;
					imgWidth = Math.round(imgWidth / imgWidth * imgHeight);
					marginLeft = (width - imgWidth) / 2;
				}
				if (!(width > imgWidth)) {
					imgWidth = width;
					marginLeft = 0;
					imgHeight = Math.round(imgHeight / imgWidth * imgWidth);
					marginTop = (height - imgHeight) / 2;
				}
				if (imgHeight > height) {
					imgHeight = height;
					marginTop = 0;
					imgWidth = Math.round(widthPer * imgHeight);
					marginLeft = (width - imgWidth) / 2;
				}
			} else {	// 정사각형일 때
				if (!(height > imgHeight) || !(width > imgWidth)) {
					if (height > width) {
						imgHeight = width;
						imgWidth = width;
						marginLeft = 0;
						marginTop = (height - imgHeight) / 2;
					} else {
						imgHeight = height;
						imgWidth = height;
						marginTop = 0;
						marginLeft = (width - imgWidth) / 2;
					}
				}
			}

			$(".bottomDiv").css("top", marginTop);
			$(".bottomDiv").css("left", marginLeft);

			$('.topInfo').width(width);
			
			$('.bottomDiv').width(imgWidth);
			$('.bottomDiv').height(imgHeight);
			
			$('.bottomImageDiv').width(imgWidth);
			$('.bottomImageDiv').height(imgHeight);
			
			$('.imagediv2').width(imgWidth);
			$('.imagediv2').height(imgHeight);
			
			$('.image').width(imgWidth);
			$('.image').height(imgHeight);
	        isInfo = false;
	});
});
</script>
</head>
<body>
<div class="topInfo">
	<div class="topDiv">
		<div class="menu3">
			<div class="preDiv">
				<div class="pre">
					<div class="arrowDiv">
						<a class="arrow">
							<span class="arrowSpan">
								<svg width="24px" height="24px" viewBox="0 0 24 24">
									<path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"></path>
								</svg>
							</span>
						</a>
					</div>
				</div>
			</div>
			
			<span class="menu2">
				<div class="iconInfo">
					<div class="infoIcon">
						<button class="infoBtn">
							<span>
								<svg width="24px" height="24px" viewBox="0 0 24 24">
									<path d="M11 7h2v2h-2zm0 4h2v6h-2zm1-9C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z"></path>
								</svg>
							</span>
						</button>
					</div>
				</div>
			</span>
			
		</div>
	</div>
</div>
<div class="showInfo">
	<div>
		<div class="infoTitle">정보
			<button class="closeTitle">
				<span>
					<svg width="24px" height="24px" class="infoSvg" viewBox="0 0 24 24">
						<path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path>
					</svg>
				</span>
			</button>
		</div>
		<div>
			<div>
				<div class="detail">태그정보</div>
				<dl class="detailInfo">
					<div class="IP">
						<dt class="IPDt">
							<svg width="24px" height="24px" class="IPSvg">
								<path d="M19 2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h4l3 3 3-3h4c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 16H5V4h14v14z M12 16l1.57-3.43L17 11l-3.43-1.57L12 6l-1.57 3.43L7 11l3.43 1.57z"></path>
							</svg>
						</dt>
						<dd class="IPDd">
							<div class="IPDiv"></div>
							<div class="chDiv">
								<span class="chSpan"></span>
							</div>
						</dd>
					</div>
					<div class="dateTime">
						<dt class="dateDt">
							<svg width="24px" height="24px" class="dateSvg">
								<path d="M19 3h-1V1h-2v2H8V1H6v2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM9 9.5a2.5 2.5 0 0 0 0 5 2.5 2.5 0 0 0 0-5z"></path>
							</svg>
						</dt>
						<dd class="dateDd">
							<div class="dateDiv"></div>
							<div class="timeDiv">
								<span class="timeSpan"></span>
							</div>
						</dd>
					</div>
					<div class="tagCount">
						<dt class="tagDt">
							<svg width="24px" height="24px" class="tagSvg">
								<path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 18H6V4h6v7l2.5-1.88L17 11V4h1v16zm-4.33-6L17 18H7l2.5-3.2 1.67 2.18 2.5-2.98z"></path>
							</svg>
						</dt>
						<dd class="tagDd">
							<div class="tagDiv"></div>
							<div class="countDiv">
								<span class="countSpan"></span>
							</div>
						</dd>
					</div>
				</dl>
			</div>
		</div>
	</div>
</div>
</body>
</html>