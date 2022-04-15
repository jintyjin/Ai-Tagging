<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
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
.tag_setting {
	width:700px;
	float:left;
	margin-top:30px;
	/* padding-left:15px; */
	padding-right:15px;
}
.tag_setting_hide {
	display:none;
}
.tag_title {
	border:none;
}
.tag_title_h4 {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.tag_content {
	border:1px solid #35353A;
	padding-top:20px;
}
.tag_content_tag {
	width:650px;
	padding-right:15px;
	padding-left:15px;
	padding-bottom:40px;
}
.tag_content_tag_title {
	width:180px;
	height:30px;
	float:left;
	padding-top:6px;
}
.tag_content_tag_content {
	width:450px;
	float:left;
}
.tag_content_device {
	width:650px;
	padding-right:15px;
	padding-left:15px;
	padding-bottom:40px;
	margin-bottom:10px;
}
.tag_content_device_title {
	width:180px;
	height:30px;
	float:left;
	padding-top:6px;
}
.tag_content_device_content {
	width:450px;
	float:left;
}
.tag_content_device_content_2 {
	width:450px;
	float:left;
}
.tag_content_channel {
	width:650px;
	padding-right:15px;
	padding-left:15px;
	display:flex;
	margin-bottom:10px;
}
.tag_content_channel_title {
	width:180px;
	height:30px;
	float:left;
	padding-top:6px;
}
.tag_content_channel_content {
	width:450px;
}
.action_setting {
	width:550px;
	float:left;
	padding-left:15px;
	/* padding-right:15px; */
	margin-top:30px;
}
.action_setting_hide {
	display:none;
}
.action_title {
	border:none;
}
.action_title_h4 {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.action_content {
	border:1px solid #35353A;
	padding-top:20px;
}
.action_content_action {
	width:460px;
	padding-right:15px;
	padding-left:15px;
	padding-bottom:40px;
}
.action_content_action_title {
	width:130px;
	height:30px;
	float:left;
	padding-top:6px;
}
.action_content_action_content, .action_content_action_content_2 {
	width:510px;
	float:left;
}
.action_content_manager, .action_content_manager_2 {
	width:460px;
	padding-right:15px;
	padding-left:15px;
	padding-bottom:40px;
	display:none;
}
.action_content_manager_title {
	width:130px;
	height:30px;
	float:left;
	padding-top:9px;
	padding-top:6px;
}
.action_content_manager_content, .action_content_manager_content_2 {
	width:310px;
	float:left;
}

.action_content_network, .action_content_network_2 {
	width:460px;
	padding-right:15px;
	padding-left:15px;
	padding-bottom:40px;
	display:none;
}
.action_content_network_title {
	width:130px;
	height:30px;
	float:left;
	padding-top:9px;
	padding-top:6px;
}
.action_content_network_content, .action_content_network_content_2 {
	width:310px;
	float:left;
}

.action_content_scada, .action_content_scada_2 {
	width:460px;
	padding-right:15px;
	padding-left:15px;
	padding-bottom:40px;
	display:none;
}
.action_content_scada_title {
	width:130px;
	height:30px;
	float:left;
	padding-top:9px;
	padding-top:6px;
}
.action_content_scada_content, .action_content_scada_content_2 {
	width:260px;
	height:30px;
	float:left;
	border:1px solid #35353A;
	background-color:#3E3E42;
	padding-left:4px;
	line-height:17px;
}
.btnDiv {
    width:1250px;
    padding-left:15px;
    padding-right:15px;
    padding-top:20px;
    padding-bottom:20px;
    display:inline-flex;
    justify-content:center;
    align-items:center;
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
.button_delete {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.delete {
	width:12px;
	height:14px;
	font-size:14px;
	font-weight:bold;
	margin-right:8px;
}
.button_delete:hover {
	color:#1c97ea;
}
.delete:active {
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
	width:1250px;
	height:5px;
	padding-top:10px;
	padding-bottom:10px;
}
.hr_hr {
	width:1250px;
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

</style>
<script>
function get(key) {
	return sessionStorage.getItem(key);
}
$(document).ready(function(){
	$('.Progress_Loading').show();
})
var categorySource = [{
		text : getTranslate('falldown'),
		value : "KWATER_Falldown_Detection"
	}, {
	 	text : getTranslate('fire'),
		value : "KWATER_Fire_Detection"
	}, {
	 	text : getTranslate('flood'),
		value : "KWATER_Flood_Detection" 
	}, {
		text : getTranslate('glove'),
		value : "KWATER_Glove_Detection"
	}, {
	 	text : getTranslate('invasion'),
		value : "KWATER_Invasion_Detection"
	}, {
	 	text : getTranslate('leak'),
		value : "KWATER_Leak_Detection" 
	}, {
		text : getTranslate('loitering'),
		value : "KWATER_Loitering_Detection"
	}, {
	 	text : getTranslate('handaction'),
		value : "KWATER_HandAction_Detection"
	}, {
		text : getTranslate('spin'),
		value : "KWATER_Spin_Detection"
}]; 
var categorySource1 = [{	
		text : getTranslate('cmtank'),
		value : "KWATER_Cmtank_Leak"
	}, {
	 	text : getTranslate('outtank'),
		value : "KWATER_Outtank_Leak"
	}, {
	 	text : getTranslate('overflow'),
		value : "KWATER_Overflow" 
}];

$(document).ready(function () {
	if (window.parent.userId == null) {
		location.replace('/index');
	}
	if (typeof window.parent.loginUser != 'function') {
		location.replace('/index/eventActionList');
	}
	
	<%
		List<Map> itemDto = (List<Map>)request.getAttribute("itemDto");
		List<Map> actionInfo = (List<Map>)request.getAttribute("actionInfo");
	%>
	
	<%
		for (Map item : itemDto) {
	%>
	
	<%	
		}
	%>
	
	var jsonUrl = "/selectEventAction";
	
	var obj = new Object();
	
	var jsonData = JSON.stringify(obj);
	var actionArr;
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",   
		async:false,
		data : jsonData,          		   
	    success: function(data) {
	    	//var categoryArr = data[0];
	    	var itemArr = data[0];
	    	actionArr = data[1];
   
    		$('.tag_content_tag_content').jqxDropDownList({checkboxes:true, source:categorySource, scrollBarSize:5, width: 260, height: 30, theme: 'metrodark', disabled: true, displayMember: 'text',  valueMember: 'value'});
    		$('.tag_content_tag_content_2').jqxDropDownList({checkboxes:true, source:categorySource, scrollBarSize:10, width: 260, height: 30, theme: 'metrodark', autoDropDownHeight: true, displayMember: 'text',  valueMember: 'value'});
    
    		$("#kwater_2").click(function(){
       			$('.tag_content_tag_content_2').jqxDropDownList({checkboxes:true, source:categorySource, scrollBarSize:10, width: 260, height: 30, theme: 'metrodark', autoDropDownHeight: true, displayMember: 'text',  valueMember: 'value'});
    		});	
    		
    		$("#scada_2").click(function(){			
    			$('.tag_content_tag_content_2').jqxDropDownList({checkboxes:true, source:categorySource1, scrollBarSize:10, width: 260, height: 30, theme: 'metrodark', autoDropDownHeight: true, displayMember: 'text',  valueMember: 'value'});  	 	
    		});

	    	var itemSource = [];
    		for (var i = 0; i < itemArr.length; i++) {
	    		itemSource.push(itemArr[i].dev_title);
    		}
    		
	    	$('.tag_content_device_content').jqxDropDownList({source:itemSource, width: 260, height: 30, theme: 'metrodark', scrollBarSize :5, disabled: true });
	    	$('.tag_content_device_content_2').jqxDropDownList({source:itemSource, width: 260, height: 30, theme: 'metrodark', scrollBarSize :10, dropDownHeight: 200 });
    		
	    	var actionSource = [];
	    	if (itemArr.length > 0) { 
	    		for (var i = 0; i < 1; i++) {
	    			actionSource.push(getTranslate('alarm'));
	    			actionSource.push(getTranslate('popUp'));
	    			actionSource.push(getTranslate('preset'));
	    			actionSource.push(getTranslate('sms'));
	    			actionSource.push(getTranslate('speaker'));
	    		}
	    	}

	    	$('.action_content_action_content').jqxDropDownList({checkboxes:true, source:actionSource, scrollBarSize:10, autoDropDownHeight: true, width: 260, height: 30, theme: 'metrodark'});
	    	$('.action_content_action_content_2').jqxDropDownList({checkboxes:true, source:actionSource, scrollBarSize:10, autoDropDownHeight: true, width: 260, height: 30, theme: 'metrodark'});
	    	
	    	var managerSource = [];
	    	
	    	$('.action_content_manager_content').jqxDropDownList({source:managerSource, scrollBarSize:5, dropDownHeight: 200, width: 260, height: 30, theme: 'metrodark'});
	    	$('.action_content_manager_content_2').jqxDropDownList({source:managerSource, scrollBarSize:10, dropDownHeight: 200, width: 260, height: 30, theme: 'metrodark'});

	    	var networkrSource = [];
	    	
	    	$('.action_content_network_content').jqxDropDownList({source:networkrSource, scrollBarSize:5, dropDownHeight: 200, width: 260, height: 30, theme: 'metrodark'});
	    	$('.action_content_network_content_2').jqxDropDownList({source:networkrSource, scrollBarSize:10, dropDownHeight: 200, width: 260, height: 30, theme: 'metrodark'});
	    	
			for (var i = 0; i < actionArr.length; i++) {
				actionArr[i].action = getTranslate(actionArr[i].action_event.toLowerCase());
				actionArr[i].action_source = getTranslate(actionArr[i].action_source);
				
				if (actionArr[i].action_action.indexOf(', ') != -1) {
					var action = '';
					var actionList = actionArr[i].action_action.split(', ');
					for (var j = 0; j < actionList.length; j++) {
						if (j == 0) {
							if (actionList[j].indexOf('(') != -1) {
								action = getTranslate(actionList[j].substring(0, 3));
							} else {
								action = getTranslate(actionList[j]);
							}
						} else {
							if (actionList[j].indexOf('(') != -1) {
								action += ', ' + getTranslate(actionList[j].substring(0, 3));
							} else {
								action += ', ' + getTranslate(actionList[j]);
							}
						}
					}
					actionArr[i].action_action = action;
				} else {
					if (actionArr[i].action_action.indexOf('(') != -1) {
						actionArr[i].action_action = getTranslate(actionArr[i].action_action.substring(0, 3));
					} else {
						actionArr[i].action_action = getTranslate(actionArr[i].action_action);
					}
				}
			}	    	
			
			var source = {
				dataType : "json",
				localdata: actionArr,
				datafields: [
		        	{ name: 'action_idx', type: 'String'},
		        	{ name: 'action_ip', type: 'string'},
		        	{ name: 'action_event', type: 'string'},
		        	{ name: 'action_action', type: 'string'},
		        	{ name: 'action_isuse', type: 'string'},
		        	{ name: 'dev_title', type: 'string'},
		        	{ name: 'pre_title', type: 'string'},
		        	{ name: 'action_source', type: 'string'},
		        	{ name: 'action_key', type: 'string'},
		        	{ name: 'action', type: 'string'},
		        	{ name: 'scada_tag', type: 'string'},
		        	{ name: 'network_title', type: 'string'}
				]
			};
			var dataAdapter = new $.jqx.dataAdapter(source);
			
			
			$(".grid").jqxGrid({
				width: '1250px',
				source: dataAdapter,
				height: 510,
				theme: 'metrodark',
				selectionmode: 'singlerow',
				//showfilterrow: true,
                sortable: true,
                filterable: true,
                filtermode: 'excel',
                columnsresize: true,
                autoshowfiltericon: true,
				editable: true,
				ready: function () {  
                       var rows = $(".grid").jqxGrid('getrows');
                       
					for (var t = 0; t < rows.length; t++) {
						var value = $('.grid').jqxGrid('getcellvalue', t, "action_isuse");
						var action_idx = $('.grid').jqxGrid('getcellvalue', t, "action_idx");
						if (value == 'Y') {
                            var boundindex = $(".grid").jqxGrid('getrowboundindex', t);
                            $(".grid").jqxGrid('setcellvalue', boundindex, 'available', true);
                            
						}
						/* if (value == 'Y') {
							$('.grid').jqxGrid('selectrow', t);
						} */
					} 
				},
				columns: [
					{ text: getTranslate('idx'), datafield: 'action_idx', width: '4%', hidden:true},
					{ text: '', datafield: 'action_isuse', width: '4%', align: 'center', columntype: 'checkbox', hidden:true},
					/* { text: '활성', datafield: 'action_isuse', width: '4%', align: 'center', columntype: 'checkbox', type:'bool' }, */
					                {
                     text: '', menu: false, sortable: false,
                     datafield: 'available', columntype: 'checkbox', width: '3%', align: 'center', 
                     rendered: function (element) {
                         $(element).jqxCheckBox({ width:"25px", animationShowDelay: 0, animationHideDelay: 0 });
                         columnCheckBox = $(element);
                         $(element).addClass('total');
                         $(element).on('change', function (event) {
                             var checked = event.args.checked;
                           
                             var rows = $(".grid").jqxGrid('getrows');
                             
                             // update cells values.
                             for (var i = 0; i < rows.length; i++) {
                                 var boundindex = $(".grid").jqxGrid('getrowboundindex', i);
                                 $(".grid").jqxGrid('setcellvalue', boundindex, 'available', event.args.checked);
                             }

                     		var isuse = "N";
                     		
                     		if (event.args.checked) {		// 'Y'로 바꿔줘야 함
                     			isuse = "Y";
                     		}
                     	
                     		var data = $('.grid').jqxGrid('getrowdata', event.args.rowindex);
                     		
                     		var idx = data.action_idx;

                     		var jsonUrl = '/updateActionIsuseAll';
                     			
                     		obj = new Object();

                   			obj.login_id = window.parent.userId;
                   			obj.idx = data.action_key;
                     		obj.action_isuse = isuse;
                     		var jsonData = JSON.stringify(obj);
                     		$.ajax({
                     			type : "POST",                        	 	     
                     			url : jsonUrl,                      		
                     			dataType : "text",                        	  
                     			contentType : "application/json; charset=UTF-8",       
                     			data : jsonData,          		     		 
                     			success: function(data) {
                     				alert(getTranslate('completeModification'));
                     				for (var c = 0; c < actionArr.length; c++) {
                         				actionArr[c].action_isuse = isuse;      
                     				}
                     			},
                     			error: function(errorThrown) {
                     				alert(errorThrown.statusText);
                     				alert(JSON.stringify(data));             				
                     			}
                     		});
                     		
                             $(".grid").jqxGrid('endupdate');
                         });
                         return true;
                     }
                 },
					{ text: getTranslate('device_title'), datafield: 'dev_title', width: '17%', editable: false },
					{ text: getTranslate('event_source'), datafield: 'action_source', width: '15%'/* '216.41px' */, editable: false },
					{ text: getTranslate('event_name'), datafield: 'action_event', width: '25%', editable: false, hidden:true },
					{ text: getTranslate('event_name'), datafield: 'action', width: '25%', editable: false },
					{ text: getTranslate('device_ip'), datafield: 'action_ip', width: '20%', editable: false },
					{ text: getTranslate('action'), datafield: 'action_action', width: '20%'/* '216.41px' */, editable: false },
					{ text: getTranslate('preset'), datafield: 'pre_title', width: '30%'/* '216.41px' */, editable: false, hidden:true  },
					{ text: getTranslate('speaker'), datafield: 'network_title', width: '30%'/* '216.41px' */, editable: false, hidden:true  },
					{ text: getTranslate('sms'), datafield: 'scada_tag', width: '30%'/* '216.41px' */, editable: false, hidden:true  },
					{ text: getTranslate('key'), datafield: 'action_key', width: '30%'/* '216.41px' */, editable: false, hidden:true  }
				]
			});
	    },
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(jsonUrl);
		}
	});
	$('#Progress_Loading').hide();
	$('.loading').attr('class','divBody');
	
	$("#ex6").slider();
	$("#ex6").on("slide", function(slideEvt) {
		$("#ex6SliderVal").text(slideEvt.value);
	});
	$('.slider-handle').mouseup(function () {
		var convidenceValue = 0;
		if (($('.slider-selection').width() / $('.slider-track').width() * 100) - parseInt($('.slider-selection').width() / $('.slider-track').width() * 100) > 0.5) {
			confidenceValue = parseInt($('.slider-selection').width() / $('.slider-track').width() * 100) + 1;
		} else {
			confidenceValue = parseInt($('.slider-selection').width() / $('.slider-track').width() * 100);
		}
		$("#ex6SliderVal").text(confidenceValue);
	});
	$('.grid').on('cellclick', function (event) {
	     // event.args.rowindex is a bound index.
		$('.modify_setting_hide').attr('class','modify_setting');
		var data = $('.grid').jqxGrid('getrowdata', event.args.rowindex);

		var eventAction = new EventAction(data);
		
		//var actionList = data.action_action.split(', ');
		var actionList = eventAction.action_action;

		$(".tag_content_tag_content").jqxDropDownList('uncheckAll'); 
		$(".tag_content_device_content").jqxDropDownList('uncheckAll'); 
		$(".action_content_action_content").jqxDropDownList('uncheckAll'); 
		$(".action_content_manager_content").jqxDropDownList('uncheckAll'); 

		for (var i = 0; i < actionList.length; i++) {
			$(".action_content_action_content").jqxDropDownList('checkItem', actionList[i]);
		}

		if (actionList.includes(getTranslate('스피커'))) {
			selectNetworkSpeaker(eventAction.dev_title, ".action_content_network_content", eventAction.network_title);
		}
		
		$(".tag_content_device_content").jqxDropDownList('selectItem', eventAction.dev_title);
		
		$('.action_content_manager').show();

		if (actionList.includes(getTranslate('프리셋'))) {
			selectPreset250(eventAction.dev_title, ".action_content_manager_content", eventAction.pre_title);
			$('.action_content_manager').show();
		} else {
			$('.action_content_manager').hide();
		}

		if (actionList.includes(getTranslate('스피커'))) {
			$('.action_content_network').show();
		} else {
			$('.action_content_network').hide();
		}
		
		if (eventAction.action_source == 'SCADA') {
			$('#scada').prop('checked', true);
			$("input[name='source'][value='kwater']").attr('disabled', true);
			$("input[name='source'][value='SCADA']").attr('disabled', false);
			$('.tag_content_tag_content').jqxDropDownList({checkboxes:true, source:categorySource1, scrollBarSize:5, width: 260, height: 30, theme: 'metrodark', disabled: true, displayMember: 'text',  valueMember: 'value'});
			$(".tag_content_tag_content").jqxDropDownList('checkItem', data.action_event);
		} else {
			$('#kwater').prop('checked', true);
			$("input[name='source'][value='SCADA']").attr('disabled', true);
			$("input[name='source'][value='kwater']").attr('disabled', false);
			$('.tag_content_tag_content').jqxDropDownList({checkboxes:true, source:categorySource, scrollBarSize:5, width: 260, height: 30, theme: 'metrodark', disabled: true, displayMember: 'text',  valueMember: 'value'});
			$(".tag_content_tag_content").jqxDropDownList('checkItem', data.action_event);
		}
	});
	$(".grid").on('cellendedit', function (event) {
		var isuse = "N";
		var data = $('.grid').jqxGrid('getrowdata', event.args.rowindex);
		
		if (data.action_isuse == 'N') {		// 'Y'로 바꿔줘야 함
			isuse = "Y";
		}

		var jsonUrl = '/updateActionIsuse';
			
		obj = new Object();
		
		obj.action_key = data.action_key;
		obj.action_isuse = isuse;
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",       
			data : jsonData,          		     		 
			success: function(data) {
				$(".grid").jqxGrid('setcellvalue', event.args.rowindex, "action_isuse", isuse);
				alert(getTranslate('completeModification'));
			},
			error: function(errorThrown) {
				alert(errorThrown.statusText);
				alert(JSON.stringify(data));				
			}
		});
	});
	
	$('#modify').click(function () { 
		if (confirm(getTranslate('questionModification'))) {
			var selectedrowindex = $(".grid").jqxGrid('getselectedrowindex');
			if (selectedrowindex > -1) {
		        var rows = $(".grid").jqxGrid('getrowdata', selectedrowindex);
		        var action_key = rows.action_key;
		        var action_event = rows.action_event;
		        var dev_title = rows.dev_title;
		        
				var checkedactionArr = $('.action_content_action_content').jqxDropDownList('getCheckedItems');
				var chkActionArr = [];
				
				var isPreset = false; 
				var isNetwork = false; 
				for (var p = 0; p < checkedactionArr.length; p++) {
					if (checkedactionArr[p].label == getTranslate('preset')) {
						isPreset = true;
					} else if (checkedactionArr[p].label == getTranslate('sms')) {
						isScada = true;
					} else if (checkedactionArr[p].label == getTranslate('speaker')) {
						isNetwork = true;
					}
					chkActionArr.push(checkedactionArr[p].label);
				}

				var checkedtargetArr = $('.action_content_manager_content').jqxDropDownList('getSelectedItem');
				if (isPreset) {
					if (checkedtargetArr == null) {
						alert(getTranslate('setPreset'));
						return;				
					} else {
						checkedtargetArr = checkedtargetArr.label;
					}
				}

				var checkedNetworkArr = $('.action_content_network_content').jqxDropDownList('getSelectedItem');
				if (isNetwork) {
					if (checkedNetworkArr == null) {
						alert(getTranslate('setSpeaker'));
						return;				
					} else {
						checkedNetworkArr = checkedNetworkArr.label;
					}
				}
				obj = new Object();
	
				obj.action_key = action_key;
				obj.action_action = chkActionArr;
				obj.action_event = action_event;
				obj.dev_title = dev_title;
				
				obj.isPreset = isPreset;
				obj.pre_title = checkedtargetArr;
				
				obj.isNetwork = isNetwork;
				obj.network_title = checkedNetworkArr;
				
				var jsonData = JSON.stringify(obj);

		        var jsonUrl = '/updateActionInfo';

				$.ajax({
					type : "POST",                        	 	     
					url : jsonUrl,                      		
					dataType : "json",                        	  
					contentType : "application/json; charset=UTF-8",       
					data : jsonData,          		     		 
					success: function(data) {
						alert(getTranslate('completeModification'));
						location.reload();
					},
					error: function(errorThrown) {
						alert(errorThrown.statusText);
					}
				});

		        return;
			}
		}
	});
	
	$('.button_delete').click(function () {
		if (confirm(getTranslate('questionDelete'))) {
			var selectedrowindex = $(".grid").jqxGrid('getselectedrowindex');
			if (selectedrowindex > -1) {
		        var rows = $(".grid").jqxGrid('getrowdata', selectedrowindex);

				var obj = new Object();
				obj.action_key = rows.action_key;
				obj.dev_title = rows.dev_title;
				obj.action_event = rows.action_event;
				
				var jsonUrl = "/deleteActionInfo";
				var jsonData = JSON.stringify(obj);
				
				$.ajax({
					type : "POST",                        	 	     
					url : jsonUrl,                      		
					dataType : "json",                        	  
					contentType : "application/json; charset=UTF-8",       
					data : jsonData,          		     		 
					success: function(data) {
						alert(getTranslate('completeDelete'));
						location.reload();
					},
					error: function(errorThrown) {
						alert(errorThrown.statusText);
						alert(JSON.stringify(data));
					}
				}); 
			}
		}
	});
	// When the user clicks the button, open the modal 
	$('.button_check').click(function() {
		$('.modal_hide').attr('class','modal');
	});

	$('.closeBtn').click(function () {
		$('.modal').attr('class','modal_hide');
		//$('.action_content_scada_content_2').val('');
	});
	
	$('.checkBtn').click(function () {
		obj = new Object();
		obj.login_id = window.parent.userId;
		
		var checkedeventArr = [];
		
		var checkeddeviceArr = $('.tag_content_device_content_2').jqxDropDownList('getSelectedItem');
		if (checkeddeviceArr == null) {
			alert(getTranslate('setDeviceTitle'));
			return;
		} else {
			checkeddeviceArr = checkeddeviceArr.label;
		}
		
		var items = $('.tag_content_tag_content_2').jqxDropDownList('getCheckedItems');
		$.each(items, function (index) {
			checkedeventArr.push(this.value);
		});
		
		if (checkedeventArr.length == 0) {
			alert(getTranslate('setEvent'));
			return;
		}
			
		var checkedactionArr = $('.action_content_action_content_2').jqxDropDownList('getCheckedItems');
		
		if (checkedactionArr.length == 0) {
			alert(getTranslate('setEventAction'));
			return;
		}

		var isPreset = false; 
		var isScada = false;
		var isNetwork = false; 
		for (var p = 0; p < checkedactionArr.length; p++) {
			if (checkedactionArr[p].label == getTranslate('preset')) {
				isPreset = true;
			} else if (checkedactionArr[p].label == getTranslate('sms')) {
				isScada = true;
			} else if (checkedactionArr[p].label == getTranslate('speaker')) {
				isNetwork = true;
			}
		}

		var checkedtargetArr = $('.action_content_manager_content_2').jqxDropDownList('getSelectedItem');
		if (isPreset) {
			if (checkedtargetArr == null) {
				alert(getTranslate('setPreset'));
				return;				
			} else {
				checkedtargetArr = checkedtargetArr.label;
			}
		}

		var checkedNetworkArr = $('.action_content_network_content_2').jqxDropDownList('getSelectedItem');
		if (isNetwork) {
			if (checkedNetworkArr == null) {
				alert(getTranslate('setSpeaker'));
				return;				
			} else {
				checkedNetworkArr = checkedNetworkArr.label;
			}
		}
		var radio = $("input[name='source_2']:checked").val();

		if (radio == 'kwater_2') {
			radio = '지능형안전관리시스템';
		} else {
			radio = 'SCADA'
		}

		for (var li = 0; li < checkedeventArr.length; li++) {
			//console.log('이벤트 = ' + checkedeventArr[li]);
		}

		var chkActionArr = [];
		
		for (var il = 0; il < checkedactionArr.length; il++) {
			//console.log('동작 = ' + checkedactionArr[il].label);
			if (checkedactionArr[il].label.indexOf('(') != -1) {
				chkActionArr.push(getTranslate(checkedactionArr[il].label.substring(0, 3)));
			} else {
				chkActionArr.push(getTranslate(checkedactionArr[il].label));
			}
		}

		obj.dev_title = checkeddeviceArr;
		obj.action_source = radio;
		obj.action_event = checkedeventArr;
		obj.action_action = chkActionArr;
				
		obj.isPreset = isPreset;
		obj.pre_title = checkedtargetArr;
		
		obj.isNetwork = isNetwork;
		obj.network_title = checkedNetworkArr;
		obj.action_isuse = 'Y'
		
		var jsonData = JSON.stringify(obj);

		var jsonUrl = '/insertActionInfo';
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",       
			data : jsonData,          		     		 
			success: function(data) {
				alert(getTranslate('completeSave'));
				location.reload();
			},
			error: function(errorThrown) {
				alert(errorThrown.statusText);
				alert(JSON.stringify(jsonData));
			}
		}); 
	});
	
	$('.tag_content_device_content_2').on('select', function (event) {
		var args = event.args;
		if (args) {
			// index represents the item's index.                          
			var index = args.index;
			var item = args.item;
			// get item's label and value.
			var label = item.label;

			selectPreset250(label, ".action_content_manager_content_2", null);
			//selectNetworkSpeaker(label, ".action_content_network_content_2", null);
		}
	});

	$('.action_content_action_content_2').bind('checkChange', function (event) {
		var args = event.args;
		if (args) {
		    var item = args.item;
		    var label = item.label;
		    var checked = item.checked;
		    
		    if (label == getTranslate('preset')) {
		    	if (args.checked) {
		    		$('.action_content_manager_2').show();
		    	} else {
		    		$('.action_content_manager_2').hide();
		    	}
		    }

		    if (label == getTranslate('speaker')) {
		    	if (args.checked) {
		    		selectNetworkSpeaker(null, ".action_content_network_content_2", null);
		    		$('.action_content_network_2').show();
		    	} else {
		    		$('.action_content_network_2').hide();
		    	}
		    }
		    /* if (label == 'SMS(SCADA)') {
		    	if (args.checked) {
					$('.action_content_scada_2').show();
		    	} else {
					$('.action_content_scada_2').hide();
		    	}
		    } */
		}
	});
	$("input[name='source_2']").change(function () {
		/* if ($("input[name='source_2']:checked").val() == 'kwater_2') {
			$(".tag_content_tag_content_2").jqxDropDownList('clear');
			
			for (var i = 0; i < categorySource.length; i++) {
				$('.tag_content_tag_content_2').jqxDropDownList('addItem', categorySource[i]);
			}
		} else {
			$(".tag_content_tag_content_2").jqxDropDownList('clear');
			
			for (var i = 0; i < categorySource2.length; i++) {
				$('.tag_content_tag_content_2').jqxDropDownList('addItem', categorySource[i]);
				
			}
		} */
	});
	$('.action_content_action_content').bind('checkChange', function (event) {
		var args = event.args;
		if (args) {
		    var item = args.item;
		    var label = item.label;
		    var checked = item.checked;
		   
		    if (label == getTranslate('preset')) {
		    	if (args.checked) {
					selectPreset250($(".tag_content_device_content").jqxDropDownList('getSelectedItem').label, ".action_content_manager_content", null);
		    		$('.action_content_manager').show();
		    	} else {
		    		$('.action_content_manager').hide();
		    	}
		    }

		    if (label == getTranslate('speaker')) {
		    	if (args.checked) {
		    		selectNetworkSpeaker(null, ".action_content_network_content", null);
		    		$('.action_content_network').show();
		    	} else {
		    		$('.action_content_network').hide();
		    	}
		    }
		    /* if (label == 'SMS(SCADA)') {
		    	if (args.checked) {
					$('.action_content_scada_2').show();
		    	} else {
					$('.action_content_scada_2').hide();
		    	}
		    } */
		}
	});
});
function selectPreset250(label, content_class, preset) {
	console.log(label, content_class, preset);
	var jsonUrl = '/selectPreset250';
	
	var object = new Object;
	object.dev_title = label;
	
	var jsonData = JSON.stringify(object);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",       
		data : jsonData,          		     		 
		success: function(data) {
			$(content_class).remove();
			
			var parentClass = '.action_content_manager';
			
			if (content_class == '.action_content_manager_content_2') {
				parentClass += '_2';
			}
			
			$(parentClass).append('<div class="' + content_class.substring(1) + '"></div>');
			var managerSource = [];
			var idx = 0;

			for (var i = 0; i < data.length; i++) {
				managerSource.push(data[i].pre_title);
				if (preset != null && preset == data[i].pre_title) {
					console.log(preset != null && preset == data[i].pre_title);
					idx = i;
				}
			}

			$(content_class).jqxDropDownList({selectedIndex:idx, source:managerSource, scrollBarSize:5, dropDownHeight: 200, width: 260, height: 30, theme: 'metrodark'});
			
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
		}
	}); 
}
function selectNetworkSpeaker(label, content_class, preset) {
	var jsonUrl = '/networkSpeakerSetup';
	
	var object = new Object;
	
	var jsonData = JSON.stringify(object);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",       
		data : jsonData,          		     		 
		success: function(data) {
			$(content_class).remove();
			var parentClass = '.action_content_network';
			
			if (content_class == '.action_content_network_content_2') {
				parentClass += '_2';
			}
			
			$(parentClass).append('<div class="' + content_class.substring(1) + '"></div>');
			var managerSource = [];
			var idx = 0;

			console.log('preset = ' + preset);
			for (var i = 0; i < data.length; i++) {
				managerSource.push(data[i].network_title);
				if (preset != null && preset == data[i].network_title) {
					idx = i;
				}
			}
			
			$(content_class).jqxDropDownList({selectedIndex:idx, source:managerSource, scrollBarSize:5, dropDownHeight: 200, width: 260, height: 30, theme: 'metrodark'});
			
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
		}
	}); 
}
class EventAction {
	constructor (data) {
		this.action_idx = data.action_idx;
		this.action = data.action;
		this.action_action = data.action_action.split(', ');
		this.action_event = data.action_event;
		this.action_ip = data.action_ip;
		this.action_isuse = data.action_isuse;
		this.action_key = data.action_key;
		this.action_source = data.action_source;
		this.available = data.available;
		this.boundindex = data.boundindex;
		this.dev_title = data.dev_title;
		this.network_title = data.network_title;
		this.pre_title = data.pre_title;
		this.scada_tag = data.scada_tag;
	}	
}
</script>
</head>
<body>
	<div id="Progress_Loading" align="center" > <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" width="30%" style="margin-top:70px;"/>
	</div>
	<div class="loading">
		<div class="detailed_setting">
			<div class="detailed_title">
				<div class="detailed_title_text">
					<h4 class="detailed_title_h4"><spring:message code="eventAction.detailedSettings" /></h4>
				</div>
			</div>
			<div class="detailed_content">
				<div class="detailed_content_count">
					<div class="detailed_content_count_title"><spring:message code="eventAction.count" /></div>
					<div class="detailed_content_count_content">
						<input type="text" class="detailed_content_count_content_text" />
					</div>
				</div>
				<div class="detailed_content_accuracy">
					<div class="detailed_content_accuracy_title"><spring:message code="eventAction.accuracy" /></div>
					<div class="detailed_content_accuracy_content">
						<input id="ex6" data-slider-id='ex6Slider' type="text" data-slider-handle="round" data-slider-min="0" data-slider-max="100" data-slider-step="1" data-slider-value="0"/>
  						<span id="ex6SliderVal">0</span>
					</div>
				</div>
			</div>
		</div>
		<div class="btnDiv">
			<button class="button_check">
				<span class="glyphicon glyphicon-plus check" aria-hidden="true"></span><spring:message code="common.add" />
			</button>
			<button class="button_modify" id="modify">
				<span class="glyphicon glyphicon-edit modify" aria-hidden="true"></span><spring:message code="common.modify" />
			</button>
			<button class="button_delete">
				<span class="glyphicon glyphicon-trash delete" aria-hidden="true"></span><spring:message code="common.delete" />
			</button>
		</div>
		<div class="grid"></div>
		<div class="div_hr">
			<hr class="hr_hr">
		</div>
		<div class="modify_setting_hide">
			<div class="tag_setting">
				<div class="tag_title">
					<div class="tag_title_text">
						<h4 class="tag_title_h4"><spring:message code="eventAction.eventSetup" /></h4>
					</div>
				</div>
				<div class="tag_content">
					<div class="tag_content_device">
						<div class="tag_content_device_title"><spring:message code="device.title" /></div>
						<div class="tag_content_device_content"></div>
					</div>
					<div class="tag_content_channel">
						<div class="tag_content_channel_title"><spring:message code="eventAction.eventSource" /></div>
						<div class="tag_content_channel_content">
							<div>
								<input type="radio" id="kwater" name="source" value="kwater" checked>
								<label for="kwater"><spring:message code="common.kwater" /></label>
							</div>
							<div>
								<input type="radio" id="scada" name="source" value="SCADA">
								<label for="scada"><spring:message code="common.scada" /></label>
							</div>
						</div>
					</div>
					<div class="tag_content_tag">
						<div class="tag_content_tag_title"><spring:message code="eventAction.event" /></div>
						<div class="tag_content_tag_content">
							<!-- <div style="border:none;" id="jqxTree">
								<ul class="category"></ul>
							</div> -->
						</div>
					</div>
					<div class="tag_content_calendar"></div>
				</div>
			</div>
			<div class="action_setting">
				<div class="action_title">
					<div class="action_title_text">
						<h4 class="action_title_h4"><spring:message code="eventAction.actionSettings" /></h4>
					</div>
				</div>
				<div class="action_content">
					<div class="action_content_action">
						<div class="action_content_action_title"><spring:message code="eventAction.action" /></div>
						<div class="action_content_action_content"></div>
					</div>
					<div class="action_content_manager">
						<div class="action_content_manager_title"><spring:message code="eventAction.presetName" /></div>
						<div class="action_content_manager_content"></div>
					</div>
					<div class="action_content_network">
						<div class="action_content_network_title"><spring:message code="eventAction.speakerName" /></div>
						<div class="action_content_network_content"></div>
					</div>
					<!-- <div class="action_content_scada">
						<div class="action_content_scada_title">태그</div>
						<input type="text" class="action_content_scada_content" />
					</div> -->
				</div>
			</div>
			<!-- <div class="btnDiv">
				<div class="button_check">
					<input type="button" class="modify" value="확인">
				</div>
			</div> -->
		</div>
	</div>
	
