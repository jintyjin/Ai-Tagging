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
#startDate, #top span, #endDate, #submit {
	float:right;
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
var eventNameSource = [{
	text : getTranslate('falldown'),
	value : "falldown"
}, {
 	text : getTranslate('fire'),
	value : "fire"
}, {
 	text : getTranslate('flood'),
	value : "flood" 
}, {
	text : getTranslate('glove'),
	value : "glove"
}, {
 	text : getTranslate('invasion'),
	value : "invasion"
}, {
 	text : getTranslate('leak'),
	value : "leak" 
}, {
	text : getTranslate('loitering'),
	value : "loitering"
}, {
 	text : getTranslate('handaction'),
	value : "handaction"
}, {
	text : getTranslate('spin'),
	value : "spin"
},{	
	text : getTranslate('cmtank'),
	value : "cmtank"
}, {
 	text : getTranslate('outtank'),
	value : "outtank"
}, {
 	text : getTranslate('overflow'),
	value : "overflow" 
}]; 
var typeSource = [{
	text : 'time',
	value : 'time'
}, {
 	text : 'day',
	value : 'day'
}];
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
	    	if (data.length > 0) {
	    		chSource = data;
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
	
	getStartFormatDate(new Date());
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
	    	console.log(data);
	    	if (data.length > 0) {
	    		var format = "DD MMM";
	    		if ($('#type').jqxDropDownList('getSelectedItem').value == 'time') {
	    			format = "H";
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
	var chart;
	var margin = 60;
	for (var obj in data) {
		if (ch != data[obj].ch) {
			ch = data[obj].ch;
			var div = document.createElement("div");
			var title = data[obj].title;
			div.className = 'graph';
			div.id = title;
			div.style.position = 'absolute';
			div.style.marginTop = margin + 'px';
			margin += 460;
			document.getElementById('bottom').appendChild(div);
			chart = createChart(data[obj].title, format);
			chart.render();
		}
		
		if (false) {
			var timePoint = new TimePoint(data[obj]);
			chart.data[0].addTo("dataPoints", timePoint);
			//chart.data[0].addTo("dataPoints", {x : new Date(data[obj].time.split("-")[0], data[obj].time.split("-")[1], data[obj].time.split("-")[2]), y : data[obj].event.split("_")[1]});
		} else {
			var dayPoint = new DayPoint(data[obj]); 
			chart.data[0].addTo("dataPoints", dayPoint);
			console.log(chart.data[0]);
			//chart.data[0].addTo("dataPoints", {x : new Date(data[obj].time.split("-")[0], data[obj].time.split("-")[1], data[obj].time.split("-")[2]), y : Number(data[obj].event.split("_")[1])});
		}
	}
}
function createChart(title, format) {
	var chart = new CanvasJS.Chart(title, {
		animationEnabled: true,
		theme: "light2",
		title:{
			text: title
		},
		axisX:{
			valueFormatString: "DD MMM"
		},
		axisY: {
			title: "Count",
			includeZero: true,
			crosshair: {
				enabled: true
			}
		}, 
		legend:{
			cursor:"pointer",
			verticalAlign: "bottom",
			horizontalAlign: "left",
			dockInsidePlotArea: true
		},
		data: [{
			type: "line",
			xValueFormatString: "DD MMM, YYYY",
			color: "#F08080",
			dataPoints: [
			]
		}]
	});
    
	return chart;
}
class DayPoint {
	constructor(data) {
		this.x = new Date(data.time.split("-")[0], data.time.split("-")[1], data.time.split("-")[2]);
		this.y = Number(data.event.split("_")[1]); 
	}
}
class TimePoint {
	constructor(data) {
		this.x = new Date(data.time.split("-")[0], data.time.split("-")[1], data.time.split("-")[2], data.time.split(" ")[1]);
		this.y = Number(data.event.split("_")[1]); 
	}
}
</script>
<body>
	<div id="body">
		<div id="top">
			<div id="ch"></div>
			<div id="eventName"></div>
			<div id="type"></div>
			<div id="submit">
				<button onclick="getData();">검색</button>
			</div>
			<div id="endDate" class="calendar"></div>
			<span id="tilde"> ~ </span> 
			<div id="startDate" class="calendar"></div>
		</div>
		<div id="bottom"></div>
	</div>
</body>
</html>