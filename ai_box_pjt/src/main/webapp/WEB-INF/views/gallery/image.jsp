<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../include/searchBar.jsp" %> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
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
#loading {
	display:none;
}
body {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:black;
	background-color:#252525;
	margin:0;
	text-size-adjust:100%;
}
.top {
	left:0;
	right:0;
	top:0;
	height:72px;
	position:fixed;
	z-index :50;
}

.searchHr {
	position:absolute;
	height:5px;
	width:100%;
	top:59px;
	left:0;
	opacity:0;
}
.search {
	align-items:center;
	display:flex;
	/* background:white; */
	padding:0 14px;
	height:64px;
	right:0;
	top:0;
	width:100%;
	-webkit-box-pack:center;
	justify-content:center;
	transition:background linear 270ms,box-shadow linear 0ms 270ms;
}
.searchHidden {
	display:none;
	transition:background linear 270ms,box-shadow linear 0ms 270ms;
}
.searchDiv {
	display:flex;
	flex:0 1 50vw;
	max-width:720px;
}
.searchBar {
	background:#f1f3f4;
	border-radius:8px;
	display:flex;
	flex:0 1 50vw;
	height:48px;
	margin:12px 0;
	transition:background linear 270ms,box-shadow linear 0ms 270ms;
}
.menu {
	justify-content:flex-end;
	display:flex;
	background:white;
	padding:0 14px;
	height:64px;
	width:100%;
	box-shadow: 0 1px 2px 0 rgba(60,64,67,.30), 0 2px 6px 2px rgba(60,64,67,.15);
	transition:background linear 270ms,box-shadow linear 0ms 270ms;
}
.menuHidden {
	display:none;
}
.choiceMenu {
	align-items:center;
}
.downloadDiv {
	outline:none;
	margin:8px 0;
	display:inline-block;
	min-width:0;
	vertical-align:middle;
}
.favoritesDiv {
	outline:none;
	margin:8px 0;
	display:inline-block;
	min-width:0;
	vertical-align:middle;
}
.trashDiv {
	outline:none;
	margin:8px 0;
	display:inline-block;
	min-width:0;
	vertical-align:middle;
}
.downloadButton {
	outline:none;
	vertical-align:middle;
	display:inline-block;
	position:relative;
	border:none;
	background-color:transparent;
	fill:currentColor;
	color:inherit;
	font-size:24px;
	width:48px;
	height:48px;
	padding:12px;
}
.favoritesButton {
	outline:none;
	vertical-align:middle;
	display:inline-block;
	position:relative;
	border:none;
	background-color:transparent;
	fill:currentColor;
	color:inherit;
	font-size:24px;
	width:48px;
	height:48px;
	padding:12px;
}
.trashButton {
	outline:none;
	vertical-align:middle;
	display:inline-block;
	position:relative;
	border:none;
	background-color:transparent;
	fill:currentColor;
	color:inherit;
	font-size:24px;
	width:48px;
	height:48px;
	padding:12px;
}
.downloadButton:hover{
	background-color:#d2d2d2;
	border-radius:50%;
}
.favoritesButton:hover{
	background-color:#d2d2d2;
	border-radius:50%;
}
.trashButton:hover{
	background-color:#d2d2d2;
	border-radius:50%;
}
.downloadButton:focus{
	outline:none;
}
.favoritesButton:focus{
	outline:none;
}
.trashButton:focus{
	outline:none;
}
.downloadSvg {
	fill:#1a73e8;
	transition:fill cubic-bezier(0.4,0.0,0.2,1) 400ms;
	vertical-align:top;
}
.favoritesSvg {
	fill:#1a73e8;
	transition:fill cubic-bezier(0.4,0.0,0.2,1) 400ms;
	vertical-align:top;
}
.trashSvg {
	fill:#1a73e8;
	transition:fill cubic-bezier(0.4,0.0,0.2,1) 400ms;
	vertical-align:top;
}
.svgDiv {
	color:#5f6368;
	margin:12px 16px;
	vertical-align:top;
}
.svg {
	fill:currentColor;
	vertical-align:top;
}
.searchTextDiv {
	height:100%;
	display:flex;
	flex:1;
}
.searchText {
	height:100%;
	background:none;
	border:none;
	vertical-align:top;
	z-index:auto;
	color:#3c4043;
	text-overflow:ellipsis;
	font-size:14px;
	font-weight:500;
	line-height:1.5rem;
	flex-grow:1;
	outline:none;
}
.bottom {
	top:0;
	left:0;
	right:0;
	bottom:0;
	margin-top:72px;
	padding-top:24px;
	padding-left:72px;
	padding-right:432px;		/* 72px */
}
.imageDiv {
	margin-bottom:24px;
}
.allImage {
	top:0px;
	left:0px;
	background:none;
	border-top:0;
	contain:layout;
}
.fail img { display: none; }
img {
	background-image:url(/resources/image/test/image1_gray.png);
	background-size:cover;
	transition:transform .135s cubic-bezier(0.0,0.0,0.2,1), opacity linear .15s;
	background-repeat: no-repeat;
	height:100%;
	background-position:center center;
}
.images {
	contain:layout;
}
.imagesTitle {
	align-items:center;
	display:flex;
	height:44px;
	line-height:44px;
	left:0;
}
.image {
	transition:none 0s ease 0s;
	display:inline-block;
	left:0;
	top:0;
	contain:strict;
}
.imageA {
	bottom:0;
	left:0;
	right:0;
	top:0;
	transition:transform .135s cubic-bezier(0.0,0.0,0.2,1);
	width:100%;
	height:100%;
}
.imageInA {
	background-repeat:no-repeat;
	background-size:100% 100%;
	bottom:0;
	right:0;
	top:0;
	transition:transform .135s cubic-bezier(0.0,0.0,0.2,1),opacity linear .15s;
	width:100%;
	height:100%;
}
.monitoring_tag {
	float:left;
	width:284px;
	height:214px;
	z-index:5;
	cursor:pointer;
}
.monitoring_tag_div {
	width:280px; 
	height:210px;
	background-color:#e8f0fe;
}
.showTitleChk {		/* 마우스 올렸을 때 */
	fill:white;
	/* fill:rgba(0,0,0,.54); */
	cursor:pointer;
	margin-right:4px;
}
.hideTitleChk {		
	display:none;
}
.afterTitleChk {
	fill:#4285f4;
	cursor:pointer;
	margin-right:4px;
}
.showChk {		/* 마우스 올렸을 때 */
	fill:#fff;
	cursor:pointer;
	fill-opacity:0.54;
	position:absolute;
}
.hideChk {		/* 평상시 */
	display:none;
}
.beforeChk {
}
.afterChk {		/* 클릭 시 */
	fill:#fff;
	cursor:pointer;
	position:absolute;
}
.showChkV {
	fill:#fff;
	cursor:pointer;
	fill-opacity:0.54;
	position:absolute;
}
.showChkV:hover {
	fill:#fff;
	cursor:pointer;
	fill-opacity:1;
}
.hideChkV {
	display:none;
}
.beforeChkV {
	fill:#fff;
	color:#fff;
}
.afterChkV {	/* 클릭 시 */
	fill:#4285f4;
	cursor:pointer;
	position:absolute;
}
.beforeChkImage {
	position:relative;
	width:100%;
	height:100%;
	top:-30px;
}
.afterChkImage {
	position:relative;
	width:224px;
	height:168px;
	top:-8px;
	left:28px;
}
.bgDivBefore {
	position:relative;
	width:100%;
	height:100%;
}
.bgDivAfter {
	position:relative;
	width:80%;
	height:80%;
	left:28px;
	top:21px;
}
.icon {
	position:relative;
	width:100%;
	height:30px;
	z-index:10;
}
.titleH2 {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight:bold;
	color:white;
	width:100%; 
	line-height:44px; 
	left:0;
	margin:0;
}
#theModal {
    background-color: rgba(37, 37, 37, 0.5);
	transition: all 0.5s linear;
}
.modal-dialog {
	margin:0;
}
/* .downloadImageHide {
	display:none;
} */
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
#searchModal {
	z-index:300;
	background-color:#fff;
	position:absolute;
	top:0;
	left:0;
	right:0;
	bottom:0;
}
.closeFilter {
	z-index:0;
	-webkit-tap-highlight-color:rgba(0,0,0,0);
	will-change:transform,opacity;
	/* display:flex; */
	box-sizing:border-box;
	border:none;
	outline:none;
	background-color:transparent;
	fill:currentColor;
	color:inherit;
	font-size:14px;
	text-decoration:none;
	cursor:pointer;
	/* width:48px; */
	width:100%;
	height:48px;
	padding:12px;
	text-align:right;
}
.closeFilter:hover {
	/* background-color:rgba(150,150,150,0.1);
	border-radius:50%; */
	color:#007ACC;
	border-radius:50%;
}
#search_date {
	position:fixed;
	top:0;
	bottom:0;
	left:0;
	min-width:120px;
	/* background:white; */
	overflow-y:auto;
	transform:translate3d(-120px, 0, 0);
	transition:transform 0.5s linear;
	z-index:1;
	color:white;
	background-color:rgba(37, 37, 37, 0.8);
	z-index:51;
}
ul {
	padding:0 0 0 10px;
}
ul li {
    list-style: none;
    font-size: 14px;
}
ul li:before {
	content:"+ ";
}
ul li.minus:before {
	content:"- ";
}
ul li:first-child {
	margin-top:5px;
}
ul li:last-child {
}
li.date_menu {
    margin-bottom: 5px;
    padding: 0px 5px 6px 0px;
}
li.date_menu:first-child {
	margin-top:11px;
}
.date_menu a {
	cursor:pointer;
}
.date_menu .hide {
	display:none;
}
li.month_menu {
	margin-bottom:3px;
}
li.month_menu:last-child {
	margin-bottom:0;
}
.filterMenu {
	padding-right:10px;
}
.filterDiv {
}
a {
	color:white;
}
a:hover {
	text-decoration:none;
	color:#007ACC;
}
.filterButton {
	outline:none;
	display:flex;
	border:none;
	background-color:transparent;
	fill:currentColor;
	color:white;
	font-size:24px;
	width:48px;
	height:48px;
	padding:12px;
}
.filterButton:hover {
	/* background-color:#b3b3b3; */
	color:#007ACC;
	border-radius:50%;
}
#right_info {
	position:fixed;
	top:72px;
	right:0;
	bottom:0;
	width:360px;
	transform:translate3d(100%, 0, 0);
	transition:transform 0.5s linear;
	background:rgba( 128, 128, 128, 0.5 );
}
.detail2 {
	color:#fff;
	display:flex;
	padding:14px 24px;
	letter-spacing:0.7272727em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	text-transform:uppercase;
}
.detailInfo2 {
	margin:0;
	padding:0;
}
.IP2 {
	/* cursor:pointer; */
	position:relative;
	display:flex;
	align-items:center;
	padding:18px 24px;
	min-height:36px;
}
.IP2:hover {
	background-color:rgba(150,150,150,0.1);
}
.IPDt2 {
	height:24px;
	min-width:40px;
	width:40px;
}
.IPSvg2 {
	fill:#fff;
}
.IPDd2 {
	margin:0;
	overflow:hidden;
}
.IPDiv2 {
	color:#fff;
	letter-spacing:.00625em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
}
.chDiv2 {
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
.chSpan2 {
	margin-right:12px;
	margin-top:0;
}
.dateTime2 {
	/* cursor:pointer; */
	position:relative;
	display:flex;
	align-items:center;
	padding:18px 24px;
	min-height:36px;
}
.dateTime2:hover {
	background-color:rgba(150,150,150,0.1);
}
.dateDt2 {
	height:24px;
	min-width:40px;
	width:40px;
}
.dateSvg2 {
	fill:#fff;
}
.dateDd2 {
	margin:0;
	overflow:hidden;
}
.dateDiv2 {
	color:#fff;
	letter-spacing:.00625em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
}
.timeDiv2 {
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
.timeSpan2 {
	margin-right:12px;
	margin-top:0;
}
.tagCount2 {
	/* cursor:pointer; */
	position:relative;
	display:flex;
	align-items:center;
	padding:18px 24px;
	min-height:36px;
}
.tagCount2:hover {
	background-color:rgba(150,150,150,0.1);
}
.tagDt2 {
	height:24px;
	min-width:40px;
	width:40px;
}
.tagSvg2 {
	fill:#fff;
}
.tagDd2 {
	margin:0;
	overflow:hidden;
}
.tagDiv2 {
	color:#fff;
	letter-spacing:.00625em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
}
.countDiv2 {
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
.countSpan2 {
	margin-right:12px;
	margin-top:0;
}
</style>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
function setModalInfoArr(ModalInfoArr) {
	sessionStorage.setItem('ModalInfoArr', ModalInfoArr);
}
function setKeywordOption(keywordOption) {
	sessionStorage.setItem('keywordOption', keywordOption);
}
function setBack(back) {
	sessionStorage.setItem('back', back);
}
function setScroll(scroll) {
	sessionStorage.setItem('scroll', scroll);
}

var ModalInfoArr = [];
var ModalInfoVal;
var day2 = new Date();
var year2 = day2.getFullYear();
var week = new Array('일', '월', '화', '수', '목', '금', '토');
var isDateStr = "";
var isShow = false;
var prevTime = 1;
var durationObj = new Object();
var time = 1;
$(document).ready(function () {
	var tagInfo;
	var obj = new Object();
	obj.login_id = JSON.parse(get('userdata')).user_id;
	var arr = [];
	var jsonData = JSON.stringify(obj);
	var jsonUrl = '/imageInfo';
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",   
		async:false,
		data : jsonData,          		   
	    success: function(data) {
	    	if (data.length > 0) {
				if (JSON.parse(data[0]).login_id == JSON.parse(get('userdata')).user_id) {
					//var tmpClass = $(document.createDocumentFragment());
					var dataArr = data;
					var dataLength = data.length;
					
			    	var day = new Date();
			    	
			    	var allImage = document.getElementById('allImage');
			    	var appendStr = "";
			    	
		  	    	for (var i = 0; i < dataLength; i++) {
						var json = JSON.parse(dataArr[i]);
						var monitoringTag = json.monitoring_tag;
						ModalInfoArr.push(json);
				    	var day = new Date(json.monitoring_time);
		 		    	var year = day.getFullYear();
				    	var month = day.getMonth() + 1;
				    	var date = day.getDate();
				    	
				    	if (month < 10) {
				    		month = '0' + month;
				    	} 
				    	if (date < 10) {
				    		date = '0' + date;
				    	}
			    	
						var count = json.monitoring_count;
						var dateStr = "'" + year + '-' + month + '-' + date + "일'";
						
						if (dateStr != isDateStr) {
		 		    		var yearStr = "";
		 		    		var yearStr2 = year + "-";
		 		    		if (year < year2) {
		 		    			yearStr = year + "년 ";
		 		    		}
		 		    		if (dateStr != "") {
		 		    			appendStr +='</div></div>'
		 		    		}
		 		    		//tmpClass.append('<div class="images ' + month + '-' + date + '" onmouseover="showTitleV(' + dateStr + ')" onmouseout="hideTitleV(' + dateStr + ')"><div class="imagesTitle"><svg class="hideTitleChk" width="24px" height="24px" onclick="clickTitleV(' + dateStr + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><div style="height:44px;"><h2 class="titleH2">' + yearStr + month + '월 ' + date + '일 ' + '(' + week[day.getDay()] + ')' + '</h2></div></div><div class="imageInA" id="'+ month + '-' + date + '"></div></div>');
				    		//$('<div class="images ' + month + '-' + date + '" onmouseover="showTitleV(' + dateStr + ')" onmouseout="hideTitleV(' + dateStr + ')"><div class="imagesTitle"><svg class="hideTitleChk" width="24px" height="24px" onclick="clickTitleV(' + dateStr + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><div style="height:44px;"><h2 class="titleH2">' + yearStr + month + '월 ' + date + '일 ' + '(' + week[day.getDay()] + ')' + '</h2></div></div><div class="imageInA" id="'+ month + '-' + date + '"></div></div>').appendTo('.allImage');
				    		appendStr += '<div class="images ' + yearStr2 + month + '-' + date + '일" onmouseover="showTitleV(' + dateStr + ')" onmouseout="hideTitleV(' + dateStr + ')"><div class="imagesTitle"><svg class="hideTitleChk" width="24px" height="24px" onclick="clickTitleV(' + dateStr + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><div style="height:44px;"><h2 class="titleH2">' + yearStr + month + '월 ' + date + '일 ' + '(' + week[day.getDay()] + ')' + '</h2></div></div><div class="imageInA" id="' + year + '-' + month + '-' + date + '일">';
				    		isDateStr = "'" + year + '-' + month + '-' + date + "일'";
				    	}
						
						var countstr = ''; 
						
						if (count > 1) {
							countstr = '+' + count;
						}
						
						var tag = "'" + monitoringTag + "'";
						
						//$('<div class="' + monitoringTag + '" style="float:left; width:244px; height:184px; " id="' + count + '" onmouseover="showV(' + tag + ');" onmouseout="hideV(' + tag + ');"><div style="width:80%; height:80%;"><div style="position:absolute; width:240px;"><svg width="24px" height="24px" class="showChk"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"></path></svg><svg class="showChkV" width="24px" height="24px"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><div style="float:right;"><a style="color:white; text-shadow:1px -1px 2px white; cursor:pointer;" onclick="popupMenu(' + tag + ');">' + countstr + '</a></div></div><div style="background-image:url(' + json.monitoring_src + '); background-size:100% 100%; background-repeat:no-repeat; width:240px; height:180px;"></div></div></div>').appendTo('#' + month + '-' + date);
						
						//$('#' + month + '-' + date).append('<div class="monitoring_tag ' + monitoringTag + '" id="' + count + '" onmouseover="showV(' + tag + ')" onmouseout="hideV(' + tag + ');"><div class="monitoring_tag_div"><div class="bgDivBefore" ><div class="icon"><svg class="hideChkV" width="24px" height="24px" id="' + monitoringTag + 'V" onclick="clickV(' + tag + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><svg width="24px" height="24px" class="hideChk" id="' + monitoringTag + 'Circle"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"></path></svg><div style="float:right;"><a style="color:white; text-shadow:1px -1px 2px black; cursor:pointer;" onclick="popupMenu(' + tag + ');">' + countstr + '</a></div></div><a class="imageA" id="' + count + '"  onclick="clickModal(' + tag + ')"><img loading="lazy" class="beforeChkImage" src="' + json.monitoring_src + '" alt="" /></a></div></div></div>');
				    	//$('<div class="monitoring_tag ' + monitoringTag + '" id="' + count + '" onmouseover="showV(' + tag + ')" onmouseout="hideV(' + tag + ');"><div class="monitoring_tag_div"><div class="bgDivBefore" ><div class="icon"><svg class="hideChkV" width="24px" height="24px" id="' + monitoringTag + 'V" onclick="clickV(' + tag + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><svg width="24px" height="24px" class="hideChk" id="' + monitoringTag + 'Circle"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"></path></svg><div style="float:right;"><a style="color:white; text-shadow:1px -1px 2px black; cursor:pointer;" onclick="popupMenu(' + tag + ');">' + countstr + '</a></div></div><a class="imageA" id="' + count + '"  onclick="clickModal(' + tag + ')"><img loading="lazy" class="beforeChkImage" src="' + json.monitoring_src + '" alt="" /></a></div></div></div>').appendTo('#' + month + '-' + date);
				    	appendStr += '<div class="monitoring_tag ' + monitoringTag + '" id="' + count + '" onmouseover="showV(' + tag + ')" onmouseout="hideV(' + tag + ');"><div class="monitoring_tag_div"><div class="bgDivBefore" ><div class="icon"><svg class="hideChkV" width="24px" height="24px" id="' + monitoringTag + 'V" onclick="clickV(' + tag + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><svg width="24px" height="24px" class="hideChk" id="' + monitoringTag + 'Circle"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"></path></svg><div style="float:right;"><a style="color:white; text-shadow:1px -1px 2px black; cursor:pointer;" onclick="popupMenu(' + tag + ');">' + countstr + '</a></div></div><a class="imageA" id="' + count + '"  onclick="clickModal(' + tag + ')"><img loading="lazy" onError="this.src=' + "'" + json.monitoring_src.replace('web_server', 'webserver') + "'" + '" class="beforeChkImage" src="' + json.monitoring_src + '" alt="" /></a></div></div></div>';
				    	
				    	///* href="./showImageInfo.html" data-toggle="modal" data-target="#theModal" */
			  	    	
						showDashInfo(i, json.monitoring_time.substring(0, json.monitoring_time.indexOf(':')), 'first');
		  	    	}

		  	    	$("#allImage").append(appendStr + '</div></div>');
		  	    	
					
			    	var day2 = new Date();
			    	
			    	console.log(day2.getHours() + ':' + day2.getMinutes() + ':' + day2.getSeconds());
	  	    		//console.log('걸린 시간 = ' + ((gap % (1000 * 60)) / 1000) + '초');
		  	    	/* $('.allImage').imagesLoaded().done(function () {
		  	    	}); */
					if("${scroll}" != "") {
						window.scrollTo(0, parseInt("${scroll}"));
					}
				}
	  	    	/* $('#allImage').imagesLoaded().done(function () {
	  	    	}); */
	    	}
  	    	var progress_Loading = document.getElementById('Progress_Loading');
    		var loading = document.getElementById('loading');
    		
    		progress_Loading.style.display = 'none';
    		
    		loading.removeAttribute('id');
	    },
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(jsonUrl);
		}
	});
	
	var websocketUrl = '/websocket';
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/showImage', function (message) {
			if (JSON.parse(message.body).login_id == JSON.parse(get('userdata')).user_id) {
				var json = JSON.parse(message.body);
				
				if (eval('durationObj.' + json.monitoring_tag) != null) {
					json.count = eval('durationObj.' + json.monitoring_tag).count + 1;
					eval('durationObj.' + json.monitoring_tag + ' = json');
				} else {
					json.count = 1;
					eval('durationObj.' + json.monitoring_tag + ' = json');
				}
			}
		}); 
		stompClient.subscribe('/updateMonitoringCount', function (message) {
			if (JSON.parse(message.body).login_id == JSON.parse(get('userdata')).user_id) {
				var json2 = JSON.parse(message.body);
				var monitoringClass = $('.' + json2.monitoring_tag);
				var count = parseInt(monitoringClass.attr('id')) - 1;
				monitoringClass.attr('id', count);
				monitoringClass.find('.imageA').attr('id', count);
				var countStr = '';
				if (count > 1) {
					countStr = '+' + count;
				}
				monitoringClass.find('.icon').find('a').text(countStr);
			}
		}); 
		stompClient.subscribe('/deleteMonitoring', function (message) {
			if (JSON.parse(message.body).login_id == JSON.parse(get('userdata')).user_id) {
				var json2 = JSON.parse(message.body);
				var monitoringClass = $('.' + json2.monitoring_tag);
				if (monitoringClass.parents('div').find('monitoring_tag').length == 0) {
					$('.' + monitoringClass.parents('div').attr('id')).remove();
				} else {
					monitoringClass.remove();
				}
			}
		}); 
	});
	$(".searchText").focus(function() {
		$(".svg").click();
	});
	$('.searchText').keyup(function(e) {
		if (e.keyCode == 13) $(".svg").click();
	});

	$('.downloadButton').click(function() {
		$(top.document).find(".downloadButton").click();
	});
	$('.filterButton').click(function(e) {
		if (!isShow) {
		    $('#search_date').css({"transform": "translate3d(0, 0, 0)"});
		    isShow = true;
		} else {
		    $('#search_date').css({"transform": "translate3d(-120px, 0, 0)"});
		    //$('#search_date div').remove();
		    //$(".top").prepend('<div id="search_date"></div>');
		    isShow = false;
		}
	});
	$('.closeFilter').click(function(e) {
		if (isShow) {
		    $('#search_date').css({"transform": "translate3d(-120px, 0, 0)"});
		    isShow = false;
		}
	});
	 $(".date_menu>a").click(function(){         
  		var targetUl = $(this).next("ul");
	  	targetUl.toggleClass("hide");
	  	$(this).parent().toggleClass('minus');
     });
	 $(".month_menu>a").click(function(){         
  		var targetUl = $(this).next("ul");
  		targetUl.toggleClass("hide");   
  		$(this).parent().toggleClass('minus');
     });
	 $(".day_menu>a").click(function(){         
  		var targetUl = $(this).next("ul");
  		targetUl.toggleClass("hide");    
     });
});
const hasSupport = 'loading' in HTMLImageElement.prototype;
document.documentElement.className = hasSupport ? 'pass' : 'fail';

