<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.metro.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.arctic.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<!-- <script  src="./resources/js/canvas/canvasjs.min.js"></script> -->
<script src="./resources/js/bootstrap.min.js"></script>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap4-alpha3.min.css" />
<script  src="./resources/js/jqwidgets/jqxcore.js"></script>
<script  src="./resources/js/jqwidgets/jqxdata.js"></script>
<script  src="./resources/js/jqwidgets/jqxbuttons.js"></script>
<script  src="./resources/js/jqwidgets/jqxscrollbar.js"></script>
<script  src="./resources/js/jqwidgets/jqxscrollbar.js"></script>
<script  src="./resources/js/jqwidgets/jqxmenu.js"></script>
<script  src="./resources/js/jqwidgets/jqxlistbox.js"></script>
<script  src="./resources/js/jqwidgets/jqxdropdownlist.js"></script>
<script  src="./resources/js/jqwidgets/jqxdatetimeinput.js"></script>
<script  src="./resources/js/jqwidgets/jqxcalendar.js"></script>
<script  src="./resources/js/jqwidgets/jqxcheckbox.js"></script>
<script  src="./resources/js/jqwidgets/jqxlistbox.js"></script>
<script src="./resources/js/canvas/recent_canvasjs.min.js"></script>
<script src="./resources/js/tether.min.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<style>
.loading {
	display:none;
}
body {
	background-color: #252525;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:white;
	line-height: 1.5;
}
.jqx-dropdownlist-content, .jqx-widget-content-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:white;
}
h1,h2,h3,h4,h5,h6 {
	font-weight: 400;	
}
#header {
	/* border: 2px solid; */
	border-bottom: 5px solid #b3b3b3;
	color: #526974;
	margin-bottom: 1.5rem;
	padding: 1rem 0;
}
#monthly-chart, #daily-chart, #hourly-chart, #size-chart0, #size-chart1 {
	height: 234px;
	width: 100%;
}
.card {
	border:none;
}
.card-block {
	border:none;
	background-color:#2a2a2c;
}

.card-header {
	background-color: #3e3e42;
	border-radius: 0 !important;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:white;
	margin-bottom: 0;
}
.menu_title {
	padding-left:15px;
	color:white;
}
.jqx-fill-state-hover-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.jqx-fill-state-normal-metrodark {
	background:transparent;
}
.jqx-fill-state-hover-metrodark {
	background:transparent;
	border-color:transparent;
	color:#007ACC;
}
.jqx-fill-state-pressed-metrodark {
	background:transparent;
	border-color:transparent;
	color:#007ACC;
}
.jqx-fill-state-focus-metrodark {
	border-color:transparent;
}
.jqx-widget-content-metrodark {
	border-color:transparent;
}
.jqx-action-button {
	border-left:none;
}
.jqx-action-button:hover {
	background:#007ACC;
}
.jqx-dropdownlist {
	border-color:transparent;
}
.jqx-dropdownlist-content:hover {
	color:#007ACC;
}
.container {
	max-width:1200px;
	width:1200px;
}
.row {
	margin-left:0px;
}
</style>
<script>
var jsonUrl = "/mainCount";
//var websocketUrl = 'http://192.168.100.101:20101/websocket';
var websocketUrl = '/websocket';
var prevTime = 1;

function get(key) {
	return sessionStorage.getItem(key);
}

function setSearchdate2(searchdate2) {
	sessionStorage.setItem('searchdate2', searchdate2);
}
function setEventName(eventName) {
	sessionStorage.setItem('eventName', eventName);
}
function setItemName(itemName) {
	sessionStorage.setItem('itemName', itemName);
}
function setDeviceIp(deviceIp) {
	sessionStorage.setItem('deviceIp', deviceIp);
}
function setDeviceChannel(deviceChannel) {
	sessionStorage.setItem('deviceChannel', deviceChannel);
}
function setEventIndex(eventIndex) {
	sessionStorage.setItem('eventIndex', eventIndex);
}
function setItemIndex(itemIndex) {
	sessionStorage.setItem('itemIndex', itemIndex);
}
function setDeviceIndex(deviceIndex) {
	sessionStorage.setItem('deviceIndex', deviceIndex);
}
function setChannelIndex(channelIndex) {
	sessionStorage.setItem('channelIndex', channelIndex);
}

$(document).ready(function(){
	$('.Progress_Loading').show();
	/* $('#header').hide();
	$('#calendar').hide();
 	$('.card-header').hide();
 	$('.card-block').hide(); 
	$('#Progress_Loading').hide(); //첫 시작시 로딩바를 숨겨준다.*/
	
})
.ajaxStart(function(){
	/* $('#header').hide();
	$('#calendar').hide();
 	$('.card-header').hide();
 	$('.card-block').hide(); 
	$('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.*/
})
.ajaxStop(function(data){
	/*$('#Progress_Loading').hide(); //ajax종료시 로딩바를 숨겨준다.
	$('#header').show();
	$('#calendar').show();
 	$('.card-header').show(); 
 	$('.card-block').show(); */
}); 

