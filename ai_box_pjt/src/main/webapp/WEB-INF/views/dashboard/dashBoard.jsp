<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>dashBoard</title>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metro.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.dark.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxcore.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxdata.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxbuttons.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxscrollbar.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxmenu.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.selection.js"></script> 
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.columnsresize.js"></script> 
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.pager.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxcheckbox.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxlistbox.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxdropdownlist.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxdatetimeinput.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxcalendar.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.sort.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.filter.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.edit.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxwindow.js"></script>
<style>
html, body {
	background-color: #252525;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:white;
	line-height: 1.5;
	width:100%;
	height:100%;
}
#body {
	width:100%;
	height:100%;
	padding:60px 0px 60px 0px;
}
#top, #middle, #bottom {
	margin:auto;
}
#top {
	width:1440px;
}
#startDate, #top span, #endDate {
	float:right;
}
#top span {
	margin-left:10px;
	margin-right:10px;
	height:28px;
	line-height:28px;
}
#middle {
	width:1440px;
	height:80px;
	margin-top:90px;
	margin-bottom:60px;
}
.event {
	width:120px;
	float:left;
}
.title {
	height:60px;
	line-height:40px;
	text-align:center;
}
.count {
	height:20px;
	text-align:center;
}
#bottom {
	width:1440px;
	height:65%;
}
#left, #center, #right {
	height:840px;
	float:left;
}
#left {
	width:10%;
}
.leftEvent {
	height:60px;
	text-align:center;
	line-height:60px;
	font-size:16px;
	border:1px solid white;
	background-color:#3E3E42;
}
#center {
	/* width:72%; */
	width:90%;
	
}
#centerLeft, #centerRight {
	height:840px;
	float:left;
}
#centerLeft {
	width:1152px;
	/* width:1512px; */
}
#centerLeftContent {
	height:840px;
	/* border:1px solid white; */
}
#centerTable {
	width:100%;
	height:100%;
	display:flex;
	display:-webkit-box;
	display:-ms-flexbox;
	overflow-x:auto;
	overflow-y:hidden;
	text-align:center;
	border:1px solid white;
	border-collapse:collapse;
}
#centerTable tbody {
	display:flex
}
.centerTr {
	display: block; 
	float: left;
}
.centerTd {
	display:block;
	border:1px solid white;
	width:144px;
	height:60px;
	line-height:60px;
}
.dateTd {
	background-color:#3E3E42;
}
.centerCount {
	height:60px;
	text-align:center;
	line-height:90px;
	font-size:16px;
	border:1px solid white;
}
#centerRight {
	width:144px;
}
.rightEvent {
	height:60px;
	text-align:center;
	line-height:60px;
	font-size:16px;
	border:1px solid white;
	background-color:#3E3E42;
}
#right {
	width:20%;
	border:1px solid white;
}
::-webkit-scrollbar {
  width: 6px;
}
::-webkit-scrollbar-track {
  background-color: transparent;
}
::-webkit-scrollbar-thumb {
  border-radius: 3px;
  background-color: gray;
}
::-webkit-scrollbar-button {
  width: 0;
  height: 0;
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
#imageDiv {
	width:280px;
	height:210px;
	margin:auto;
	margin-top:18px;
}
.glyphicon {
	font-size:28px;
}
#tooltip {
	position:absolute;
	z-index:999;
}
#tooltip .tipBody {
	padding:8px;
}
.changeColor:hover {
	cursor:pointer;
	color: #007ACC;
}
</style>
<script type="text/javascript">
var eventArr = ['falldown', 'fire', 'flood', 'glove', 'invasion', 'leak', 'loitering', 'handaction', 'spin', 'cmtank', 'outtank', 'overflow']
var week = new Array('일', '월', '화', '수', '목', '금', '토');
var day2 = new Date();
var year2 = day2.getFullYear();
$(document).ready(function () {
	function getStartFormatDate(date){
		date.setDate(date.getDate() - 7);
		var year = date.getFullYear();              //yyyy
		var month = (1 + date.getMonth());          //M
		month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
		var day = date.getDate();                   //d
		day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
		
		$('#startDate').jqxDateTimeInput('setDate', new Date(year, date.getMonth(), day));
		//return  year + '-' + month + '-' + day;
	}

	function getEndFormatDate(date){
		var year = date.getFullYear();              //yyyy
		var month = (1 + date.getMonth());          //M
		month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
		var day = date.getDate();                   //d
		day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
		$('#endDate').jqxDateTimeInput('setDate', new Date(year, date.getMonth(), day));
		//return  year + '-' + month + '-' + day;
	}
	
	$('#startDate').jqxDateTimeInput({ 
		width: 180, height: 30, formatString: 'yyyy-MM-dd', theme: 'metrodark', dropDownVerticalAlignment: 'bottom'	//, placeHolder: getStartFormatDate(new Date)
	});
	$('#endDate').jqxDateTimeInput({ 
		width: 180, height: 30, formatString: 'yyyy-MM-dd', theme: 'metrodark', dropDownVerticalAlignment: 'bottom'	//, placeHolder: getEndFormatDate(new Date)
	});
	
	getStartFormatDate(new Date());

	$(".calendar").on('valueChanged', function (event) {
		getStatisticsData($('#startDate').jqxDateTimeInput('val'), $('#endDate').jqxDateTimeInput('val'));
	});
	$('.event').mouseover(function(e) {
		var tag = $(this).attr('id');

		if (tag == 'fire') {
			tag = '화재';
		}
		if (tag == 'falldown') {
			tag = '쓰러짐';
		}
		if (tag == 'flood') {
			tag = '침수';
		}
		if (tag == 'glove') {
			tag = '장갑미착용';
		}
		if (tag == 'invasion') {
			tag = '침입';
		}
		if (tag == 'leak') {
			tag = '누수';
		}
		if (tag == 'loitering') {
			tag = '배회';
		}
		if (tag == 'handaction') {
			tag = '수신호';
		}
		if (tag == 'spin') {
			tag = '약품미투입';
		}
		if (tag == 'cmtank') {
			tag = '약품탱크누액';
		}
		if (tag == 'outtank') {
			tag = '옥외탱크누액';
		}
		if (tag == 'overflow') {
			tag = '배출수월류';
		}
		
		$(this).append('<div id="tooltip"><div class="tipBody">' + tag + '</div></div>');
	}).mousemove(function(e) {
		$("#tooltip").css('top', e.pageY + 10);
		$("#tooltip").css('left', e.pageX + 10);
	}).mouseout(function() {
		$(this).children('div#tooltip').remove();
	});
	getStatisticsData($('#startDate').jqxDateTimeInput('val'), $('#endDate').jqxDateTimeInput('val'));
});

