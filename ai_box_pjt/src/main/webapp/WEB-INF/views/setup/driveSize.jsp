<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.metro.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.arctic.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<script src="./resources/js/bootstrap.min.js"></script>
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
<script type="text/javascript" src="/resources/js/translate.js"></script>
<style>
select, input:focus {
	outline:0;
}
button:focus{
	border-color:transparent!important;
	outline:none;
}
button:active {
	border-color:transparent!important;
	outline:none;
}
body {
	width:100%;
	height:100%;
	margin:0;
	color:#fff;
	font-size:14px;
	font-weight:bold;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	background-color:#252525;
	padding-top:70px;
}
#driveC_div {
	height:370px;
	width:49%;
	float:left;
}
#driveD_div {
	height:370px;
	width:49%;
	float:right;
}
#div_text {
	padding:0;
	border:none;
	background-color:#3E3E42;
	width:100%;
}
select:hover {
	cursor:pointer;
	color:#007ACC;
}
#save_info {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.modify {
	width:14px;
	height:14px;
	font-size:14px;
	font-weight: bold;
	color:white;
	margin-right:8px;
}
#save_info:hover {
	color:#1c97ea;
}
#save_info:focus {
	color:#1c97ea;
	border:1px solid #35353A;
}
button {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
	line-height: 1.5;
}
button:focus {
	outline:1px solid #35353A;
}
</style>
<script>
$(document).ready(function () {
	if (window.parent.userId == null) {
		location.replace('/index');
	}
	if (typeof window.parent.loginUser != 'function') {
		location.replace('/index/driveSize');
	}
	var jsonUrl2 = "/sizeData";
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
				eval("var driveSize" + l + " = ''");
				eval("var driveName" + l + " = ''");
		    	Object.keys(data2[l]).forEach(function(k){
		    		if (k.substring(0, k.indexOf('_')) != 'free' && k.substring(0, k.indexOf('_')) != 'drive' && k.substring(0, k.indexOf('_')) != 'total') {
						var sizeObj = new Object();
						
						sizeObj.y = data2[l][k];
						sizeObj.label = k.substring(0, k.indexOf('_'));
						
						eval("sizeArr" + l + ".push(sizeObj)");
		    		} else if (k.substring(0, k.indexOf('_')) == 'total') {
		    			eval('driveSize' + l + ' = data2[l][k]');
		    		} else if (k.substring(0, k.indexOf('_')) == 'drive') {
		    			eval('driveName' + l + ' = data2[l][k]');		    		}
		    	});

		    	if (l == 0) {
			    	var chart = new CanvasJS.Chart("driveC_div", {
			    		animationEnabled: true,
			    		backgroundColor: "#2a2a2c",
			    		title:{
			    			text: eval("driveName" + l) + getTranslate('driveCapacity') + " : " + eval("sizeArr" + l + '[0].y') + 'GB/' + eval("driveSize" + l) + 'GB',
			    			horizontalAlign: "left",
			    			fontColor: "#fff",
			    	        fontFamily: "Lucida Sans",
			    			fontSize: 14
			    		},
			    		data: [{
			    			type: "doughnut",
			    			startAngle: 90,
			    			//innerRadius: 60,
			    			indexLabelFontSize: 14,
			    		    indexLabelFontColor: "white",
			    		    indexLabelFontFamily: "Lucida Sans",
			    			indexLabel: "{label} - #percent%",
			    			toolTipContent: "<b>{label}:</b> {y}GB (#percent%)",
			    			dataPoints: eval("sizeArr" + l)
			    		}]
			    	});
			    	chart.render();
		    	} else {
			    	var chart1 = new CanvasJS.Chart("driveD_div", {
			    		animationEnabled: true,
			    		backgroundColor: "#2a2a2c",
			    		title:{
			    			text: eval("driveName" + l) + getTranslate('driveCapacity') + " : " + eval("sizeArr" + l + '[0].y') + 'GB/' + eval("driveSize" + l) + 'GB',
			    			horizontalAlign: "left",
			    	        fontFamily: "Lucida Sans",
			    			fontSize: 14,
			    			fontColor: "#fff"
			    		},
			    		data: [{
			    			type: "doughnut",
			    			startAngle: 90,
			    			//innerRadius: 60,
			    			indexLabelFontSize: 14,
			    		    indexLabelFontColor: "white",
			    		    indexLabelFontFamily: "Lucida Sans",
			    			indexLabel: "{label} - #percent%",
			    			toolTipContent: "<b>{label}:</b> {y}GB (#percent%)",
			    			dataPoints: eval("sizeArr" + l)
			    		}]
			    	});
			    	chart1.render();	
		    	}
			}
	    },
		error: function(errorThrown) {
			//alert('오류가 발생하였습니다.');
			//alert(errorThrown.statusText);
			//alert(jsonUrl2);
		}
	});
	
});
</script>
</head>
<body>
	<div class="container" style="margin-top:50px;">
		<div id="driveC_div"></div>
		<div id="driveD_div"></div>
	</div>
	<div class="container" style="margin-top:15px;">
		<div class="col-md-6" style="width:49%; border: 1px solid #35353A; padding-top:15px; padding-bottom:15px; display:none;">
			<div class="col-md-12">
				<div class="col-md-4" style="padding-right:0;">현재 제한 용량</div>
				<div class="col-md-8" style="padding-left:0;">250GB</div>
			</div>
			<div class="col-md-12" style="margin-top:10px;">
				<div class="col-md-4" style="padding-right:0;">수정할 제한 용량</div>
				<div class="col-md-8" style="padding-left:0;">
					<div class="col-md-5" style="padding:0;">
						<input type="text" id="div_text" />
					</div>
					<div class="col-md-2" style="padding-left:5px;">
						<select style="border:none; height:21px; background-color:#3E3E42;">
							<option value="G">G</option>
							<option value="%">%</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6" style="width:49%; border: 1px solid #35353A; padding-top:15px; padding-bottom:15px; float:right; display:none;">
			<div class="col-md-12">
				<div class="col-md-4" style="padding-right:0;">현재 제한 용량</div>
				<div class="col-md-8" style="padding-left:0;">250GB</div>
			</div>
			<div class="col-md-12" style="margin-top:10px;">
				<div class="col-md-4" style="padding-right:0;">수정할 제한 용량</div>
				<div class="col-md-8" style="padding-left:0;">
					<div class="col-md-5" style="padding:0;">
						<input type="text" id="div_text" />
					</div>
					<div class="col-md-2" style="padding-left:5px;">
						<select style="border:none; height:21px; background-color:#3E3E42;">
							<option value="G">G</option>
							<option value="%">%</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-12" style="float:none;">
			<div class="col-md-6 checkbox" style="margin-left:auto; margin-right:auto; float:none; text-align:center;">
				<label style="margin:0;">
					<input type="checkbox" checked> <spring:message code="storage.HDDOverwrite" />
				</label>
			</div>
		</div>
		<div class="col-md-12" style="margin-top:15px;">
			<div class="col-md-6" style="margin-left:auto; margin-right:auto; float:none; text-align:center;">
				<button id="save_info"><span class="glyphicon glyphicon-edit modify" aria-hidden="true"></span><spring:message code="common.save" /> </button>
			</div>
		</div>
	</div>
</body>
</html>