<!-- The Modal -->
<div class="modal_hide">
	<!-- Modal content -->
	<div class="modal-content">
		<div class="tag_setting">
			<div class="tag_title">
				<div class="tag_title_text">
					<h4 class="tag_title_h4"><spring:message code="eventAction.eventSetup" /></h4>
				</div>
			</div>
			<div class="tag_content">
				<div class="tag_content_device">
					<div class="tag_content_device_title"><spring:message code="device.title" /></div>
					<div class="tag_content_device_content_2"></div>
				</div>
				<div class="tag_content_channel">
					<div class="tag_content_channel_title"><spring:message code="eventAction.eventSource" /></div>
					<div class="tag_content_channel_content_2">
						<div>
							<input type="radio" id="kwater_2" name="source_2" value="kwater_2" checked>
							<label for="kwater_2"><spring:message code="common.kwater" /></label>
						</div>								
						<div>
							<input type="radio" id="scada_2" name="source_2" value="scada_2">
							<label for="scada_2"><spring:message code="common.scada" /></label>						
						</div>
					</div>
				</div>
				<div class="tag_content_tag">
					<div class="tag_content_tag_title"><spring:message code="eventAction.event" /></div>
					<div class="tag_content_tag_content_2">
						<!-- <div style="border:none;" id="jqxTree_2">
							<ul class="category_2"></ul>
						</div> -->
					</div>
				</div>				
				<div class="tag_content_calendar"></div>
			</div>
		</div>
		<div class="action_setting">
			<div class="action_title">
				<div class="action_title_text">
					<h4 class="action_title_h4"><spring:message code="eventAction.actionSettings" /></h4>
				</div>
			</div>
			<div class="action_content">
				<div class="action_content_action">
					<div class="action_content_action_title"><spring:message code="eventAction.action" /></div>
					<div class="action_content_action_content_2"></div>
				</div>
				<div class="action_content_manager_2">
					<div class="action_content_manager_title"><spring:message code="eventAction.presetName" /></div>
					<div class="action_content_manager_content_2"></div>
				</div>
				<div class="action_content_network_2">
					<div class="action_content_network_title"><spring:message code="eventAction.speakerName" /></div>
					<div class="action_content_network_content_2"></div>
				</div>
				<!-- <div class="action_content_scada_2">
					<div class="action_content_scada_title">태그</div>
					<input type="text" class="action_content_scada_content_2" />
				</div> -->
			</div>
		</div>
		<div class="btnDiv">
			<button class="button_check checkBtn">
				<span class="glyphicon glyphicon-plus check" aria-hidden="true"></span><spring:message code="common.add" />
			</button>
			<button class="button_modify closeBtn">
				<spring:message code="common.cancel" />
			</button>
		</div>
	</div>
</div>
</body>
</html>