function getStatisticsData(startDate, endDate) {
	var obj = new Object();
	obj.startDate = startDate;
	obj.endDate = endDate;
	
	var jsonUrl = "/dashboard";
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		   
	    success: function(data) {
	    	var totalEventCountData = data[0];
	    	var dateEventCountData = data[1];

	    	clearRightData();
	    	changeMiddleCount(totalEventCountData);
	    	changeBottomCount(dateEventCountData);
	    	
	    },
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(jsonUrl);
		}
	});
}

function changeMiddleCount(countArr) {
	for (var i = 0; i < countArr.length; i++) {
		$('#' + countArr[i].event + 'Count').text(countArr[i].count);
	}
}
function changeBottomCount(countArr) {
	$('#centerTable tr').remove();
	
	var str = '<tbody>';
	
	var totalCount = 0;
	
	if (countArr.length > 0) {
		console.log(countArr);
		for (var i = 0; i < countArr.length; i++) {
			str += '<tr>';
			str += '<td class="centerTd dateTd">' + countArr[i].time + '</td>';

			var idx = 0;
			var count = 0;
			for (var k = 0; k < countArr[i].event.split(',').length; k++) {
				for (var j = idx; j < eventArr.length; j++) {
					console.log(eventArr[j], countArr[i].event.split(',')[k].split('_')[0]);
					if (eventArr[j] == countArr[i].event.split(',')[k].split('_')[0]) {
						str += '<td class="centerTd ' + countArr[i].event.split(',')[k].split('_')[0] + ' changeColor" ondblclick="showPopup(' + "'" + countArr[i].event.split(',')[k].split('_')[0] + "', '" + countArr[i].time + "일'" + ');">' + countArr[i].event.split(',')[k].split('_')[1] + '</td>';
						idx = j + 1;
						count += parseInt(countArr[i].event.split(',')[k].split('_')[1]);
						$('#total' + j).text(parseInt($('#total' + j).text()) + parseInt(countArr[i].event.split(',')[k].split('_')[1]));
						if (k != countArr[i].event.split(',').length - 1) {
							break;
						}
					} else {
						str += '<td class="centerTd ' + eventArr[j] + '">' + 0 + '</td>';
					}
				}
			}
			
			str += '<td class="centerTd">' + count + '</td>';
			str += '</tr>';
			
			totalCount += count;
		}
	} else {
		for (var i = 0; i < eventArr.length; i++) {
			$('#total' + i).text(0);
		}
	}
	str += '</tbody>';
	
	$('#centerTable').append(str);
	
	$('#dateTotal').text(countArr.length + '일');
	$('#total12').text(totalCount);
}
function showInfo(idx) {
	var jsonUrl = "/showRightInfo";
	
	var jsonData = idx;

	$('#imageDiv img').remove();
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",   
		async:false,
		data : jsonData,             		   
	    success: function(data) {
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
				
				if (i < tags.split(', ').length - 1) {
					tagInfo += ', ';
				}
			}
	    	$('.IPDiv2').text(data.dev_title);
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
			
			var tag = data.event_name;

    		if (tag == 'KWATER_Falldown_Detection') {
    			tag = '화재';
    		}
    		if (tag == 'KWATER_Falldown_Detection') {
    			tag = '쓰러짐';
    		}
    		if (tag == 'KWATER_Flood_Detection') {
    			tag = '침수';
    		}
    		if (tag == 'KWATER_Glove_Detection') {
    			tag = '장갑미착용';
    		}
    		if (tag == 'KWATER_Invasion_Detection') {
    			tag = '침입';
    		}
    		if (tag == 'KWATER_Leak_Detection') {
    			tag = '누수';
    		}
    		if (tag == 'KWATER_Loitering_Detection') {
    			tag = '배회';
    		}
    		if (tag == 'KWATER_HandAction_Detection') {
    			tag = '수신호';
    		}
    		if (tag == 'KWATER_Spin_Detection') {
    			tag = '약품미투입';
    		}
				
	    	$('.tagDiv2').text(tagInfo);
	    	var imgStr = '<img src="' + data.thumb_name + '" style="width:100%; height:100%;" />';
	    	$('#imageDiv').append(imgStr);
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});
}
var POPUP_MORE = 0;
var popup_window = new Array();
var popup_width = 1280;
var popup_height = 720;
function showPopup(tag, time) {
	var event_name = 'KWATER_' + tag + '_Detection';
	
	if (tag == 'cmtank' || tag == 'outtank') {
		event_name = 'KWATER_' + tag + '_Leak';
	}
	
	if (tag == 'overflow') {
		event_name = 'KWATER_' + tag;
	}
	
	var url = '/tagImage.htm?event_name=' + event_name + '&scroll=Y&event_time=' + time;
		
	if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed) {
		popup_window[POPUP_MORE].close();
	}

	popup_window[POPUP_MORE] = openWindow(url, event_name, window.innerWidth, window.innerHeight);	// 1280 + 16, 720 + 68
}
function openWindow(page, pageName, width, height) {
	var popupX = (screen.availWidth - width) / 2;
	var popupY = (screen.availHeight - height) / 2;
	var scrollbars = (pageName == 'webNoticeAdd' || pageName == 'webNoticeModify') ? 'yes' : 'no';

	var popup_window = window.open(page, pageName, 'width=' + width + ', height=' + height + ', toolbar=no, location=no, status=no, menubar=no, scrollbars=' + scrollbars + ', resizable=no, left=' + popupX + ', top=' + popupY);

	//popup_window.focus();
	
	return popup_window;
}
function clearRightData() {
	$('.IPDiv2').text('');
	$('.dateDiv2').text('');
	$('.timeSpan2').text('');
	$('.tagDiv2').text('');
	$('.rightEvent').text(0);
	$('.count').text(0);
	$('#imageDiv img').remove();
}
</script>
</head>
<body>
	<div id="body">
		<div id="top">
			<div id="endDate" class="calendar"></div>
			<span> ~ </span> 
			<div id="startDate" class="calendar"></div>
		</div>
		<div id="middle">
			<div id="falldown" class="event">
				<div id="falldownTitle" class="title">
					<span><img src="/resources/image/event/falldown.png" width="80px" style="margin-top:-25px;"/></span>
				</div>
				<div id="falldownCount" class="count 1"></div>
			</div>
			<div id="fire" class="event">
				<div id="fireTitle" class="title">
					<span><img src="/resources/image/event/fire.png" width="80px" style="margin-top:-30px;"/></span>
				</div>
				<div id="fireCount" class="count 0"></div>
			</div>
			<div id="flood" class="event">
				<div id="floodTitle" class="title">
					<span><img src="/resources/image/event/flood.png" width="70px" style="margin-top:-20px;"/></span>
				</div>
				<div id="floodCount" class="count 2"></div>
			</div>
			<div id="glove" class="event">
				<div id="gloveTitle" class="title">
					<span><img src="/resources/image/event/glove.png" width="110px" style="margin-top:-30px;"/></span>
				</div>
				<div id="gloveCount" class="count 3"></div>
			</div>
			<div id="invasion" class="event">
				<div id="invasionTitle" class="title">
					<span><img src="/resources/image/event/invasion.png" width="70px" style="margin-top:-20px;"/></span>
				</div>
				<div id="invasionCount" class="count 4"></div>
			</div>
			<div id="leak" class="event">
				<div id="leakTitle" class="title">
					<span><img src="/resources/image/event/leak.png" width="90px" style="margin-top:-25px;"/></span>
				</div>
				<div id="leakCount" class="count 5"></div>
			</div>
			<div id="loitering" class="event">
				<div id="loiteringTitle" class="title">
					<span><img src="/resources/image/event/loitering.png" width="65px" style="margin-top:-20px;"/></span>
				</div>
				<div id="loiteringCount" class="count 6"></div>
			</div>
			<div id="handaction" class="event">
				<div id="handactionTitle" class="title">
					<span><img src="/resources/image/event/handaction.png" width="100px" style="margin-top:-40px;"/></span>
				</div>
				<div id="handactionCount" class="count 7"></div>
			</div>
			<div id="spin" class="event">
				<div id="spinTitle" class="title">
					<span><img src="/resources/image/event/spin.png" width="70px" style="margin-top:-20px; margin-left:-40px;"/></span>
				</div>
				<div id="spinCount" class="count 8" style="margin-left:-40px;"></div>
			</div>
			<div id="cmtank" class="event">
				<div id="cmtankTitle" class="title">
					<span><img src="/resources/image/event/cmtank.png" width="70px" style="margin-top:-20px; margin-left:-40px;"/></span>
				</div>
				<div id="cmtankCount" class="count 8" style="margin-left:-40px;"></div>
			</div>
			<div id="outtank" class="event">
				<div id="outtankTitle" class="title">
					<span><img src="/resources/image/event/outtank.png" width="70px" style="margin-top:-20px; margin-left:-40px;"/></span>
				</div>
				<div id="outtankCount" class="count 8" style="margin-left:-40px;"></div>
			</div>
			<div id="overflow" class="event">
				<div id="overflowTitle" class="title">
					<span><img src="/resources/image/event/overflow.png" width="70px" style="margin-top:-20px; margin-left:-40px;"/></span>
				</div>
				<div id="overflowCount" class="count 8" style="margin-left:-40px;"></div>
			</div>
		</div>
		<div id="bottom">
			<div id="left">
				<div class="leftEvent">날짜</div>
				<div class="leftEvent">쓰러짐</div>
				<div class="leftEvent">화재</div>
				<div class="leftEvent">침수</div>
				<div class="leftEvent">장갑미착용</div>
				<div class="leftEvent">침입</div>
				<div class="leftEvent">누수</div>
				<div class="leftEvent">배회</div>
				<div class="leftEvent">수신호</div>
				<div class="leftEvent">약품미투입</div>
				<div class="leftEvent">약품탱크누액</div>
				<div class="leftEvent">옥외탱크누액</div>
				<div class="leftEvent">배출수월류</div>
				<div class="leftEvent">총합</div>
			</div>
			<div id="center">
				<div id="centerLeft">
					<div id="centerLeftContent">
						<table id="centerTable">
						</table>
					</div>
				</div>
				<div id="centerRight">
					<div id="dateTotal" class="rightEvent"></div>
					<div id="total0" class="rightEvent"></div>
					<div id="total1" class="rightEvent"></div>
					<div id="total2" class="rightEvent"></div>
					<div id="total3" class="rightEvent"></div>
					<div id="total4" class="rightEvent"></div>
					<div id="total5" class="rightEvent"></div>
					<div id="total6" class="rightEvent"></div>
					<div id="total7" class="rightEvent"></div>
					<div id="total8" class="rightEvent"></div>
					<div id="total9" class="rightEvent"></div>
					<div id="total10" class="rightEvent"></div>
					<div id="total11" class="rightEvent"></div>
					<div id="total12" class="rightEvent"></div>
				</div>
			</div>
			<!-- <div id="right">
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
							</dd>
						</div>
					</dl>
					<div id="imageDiv">
					
					</div>
				</div>
			</div> -->
		</div>
	</div>
</body>
</html>