<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" /> -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"> -->
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.arctic.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<link rel="stylesheet" href="./resources/css/bootstrap4-alpha3.min.css" />
<link rel="stylesheet" href="./resources/css/bootstrap-slider.css" />
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxcore.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdata.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxbuttons.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxscrollbar.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxmenu.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxlistbox.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdropdownlist.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxcombobox.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdatetimeinput.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxcalendar.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.selection.js"></script> 
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.columnsresize.js"></script> 
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.pager.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.sort.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.filter.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.edit.js"></script>
<script type="text/javascript" src="/resources/js/jqwidgets/jqxgrid.export.js"></script>
<script src="./resources/js/canvas/canvasjs.min.js"></script>
<script src="./resources/js/tether.min.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxcheckbox.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxlistbox.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxtree.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdropdownbutton.js"></script>
<script src="./resources/js/bootstrap-slider.js"></script>
<script type="text/javascript" src="/resources/js/translate.js"></script>
<style>
/* button {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight:bold;
	color:white;
} */
body {
	background-color: #252525;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight:bold;
	color:white;
	line-height: 1.5;
}
button:focus {
	outline:none;
}
input:focus {
	outline:none;
}
.loading {
	display:none;
}
.divBody {
	width:1400px;
	padding:0;
	margin:0;
	padding-left:100px;
	padding-bottom:100px;
	margin:auto;
	/* padding-right:40px; */
}

.btnDiv {
	margin:auto;
	margin-top:30px;
	width:1400px;
	padding-top:20px;
	padding-bottom:20px;
    text-align: -webkit-right;
}
.button_check {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
	margin-right:20px;
}
.check {
	width:12px;
	height:14px;
	font-size:14px;
	font-weight:bold;
	margin-right:8px;
}
.button_check:hover {
	color:#1c97ea;
}
.check:active {
	box-shadow: 0 #666;
}
.closeBtn {
	width:100px;
	height:30px;
	border-radius:3px;
	color:#fff;
	font-size:14px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	background-color:#3e3e42;
	outline:0;
}
.closeBtn:hover {
	color:#1c97ea;
}
.closeBtn:active {
	box-shadow: 0 #666;
}
.button_modify {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
	margin-right:20px;
}
.modify {
	width:12px;
	height:14px;
	font-size:14px;
	font-weight:bold;
	margin-right:8px;
}
.button_modify:hover {
	color:#1c97ea;
}
.modify:active {
	box-shadow: 0 #666;
}
.detailed_setting {
	width:700px;
	float:left;
	padding-top:30px;
	padding-left:15px;
	padding-right:15px;
	display:none;
}
.detailed_title {
	border:none;
}
.detailed_title_h4 {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.detailed_content {
	border:1px solid #35353A;
	padding-top:20px;
}
.detailed_content_count {
	width:650px;
	padding-right:15px;
	padding-left:15px;
	padding-bottom:40px;
}
.detailed_content_count_title {
	width:180px;
	height:30px;
	float:left;
	padding-top:6px;
}
.detailed_content_count_content {
	width:440px;
	float:left;
	height:30px;
}
.detailed_content_count_content_text {
	width:260px;
	height:30px;
	padding:0 0 0 4px;
	background-color:#3E3E42;
	border:none;
	outline:0;
	color:#fff;
}
.detailed_content_accuracy {
	width:650px;
	padding-right:15px;
	padding-left:15px;
	padding-bottom:40px;
}
.detailed_content_accuracy_title {
	width:180px;
	height:30px;
	float:left;
	padding-top:6px;
}
.detailed_content_accuracy_content {
	width:440px;
	height:30px;
	padding-top:7px;
	float:left;
}
.slider-handle {
	background: #3E3E42;
}
.slider.slider-horizontal {
	width:260px;
}
#ex6SliderVal {
	margin-left:15px;
}
#ex6Slider .slider-selection {
	background: #3e3e42;
}