function search() {
	//alert($('.searchText').val());
  	if (get('keywordOption') != null) {
  		sessionStorage.removeItem("keywordOption");
  	}
  	setBack('image');
  	setScroll(document.scrollingElement.scrollTop);
  	
	location.href = './searchBar.htm';
	//document.getElementById("searchModal").style.display = 'block';
}
function showTitleV(tag) {
	$('.' + tag).find('.hideTitleChk').attr('class','showTitleChk');
}
function hideTitleV(tag) {
	$('.' + tag).find('.showTitleChk').attr('class','hideTitleChk');
}
function showV(tag) {
	if ($('#' + tag + 'V').attr('class') == 'hideChkV') {
		$('#' + tag + 'V').removeClass('hideChkV');
		$('#' + tag + 'V').addClass("showChkV");	
	}
	
	var jsonUrl = "/showRightInfo";
	
	var rightObj = new Object();
	rightObj.monitoring_tag = tag;
	
	var jsonData = JSON.stringify(rightObj);

	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",   
		async:false,
		data : jsonData,          		   
	    success: function(data) {
	    	//$('.IPDiv2').text(data.monitoring_item + " ch" + data.monitoring_ch);
	    	$('.IPDiv2').text("ch" + data.monitoring_ch);
	    	var day2 = new Date(data.monitoring_time);
	    	var year2 = day2.getFullYear();
	    	var month2 = day2.getMonth() + 1;
	    	var date2 = day2.getDate();
	    	var hour2 = day2.getHours();
	    	var min2 = day2.getMinutes();
	    	var second2 = day2.getSeconds();
	    	
	    	if (month2 < 10) {
	    		month2 = '0' + month2;
	    	} 
	    	if (date2 < 10) {
	    		date2 = '0' + date2;
	    	}
    	
	    	if (hour2 < 10) {
	    		hour2 = '0' + hour2;
	    	} 
	    	
	    	if (min2 < 10) {
	    		min2 = '0' + min2;
	    	} 
	    	
	    	if (second2 < 10) {
	    		second2 = '0' + second2;
	    	} 
	    	
	    	var dateInfo2 = year2 + "년 " + month2 + '월 ' + date2 + "일 " + week[day2.getDay()] + "요일";
			var timeInfo2= hour2 + "시 " + min2 + "분 " + second2 + "초";
			$('.dateDiv2').text(dateInfo2);
			$('.timeSpan2').text(timeInfo2);
	    	var tagInfo2 = "";
			for (var w = 0; w < data.monitoring_info.split('/').length; w++) {
				if (w == 0) {
					tagInfo2 = (data.monitoring_info.split('/')[w].split(':')[0]);
				} else {
					tagInfo2 += ', ' + (data.monitoring_info.split('/')[w].split(':')[0]);
				}
			}
	    	$('.tagDiv2').text(tagInfo2);
	        $('#right_info').css({"transform": "translate3d(0, 0, 0)"});
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});
}
function hideV(tag) {
	if ($('#' + tag + 'V').attr('class') == 'showChkV') {
		$('#' + tag + 'V').removeClass('showChkV');
		$('#' + tag + 'V').addClass("hideChkV");
	}
    $('#right_info').css({"transform": "translate3d(100%, 0, 0)"});
}
function clickTitleV(tag) {
	if ($('.' + tag).find('.showTitleChk').length > 0) {
		
		$('.' + tag).find('.showTitleChk').addClass("afterTitleChk");
		$('.' + tag).find('.showTitleChk').removeClass("showTitleChk");
		
		$('.' + tag).find('.hideChkV').addClass("afterChkV");
		$('.' + tag).find('.hideChkV').removeClass("hideChkV");

		$('.' + tag).find('.beforeChkImage').addClass("afterChkImage");
		$('.' + tag).find('.afterChkImage').removeClass("beforeChkImage");
 
		$('.search').attr('class','searchHidden');
		$('.menuHidden').attr('class','menu'); 
		
	} else if ($('.' + tag).find('.afterTitleChk').length > 0) {
		$('.' + tag).find('.afterTitleChk').addClass("showTitleChk");
		$('.' + tag).find('.afterTitleChk').removeClass("afterTitleChk");

		$('.' + tag).find('.afterChkV').addClass("hideChkV");
		$('.' + tag).find('.afterChkV').removeClass("afterChkV");
		
		$('.' + tag).find('.afterChkImage').addClass("beforeChkImage");
		$('.' + tag).find('.afterChkImage').removeClass("afterChkImage");
 
		if ($('.afterChkV').length > 0) {
		} else {
			$('.searchHidden').attr('class','search');
			$('.menu').attr('class','menuHidden');
		} 
	}
}
function clickV(tag) {
	if ($('#' + tag + 'V').attr('class') == 'showChkV') {
		$('#' + tag + 'V').removeClass('showChkV');
		$('#' + tag + 'V').addClass("afterChkV");
		$('.' + tag).find('.beforeChkImage').addClass("afterChkImage");
		$('.' + tag).find('.afterChkImage').removeClass("beforeChkImage");
		if ($('.' + cutStr(tag)).find('.beforeChkImage').length > 0) {
		} else {
			$('.' + cutStr(tag)).find('.hideTitleChk').addClass("afterTitleChk");
			$('.' + cutStr(tag)).find('.hideTitleChk').removeClass("hideTitleChk");
		}
		
		if ($('.' + cutStr(tag)).find('.afterChkV').length == 1) {
			$('.search').addClass("searchHidden");
			$('.search').removeClass("search");
			$('.menuHidden').addClass("menu");
			$('.menuHidden').removeClass("menuHidden");
		}
	} else if ($('#' + tag + 'V').attr('class') == 'afterChkV') {
		$('#' + tag + 'V').removeClass('afterChkV');
		$('#' + tag + 'V').addClass("showChkV");
		$('.' + tag).find('.afterChkImage').addClass("beforeChkImage");
		$('.' + tag).find('.beforeChkImage').removeClass("afterChkImage");
		if ($('.' + cutStr(tag)).find('.afterTitleChk').length > 0) {
			$('.' + cutStr(tag)).find('.afterTitleChk').addClass("hideTitleChk");
			$('.' + cutStr(tag)).find('.afterTitleChk').removeClass("afterTitleChk");
		}
		if ($('.afterChkV').length == 0) {
			$('.searchHidden').addClass("search");
			$('.searchHidden').removeClass("searchHidden");
			$('.menu').addClass("menuHidden");
			$('.menu').removeClass("menu");
		}
	}
}
function cutStr(tag) {
	var cutStr = tag.substring(tag.indexOf('ch')).split('_')[1].substring(0, 4) + '-' + tag.substring(tag.indexOf('ch')).split('_')[1].substring(4, 6) + '-' + tag.substring(tag.indexOf('ch')).split('_')[1].substring(6) + '일';
	return cutStr;
}
function popupMenu(flag) {
	setKeywordOption('Y');
	var popupX = (screen.availWidth - width) / 2;
	var popupY = (screen.availHeight - height) / 2;
	var scrollbars = (pageName == 'webNoticeAdd' || pageName == 'webNoticeModify') ? 'yes' : 'no';
	var width = '1400';
	var height = '800';
	
	var pageName = './searchBar.htm?keyword=' + flag;
	
	window.open(pageName, pageName, 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 500, left = 50, location = no');
}
function sampleModalPopup() {
	var url = "./showImageInfo";
	/* $('.modal_hide').attr('class','modal');
	
	$(".modal-body").load(url); */

	$("#sampleModalPopup > .modal-dialog").load(url, function() { 
        $("#sampleModalPopup").modal("show"); 
    });
}
function clickModal(tag) {
   	var day = new Date();
   	//console.log(day.getHours() + ':' + day.getMinutes() + ':' + day.getSeconds());
   	
	setModalInfoArr(JSON.stringify(ModalInfoArr));
	var url = "showImageInfo.htm?tag=" + tag;
	
	$(".modal-content").load(url, function(e) {
		$('#theModal').modal('show');
	   	/* day = new Date();
	   	console.log(day.getHours() + ':' + day.getMinutes() + ':' + day.getSeconds());
	   	day = new Date();
	   	console.log(day.getHours() + ':' + day.getMinutes() + ':' + day.getSeconds()); */
	});

   // document.getElementById("theModal").innerHTML='<object type="text/html" data="' + url + '" ></object>';
    
   	/* day = new Date();
   	console.log(day.getHours() + ':' + day.getMinutes() + ':' + day.getSeconds()); */
}
function isErrorImg(img, tag) {
	var imgObj = new Object();
	var src = "/resources/image/imageError.png"
	var thumb_name = img.src.substring(img.src.indexOf('/web_server/'));
	
	imgObj.image_name = thumb_name.substring(0, thumb_name.lastIndexOf('_')) + '.jpg';
	imgObj.monitoring_tag = tag;
	imgObj.thumb_name = thumb_name;
	
	img.src = src;
	
	var jsonUrl = "/isErrorImg";
	
	var jsonData = JSON.stringify(imgObj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "text",                        	  
		contentType : "application/json; charset=UTF-8",       
		data : jsonData,          		     		 
		success: function(data) {
			if (data == "success") {
				img.src = thumb_name;
			}
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});
}
function showDashInfo(i, event_time, option) {
	var appendStr = "";
	var dateStr = event_time;
	var yearStr = dateStr.substring(0, dateStr.indexOf('-'));
	var monthStr = dateStr.substring(dateStr.indexOf('-') + 1, dateStr.lastIndexOf('-'));
	var dateStr = event_time.substring(0, event_time.lastIndexOf(' '));
	var dayStr = dateStr.substring(dateStr.lastIndexOf('-') + 1);
	var yMonthStr = dateStr.substring(0, dateStr.lastIndexOf('-'));
	var timeStr = event_time.substring(event_time.lastIndexOf(' ') + 1);
	
	if (option == 'first') {
		if (i == 0) {
			appendStr = "<ul id='allUl'><li class='date_menu'><a>" + yearStr + "</a><ul class='hide' id='" + yearStr + "'><li class='month_menu' value='" + yMonthStr + "'><a>" + monthStr + "월" + "</a><ul class='hide' id='"
			+ yMonthStr + "'><li id='" + dateStr + "' class='day_menu minus' value='" + dateStr + "'><a onclick='showDateImage(" + '"' + dateStr + '일' + '"' + ");'>" + dayStr + "일" + "</a></li></ul></li></ul></li></ul>";
			// <ul class='hide' id='"	+ dateStr + "' ><li class='time_menu' id='" + allDateStr + "' value='" + allDateStr + "'><a onclick='showDateImage(" + '"' + allDateStr + '"' + ");'>" + allDateStr.substring(allDateStr.lastIndexOf(' ') + 1) + "시" + "</a></li></ul>
			
			$("#search_date").append(appendStr);
		} else {
			if (document.getElementById(yearStr) == null) {
				var tmpDate = event_time.substring(0, event_time.lastIndexOf(' '));
				yearStr = tmpDate.substring(0, tmpDate.indexOf('-'));
				monthStr = tmpDate.substring(tmpDate.indexOf('-') + 1, tmpDate.lastIndexOf('-'));
				appendStr = "<li class='date_menu'><a>" + yearStr + "</a><ul class='hide' id='" + yearStr + "'></ul></li>";
				$("#allUl").append(appendStr);
			}
			if (document.getElementById(yMonthStr) == null) {
				var tmpDate = event_time.substring(0, event_time.lastIndexOf(' '));
				yMonthStr = event_time.substring(0, event_time.lastIndexOf(' ')).substring(0, tmpDate.lastIndexOf('-'));
				monthStr = yMonthStr.substring(yMonthStr.indexOf('-') + 1);
				appendStr = "<li class='month_menu' value='" + yMonthStr + "'><a>" + monthStr + "월" + "</a><ul class='hide' id='" + yMonthStr + "'></ul></li>";
				$("#" + yearStr).append(appendStr);
			} 
			if (document.getElementById(dateStr) == null) {
				dateStr = event_time.substring(0, event_time.lastIndexOf(' '));
				dayStr = dateStr.substring(dateStr.lastIndexOf('-') + 1);
				appendStr = "<li id='" + dateStr + "' class='day_menu minus' value='" + dateStr + "'><a onclick='showDateImage(" + '"' + dateStr + '일' + '"' + ");'>" + dayStr + "일" + "</a></li>";
				// <ul class='hide' id='" + dateStr + "'></ul>
				$("#" + yMonthStr).append(appendStr);
			}
		}    
	} else {
		if (yearStr != event_time.substring(0, event_time.lastIndexOf(' ')).substring(0, event_time.substring(0, event_time.lastIndexOf(' ')).indexOf('-'))) {
			var tmpDate = event_time.substring(0, event_time.lastIndexOf(' '));
			yearStr = tmpDate.substring(0, tmpDate.indexOf('-'));
			monthStr = tmpDate.substring(tmpDate.indexOf('-') + 1, tmpDate.lastIndexOf('-'));
			appendStr = "<li class='date_menu'><a>" + yearStr + "</a><ul class='hide' id='" + yearStr + "'></ul></li>";
			$("#allUl").append(appendStr);
		}
		if (yMonthStr != event_time.substring(0, event_time.lastIndexOf(' ')).substring(0, event_time.substring(0, event_time.lastIndexOf(' ')).lastIndexOf('-'))) {
			var tmpDate = event_time.substring(0, event_time.lastIndexOf(' '));
			yMonthStr = event_time.substring(0, event_time.lastIndexOf(' ')).substring(0, tmpDate.lastIndexOf('-'));
			monthStr = yMonthStr.substring(yMonthStr.indexOf('-') + 1);
			appendStr = "<li class='month_menu' value='" + yMonthStr + "'><a>" + monthStr + "월" + "</a><ul class='hide' id='" + yMonthStr + "'></ul></li>";
			$("#" + yearStr).append(appendStr);
		} 
		if (dateStr != event_time.substring(0, event_time.lastIndexOf(' '))) {
			dateStr = event_time.substring(0, event_time.lastIndexOf(' '));
			dayStr = dateStr.substring(dateStr.lastIndexOf('-') + 1);
			appendStr = "<li class='day_menu' value='" + dateStr + "'><a onclick='showDateImage(" + '"' + dateStr + '일' + '"' + ");'>" + dayStr + "일" + "</a></li>";
			// <ul class='hide' id='" + dateStr + "'></ul>
			$("#" + yMonthStr).append(appendStr);
		}
	}
}
function showDateImage(dateTime) {
	/* var year = dateTime.substring(0, dateTime.indexOf('-'));
	
	if (year == year2) {
		year = dateTime.substring(dateTime.indexOf('-') + 1);
	} else {
		year = dateTime;
	} */
	
 	$('html, body').animate({scrollTop : ($('.' + dateTime).offset().top - 96)}, 400);
 	// $('.' + scrollDateArr[1]).offset().top
 	
	/* var popupX = (screen.availWidth - width) / 2;
	var popupY = (screen.availHeight - height) / 2;
	var scrollbars = (pageName == 'webNoticeAdd' || pageName == 'webNoticeModify') ? 'yes' : 'no';
	var width = '1400';
	var height = '800';
	
	var pageName = './test.htm?monitoring_time=' + dateTime;
	
	window.open(pageName, pageName, 'width = ' + window.outerWidth + ', height = ' + window.outerHeight + ', top = 500, left = 50, location = no'); */
}
function showImageDuration(time) {
	/* var durationDate = new Date();
	//var durationDate2 = new Date('2020-11-26 11:05:14');
	var durationDateStr = durationDate.getFullYear() + "-" + (durationDate.getMonth() + 1) + "-" + durationDate.getDate() + " " + durationDate.getHours() + ":"
	+ durationDate.getMinutes() + ":" + durationDate.getSeconds();
	durationDate = new Date(durationDateStr);
	//console.log("시간차 = " + Math.abs(durationDate2 - durationDate) / 1000);
	console.log("현재 시간 = " + durationDate); */

	//console.log(new Date());
	
	if (Object.keys(durationObj).length > 0) {
		for (var key in durationObj) {
			var json2 = durationObj[key];
			ModalInfoArr.push(json2);
			var monitoringClass = $('.' + json2.monitoring_tag);
			var monitoringLength = $('.' + json2.monitoring_tag).length;
	    	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	    	var day = new Date(json2.monitoring_time);
		    var year = day.getFullYear();
	    	var month = day.getMonth() + 1;
	    	var date = day.getDate();
	    	
	    	if (month < 10) {
	    		month = '0' + month;
	    	} 
	    	if (date < 10) {
	    		date = '0' + date;
	    	}

	    	var dateStr = "'" + year + '-' + month + '-' + date + "일'";

			var tagDay = year + '-' + month + '-' + date + '일';
			if (monitoringLength > 0) {
				var count = parseInt(monitoringClass.attr('id')) + json2.count;
			} else {
				var count = json2.count;
			}
			monitoringClass.attr('id', count);

			var countstr = '';
			if (count > 1) {
				countstr = '+' + count;
			}

			var tag = "'" + json2.monitoring_tag + "'";
			
			var yearStr = "";
	    	if (document.getElementById(tagDay) == null) {
	    		yearStr = "";
	    		if (year < year2) {
	    			yearStr = year + "년 ";
	    		}
	    		$('<div class="images ' + tagDay + '" onmouseover="showTitleV(' + dateStr + ')" onmouseout="hideTitleV(' + dateStr + ')"><div class="imagesTitle"><svg class="hideTitleChk" width="24px" height="24px" onclick="clickTitleV(' + dateStr + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><div style="height:44px;"><h2 class="titleH2">' + yearStr + month + '월 ' + date + '일 ' + '(' + week[day.getDay()] + ')' + '</h2></div></div><div class="imageInA" id="'+ tagDay +'"></div></div>').prependTo('.allImage');
	    	}
	    	
			var chkV = "hideChkV";
			var chkImage = "beforeChkImage";
			if ($('.' + tagDay).find('.afterTitleChk').length > 0) {
				var chkV = "afterChkV";
				chkImage = "afterChkImage";
			}
			$("div").remove("." + json2.monitoring_tag);
			$('<div class="monitoring_tag ' + json2.monitoring_tag + '" id="' + count + '" onmouseover="showV(' + tag + ')" onmouseout="hideV(' + tag + ');"><div class="monitoring_tag_div"><div class="bgDivBefore" ><div class="icon"><svg width="24px" height="24px" class="hideChk" id="' + json2.monitoring_tag + 'Circle"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"></path></svg><svg class="' + chkV + '" id="' + json2.monitoring_tag + 'V" width="24px" height="24px" onclick="clickV(' + tag + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><div style="float:right;"><a style="color:white; text-shadow:1px -1px 2px black; cursor:pointer;" onclick="popupMenu(' + tag + ');">' + countstr + '</a></div></div><a class="imageA" id="' + count + '" onclick="clickModal(' + tag + ')"><img loading="lazy" onError="this.src=' + "'" + json2.monitoring_src.replace('web_server', 'webserver') + "'" + '" class="' + chkImage + '" src="' + json2.monitoring_src + '" alt=""/></a></div></div></div>').prependTo('#' + tagDay);

			showDashInfo(null, json2.monitoring_time.substring(0, json2.monitoring_time.indexOf(':')), null);
			
			delete durationObj[json2.monitoring_tag];
		}
	}
	setTimeout("showImageDuration(" + time + ")", (time * 1000)); 
}
showImageDuration(time);
</script>
</head>
<body>
	<div id="Progress_Loading" style="text-align:-webkit-center;"> <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" style="width:30%; margin-top:70px;" alt="loading" />
	</div>
	<div id="loading">
		<div id="search_date">
			<button class="closeFilter">
				<span>
					<svg width="24px" height="24px" class="infoSvg" viewBox="0 0 24 24">
						<path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path>
					</svg>
				</span>
			</button>
		</div>
		<div class="top">
			<div class="searchHr"></div>
			<div class="search">
				<div class="filterMenu">
					<div class="filterDiv">
						<button class="filterButton">
							<span class="filterSpan">
								<svg class="filterSvg" width="24px" height="24px">
									<path d="M20 4v12H8V4h12m0-2H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-7.53 12L9 10.5l1.4-1.41 2.07 2.08L17.6 6 19 7.41 12.47 14zM4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6z"></path>
								</svg>
							</span>
						</button>
					</div>
				</div>
				<div class="searchDiv">
					<div class="searchBar">
						<div class="svgDiv">
							<svg class="svg" width="24px" height="24px" onclick="search();">
								<path d="M20.49 19l-5.73-5.73C15.53 12.2 16 10.91 16 9.5A6.5 6.5 0 1 0 9.5 16c1.41 0 2.7-.47 3.77-1.24L19 20.49 20.49 19zM5 9.5C5 7.01 7.01 5 9.5 5S14 7.01 14 9.5 11.99 14 9.5 14 5 11.99 5 9.5z"></path>
							</svg>
						</div>
						<div class="searchTextDiv">
							<input class="searchText" type="text" placeholder="내 사진 검색">
						</div>
					</div>
				</div>
			</div>
			<div class="menuHidden">
				<div class="choiceMenu">
					<div class="downloadDiv">
						<button class="downloadButton">
							<span class="downloadSpan">
								<svg class="downloadSvg" width="24px" height="24px">
									<!-- <path d="M18 16c-.79 0-1.5.31-2.03.81L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.7l7.05-4.11c.53.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.48.09.7L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.05 4.12c-.05.22-.09.45-.09.69 0 1.66 1.34 3 3 3s3-1.34 3-3-1.34-3-3-3zm0-12c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zM6 13c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm12 7c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1z"></path> -->
									<path d="M20.54 5.23l-1.39-1.68C18.88 3.21 18.47 3 18 3H6c-.47 0-.88.21-1.16.55L3.46 5.23C3.17 5.57 3 6.02 3 6.5V19c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V6.5c0-.48-.17-.93-.46-1.27zM6.24 5h11.52l.83 1H5.42l.82-1zM5 19V8h14v11H5zm8-5.35V9.5h-2v4.15l-1.79-1.79-1.42 1.41L12 17.48l4.21-4.21-1.42-1.41z"></path>
								</svg>
							</span>
						</button>
					</div>
					<!-- <div class="favoritesDiv">
						<button class="favoritesButton">
							<span class="favoritesSpan">
								<svg class="favoritesSvg" width="24px" height="24px">
									<path d="M20 13h-7v7h-2v-7H4v-2h7V4h2v7h7v2z"></path>
								</svg>
							</span>
						</button>
					</div>
					<div class="trashDiv">
						<button class="trashButton">
							<span class="trashSpan">
								<svg class="trashSvg" width="24px" height="24px">
									<path d="M15 4V3H9v1H4v2h1v13c0 1.1.9 2 2 2h10c1.1 0 2-.9 2-2V6h1V4h-5zm2 15H7V6h10v13zM9 8h2v9H9zm4 0h2v9h-2z"></path>
								</svg>
							</span>
						</button>
					</div> -->
				</div>
			</div>
		</div>
		<div class="bottom">
			<div class="imageDiv">
				<div class="allImage" id="allImage">
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="theModal">
	    <div class="modal-dialog">
			<div class="modal-content">
		    </div>
	    </div>
	</div>
	<!-- <div class="modal_hide">
	    <div class="modal-content">
	        <div class="modal-header">
	            <button type="button" class="close_modal" ><span aria-hidden="true">×</span></button>
	        </div>
	        <div class="modal-body">
	        </div>
	    </div>
	</div> -->
	<div id="right_info">
		<div>
			<div class="detail2">태그정보</div>
			<dl class="detailInfo2">
				<div class="IP2">
					<dt class="IPDt2">
						<svg width="24px" height="24px" class="IPSvg2">
							<path d="M19 2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h4l3 3 3-3h4c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 16H5V4h14v14z M12 16l1.57-3.43L17 11l-3.43-1.57L12 6l-1.57 3.43L7 11l3.43 1.57z"></path>
						</svg>
					</dt>
					<dd class="IPDd2">
						<div class="IPDiv2"></div>
						<div class="chDiv2">
							<span class="chSpan2"></span>
						</div>
					</dd>
				</div>
				<div class="dateTime2">
					<dt class="dateDt2">
						<svg width="24px" height="24px" class="dateSvg2">
							<path d="M19 3h-1V1h-2v2H8V1H6v2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM9 9.5a2.5 2.5 0 0 0 0 5 2.5 2.5 0 0 0 0-5z"></path>
						</svg>
					</dt>
					<dd class="dateDd2">
						<div class="dateDiv2"></div>
						<div class="timeDiv2">
							<span class="timeSpan2"></span>
						</div>
					</dd>
				</div>
				<div class="tagCount2">
					<dt class="tagDt2">
						<svg width="24px" height="24px" class="tagSvg2">
							<path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm0 18H6V4h6v7l2.5-1.88L17 11V4h1v16zm-4.33-6L17 18H7l2.5-3.2 1.67 2.18 2.5-2.98z"></path>
						</svg>
					</dt>
					<dd class="tagDd2">
						<div class="tagDiv2"></div>
						<div class="countDiv2">
							<span class="countSpan2"></span>
						</div>
					</dd>
				</div>
			</dl>
		</div>
	</div>
	<div id="searchModal" style="display:none;">
	</div>
</body>
</html>