$(document).ready(function () {
	var obj = new Object();
	 
	obj.search_date = get('searchdate2');
	
	obj.event_name = get('eventName');
	obj.item_name = get('itemName');
	obj.dev_ip = get('deviceIp');
	obj.dev_channel = get('deviceChannel');
	
	obj.event_index = get('eventIndex');
	if (obj.event_index == 0 || obj.event_index == null) {
		obj.event_index = 0;
	}
	obj.item_index = get('itemIndex');
	if (obj.item_index == 0 || obj.item_index == null) {
		obj.item_index = 0;
	}
	obj.device_index = get('deviceIndex');
	if (obj.device_index == 0 || obj.device_index == null) {
		obj.device_index = 0;
	}
	obj.channel_index = get('channelIndex');
	if (obj.channel_index == 0 || obj.channel_index == null) {
		obj.channel_index = 0;
	}
	
	var jsonData = JSON.stringify(obj);
	var countData = new Object();

	var arr = [];
	var arrChannel = [];
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		async:false,
		data : jsonData,          		   
	    success: function(data) {
	    	countData = data;
	    },
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(jsonUrl);
		}
	});

	
	function draw_dropDownList(countData, obj) {
		$('#event_name').jqxDropDownList({ checkboxes:true, width: 200, height: 30, autoDropDownHeight: true, theme: 'metrodark' });
		//$('#item_name').jqxDropDownList({ selectedIndex: obj.item_index, width: 210, height: 30, autoDropDownHeight: true, theme: 'metrodark' });
		$('#dev_ip').jqxDropDownList({ selectedIndex: obj.device_index, width: 320, height: 30, autoDropDownHeight: true, theme: 'metrodark' });
		
		if (obj.search_date == "" || obj.search_date == null) {
			obj.search_date = countData[0].event_time.substring(0, 10);
		}
		if (obj.event_name == "" || obj.event_name == null) {
			obj.event_name = "";
		}
		if (obj.item_name == "" || obj.item_name == null) {
			obj.item_name = countData[0].item_name;
		}
		if (obj.dev_ip == "" || obj.dev_ip == null) {
			obj.dev_ip = countData[0].dev_ip;
		}
		if (obj.dev_channel == "" || obj.dev_channel == null) {
			obj.dev_channel = "";
		}
			
		for(var i = 0; i < countData.length; i++) {
			var event_name = new Object();
			var item_name = new Object();
			var dev_ip = new Object();
			var dev_channel = new Object();
			
			if (countData[i].event_name != "Test" && countData[i].event_name != "test" && countData[i].event_name != "Test Event") {
				event_name.label = countData[i].event_name;
				event_name.value = countData[i].event_name;
				if (arr.indexOf(countData[i].event_name) >= 0) {
				} else {
					$('#event_name').jqxDropDownList('addItem', event_name);
					arr.push(countData[i].event_name);
				}
			}
			
			/* item_name.label = countData[i].item_name;
			item_name.value = countData[i].item_name; */
			/* if (arr.indexOf(countData[i].item_name) >= 0) {
			} else {
				$('#item_name').jqxDropDownList('addItem', item_name);
				arr.push(countData[i].item_name);
			} */
			dev_ip.label = countData[i].dev_ip;
			dev_ip.value = countData[i].dev_ip;
			if (arr.indexOf(countData[i].dev_ip) >= 0) {
			} else {
				$('#dev_ip').jqxDropDownList('addItem', dev_ip);
				arr.push(countData[i].dev_ip);
			}
			
				
			/* dev_channel.label = countData[i].dev_channel;
			dev_channel.value = countData[i].dev_channel; */
			/* if (arrChannel.indexOf(countData[i].dev_channel) >= 0) {
			} else {
				arrChannel.push(countData[i].dev_channel);
			} */
		}

		arrChannel.sort(function(a, b) {
			return a-b;
		})
		
		//$('#dev_channel').jqxDropDownList({checkboxes:true, source: arrChannel, width: 260, height: 30, autoDropDownHeight: true, theme: 'metrodark' });
		
		if (obj.event_name == "" || obj.event_name == null) {
			$("#event_name").jqxDropDownList('checkIndex', 0);
			$("#event_name").jqxDropDownList('checkIndex', 1);
			obj.event_name = $("#event_name").jqxDropDownList('val');
			setEventName(obj.event_name);
		} else if (obj.event_name == "None") {
			$("#event_name").jqxDropDownList('uncheckAll');
		} else {
			for (var i in obj.event_name.split(',')) {
				$('#event_name').jqxDropDownList('checkItem', obj.event_name.split(',')[i]);
			}
		}
		
		/* if (obj.dev_channel == "" || obj.dev_channel == null) {
			$("#dev_channel").jqxDropDownList('checkAll');
			obj.dev_channel = $("#dev_channel").jqxDropDownList('val')
		} else if (obj.dev_channel == "None") {
			$("#dev_channel").jqxDropDownList('uncheckAll');
		} else {
			for (var i in obj.dev_channel.split(',')) {
				$('#dev_channel').jqxDropDownList('checkItem', obj.dev_channel.split(',')[i]);
			}
		} */
	}
	
	function draw_dashboard(countData, obj) {
    	var year = parseInt(obj.search_date.substring(0, 4), 10);
		var month = parseInt(obj.search_date.substring(5, 7), 10);	
		var monthStr = "";
		var sum = 0;		// 총합
		var sumArr1 = new Array();
		var sumArr2 = new Array();

		for(var i = 0; i < 13; i++) {
			sum = 0;
			if(month < 1) {
				year = year - 1;
				month = 13 - 1;
			}
			
			if (month < 10) {
				monthStr = "0" + month;
			} else {
				monthStr = month + "";
			}
				
			if (obj.event_name.split(',').length == 2) {
				for (var l = 1; l < obj.event_name.split(',').length + 1; l++) {
					sum = 0;
					/* if (obj.dev_channel == "" || obj.dev_channel == null) { */	
						for (var j = 0; j < countData.length; j++) {
							if (year + "-" + monthStr == countData[j].event_time.substring(0, 7) && 
									obj.event_name.split(',')[l-1] == countData[j].event_name/*  && obj.item_name == countData[j].item_name */
									&& obj.dev_ip == countData[j].dev_ip) {
								sum = sum + parseInt(countData[j].event_count, 10);
							}
						}
					/* } else if(obj.dev_channel == "None") { */
						for (var j = 0; j < countData.length; j++) {
							if (year + "-" + monthStr == countData[j].event_time.substring(0, 7) && 
									obj.event_name.split(',')[l-1] == countData[j].event_name/*  && obj.item_name == countData[j].item_name */
									&& obj.dev_ip == countData[j].dev_ip && obj.dev_channel == countData[j].dev_channel) {
								sum = sum + parseInt(countData[j].event_count, 10);
							}
						}
					/* } else { */
						for (var j = 0; j < countData.length; j++) {
							if (year + "-" + monthStr == countData[j].event_time.substring(0, 7) && 
									obj.event_name.split(',')[l-1] == countData[j].event_name/*  && obj.item_name == countData[j].item_name */
									&& obj.dev_ip == countData[j].dev_ip) {
								for (var k = 0; k < obj.dev_channel.split(',').length; k++) {
									if (obj.dev_channel.split(',')[k] == countData[j].dev_channel) {
										sum = sum + parseInt(countData[j].event_count, 10);
									}
								}
							}
						}
					/* } */
						
					var jsonObj = new Object();
					jsonObj.x = new Date(year + '-' + (monthStr) + '-01');
					jsonObj.y = sum;
					eval('sumArr' + l + '.push(jsonObj)');
				}
				month--;
			} else {
				/* if (obj.dev_channel == "" || obj.dev_channel == null) { */	
					for (var j = 0; j < countData.length; j++) {
						if (year + "-" + monthStr == countData[j].event_time.substring(0, 7) && 
								obj.event_name == countData[j].event_name/*  && obj.item_name == countData[j].item_name */
								&& obj.dev_ip == countData[j].dev_ip) {
							sum = sum + parseInt(countData[j].event_count, 10);
						}
					}
				/* } else if(obj.dev_channel == "None") { */
					for (var j = 0; j < countData.length; j++) {
						if (year + "-" + monthStr == countData[j].event_time.substring(0, 7) && 
								obj.event_name == countData[j].event_name/*  && obj.item_name == countData[j].item_name */
								&& obj.dev_ip == countData[j].dev_ip && obj.dev_channel == countData[j].dev_channel) {
							sum = sum + parseInt(countData[j].event_count, 10);
						}
					}
				/* } else { */
					for (var j = 0; j < countData.length; j++) { 
						if (year + "-" + monthStr == countData[j].event_time.substring(0, 7) && 
								obj.event_name == countData[j].event_name/*  && obj.item_name == countData[j].item_name */
								&& obj.dev_ip == countData[j].dev_ip) {
							for (var k = 0; k < obj.dev_channel.split(',').length; k++) {
								if (obj.dev_channel.split(',')[k] == countData[j].dev_channel) {
									sum = sum + parseInt(countData[j].event_count, 10);
								}
							}
						}
					}
				/* } */
					
				var jsonObj = new Object();
				jsonObj.x = new Date(year + '-' + (monthStr) + '-01');
				jsonObj.y = sum;
				month--;
				sumArr1.push(jsonObj);
			}			
		}

		if (obj.event_name.split(',').length == 2) {
			var monthlyChart = new CanvasJS.Chart("monthly-chart", {
				animationEnabled: true,
				backgroundColor: "#2a2a2c",
				legend: {
				    fontColor: "#fff",
					fontSize: 14,
					fontWeight: "bold",
				    horizontalAlign: "center", // left, center ,right 
				    verticalAlign: "bottom"  // top, center, bottom
				},
				axisX: {
			        labelFontColor:"#fff",
					labelFontSize: 14,
					valueFormatString: "YYYY-MM",
			        intervalType: "month"
				},
				axisY: {
					title:obj.event_name.split(',')[0],
					titleFontColor: "#fff",
					titleFontSize: 20,
			        labelFontColor:"#fff",
					labelFontSize: 14,
					/* scaleBreaks: {
						autoCalculate: true,
					} */
					includeZero: true
				},
				axisY2: {
					title: obj.event_name.split(',')[1],
					titleFontColor: "#fff",
					titleFontSize: 20,
					labelFontSize: 14,
					labelFontColor: "#fff",
					includeZero: true
				},
				toolTip: {
					borderColor: "white",
					cornerRadius: 0
				},
				data: [
					{
						type: "column",		// line
						name: "Axis Y-1",
						legendText: obj.event_name.split(',')[0],
						showInLegend: true,
						xValueFormatString: "YYYY-MM",
						yValueFormatString: "###,###.##",
					    indexLabelFontColor: "white",
						indexLabel: "{y}",
						dataPoints:sumArr1
					},
					{
						type: "column",		// line
						axisYType: "secondary",
						name: "Axis Y-2",
						legendText: obj.event_name.split(',')[1],
						showInLegend: true,
						xValueFormatString: "YYYY-MM",
						yValueFormatString: "###,###.##",
					    indexLabelFontColor: "white",
						indexLabel: "{y}",
						dataPoints:sumArr2
					}
				]
			}); 
		} else {
			var monthlyChart = new CanvasJS.Chart("monthly-chart", {
				animationEnabled: true,
				backgroundColor: "#2a2a2c",
				legend: {
				    fontColor: "#fff",
					fontSize: 14,
					fontWeight: "bold",
				    horizontalAlign: "center", // left, center ,right 
				    verticalAlign: "bottom"  // top, center, bottom
				},
				axisX: {
			        labelFontColor:"#fff",
					labelFontSize: 14,
			        intervalType: "month"
				},
				axisY: {
			        labelFontColor:"#fff",
					labelFontSize: 14,
					/* scaleBreaks: {
						autoCalculate: true,
					} */
				},
				toolTip: {
					borderColor: "white",
					cornerRadius: 0
				},
				data: [
					{
						type: "column",		// line
				        color: "#3CB371",
						legendText: obj.event_name,
						showInLegend: true,
						xValueFormatString: "YYYY-MM",
						yValueFormatString: "###,###.##",
					    indexLabelFontColor: "white",
						indexLabel: "{y}",
						dataPoints:sumArr1
					}
				]
			}); 
		}
		
		monthlyChart.render();
		
		// CanvasJS column chart to show revenue from Jan 2015 - Dec 2015
			var sumDay = 0;		// 총합
			var dayStr = "";
			var dayArr1 = new Array();
			var dayArr2 = new Array();
			var lastDay = new Date(parseInt(obj.search_date.substring(0, 4), 10), 
     			parseInt(obj.search_date.substring(5, 7), 10), 0).getDate();
			
		for(var i = 1; i < lastDay + 1; i++) {
			sumDay = 0;
									
			if (i < 10) {
				dayStr = obj.search_date.substring(0, 8) + "0" + i;
			} else {
				dayStr = obj.search_date.substring(0, 8) + i;
			} 
			
			if (obj.event_name.split(',').length == 2) {
				for (var l = 1; l < obj.event_name.split(',').length + 1; l++) {
					sumDay = 0;
					
					/* if (obj.dev_channel == "" || obj.dev_channel == null) { */
						for (var j = 0; j < countData.length; j++) {
							if (dayStr == countData[j].event_time.substring(0, 10) && obj.event_name.split(',')[l-1] == countData[j].event_name
								/* && obj.item_name == countData[j].item_name  */&& obj.dev_ip == countData[j].dev_ip) {
								sumDay = sumDay + parseInt(countData[j].event_count, 10);
							}
						}
					/* } else if(obj.dev_channel == "None") { */
						for (var j = 0; j < countData.length; j++) {
							if (dayStr == countData[j].event_time.substring(0, 10) && obj.event_name.split(',')[l-1] == countData[j].event_name
									/* && obj.item_name == countData[j].item_name */ && obj.dev_ip == countData[j].dev_ip/*  && obj.dev_channel == countData[j].dev_channel */) {
									sumDay = sumDay + parseInt(countData[j].event_count, 10);
							}
						}
					/* } else { */
						for (var j = 0; j < countData.length; j++) {
							if (dayStr == countData[j].event_time.substring(0, 10) && obj.event_name.split(',')[l-1] == countData[j].event_name
									/* && obj.item_name == countData[j].item_name */ && obj.dev_ip == countData[j].dev_ip) {
								/* for (var k = 0; k < obj.dev_channel.split(',').length; k++) {
									if (obj.dev_channel.split(',')[k] == countData[j].dev_channel) {
										sumDay = sumDay + parseInt(countData[j].event_count, 10);
									}	
								} */
							}
						}
					/* } */
					
					var jsonObj = new Object();
					var label = i + "";
					
					jsonObj.x = i;
					jsonObj.y = sumDay;
					jsonObj.label = label;
					eval('dayArr' + l + '.push(jsonObj)');
				}
			} else {
				/* if (obj.dev_channel == "" || obj.dev_channel == null) { */
					for (var j = 0; j < countData.length; j++) {
						if (dayStr == countData[j].event_time.substring(0, 10) && obj.event_name == countData[j].event_name
							/* && obj.item_name == countData[j].item_name */ && obj.dev_ip == countData[j].dev_ip) {
							sumDay = sumDay + parseInt(countData[j].event_count, 10);
						}
					}
				/* } else if(obj.dev_channel == "None") { */
					for (var j = 0; j < countData.length; j++) {
						if (dayStr == countData[j].event_time.substring(0, 10) && obj.event_name == countData[j].event_name
								/* && obj.item_name == countData[j].item_name */ && obj.dev_ip == countData[j].dev_ip/*  && obj.dev_channel == countData[j].dev_channel */) {
								sumDay = sumDay + parseInt(countData[j].event_count, 10);
							}
					}
				/* } else { */
					for (var j = 0; j < countData.length; j++) {
						if (dayStr == countData[j].event_time.substring(0, 10) && obj.event_name == countData[j].event_name
								/* && obj.item_name == countData[j].item_name */ && obj.dev_ip == countData[j].dev_ip) {
							/* for (var k = 0; k < obj.dev_channel.split(',').length; k++) {
								if (obj.dev_channel.split(',')[k] == countData[j].dev_channel) {
									sumDay = sumDay + parseInt(countData[j].event_count, 10);
								}
							} */
						}
					}
				/* } */
				
				var jsonObj = new Object();
				var label = i + "";
				
				jsonObj.x = i;
				jsonObj.y = sumDay;
				jsonObj.label = label;
				dayArr1.push(jsonObj);
			}
		}

		if (obj.event_name.split(',').length == 2) {
			var dailyChart = new CanvasJS.Chart("daily-chart", {
				animationEnabled: true,
				backgroundColor: "#2a2a2c",
				legend: {
				    fontColor: "#fff",
					fontSize: 14,
					fontWeight: "bold",
				    horizontalAlign: "center", // left, center ,right 
				    verticalAlign: "bottom"  // top, center, bottom
				},
				axisX: {
			        labelFontColor:"#fff",
					labelFontSize: 14
				},
				axisY: {
					title:obj.event_name.split(',')[0],
					titleFontColor: "#fff",
					titleFontSize: 20,
			        labelFontColor:"#fff",
					labelFontSize: 14,
					/* scaleBreaks: {
						autoCalculate: true,
					} */
					includeZero: true
				},
				axisY2: {
					title: obj.event_name.split(',')[1],
					titleFontColor: "#fff",
					titleFontSize: 20,
					labelFontSize: 14,
					labelFontColor: "#fff",
					includeZero: true
				},
				toolTip: {
					borderColor: "white",
					cornerRadius: 0
				},
				data: [
					{
						type: "column",		// line
						legendText: obj.event_name.split(',')[0],
						showInLegend: true,
						xValueFormatString: "##",
						yValueFormatString: "###,###.##",
					    indexLabelFontColor: "white",
						indexLabel: "{y}",
						dataPoints:dayArr1
					},
					{
						type: "column",		// line
						axisYType: "secondary",
						legendText: obj.event_name.split(',')[1],
						showInLegend: true,
						xValueFormatString: "##",
						yValueFormatString: "###,###.##",
					    indexLabelFontColor: "white",
						axisYType: "secondary",
						indexLabel: "{y}",
						dataPoints:dayArr2
					}
				]
			}); 
		} else {
			var dailyChart = new CanvasJS.Chart("daily-chart", {
				animationEnabled: true,
				backgroundColor: "#2a2a2c",
				legend: {
				    fontColor: "#fff",
					fontSize: 14,
					fontWeight: "bold",
				    horizontalAlign: "center", // left, center ,right 
				    verticalAlign: "bottom"  // top, center, bottom
				},
				axisX: {
			        labelFontColor:"#fff",
					labelFontSize: 14,
					interval: 10
				},
				axisY: {
			        labelFontColor:"#fff",
					labelFontSize: 14,
					/* scaleBreaks: {
						autoCalculate: true,
					} */
				},
				toolTip: {
					borderColor: "white",
					cornerRadius: 0
				},
				data: [
					{
						type: "column",		// line
				        color: "#4F81BC",  
						legendText: obj.event_name,
						showInLegend: true,
						xValueFormatString: "##",
						yValueFormatString: "###,###.##",
					    indexLabelFontColor: "white",
						indexLabel: "{y}",
						dataPoints:dayArr1
					}
				]
			}); 
		}
		
		dailyChart.render(); 
		
		// CanvasJS column chart to show revenue from Jan 2015 - Dec 2015
			var sumTime = 0;		// 총합
			var hourStr = "";
			var timeArr1 = new Array();
			var timeArr2 = new Array();
			
		for(var i = 0; i < 24; i++) {
			sumTime = 0;
									
			if (i < 10) {
				hourStr = "0" + i;
			} else {
				hourStr = i + "";
			} 
			
			if (obj.event_name.split(',').length == 2) {
				for (var l = 1; l < obj.event_name.split(',').length + 1; l++) {
					sumTime = 0;
						/* if (obj.dev_channel == "" || obj.dev_channel == null) { */
							for (var j = 0; j < countData.length; j++) {
								if ((obj.search_date + ' ' + hourStr) == countData[j].event_time && obj.event_name.split(',')[l-1] == countData[j].event_name
									/* && obj.item_name == countData[j].item_name */ && obj.dev_ip == countData[j].dev_ip) {
									sumTime = sumTime + parseInt(countData[j].event_count, 10);
								}
							}
						/* } else if(obj.dev_channel == "None") { */
							for (var j = 0; j < countData.length; j++) {
								if ((obj.search_date + ' ' + hourStr) == countData[j].event_time && obj.event_name.split(',')[l-1] == countData[j].event_name
										/* && obj.item_name == countData[j].item_name */ && obj.dev_ip == countData[j].dev_ip/*  && obj.dev_channel == countData[j].dev_channel */) {
									sumTime = sumTime + parseInt(countData[j].event_count, 10);
								}
							}
						/* } else { */
							for (var j = 0; j < countData.length; j++) {
								if ((obj.search_date + ' ' + hourStr) == countData[j].event_time && obj.event_name.split(',')[l-1] == countData[j].event_name
										/* && obj.item_name == countData[j].item_name */ && obj.dev_ip == countData[j].dev_ip) {
									/* for (var k = 0; k < obj.dev_channel.split(',').length; k++) {
										if (obj.dev_ip == countData[j].dev_ip && obj.dev_channel.split(',')[k] == countData[j].dev_channel) {
											sumTime = sumTime + parseInt(countData[j].event_count, 10);
										}
									} */
								}
							}
						/* } */
					

					var jsonObj = new Object();
					var label = "";
					if (i < 10) {
						label = "0" + i;
					} else {
						label = "" + i;
					}
					jsonObj.x = i;
					jsonObj.y = sumTime;
					jsonObj.label = label;
					eval('timeArr' + l + '.push(jsonObj)');
				}
			} else {
				/* if (obj.dev_channel == "" || obj.dev_channel == null) { */
					for (var j = 0; j < countData.length; j++) {
						if ((obj.search_date + ' ' + hourStr) == countData[j].event_time && obj.event_name == countData[j].event_name
							/* && obj.item_name == countData[j].item_name */ && obj.dev_ip == countData[j].dev_ip) {
							sumTime = sumTime + parseInt(countData[j].event_count, 10);
						}
					}
				/* } else if(obj.dev_channel == "None") { */
					for (var j = 0; j < countData.length; j++) {
						if ((obj.search_date + ' ' + hourStr) == countData[j].event_time && obj.event_name == countData[j].event_name
								/* && obj.item_name == countData[j].item_name */ && obj.dev_ip == countData[j].dev_ip/*  && obj.dev_channel == countData[j].dev_channel */) {
							sumTime = sumTime + parseInt(countData[j].event_count, 10);
						}
					}
				/* } else { */
					for (var j = 0; j < countData.length; j++) {
						if ((obj.search_date + ' ' + hourStr) == countData[j].event_time && obj.event_name == countData[j].event_name
								/* && obj.item_name == countData[j].item_name */ && obj.dev_ip == countData[j].dev_ip) {
							/* for (var k = 0; k < obj.dev_channel.split(',').length; k++) {
								if (obj.dev_channel.split(',')[k] == countData[j].dev_channel) {
									sumTime = sumTime + parseInt(countData[j].event_count, 10);
								}
							} */
						}
					}
				/* } */
					
				var jsonObj = new Object();
				var label = "";
				if (i < 10) {
					label = "0" + i;
				} else {
					label = "" + i;
				}
				jsonObj.x = i;
				jsonObj.y = sumTime;
				jsonObj.label = label;
				
				//alert("i = " + i + " / sumTime = " + sumTime + " / label = " + label);
				
				timeArr1.push(jsonObj);
			}
		}
		//alert(JSON.stringify(timeArr1));
		
		if (obj.event_name.split(',').length == 2) {
			var hourlyChart = new CanvasJS.Chart("hourly-chart", {
				//width:500,
				animationEnabled: true,
				backgroundColor: "#2a2a2c",
				legend: {
				    fontColor: "#fff",
					fontSize: 14,
					fontWeight: "bold",
				    horizontalAlign: "center", // left, center ,right 
				    verticalAlign: "bottom"  // top, center, bottom
				},
				axisX: {
			        labelFontColor:"#fff",
					labelFontSize: 14,
					interval: 1
				},
				axisY: {
					title:obj.event_name.split(',')[0],
					titleFontColor: "#fff",
					titleFontSize: 20,
			        labelFontColor:"#fff",
					labelFontSize: 14,
					/* scaleBreaks: {
						autoCalculate: true,
					} */
					includeZero: true
				},
				axisY2: {
					title: obj.event_name.split(',')[1],
					titleFontColor: "#fff",
					titleFontSize: 20,
					labelFontSize: 14,
					labelFontColor: "#fff",
					includeZero: true
				},
				toolTip: {
					borderColor: "white",
					cornerRadius: 0
				},
				data: [
					{
						type: "column",		// line
						legendText: obj.event_name.split(',')[0],
						showInLegend: true,
						xValueFormatString: "##",
						yValueFormatString: "###,###.##",
					    indexLabelFontColor: "white",
						indexLabel: "{y}",
						dataPoints:timeArr1
					},
					{
						type: "column",		// line
						axisYType: "secondary",
						legendText: obj.event_name.split(',')[1],
						showInLegend: true,
						xValueFormatString: "##",
						yValueFormatString: "###,###.##",
					    indexLabelFontColor: "white",
						indexLabel: "{y}",
						dataPoints:timeArr2
					}
				]
			}); 
		} else {
			var hourlyChart = new CanvasJS.Chart("hourly-chart", {
				animationEnabled: true,
				backgroundColor: "#2a2a2c",
				legend: {
				    fontColor: "#fff",
					fontSize: 14,
					fontWeight: "bold",
				    horizontalAlign: "center", // left, center ,right 
				    verticalAlign: "bottom"  // top, center, bottom
				},
				axisX: {
			        labelFontColor:"#fff",
					labelFontSize: 14,
					interval: 1
				},
				axisY: {
			        labelFontColor:"#fff",
					labelFontSize: 14,
					/* scaleBreaks: {
						autoCalculate: true,
					} */
				},
				toolTip: {
					borderColor: "white",
					cornerRadius: 0
				},
				data: [
					{
						type: "column",		// line
				        color: "#C0504E",  
						legendText: obj.event_name,
						showInLegend: true,
						xValueFormatString: "##",
						yValueFormatString: "###,###.##",
					    indexLabelFontColor: "white",
						indexLabel: "{y}",
						dataPoints:timeArr1
					}
				]
			}); 
		}
		hourlyChart.render();
	} 

	/* var jsonUrl2 = "/sizeData";
	var obj2 = new Object();
	var jsonData2 = JSON.stringify(obj2);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl2,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		async:false,
		data : jsonData2,          		   
	    success: function(data2) {
			for (var l = 0; l < data2.length; l++) {
				eval("var sizeArr" + l + " = new Array();");
				$('#size' + l).text(data2[l].drive_name + " drive Size");
		    	Object.keys(data2[l]).forEach(function(k){
		    		if (k.substring(0, k.indexOf('_')) != 'free' && k.substring(0, k.indexOf('_')) != 'drive') {
						var sizeObj = new Object();
						
						sizeObj.y = data2[l][k];
						sizeObj.label = k.substring(0, k.indexOf('_'));
						
						eval("sizeArr" + l + ".push(sizeObj)");
		    		}
		    	});

		    	var size_width = 500;	//$('#size-chart').width();
		    	var size_height = $('#size-chart' + l).height();
		    	var sizeChart = new CanvasJS.Chart("size-chart" + l, {
		    		width:size_width,
		    		height:size_height,
		    		animationEnabled: true,
					backgroundColor: "#2a2a2c",
		    		data: [{
		    			type: "pie",
						indexLabel: "{label} {y}",
						indexLabelFontSize: 14,
						indexLabelFontColor: "white",
						radius: 80,
						yValueFormatString: "###0.00\"GB\"",
		    			//color: "#014D65",
		    			dataPoints: eval("sizeArr" + l)
		    		}]
		    	});
		    	sizeChart.render();
			}
	    },
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(jsonUrl2);
		}
	}); */
	
	$('#Progress_Loading').hide();
	$('div').removeClass('loading');
	
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/receiveCount', function (message) {
			var socketObj = JSON.parse(message.body);
			/*var testDate = new Date('00:58:00');
			var testDate2 = new Date(countData[0].event_time); */
			//alert(socketObj);
			/* var date1 = new Date(test.split(',')[0]); */
			var today = new Date();
			var date2 = new Date(socketObj.event_time);
			/* alert((date2 - date1) / 1000); */
			
			if (prevTime == 1) {
				prevTime = date2;
			}
			
			
			/* if ((date2 - today) > 0) {
				for (var t = 0; t < countData.length; t++) {
					if (countData[t].event_time == socketObj.event_time.substring(0, 13) && countData[t].item_name == socketObj.item_name &&
							countData[t].dev_ip == socketObj.dev_ip && countData[t].dev_channel == socketObj.dev_channel && countData) {
						countData[t].event_count = parseInt(countData[t].event_count, 10) + 1 + "";
					} else {
				    	data.splice(1, 0, {"item_type" : 1})
				    	countData.unshift();
					}
				}
			} */
			
			//alert((date2 - prevTime) / 1000);
			if (/* obj.item_name == socketObj.item_name &&  */obj.dev_ip == socketObj.dev_ip && obj.search_date == socketObj.event_time.substring(0, 10)) {
				if (obj.event_name.split(',').length == 0) {
				} else if (obj.event_name.split(',').length == 1) {
					/* for (i = 0; i < obj.dev_channel.split(',').length; i++) {
						if (obj.dev_channel.split(',')[i] == socketObj.dev_channel) { */
							for (var j = 0; j < countData.length; j++) {
								if (/* countData[j].item_name == socketObj.item_name &&  */countData[j].dev_ip == socketObj.dev_ip /* && countData[j].dev_channel == socketObj.dev_channel */ && countData[j].event_name == socketObj.event_name 
										&& countData[j].event_time == socketObj.event_time.substring(0, 13)) {
									countData[j].event_count = parseInt(countData[j].event_count, 10) + 1 + "";
									if ((date2 - prevTime) / 1000 >= 60) {
										prevTime = date2;
										draw_dashboard(countData, obj);	
									}
								}
							}	
						/* }
					} */
				} else {
					if (obj.event_name.split(',')[0] == socketObj.event_name || obj.event_name.split(',')[1] == socketObj.event_name) {
						/* for (var i = 0; i < obj.dev_channel.split(',').length; i++) {
							if (obj.dev_channel.split(',')[i] == socketObj.dev_channel) { */
								for (var j = 0; j < countData.length; j++) {
									if (/* countData[j].item_name == socketObj.item_name &&  */countData[j].dev_ip == socketObj.dev_ip/*  && countData[j].dev_channel == socketObj.dev_channel */ && countData[j].event_name == socketObj.event_name 
											&& countData[j].event_time == socketObj.event_time.substring(0, 13)) {
										countData[j].event_count = parseInt(countData[j].event_count, 10) + 1 + "";
										if ((date2 - prevTime) / 1000 >= 60) {
											prevTime = date2;
											draw_dashboard(countData, obj);	
										}
									}
								}	
						/* 	}
						} */
					}
				}
			}
		}); 
	});
	
	if (countData.length > 0) {
    	draw_dropDownList(countData, obj);
    	draw_dashboard(countData, obj);
	}

	$('#calendar').jqxDateTimeInput({ 
		width: 180, height: 30, formatString: 'yyyy-MM-dd', theme: 'metrodark', dropDownVerticalAlignment: 'bottom'
	});
	
	if (obj.search_date != null && obj.search_date != "") {
		$('#calendar').val(obj.search_date);
	}
	
	$('#calendar').on('valueChanged', function (event) {
		setSearchdate2($('#calendar').jqxDateTimeInput('val'));
		obj.search_date = get('searchdate2');
		
    	draw_dashboard(countData, obj);
		
	});
	
	$('#event_name').bind('checkChange', function (event) {
		var values = $("#event_name").jqxDropDownList('val');
		
		if (values == "") {
			values = "None";
		}
		var value = event.args.item.value;
		
	    if (values.split(',').length == 3) {
			alert("3개 이상 선택 불가능");
			$("#event_name").jqxDropDownList('uncheckItem', value);
		}
	    
	    values = $("#event_name").jqxDropDownList('val');
		setEventName(values);
		obj.event_name = values;
		
		draw_dashboard(countData, obj);
	});
	
	/* $('#item_name').bind('select', function (event) {
	    var args = event.args;
	    var value = $('#item_name').jqxDropDownList('getItem', args.index);
	    setItemName(value.label);
	    setItemIndex(args.index);
	    obj.item_name = get('itemName');

	    draw_dashboard(countData, obj);
	}); */
	
	$('#dev_ip').bind('select', function (event) {
	    var args = event.args;
	    var value = $('#dev_ip').jqxDropDownList('getItem', args.index);
	    setDeviceIp(value.label);
	    setDeviceIndex(args.index);
	    obj.dev_ip = get('deviceIp');

	    draw_dashboard(countData, obj);
	});

	/* $('#dev_channel').bind('checkChange', function (event) {
		var value = $("#dev_channel").jqxDropDownList('val');
		
		if (value == "") {
			value = "None";
		}
		
		setDeviceChannel(value);
		obj.dev_channel = value;
		
		draw_dashboard(countData, obj);
	}); */
		
});
</script>
</head>
<body>
	<div id="Progress_Loading" style="text-align:-webkit-center;"> <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" style="width:30%; margin-top:70px;" alt="loading" />
	</div>
	<div class="container" style="margin-top:70px;">
		<div class="loading">
			<!-- <table id="header"><tr>
			<td>
		    	<h3>
					<span id="dashboard_text" style="color:white; font-weight: bold;">Dashboard</span>
				</h3>
			</td>
			</tr></table> -->
			<div>
				<table style="width:95%;">
				<tr>
					<!-- <td class="menu_title">AI-BOX / IP CAMERA<br />
						<div id='item_name'></div>
					</td> -->
					<td class="menu_title">DEVICE<br />
						<div id='dev_ip'></div>
					</td>
					<!-- <td class="menu_title">Channel<br />
						<div id='dev_channel'></div>
					</td> -->
					<td class="menu_title">EVENT<br />
						<div id='event_name'></div>
					</td>
				</tr>
				</table>
			</div>
			<div style="margin-bottom:15px;">
				<table style="margin-top:10px;width: 100%">
					<tr>
						<td style="padding-left:15px;"><div id="calendar"></div></td>
					</tr>
				</table>
			</div>
			<!-- <div class="row m-b-1" style="width:600px; float:left;">
				<div class="col-xs-12">
					<div class="card shadow">
						<h4 class="card-header" id="size0"></h4>
						<div class="card-block">
							<div id="size-chart0"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row m-b-1" style="width:600px; float:left;">
				<div class="col-xs-12">
					<div class="card shadow">
						<h4 class="card-header" id="size1"></h4>
						<div class="card-block">
							<div id="size-chart1"></div>
						</div>
					</div>
				</div>
			</div> -->
			<div class="row m-b-1">	<!-- style="width:600px; float:left;" -->
				<div class="col-xs-12">
					<div class="card shadow">
						<h4 class="card-header" id="hourly">Time</h4>
						<div class="card-block">
							<div id="hourly-chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row m-b-1">	<!-- style="width:600px; float:left;"  -->
				<div class="col-xs-12">
					<div class="card shadow">
						<h4 class="card-header" id="daily">Day</h4>
						<div class="card-block">
							<div id="daily-chart"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row m-b-1">
				<div class="col-xs-12">
					<div class="card shadow">
						<h4 class="card-header" id="monthly">Month</h4>
						<div class="card-block">
							<div id="monthly-chart"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>