<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<script type="text/javascript" src="/resources/js/translate.js"></script>
<script src="./resources/js/canvas/recent_canvasjs.min.js"></script>
<style type="text/css">
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
#top, #bottom {
	margin:auto;
	width:1300px;
}
#top {
	display:none;
}
#startDate, #top span, #endDate, #submit {
	float:left;
}
#endDate {
	margin-right:20px;
}
#submit {
	margin-left:10px;
	margin-right:10px;
	height:28px;
	line-height:24px;
}
button {
	background-color:#3E3E42;
}
#tilde {
	margin-left:10px;
	margin-right:10px;
	height:28px;
	line-height:28px;
}
#ch, #eventName, #type {
	float:left;
}
#ch, #eventName {
	margin-right:20px;
}
.jqx-fill-state-normal-metrodark, .jqx-widget-content-metrodark, .jqx-fill-state-hover-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.graph {
	width:1300px;
}
</style>
</head>
<script>
var chSource = new Array();
var eventNameSource = new Array();

var typeSource = [
	{
		text : getTranslate('reportingTime'),
		value : "time"
	},
	{
		text : getTranslate('reportingDay'),
		value : "day"
	}
];

function get(key) {
	return sessionStorage.getItem(key);
}
function setReportingStartDate(reportingStartDate) {
	sessionStorage.setItem('reportingStartDate', reportingStartDate);
}
function setReportingEndDate(reportingEndDate) {
	sessionStorage.setItem('reportingEndDate', reportingEndDate);
}
function setReportingCh(reportingCh) {
	sessionStorage.setItem('reportingCh', reportingCh);
}
function setReportingEventName(reportingEventName) {
	sessionStorage.setItem('reportingEventName', reportingEventName);
}
function setReportingType(reportingType) {
	sessionStorage.setItem('reportingType', reportingType);
}
$(document).ready(function () {
	var jsonUrl = "/reportingData";

	var obj = new Object();
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",             
		async:false,     
		data : jsonData,          		   
	    success: function(data) {
	    	if (data.reportDeviceChAndTitleList.length > 0) {
	    		chSource = data.reportDeviceChAndTitleList;
	    	}
	    	if (data.reportingExistEventNameDtoList.length > 0) {
	    		for (var i = 0; i < data.reportingExistEventNameDtoList.length; i++) {
					eventNameSource.push(new EventName(getTranslate(data.reportingExistEventNameDtoList[i].event), data.reportingExistEventNameDtoList[i].event));
	    		}
	    	}
	    },
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(jsonUrl);
		}
	});
	
	$('#ch').jqxDropDownList({checkboxes:true, source:chSource, scrollBarSize:5, width: 260, height: 30, theme: 'metrodark', displayMember: 'title',  valueMember: 'ch'});
	$('#eventName').jqxDropDownList({source:eventNameSource, scrollBarSize:5, width: 260, height: 30, theme: 'metrodark', displayMember: 'text',  valueMember: 'value'});
	$('#type').jqxDropDownList({source:typeSource, scrollBarSize:5, width: 260, height: 30, theme: 'metrodark', displayMember: 'text',  valueMember: 'value'});
	
	$('#startDate').jqxDateTimeInput({ 
		width: 180, height: 30, formatString: 'yyyy-MM-dd', theme: 'metrodark', dropDownVerticalAlignment: 'bottom'	//, placeHolder: getStartFormatDate(new Date)
	});
	$('#endDate').jqxDateTimeInput({ 
		width: 180, height: 30, formatString: 'yyyy-MM-dd', theme: 'metrodark', dropDownVerticalAlignment: 'bottom'	//, placeHolder: getEndFormatDate(new Date)
	});
	
	initMenu();
	
	getData();
	
	$("#top").show();
	
	$("#startDate").on('valueChanged', function (event) {
		setReportingStartDate($('#startDate').jqxDateTimeInput('val'));
	});

	$("#endDate").on('valueChanged', function (event) {
		setReportingEndDate($('#endDate').jqxDateTimeInput('val'));
	});

	$("#ch").on('checkChange', function (event) {
		var chList = "";
		
		for (var i = 0; i < $('#ch').jqxDropDownList('getCheckedItems').length; i++) {
			if (i > 0) {
				chList += ",";
			}
			chList += $('#ch').jqxDropDownList('getCheckedItems')[i].value;
		}
		
		setReportingCh(chList);
	});
	
	$('#eventName').on('select', function (event) {
	    var args = event.args;
	    if (args) {
		    // index represents the item's index.                
		    var index = args.index;
		    var item = args.item;
		    // get item's label and value.
		    var label = item.label;
		    var value = item.value;
		    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
		    
		    setReportingEventName(value);
		}                        
	});

	$('#type').on('select', function (event) {
	    var args = event.args;
	    if (args) {
		    // index represents the item's index.                
		    var index = args.index;
		    var item = args.item;
		    // get item's label and value.
		    var label = item.label;
		    var value = item.value;
		    var type = args.type; // keyboard, mouse or null depending on how the item was selected.
		    
		    setReportingType(value);
		}                        
	});
});
function getData() {
	$('#bottom').empty();
	
	var jsonUrl = "/reporting";

	var chList = "";
	
	for (var i = 0; i < $('#ch').jqxDropDownList('getCheckedItems').length; i++) {
		if (i > 0) {
			chList += ",";
		}
		chList += $('#ch').jqxDropDownList('getCheckedItems')[i].value;
	}
	
	var obj = new Object();
	obj.startDate = $('#startDate').jqxDateTimeInput('val');
	obj.endDate = $('#endDate').jqxDateTimeInput('val');
	obj.eventName = $('#eventName').jqxDropDownList('getSelectedItem').value;
	obj.ch = chList;
	obj.type = $('#type').jqxDropDownList('getSelectedItem').value;
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		   
	    success: function(data) {
	    	if (data.length > 0) {
	    		var format = "DD MMM";
	    		if ($('#type').jqxDropDownList('getSelectedItem').value == 'time') {
	    			format = "#";
	    		}
	    		
	    		showData(format, data);
	    	}
	    },
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(jsonUrl);
		}
	});
}
function getDate() {
	if (get('reportingStartDate') != null) {
		$('#startDate').jqxDateTimeInput('setDate', new Date(get('reportingStartDate').split('-')[0], get('reportingStartDate').split('-')[1] - 1, get('reportingStartDate').split('-')[2]));
	} else {
		getStartFormatDate(new Date());
	}

	if (get('reportingEndDate') != null) {
		$('#endDate').jqxDateTimeInput('setDate', new Date(get('reportingEndDate').split('-')[0], get('reportingEndDate').split('-')[1] - 1, get('reportingEndDate').split('-')[2]));
	}
}
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
function showData(format, data) {
	var ch = 0;
	var title = "";
	var margin = 60;
	var end;
	if ($('#type').jqxDropDownList('getSelectedItem').value == 'time') {
		end = 24;
	} else {
		end = 7;
	}
	
	for (var j = 0; j < data.length; j++) {
		var lt = 0;
		var len = data[j].length;
		var arr = new Array();
		if (len >= end) {
			for (var i = 0; i < len; i++) {
				if ($('#type').jqxDropDownList('getSelectedItem').value == 'time') {
					arr.push(new TimePoint(data[j][i]));
				} else {
					arr.push(new DayPoint(data[j][i]));
				}
			}
		} else {
			if ($('#type').jqxDropDownList('getSelectedItem').value == 'time') {
				var rt = 0;
				var event = data[j][0].event;
				while (lt < end) {
					var tmpObj = new Object();
					if (data[j][rt] == null || lt != Number(data[j][rt].time)) {
						tmpObj.event = event.split("_")[0] + "_" + 0;
						tmpObj.time = lt;
						arr.push(new TimePoint(tmpObj));
					} else {
						event = data[j][rt].event;
						tmpObj.event = event;
						tmpObj.time = lt;
						arr.push(new TimePoint(tmpObj));
						rt++;
					}
					lt++;
				}
			} else {
				var tmpDate;
				var event;
				for (var i = 0; i < end; i++) {
					if (data[j][i] == null) {
						tmpDate.setDate(tmpDate.getDate() + 1);
						var tmpObj = new Object();
						tmpObj.event = event.split("_") + "_" + 0;
						tmpObj.time = tmpDate.getFullYear() + "-" + (tmpDate.getMonth() + 1) + "-" + tmpDate.getDate();						
						arr.push(new DayPoint(tmpObj));
					} else {
						event = data[j][i].event;
						tmpDate = new Date(data[j][i].time.split("-")[0], Number(data[j][i].time.split("-")[1]) - 1, data[j][i].time.split("-")[2]);
						arr.push(new DayPoint(data[j][i]));
					}
				}
			}
		}
		init(data[j][0].title, arr, margin, format);
		margin += 460;
	}
	
	/* for (var i = 0; i < len; i++) {
		if (data[i] != null) {
			if (ch != data[i].ch) {
				var chartData = init(ch, title, arr, margin, format, data[i].ch, data[i].title);
				ch = chartData.ch;
				title = chartData.title;
				arr = chartData.arr;
				margin = chartData.margin;
			}
			if ($('#type').jqxDropDownList('getSelectedItem').value == 'time') {
				arr.push(new TimePoint(data[i]));
			} else {
				arr.push(new DayPoint(data[i]));
			}
		}
	}
	if (arr.length > 0) {
		init(ch, title, arr, margin, format, null, null);
	} */
}
function createChart(title, format, arr) {
	var chart = new CanvasJS.Chart(title, {
		animationEnabled: true,
		backgroundColor: "#2a2a2c",
		title:{
		    fontColor: "#fff",
			text: title
		},
		toolTip: {
			fontColor: "white",
			backgroundColor: "#2a2a2c",
	        borderColor: "transparent"   //change color 
		},
		axisX:{
	        labelFontColor:"#fff",
			valueFormatString: format/* ,
	        intervalType: "time" */
		},
		axisY: {
			titleFontColor: "#fff",
	        labelFontColor:"#fff",
			title: getTranslate("count"),
			includeZero: true
		}, 
		legend:{
		    //fontColor: "#fff",
			cursor:"pointer",
			verticalAlign: "bottom",
			horizontalAlign: "left",
			dockInsidePlotArea: true
		},
		data: [{
			type: "column",
			xValueFormatString: format,
			dataPoints: arr
		}]
	});
	chart.render();
}
function initMenu() {
	getDate();
	
	if ($('#ch').jqxDropDownList('getItems') != null) {
		if (get('reportingCh') != null) {
			var chList = get('reportingCh').split(',');
			for (var i = 0; i < chList.length; i++) {
				$("#ch").jqxDropDownList('checkItem', chList[i]);
			}
		} else {
			$("#ch").jqxDropDownList('checkIndex', 0);
			setReportingCh($('#ch').jqxDropDownList('getCheckedItems')[0].value);
		}
	}
	
	if ($('#eventName').jqxDropDownList('getItems') != null) {
		if (get('reportingEventName') != null) {
			$('#eventName').jqxDropDownList('selectItem', get('reportingEventName'));
		} else {
			$("#eventName").jqxDropDownList('selectIndex', 0);
		}
		setReportingEventName($('#eventName').jqxDropDownList('getSelectedItem').value);
	}
	
	if (get('reportingType') != null) {
		$("#type").jqxDropDownList('selectItem', get('reportingType'));
	} else {
		$("#type").jqxDropDownList('selectItem', 'day');
		setReportingType('day');
	}
}
function init(title, arr, margin, format) {
	var div = document.createElement("div");
	div.className = 'graph';
	div.id = title;
	div.style.position = 'absolute';
	div.style.marginTop = margin + 'px';
	document.getElementById('bottom').appendChild(div);
	createChart(title, format, arr);
}
class DayPoint {
	constructor(data) {
		this.x = new Date(data.time.split("-")[0], Number(data.time.split("-")[1]) - 1, data.time.split("-")[2]);
		this.y = Number(data.event.split("_")[1]); 
		//this.indexLabelFontColor = "white";
		//this.indexLabelBackgroundColor = "#2a2a2c";
	}
}
class TimePoint {
	constructor(data) {
		this.x = Number(data.time);
		this.y = Number(data.event.split("_")[1]); 
	}
}
class ChartData {
	constructor(ch, title, arr, margin) {
		this.ch = ch;
		this.title = title;
		this.arr = arr;
		this.margin = margin;
	}	
}
class EventName {
	constructor(text, value) {
		this.text = text;
		this.value = value;
	}
}
class SettingData {
	constructor() {
	}
	
	setChartData(chartData) {
		this.chartData = chartData;
	}
	
	setData(data) {
		if (typeof data == 'TimePoint') {
			this.timePoint = data;
		} else {
			this.dayPoint = data;
		}
	}
}
</script>
<body>
	<div id="body">
		<div id="top">
			<div id="startDate" class="calendar"></div>
			<span id="tilde"> ~ </span> 
			<div id="endDate" class="calendar"></div>
			<div id="ch"></div>
			<div id="eventName"></div>
			<div id="type"></div>
			<div id="submit">
				<button onclick="getData();">검색</button>
			</div>
		</div>
		<div id="bottom"></div>
	</div>
</body>
</html>