/* The Modal (background) */
.modal {
	display:block;
	position: fixed; /* Stay in place */
	z-index: 100; /* Sit on top */ 
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0,0,0); /* Fallback color */
	background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}
.modal_hide {
	display: none; /* Hidden by default */
}
/* Modal Content */
.modal-content {
  background-color: #252525;
  margin: auto;
  padding: 20px;
  border: none;
  width: 1300px;
  display:block;
  /* flex-direction:inherit; */
}
.chkbox {
	margin-top:0px;
}
.modify_setting {
}
.modify_setting_hide {
	display:none;
}
.div_hr {
	width:1400px;
	height:5px;
	padding-top:10px;
	padding-bottom:10px;
}
.hr_hr {
	width:1400px;
	border:1px solid #35353A;
}
/* .jqx-widget-metrodark .jqx-grid-cell-selected-metrodark {
	background-color:#2A2A2C; 
	border-color: #35353A;
}
.jqx-widget-metrodark .jqx-grid-cell-selected-metrodark:hover {
	background-color:#1c97ea; 
	border-color:#1c97ea;
} */
.jqx-fill-state-normal-metrodark {
	/* background-color: transparent;
	border:1px solid #252525; */
}
.jqx-widget-content-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.jqx-fill-state-hover-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.jqx-rc-all {
	/* background:#252525;
	border:1px solid #252525; */
}
.jqxgrid-center-jin {
	margin:auto;
	padding-top:7px;
}
.jqx-grid-metrodark .jqx-widget-header-metrodark, .jqx-grid-column-header-metrodark, .jqx-grid-cell-metrodark, .jqx-widget-metrodark .jqx-grid-cell-metrodark, .jqx-fill-state-normal-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.jqx-fill-state-normal-metrodark {
	/* background-color:transparent; */
	border-color:#35353A;
}
.jqx-fill-state-hover-metrodark, .jqx-fill-state-pressed-metrodark, .jqx-widget-content-metrodark {
	border-color:#35353A;
}
.off-disabled {
	opacity:0.5;
}
.off-disabled:hover {
	background-color:#2A2A2C;
	border-color:#2A2A2C;
}
.on-abled:hover {
	background-color:#007ACC;
	border-color:#007ACC;
}
.jqx-widget-metrodark .jqx-grid-cell-selected-metrodark, .jqx-grid-cell-selected-metrodark {
	background-color:transparent;
	border-color:transparent;
}
</style>
<script>
function get(key) {
	return sessionStorage.getItem(key);
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

var categorySource = new Array();

categorySource.push({value: "KWATER_Falldown_Detection", label: "쓰러짐"});
categorySource.push({value: "KWATER_Fire_Detection", label: "화재"});
categorySource.push({value: "KWATER_Flood_Detection", label: "침수"});
categorySource.push({value: "KWATER_Glove_Detection", label: "장갑미착용"});
categorySource.push({value: "KWATER_Invasion_Detection", label: "침입"});
categorySource.push({value: "KWATER_Leak_Detection", label: "누수"});
categorySource.push({value: "KWATER_Loitering_Detection", label: "배회"});
categorySource.push({value: "KWATER_HandAction_Detection", label: "수신호"});
categorySource.push({value: "KWATER_Spin_Detection", label: "약품미투입"});

var categorySourceAdapter = new $.jqx.dataAdapter(categorySource);

var POPUP_MORE = 0;
var popup_window = new Array();
$(document).ready(function () {
	if (window.parent.userId == null) {
		location.replace('/index');
	}
	if (typeof window.parent.loginUser != 'function') {
		location.replace('/index/eventSetup');
	}
	var jsonUrl = "/eventSetup";
	
	var obj = new Object();
	
	var jsonData = JSON.stringify(obj);
	var actionArr = new Array();
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",   
		async:false,
		data : jsonData,          		   
	    success: function(data) {
	    	var realData = new Array();
	    	for (var i = 0; i < data.length; i++) {

	    		if (data[i] != null) {
	    			data[i].isExist = true;
	    			realData.push(data[i]);
	    		} else {
	    			var realObj = new Object();
	    			realObj.action_fire = 0;
	    			realObj.action_falldown = 0;
	    			realObj.actopm_flood = 0;
	    			realObj.action_glove = 0;
	    			realObj.action_invasion = 0;
	    			realObj.actopm_leak = 0;
	    			realObj.action_loitering = 0;
	    			realObj.action_handaction = 0;
	    			realObj.action_spin = 0;
	    			
	    			realObj.dev_ch = i + 1;
	    			
	    			var dev_title = 'ch' + (i + 1);
	    			if (i + 1 < 10) {
	    				dev_title = 'ch0' + (i + 1);
	    			}
	    			
	    			realObj.dev_title = dev_title;
	    			realObj.isExist = false;
	    			
	    			realData.push(realObj);
	    		}
	    	}
    		
    		var cellbeginedit = function (row, datafield, columntype, value) {
    			if (!realData[row].isExist) {
    				return false;	
    			}
    		}
    		
    		var cellsrenderer = function (row, column, value, defaultHtml) {
                if (!realData[row].isExist) {
                    var element = $(defaultHtml);
                    element.css('color', '#999');
                    return element[0].outerHTML;
                }
                return defaultHtml;
            }

			var dataArray = [
				{ value: '0', label: getTranslate('on')},
				{ value: '1', label: getTranslate('off')}
			]

			var dataSource =
            {
                 datatype: "array",
                 datafields: [
                     { name: 'label', type: 'string' },
                     { name: 'value', type: 'string' }
                 ],
                 localdata: dataArray
            };

			var dataSourceAdapter = new $.jqx.dataAdapter(dataSource, {
				autoBind: true
			});
			
			var source = {
				dataType : "json",
				localdata: realData,
				datafields: [
		        	/* { name: 'action_idx', type: 'string'}, */
		        	{ name: 'action_fire', type: 'string', values: {source: dataSourceAdapter.records, value: 'value', name: 'label' }},
		        	{ name: 'action_falldown', type: 'string', values: {source: dataSourceAdapter.records, value: 'value', name: 'label' }},
		        	{ name: 'actopm_flood', type: 'string', values: {source: dataSourceAdapter.records, value: 'value', name: 'label' }},
		        	{ name: 'action_glove', type: 'string', values: {source: dataSourceAdapter.records, value: 'value', name: 'label' }},
		        	{ name: 'action_invasion', type: 'string', values: {source: dataSourceAdapter.records, value: 'value', name: 'label' }},
		        	{ name: 'actopm_leak', type: 'string', values: {source: dataSourceAdapter.records, value: 'value', name: 'label' }},
		        	{ name: 'action_loitering', type: 'string', values: {source: dataSourceAdapter.records, value: 'value', name: 'label' }},
		        	{ name: 'action_handaction', type: 'string', values: {source: dataSourceAdapter.records, value: 'value', name: 'label' }},
		        	{ name: 'action_spin', type: 'string', values: {source: dataSourceAdapter.records, value: 'value', name: 'label' }},
		        	{ name: 'action_time', type: 'string'},
		        	{ name: 'dev_ch', type: 'string'},
		        	{ name: 'dev_title', type: 'string'},
		        	{ name: 'isExist', type: 'string'}
				]
			};

            var cellclass = function (row, columnfield, value) {
            	if (value == getTranslate('off')) {
            		return 'off-disabled';
            	} else {
            		return 'on-abled';
            	}
            }
            
			var dataAdapter = new $.jqx.dataAdapter(source);
			
			$("#content").jqxGrid({
                width: 1400,
                source: dataAdapter,
                selectionmode: 'singlecell',
				theme: 'metrodark',
                autoheight: true,
                editable: false,
				scrollbarsize: 20,
                columns: [
                	{ text: 'isExist', datafield: 'isExist', width: '10%', editable: false, hidden:true },
                	{ text: getTranslate('device_channel'), datafield: 'dev_ch', width: '7%', editable: false },
                	{ text: getTranslate('device_title'), datafield: 'dev_title', width: '12%', editable: false },
                    {
                        text: getTranslate('fire'), datafield: 'action_fire', width: '9%', cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, cellclassname: cellclass
                    },
                    {
                        text: getTranslate('falldown'), datafield: 'action_falldown', width: '9%', cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, cellclassname: cellclass
                    },
                    {
                        text: getTranslate('flood'), datafield: 'actopm_flood', width: '9%', cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, cellclassname: cellclass
                    },
                    {
                        text: getTranslate('glove'), datafield: 'action_glove', width: '9%', cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, cellclassname: cellclass
                    },
                    {
                        text: getTranslate('invasion'), datafield: 'action_invasion', width: '9%', cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, cellclassname: cellclass
                    },
                    {
                        text: getTranslate('leak'), datafield: 'actopm_leak', width: '9%', cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, cellclassname: cellclass
                    },
                    {
                        text: getTranslate('loitering'), datafield: 'action_loitering', width: '9%', cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, cellclassname: cellclass
                    },
                    {
                        text: getTranslate('handaction'), datafield: 'action_handaction', width: '9%', cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, cellclassname: cellclass
                    },
                    {
                        text: getTranslate('spin'), datafield: 'action_spin', width: '9%', cellbeginedit: cellbeginedit, cellsrenderer: cellsrenderer, cellclassname: cellclass
                    }
                ]
			});
	    },
		error: function(errorThrown) {
			//alert(errorThrown.statusText);
			//alert(jsonUrl);
		}
	});

	 $('#content').on('celldoubleclick', function (event) {
		// event arguments.
		var args = event.args;
		// row's bound index.
		var rowBoundIndex = args.rowindex;
		// column data field.
		var dataField = args.datafield;
		// cell value
		var value = args.value;
		
		var data = $('#content').jqxGrid('getrowdata', rowBoundIndex);
		
		if (dataField != 'dev_ch' && dataField != 'dev_title' && data.isExist) {
			if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed)
				popup_window[POPUP_MORE].close();

			var dev_ch = data.dev_ch;
			var model_name = dataField.split("_")[1];
			var dev_title = data.dev_title;
			
			if (value == getTranslate('on')) {
				value = 0;
			} else {
				value = 1;
			}
			
			popup_window[POPUP_MORE] = openWindow('./eventSetupInfo.htm?dev_ch=' + dev_ch + "&model_name=" + model_name + "&opt=" + value, 'eventActionSetup', 1400, 880);
		}
	 });
	 
	$('#Progress_Loading').hide();
	$('.loading').attr('class','divBody');
});
function openWindow(page, pageName, width, height) {
	var popupX = (screen.availWidth - width) / 2;
	var popupY = (screen.availHeight - height) / 2;
	var scrollbars = (pageName == 'webNoticeAdd' || pageName == 'webNoticeModify') ? 'yes' : 'no';

	var popup_window = window.open(page, pageName, 'width=' + width + ', height=' + height + ', toolbar=no, location=no, status=no, menubar=no, scrollbars=' + scrollbars + ', resizable=yes, left=' + popupX + ', top=' + popupY);

	return popup_window;
}
</script>
</head>
<body>
	<div id="Progress_Loading" align="center" > <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" width="30%" style="margin-top:70px;"/>
	</div>
	<div class="loading">
	<div style="margin:auto; margin-top:80px; width:1400px; /* height:544px; */ border:1px solid #35353A;">
		<div id="content">	<!--  style="width:1400px; overflow:auto; height:520px;" -->
		</div>
	</div>
	</div>
</body>
</html>