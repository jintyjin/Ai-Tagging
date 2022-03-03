<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../include/searchBar.jsp" %> --%>
<!DOCTYPE html>
<html>
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
* {
	-webkit-tap-highlight-color:transparent;
}
.loading {
	display:none;
}
#Progress_Loading2 {
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
.svgBtn {
	outline:none;
	vertical-align:middle;
	display:inline-block;
	position:relative;
	border:none;
	background-color:transparent;
	fill:currentColor;
	color:inherit;
}
.svgBtn:hover {
	/* border-radius:50%; */
	cursor:default;
}
.svgBtn:focus{
	outline:none;
}
.svg {
	fill:currentColor;
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
	padding-right:72px;
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
	contaion:strict;
}
.imageA {
	bottom:0;
	left:0;
	right:0;
	top:0;
	transition:transform .135s cubic-bezier(0.0,0.0,0.2,1);
	width:100%;
	height:100%;
	cursor:pointer;
}
a {
	text-decoration:none;
	color:#2962ff;
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
.thumb_name {
	float:left;
	width:284px;
	height:214px;
	z-index:5;
	cursor:pointer;
}
.thumb_name_div {
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
.scroll_big {
	/* visibility:hidden !important; */
	width:36px;
	position:fixed;
	top:0;
	/* top:64px; */
	bottom:0;
	right:0;
	z-index:150;
}
/* .scroll_big:hover .scroll, .scroll:hover {
	visibility:inherit;
	opacity:1;
	transition-delay:0s;
} */
.scroll {
	position:fixed;
	top:64px;
	bottom:0;
	right:0;
	width:56px;
	visibility:hidden;
	opacity:0;
	transition:visibility 0s linear .15s,opacity linear .15s;
	transform:translateZ(0);
}
/* .scroll:hover {
	cursor:row-resize;
} */
.location {
	position:absolute;
	top:24px;
	bottom:24px;
	right:10px;
}
.location_div {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	letter-spacing:.025em;
	position:absolute;
	right:0;
	white-space:nowrap;
}
.location_bar {
	background:#1a73e8;
	box-shadow:0 1px 2px 0 rgba(60,64,67,.30), 0 2px 6px 2px rgba(60,64,67,.15);
	height:2px;
	opacity:0;
	pointer-events:none;
	position:absolute;
	right:0;
	top:23px;
	transition:opacity linear .15s;
	width:72px;
	z-index:1;
}
/* .scroll:hover .location_bar {
	opacity:1;
} */
.location_start {
	background:#1a73e8;
	height:1px;
	pointer-events:none;
	position:absolute;
	right:0;
	top:24px;
	width:40px;
	z-index:1;
}
.location_date {
	display:flex;
	height:48px;
	position:absolute;
	right:0;
	transition:opacity linear .15s;
}
.location_date_text {
	background:rbga(255, 255, 255, 0.902);
	box-sizing:border-box;
	border-radius:2px;
	color:#fff;
	height:24px;
	min-width:0;
	padding:2px 10px;
	pointer-events:none;
	text-align:center;
	white-space:nowrap;
	letter-spacing:.01785714em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
}
.location_div {
	letter-spacing:.025em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	line-height:1rem;
	position:absolute;
	right:0;
	white-space:nowrap;
}
.location_div_small {
	transform:translateX(2px);
	padding:0 1px 0 1px;
	border-radius:3px;
	cursor:row-resize;
	background-color:rgba(37, 37, 37,.70);
	position:absolute;
	right:0;
}
.location_div_small_in {
	background:#dadce0;
	border-radius:50%;
	height:4px;
	width:4px;
}
.location_div_date {
	transform:translateX(8px);
	cursor:row-resize;
	background-color:rgba(37, 37, 37,.70);
	position:absolute;
	right:0;
	border-radius:10px;
	padding:0 8px;
	letter-spacing:.07272727em;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	text-transform:uppercase;
	color:#b3b3b3;
}
#theModal {
    background-color: rgba(37, 37, 37, 0.5);
}
.modal-dialog {
	margin:0;
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
	color:white;
}
.date_menu a:link {
	color:white;
}
.date_menu a:visited {
	color:white;
}
.date_menu a:hover {
	cursor:pointer;
	color:#007ACC;
	text-decoration: none;
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
.arrowMenu {
	/* padding-right:10px; */
}
.arrowDiv {
}
.arrowButton {
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
.arrowButton:hover {
	/* background-color:#b3b3b3; */
	color:#007ACC;
	border-radius:50%;
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
.filterMenu {
	padding-right:10px;
}
.filterDiv {
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
#noData {
	text-align:center;
	color:white;
}
</style>
<script type="text/javascript">
/* $(document).ajaxStart(function(){
	$('#Progress_Loading').show();
})
$(document).ajaxStop(function(data){
}); */
function get(key) {
	return sessionStorage.getItem(key);
}
function setModalImageArr(ModalImageArr) {
	sessionStorage.setItem('ModalImageArr', ModalImageArr);
}
function setKeywordOption(keywordOption) {
	sessionStorage.setItem('keywordOption', keywordOption);
}
var ModalImageArr = [];
var ModalImageVal;
var length;
var dataLength;
var week = new Array('일', '월', '화', '수', '목', '금', '토');
var scrollDateArr = [];
var scrollTopArr = [];
var scrollDate = "";
var scrollTop = 0;
var dateText;
var divDate = "";
var CurrentScroll;
var day2 = new Date();
var year2 = day2.getFullYear();
var isPopUp;
var keyword;
const hasSupport = 'loading' in HTMLImageElement.prototype;
var img_count;
var val;
var isShow = false;
var appendStr = "";
var yearFilterStr = "";
var monthStr = "";
var dateStr = "";
var dayStr = "";
var timeStr = "";
var isFilter = false;
var filterTags;
var filterTime;
var imgCount;
var allDateStr;    				
var dateStr2;
var yearFilterStr;
var monthStr;
var dayStr;
var yMonthStr;
var timeStr;
var isLoading = false;
var offset;
var keyword;
var status;
var image_idx;
document.documentElement.className = hasSupport ? 'pass' : 'fail';
$(document).ready(function () {
	window.scrollTo(0, 0);
	keyword = "${keyword}";
	status = "${status}";
	if (status == 'plus') {
		isPopUp = true;
	}
	image_idx = "${image_idx}";

	$('input').keyup(function(e) {
		if (e.keyCode == 13) {
			$(".svgBtn").click();
		}
	});

	if (get('back') != null) {
		$('.search').prepend('<div class="arrowMenu"><div class="arrowDiv"><button class="arrowButton"><span class="arrowSpan"><svg class="arrowSvg" width="24px" height="24px"><path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"></path></svg></button></div>');
	}

	$('.arrowButton').click(function() {
		location.href = "./" + get('back') + ".htm?scroll=" + get("scroll");
	});
	
	if (status != 'first') {
		var obj = new Object();
		obj.keyword = keyword;
		obj.status = status;
		obj.image_idx = image_idx;
		
		var jsonData = JSON.stringify(obj);
		var jsonUrl = '/searchImage';
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",   
			async:false,
			data : jsonData,          		   
		    success: function(data) {
		    	offset = data.length;
		    	
		    	var noData = document.getElementById('noData');
		    	if (noData != null) {
		    		$('#noData').remove();
		    	}
		    	
		    	if (data.length > 0) {
			    	if (get('keywordOption') != null) {
			    		sessionStorage.removeItem("keywordOption");
			    	}
			    	
			    	var length = data.length;

		  	    	for (var i = 0; i < length; i++) {
		 				var json = data[i];
		 				ModalImageArr.push(json);
		 				
		 				var idx = json.image_idx;

		 		    	var day = new Date(json.event_time);
		 		    	var year = day.getFullYear();
		 		    	var month = day.getMonth() + 1;
		 		    	var date = day.getDate();
		 		    	var image = json.thumb_name;

		 		    	if (month < 10) {
		 		    		month = '0' + month;
		 		    	} 
		 		    	if (date < 10) {
		 		    		date = '0' + date;
		 		    	}
		 		    	
		 		    	var dateStr = "'" + year + '-' + month + '-' + date + "'"; 
		 		    	
		 		    	if (document.getElementById(year + '-' + month + '-' + date + '일') == null) {
		 		    		var yearStr = "";
		 		    		if (year < year2) {
		 		    			yearStr = year + "년 ";
		 		    		}
		 		    		$('<div class="images loading ' + year + '-' + month + '-' + date + '" onmouseover="showTitleV(' + dateStr + ')" onmouseout="hideTitleV(' + dateStr + ')"><div class="imagesTitle"><svg class="hideTitleChk" width="24px" height="24px" onclick="clickTitleV(' + dateStr + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><div style="height:44px;"><h2 class="titleH2">' + yearStr + month + '월 ' + date + '일 ' + '(' + week[day.getDay()] + ')' + '</h2></div></div><div class="imageInA" id="' + year + '-' + month + '-' + date + '일' +'"></div></div>').appendTo('.allImage');
	 		    			scrollDateArr.push(year + '-' + month + '-' + date);
		 		    	}
						
		 		    	var idx2 = "'" + idx + "'";
		 		    	
		 		    	$('<div class="thumb_name ' + idx + '" id="' + idx + '" onmouseover="showV(' + idx2 + ')" onmouseout="hideV(' + idx2 + ');"><div class="thumb_name_div"><div class="bgDivBefore" ><div class="icon"><svg class="hideChkV" width="24px" height="24px" id="' + idx + 'V" onclick="clickV(' + idx2 + ', ' + dateStr + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><svg width="24px" height="24px" class="hideChk" id="' + idx + 'Circle"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"></path></svg></div><a class="imageA" id="' + i + '" onclick="clickModal(' + idx + ')"><img loading="lazy" onError="this.src=' + "'" + image.replace('webserver', 'web_server') + "'" + '" class="beforeChkImage" src="' + image + '" alt=""/></a></div></div>').appendTo('#' + year + '-' + month + '-' + date + '일');
		  	    	}
		    	} else {
		    		$('<div id="noData"><h2>데이터가 없습니다.</h2></div>').appendTo('.allImage');
		    	}
		    	if (status != 'plus') {
					$('.searchText').val(keyword);
		    	}
				$('div').removeClass('loading');
				$('#Progress_Loading').hide();
		    },
			error: function(errorThrown) {
				alert(errorThrown.statusText);
				alert(jsonUrl);
			}
		});
	} else {
		$('div').removeClass('loading');
		$('#Progress_Loading').hide();
	}

	/* $(".searchText").focus(function() {
		$('.searchText').val('');
	}); */
	
	$('.svgBtn').click(function() {
		location.href = './searchBar.htm?status=keyword&keyword=' + $('.searchText').val();
	});
	
	/* $('.svgBtn').click(function() {
		isFilter = false;
		appendStr = "";
		yearFilterStr = "";
		monthStr = "";
		dateStr = "";
		dayStr = "";
		timeStr = "";
		$('#allUl').remove();
		keyword = $('.searchText').val();
		$('.searchText').attr('disabled', true);
		$('.searchText').css('opacity', '0.5');
		$('.svgBtn').attr('disabled', true);
		$('.svgBtn').css('opacity', '0.5');
		scrollDateArr = [];
		scrollTopArr = [];
		$('#Progress_Loading').show();
		//$('.images').addClass('loading');
		$('div').remove('.images');
		$('div').remove('.location_div');
		$('html').scrollTop(0);
		
		var obj = new Object();
		obj.login_id = JSON.parse(get('userdata')).user_id;
		obj.keyword = keyword;

		if (get('keywordOption') != null) {
			obj.value = 'Y';
			val = 'Y';
			isPopUp = true;
		} else {
			obj.value = null;
			val = null;
			isPopUp = false;
		}
		
		var arr = [];
		var jsonData = JSON.stringify(obj);
		var jsonUrl = '/searchImage';
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",   
			async:false,
			data : jsonData,          		   
		    success: function(data) {
		    	var noData = document.getElementById('noData');
		    	if (noData != null) {
		    		$('#noData').remove();
		    	}
		    	if (data.length > 0) {
			    	if (get('keywordOption') != null) {
			    		sessionStorage.removeItem("keywordOption");
			    	}
			    	
			    	var length = data.length;

		  	    	for (var i = 0; i < length; i++) {
		 				var json = data[i];
		 				ModalImageArr.push(json);
		 				
		 				var idx = json.image_idx;

		 		    	var day = new Date(json.event_time);
		 		    	var year = day.getFullYear();
		 		    	var month = day.getMonth() + 1;
		 		    	var date = day.getDate();
		 		    	var image = json.thumb_name;

		 		    	if (month < 10) {
		 		    		month = '0' + month;
		 		    	} 
		 		    	if (date < 10) {
		 		    		date = '0' + date;
		 		    	}
		 		    	
		 		    	var dateStr = "'" + year + '-' + month + '-' + date + "'"; 
		 		    	
		 		    	if (document.getElementById(year + '-' + month + '-' + date + '일') == null) {
		 		    		var yearStr = "";
		 		    		if (year < year2) {
		 		    			yearStr = year + "년 ";
		 		    		}
		 		    		$('<div class="images loading ' + year + '-' + month + '-' + date + '" onmouseover="showTitleV(' + dateStr + ')" onmouseout="hideTitleV(' + dateStr + ')"><div class="imagesTitle"><svg class="hideTitleChk" width="24px" height="24px" onclick="clickTitleV(' + dateStr + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><div style="height:44px;"><h2 class="titleH2">' + yearStr + month + '월 ' + date + '일 ' + '(' + week[day.getDay()] + ')' + '</h2></div></div><div class="imageInA" id="' + year + '-' + month + '-' + date + '일' +'"></div></div>').appendTo('.allImage');
	 		    			scrollDateArr.push(year + '-' + month + '-' + date);
		 		    	}
						
		 		    	var idx2 = "'" + idx + "'";
		 		    	
		 		    	$('<div class="thumb_name ' + idx + '" id="' + idx + '" onmouseover="showV(' + idx2 + ')" onmouseout="hideV(' + idx2 + ');"><div class="thumb_name_div"><div class="bgDivBefore" ><div class="icon"><svg class="hideChkV" width="24px" height="24px" id="' + idx + 'V" onclick="clickV(' + idx2 + ', ' + dateStr + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><svg width="24px" height="24px" class="hideChk" id="' + idx + 'Circle"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"></path></svg></div><a class="imageA" id="' + i + '" onclick="clickModal(' + idx + ')"><img loading="lazy" onError="this.src=' + "'" + image.replace('web_server', 'webserver') + "'" + '" class="beforeChkImage" src="' + image + '" alt=""/></a></div></div>').appendTo('#' + year + '-' + month + '-' + date + '일');
		  	    	}
		    	} else {
		    		$('<div id="noData"><h2>데이터가 없습니다.</h2></div>').appendTo('.allImage');
		    	}
				$('div').removeClass('loading');
				$('#Progress_Loading').hide();
		    },
			error: function(errorThrown) {
				alert(errorThrown.statusText);
				alert(jsonUrl);
			}
		});
		$('.searchText').attr('disabled', false);
		$('.searchText').css('opacity', '1');
		$('.svgBtn').attr('disabled', false);
		$('.svgBtn').css('opacity', '1');
	}); */
	
	$(".searchText").focus();

	$(window).scroll(function () {
		var scrolltop = $(document).scrollTop();
        var height = $(document).height();
        var height_win = $(window).height();
        if (Math.round($(window).scrollTop()) == $(document).height() - $(window).height() && offset > 0 && offset % 300 == 0) {
    		var obj = new Object();
    		obj.keyword = keyword;
    		obj.status = status;
    		obj.image_idx = image_idx;
    		obj.offset = offset;
    		
    		var jsonData = JSON.stringify(obj);
    		var jsonUrl = '/searchImage';
    		
    		$.ajax({
    			type : "POST",                        	 	     
    			url : jsonUrl,                      		
    			dataType : "json",                        	  
    			contentType : "application/json; charset=UTF-8",   
    			async:false,
    			data : jsonData,          		   
    		    success: function(data) {
    		    	if (data.length > 0) {
    		    		offset += data.length;
    		    		
    			    	var length = data.length;

    		  	    	for (var i = 0; i < length; i++) {
    		 				var json = data[i];
    		 				ModalImageArr.push(json);
    		 				
    		 				var idx = json.image_idx;

    		 		    	var day = new Date(json.event_time);
    		 		    	var year = day.getFullYear();
    		 		    	var month = day.getMonth() + 1;
    		 		    	var date = day.getDate();
    		 		    	var image = json.thumb_name;

    		 		    	if (month < 10) {
    		 		    		month = '0' + month;
    		 		    	} 
    		 		    	if (date < 10) {
    		 		    		date = '0' + date;
    		 		    	}
    		 		    	
    		 		    	var dateStr = "'" + year + '-' + month + '-' + date + "'"; 
    		 		    	
    		 		    	if (document.getElementById(year + '-' + month + '-' + date + '일') == null) {
    		 		    		var yearStr = "";
    		 		    		if (year < year2) {
    		 		    			yearStr = year + "년 ";
    		 		    		}
    		 		    		$('<div class="images loading ' + year + '-' + month + '-' + date + '" onmouseover="showTitleV(' + dateStr + ')" onmouseout="hideTitleV(' + dateStr + ')"><div class="imagesTitle"><svg class="hideTitleChk" width="24px" height="24px" onclick="clickTitleV(' + dateStr + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><div style="height:44px;"><h2 class="titleH2">' + yearStr + month + '월 ' + date + '일 ' + '(' + week[day.getDay()] + ')' + '</h2></div></div><div class="imageInA" id="' + year + '-' + month + '-' + date + '일' +'"></div></div>').appendTo('.allImage');
    	 		    			scrollDateArr.push(year + '-' + month + '-' + date);
    		 		    	}
    						
    		 		    	var idx2 = "'" + idx + "'";
    		 		    	
    		 		    	$('<div class="thumb_name ' + idx + '" id="' + idx + '" onmouseover="showV(' + idx2 + ')" onmouseout="hideV(' + idx2 + ');"><div class="thumb_name_div"><div class="bgDivBefore" ><div class="icon"><svg class="hideChkV" width="24px" height="24px" id="' + idx + 'V" onclick="clickV(' + idx2 + ', ' + dateStr + ');"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"></path></svg><svg width="24px" height="24px" class="hideChk" id="' + idx + 'Circle"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z"></path></svg></div><a class="imageA" id="' + i + '" onclick="clickModal(' + idx + ')"><img loading="lazy" onError="this.src=' + "'" + image.replace('web_server', 'webserver') + "'" + '" class="beforeChkImage" src="' + image + '" alt=""/></a></div></div>').appendTo('#' + year + '-' + month + '-' + date + '일');
    		  	    	}
    		    	}
    				$('div').removeClass('loading');
    				$('#Progress_Loading').hide();
    		    },
    			error: function(errorThrown) {
    				alert(errorThrown.statusText);
    				alert(jsonUrl);
    			}
    		});
        }  
	});
	
	var websocketUrl = '/websocket';
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/deleteImageNow', function (message) {
			if (JSON.parse(message.body).login_id == JSON.parse(get('userdata')).user_id) {
				var json2 = JSON.parse(message.body);
				var monitoringClass = $('#' + json2.image_idx);
				var deleteDiv = $('.' + monitoringClass.parents('div'));
				monitoringClass.remove();
				if (deleteDiv.find('thumb_name').length == 0) {
					$(deleteDiv.attr('id')).remove();
				}
			}
		}); 
	});       
    
	var delta = 0;
    $("html, body").on('mousewheel DOMMouseScroll', function(e) {
    });
    var isDownload = true;
	$('.downloadButton').click(function() {
		if (isPopUp) {
			if (isDownload) {
				isDownload = false;
				$('.downloadImage').css({"transform": "translate3d(0, 0, 0)"});
				var idxArr = [];
				for (var d = 0; d < $('.afterChkV').length; d++) {
					idxArr.push($('.afterChkV:eq(' + d + ')').attr('id').substring(0, $('.afterChkV:eq(' + d + ')').attr('id').length - 1));
				}

				$('.afterChkV').attr('class','hideChkV');
				$('.afterTitleChk').attr('class','hideTitleChk');
				$('.afterChkImage').attr('class','beforeChkImage');
				$('.searchHidden').attr('class','search');
				$('.menu').attr('class','menuHidden');
				
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
						//$('.downloadButton').attr('disabled', false);
						//$('.downloadButton').css('opacity', '1');
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
		} else {
			$(top.document).find(".downloadButton2").click();
		}
		/* $('.downloadButton').attr('disabled', true);
		$('.downloadButton').css('opacity', '0.5'); */
	});
});
function clickModal(idx) {
	setModalImageArr(idx);
	var url = "showImageInfoOne.htm?image_idx=" + idx;
	
	$(".modal-content").load(url, function(e) {
		$('#theModal').modal('show');
	});
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

	var jsonUrl = "/showRightInfoImage";
	
	var rightObj = new Object();
	rightObj.image_idx = tag;
	
	var jsonData = JSON.stringify(rightObj);

	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",   
		async:false,
		data : jsonData,          		   
	    success: function(data) {
	    	//$('.IPDiv2').text(data.item_name + " ch" + data.dev_ch);
	    	
			var tags = data.tags.substring(1, data.tags.length - 1);

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
			
	    	$('.IPDiv2').text("ch" + data.dev_ch);
	    	var day2 = new Date(data.event_time);
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
	    	var tagInfoArray2 = data.tags;
	    	
	    	$('.tagDiv2').text(tagInfo);
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
 
		$('.searchHidden').attr('class','search');
		$('.menu').attr('class','menuHidden'); 
	}
}
function clickV(tag , date) {
	if ($('#' + tag + 'V').attr('class') == 'showChkV') {
		$('#' + tag + 'V').removeClass('showChkV');
		$('#' + tag + 'V').addClass("afterChkV");
		$('.' + tag).find('.beforeChkImage').addClass("afterChkImage");
		$('.' + tag).find('.afterChkImage').removeClass("beforeChkImage");
		if ($('.' + date).find('.afterChkV').length == 1) {
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
		if ($('.' + date).find('.afterTitleChk').length > 0) {
			$('.' + date).find('.afterTitleChk').addClass("hideTitleChk");
			$('.' + date).find('.afterTitleChk').removeClass("afterTitleChk");
		}
		if ($('.' + date).find('.afterChkV').length == 0) {
			$('.searchHidden').addClass("search");
			$('.searchHidden').removeClass("searchHidden");
			$('.menu').addClass("menuHidden");
			$('.menu').removeClass("menu");
		}
	}
}
function isErrorImg(img) {
	var imgObj = new Object();
	var src = "/resources/image/imageError.png"
	var thumb_name = img.src.substring(img.src.indexOf('/web_server/'));
	
	imgObj.image_name = thumb_name.substring(0, thumb_name.lastIndexOf('_')) + '.jpg';
	//imgObj.monitoring_tag = tag;
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
		success: function() {
			img.src = thumb_name;
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	}); 
}
</script>
</head>
<body><!-- style="overflow:hidden;" onscroll="scrollFunction(this)" -->
	<div id="Progress_Loading" align="center" > <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" width="30%" style="margin-top:70px;" />
	</div>
	<div class="loading">
		<!-- <div id="search_date">
			<button class="closeFilter">
				<span>
					<svg width="24px" height="24px" class="infoSvg" viewBox="0 0 24 24">
						<path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"></path>
					</svg>
				</span>
			</button>
		</div> -->
		<div class="top">
			<div class="searchHr"></div>
			<div class="search">
				<!-- <div class="filterMenu">
					<div class="filterDiv">
						<button class="filterButton">
							<span class="filterSpan">
								<svg class="filterSvg" width="24px" height="24px">
									<path d="M20 4v12H8V4h12m0-2H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-7.53 12L9 10.5l1.4-1.41 2.07 2.08L17.6 6 19 7.41 12.47 14zM4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6z"></path>
								</svg>
							</span>
						</button>
					</div>
				</div> -->
				<div class="searchDiv">
					<div class="searchBar">
						<div class="svgDiv">
							<button class="svgBtn">
								<svg class="svg" width="24px" height="24px">
									<path d="M20.49 19l-5.73-5.73C15.53 12.2 16 10.91 16 9.5A6.5 6.5 0 1 0 9.5 16c1.41 0 2.7-.47 3.77-1.24L19 20.49 20.49 19zM5 9.5C5 7.01 7.01 5 9.5 5S14 7.01 14 9.5 11.99 14 9.5 14 5 11.99 5 9.5z"></path>
								</svg>
							</button>
						</div>
						<div class="searchTextDiv">
							<input class="searchText" type="text" placeholder="내 사진 검색" />
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
		<div class="scroll_big">
			<div class="scroll">
				<div class="location"></div>
				<div class="location_bar"></div>
				<div class="location_start"></div>
				<div class="location_date">
					<div class="location_date_text"></div>
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
	<div id="Progress_Loading2" align="center" > <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" width="30%" style="margin-top:70px;" />
	</div>
	<div class="modal fade" id="theModal">
	    <div class="modal-dialog">
			<div class="modal-content">
		    </div>
	    </div>
	</div>
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
	<div class="downloadImage" style="width:300px; max-width:300px; height:80px; max-height:80px;">
		<h2 class="">다운로드중...</h2>
		<!-- <img src="/resources/image/16.gif" width="100%" /> -->
	</div>
</body>
</html>