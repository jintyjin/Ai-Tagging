<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"> -->
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxcore.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdata.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxbuttons.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxscrollbar.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxmenu.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxtextarea.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdropdownlist.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.selection.js"></script> 
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.columnsresize.js"></script> 
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.pager.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdropdownlist.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdatetimeinput.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxcheckbox.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxlistbox.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxcalendar.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.sort.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.filter.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.edit.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxinput.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxwindow.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/globalization/globalize.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxvalidator.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxdata.export.js"></script> 
<script type="text/javascript" src="./resources/js/jqwidgets/jqxgrid.export.js"></script>
<script type="text/javascript" src="/resources/js/translate.js"></script>
<style>
button {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	color:white;
	font-weight:bold;
	line-height: 1.5;
}
button:focus {
	outline:none;
}
input:focus {
	outline:none;
}
input[type="text"], input[type="password"] {
	height:25px;
	padding-top:0;
	border:none;
}
body {
	width:100%;
	height:100%;
	margin:0;
	padding:35px 0 0 0;
	color:#fff;
	font-size:14px;
	font-weight:bold;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	background-color:#252525;
}
.divBody {
	width:100%;
	overflow:auto;
	/* padding-bottom:80px; */
}
.status {
	border:1px solid #35353A;
}
.status:after {
	clear:both;
	display:table;
	content:" ";
}
.tmpMargin {
	height:20px;
	background-color:#3e3e42;
	margin-bottom:3em;
}
.schedule_name {
	width:100%;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.name {
	width:450px;
	float:left;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.name_title {
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#name_text {
	/* width:365px; */
	/* height:25px; */
	/* padding-top:5px; */
	border:none;
	padding-right:5px;
	padding-left:5px;
	float:right;
	background-color:#505050;
	/* background-color:#252525; */
	color:#fff;
}
#name_textarea {
	border:none;
	padding-right:5px;
	padding-left:5px;
	position:relative;
	color:white;
	position:relative;
	background-color:#505050;
	/* background-color:#252525; */
	width:188px;
	color:#fff;
}
.password {
	width:450px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.schedule_name_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
.password_title {
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#password_text {
	/* width:365px; */
	/* height:25px; */
	/* padding-top:5px; */
	border:none;
	padding-right:5px;
	padding-left:5px;
	position:relative;
	background-color:#505050;
	width:188px;
	/* background-color:#252525; */
	color:#fff;
}
.event_textbox {
	width:450px;
	padding-right:19px;
	padding-left:30px;
	margin-bottom:20px;
}
.textbox {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
.id {
	width:450px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:-92px;/*20px;*/
}
.id_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#id_text {
	/* width:365px; */
	/* height:25px; */
	/* padding-top:5px; */
	border:none;
	padding-right:5px;
	padding-left:5px;
	float:right;
	background-color:#505050;
	/* background-color:#252525; */
	color:#fff;
}
.activative {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
.check {
	position:relative;
	top:-25.5px;
	left:130px;
}
.active {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
.IP {
	width:450px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.IP_title {
	/* width:200px; */
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#area_set {
	position:relative;
	/* left:-86px; */
	font-size:14px;
	color:white;
	background-color:#333;
	font-weight:bold;
	line-height:1.5;
}
.schedule {
	width:450px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.schedule_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#schedule_setup {
	position:relative;
	left:-86px;
	font-size:14px;
	color:white;
	background-color:#333;
	font-weight:bold;
	line-height:1.5;
}
#IP_text {
	/* width:365px; */
	/* height:25px; */
	/* padding-top:5px; */
	border:none;
	padding-right:5px;
	padding-left:5px;
	float:right;
	background-color:#505050;
	/* background-color:#252525; */
	color:#fff;
}
.button_modify {
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
.button_modify:hover {
	color:#1c97ea;
}
.IP_message {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.IP_message:hover {
	color:#1c97ea;
}
.IP_help {
	width:25px;
	height:25px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.IP_help:hover {
	color:#1c97ea;
}
.buttonDiv {
    text-align:end;
    margin-right:20px;
}
.pwd {
	width:800px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.pwd_title {
	width:365px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#pwd_text {
	/* width:365px; */
	/* height:25px; */
	/* padding-top:5px; */
	border:none;
	padding-right:5px;
	padding-left:5px;
	float:right;
	background-color:#505050;
	/* background-color:#252525; */
	color:#fff;
}
#schedule_picture {
	width:100%;
	height:400px;
	margin-top:10px;
	display:table;
}
.schedule_row {
	display:table-row;
}
.schedule_cell {
	display:table-cell;
	border:1px solid #35353A;
	width:4%;
	text-align:center;
	vertical-align:middle;
}
.dateBox:hover {
	background-color:#1C97EA;
}
.chkBox {
	background-color:#1C97EA;
}
.chkBox:hover {
	opacity:0.5;
}
.menu_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#ch_button {
	position:relative;
	left:254px;
	bottom:90px;
	display:none;
} 
#ch {
	width:450px;
	padding-right:19px;
	padding-left:30px;
	margin-bottom:20px;
}
#ch {
	width:200px;
	left:115px;
	position:relative;
	top:-20px;	
	/* background-color:#505050; */
	color:white;
}
#ch_check {
	position: relative;
    left: 315px;
    bottom: 60px;
    margin-left:10px;
}
#d_ch {
	position:relative;
	left: 330px;
    bottom: 81px;
    margin-left:10px;
}
#dev_channel {
	left:132px; 
	bottom:15px; 
	position:relative; 
}
</style>
<script>
function SHA256(s) {     
	var chrsz   = 8;
	var hexcase = 0;
  
	function safe_add (x, y) {
		var lsw = (x & 0xFFFF) + (y & 0xFFFF);
		var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
		return (msw << 16) | (lsw & 0xFFFF);
	}
  
	function S (X, n) { return ( X >>> n ) | (X << (32 - n)); }
	function R (X, n) { return ( X >>> n ); }
	function Ch(x, y, z) { return ((x & y) ^ ((~x) & z)); }
	function Maj(x, y, z) { return ((x & y) ^ (x & z) ^ (y & z)); }
	function Sigma0256(x) { return (S(x, 2) ^ S(x, 13) ^ S(x, 22)); }
	function Sigma1256(x) { return (S(x, 6) ^ S(x, 11) ^ S(x, 25)); }
	function Gamma0256(x) { return (S(x, 7) ^ S(x, 18) ^ R(x, 3)); }
	function Gamma1256(x) { return (S(x, 17) ^ S(x, 19) ^ R(x, 10)); }
  
	function core_sha256 (m, l) {
		 
		var K = new Array(0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1,
			0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3,
			0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786,
			0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
			0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147,
			0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13,
			0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B,
			0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,
			0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A,
			0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208,
			0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2);

		var HASH = new Array(0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19);

		var W = new Array(64);
		var a, b, c, d, e, f, g, h, i, j;
		var T1, T2;
  
		m[l >> 5] |= 0x80 << (24 - l % 32);
		m[((l + 64 >> 9) << 4) + 15] = l;
  
		for ( var i = 0; i<m.length; i+=16 ) {
			a = HASH[0];
			b = HASH[1];
			c = HASH[2];
			d = HASH[3];
			e = HASH[4];
			f = HASH[5];
			g = HASH[6];
			h = HASH[7];
  
			for ( var j = 0; j<64; j++) {
				if (j < 16) W[j] = m[j + i];
				else W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16]);
  
				T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j]);
				T2 = safe_add(Sigma0256(a), Maj(a, b, c));
  
				h = g;
				g = f;
				f = e;
				e = safe_add(d, T1);
				d = c;
				c = b;
				b = a;
				a = safe_add(T1, T2);
			}
  
			HASH[0] = safe_add(a, HASH[0]);
			HASH[1] = safe_add(b, HASH[1]);
			HASH[2] = safe_add(c, HASH[2]);
			HASH[3] = safe_add(d, HASH[3]);
			HASH[4] = safe_add(e, HASH[4]);
			HASH[5] = safe_add(f, HASH[5]);
			HASH[6] = safe_add(g, HASH[6]);
			HASH[7] = safe_add(h, HASH[7]);
		}
		return HASH;
	}
  
	function str2binb (str) {
		var bin = Array();
		var mask = (1 << chrsz) - 1;
		for(var i = 0; i < str.length * chrsz; i += chrsz) {
			bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i%32);
		}
		return bin;
	}
  
	function Utf8Encode(string) {
		string = string.replace(/\r\n/g,"\n");
		var utftext = "";
  
		for (var n = 0; n < string.length; n++) {
  
			var c = string.charCodeAt(n);
  
			if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
  
		}
  
		return utftext;
	}
  
	function binb2hex (binarray) {
		var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
		var str = "";
		for(var i = 0; i < binarray.length * 4; i++) {
			str += hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8+4)) & 0xF) +
			hex_tab.charAt((binarray[i>>2] >> ((3 - i%4)*8  )) & 0xF);
		}
		return str;
	}
  
	s = Utf8Encode(s);
	return binb2hex(core_sha256(str2binb(s), s.length * chrsz));  
}
function openWindow(page, pageName, width, height) {
	var popupX = (screen.availWidth - width) / 2;
	var popupY = (screen.availHeight - height) / 2;
	var scrollbars = (pageName == 'webNoticeAdd' || pageName == 'webNoticeModify') ? 'yes' : 'no';

	var popup_window = window.open(page, pageName, 'width=' + width + ', height=' + height + ', toolbar=no, location=no, status=no, menubar=no, scrollbars=' + scrollbars + ', resizable=yes, left=' + popupX + ', top=' + popupY);

	return popup_window;
}

var POPUP_MORE = 0;

var popup_window = new Array();

function get(key) {
	return sessionStorage.getItem(key);
}
$(document).ready(function () {
	var model_name = "${model_name}";
	var dev_ch = "${dev_ch}";
	var dev_title = "${dev_title}";
	var on_off = "${on_off}";
	
	$("input:radio[id='" + on_off + "']").prop("checked", true); 
	
	model_name = getTranslate(model_name);
	
	$('.event_textbox').text(model_name);
	$('#ch').text(dev_title);
	$("#ch_channel").text(dev_title).css("visibility", "hidden");
	$("#dev_channel").css("visibility", "hidden");
	
	$("#ch_check").change(function(){
		var value = $(this).val();
		var checked = $(this).prop('checked');
		if(checked) {				
			$("#dev_channel").css("visibility", "visible");
			$("#ch").css("visibility", "hidden");
		} else {
			$("#dev_channel").css("visibility", "hidden");
			$("#ch").css("visibility", "visible");
		}
	}); // 체크박스 눌렀을 시에 채널 보여주고 사라지는 기능
	
	//var arrays = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];		
	var arrays = new Array();
	
	var obj = new Object();
	//dev_channel 채널값
	var jsonData = JSON.stringify(obj);

	var jsonUrl2 = '/eventSetup';
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl2,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",       
		data : jsonData,          		
		async : false,
		success: function(data) {
			for (i = 0; i < data.length; i++) {
				var devObj = new Object();
				devObj.value = data[i].dev_ch;
				devObj.label = data[i].dev_title;
				arrays.push(devObj);
				
				if (data[i].dev_title == dev_title) {
					if (data[i].confidence != null && data[i].confidence > 0) {
						$("#name_textarea").val(data[i].confidence);
					}
					if (data[i].duration != null && data[i].duration > 0) {
						$("#password_text").val(data[i].duration);
					}
				}
				//arrays.push(data[i].dev_title);
			}
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});	
	
	$('#dev_channel').jqxDropDownList({checkboxes:true, source: arrays, displayMember: 'label', valueMember: 'value', width: 200, height: 30, theme: 'metrodark' }); 		

	$("#ch_button").jqxButton({
		theme:'metrodark'
	});
		
	var items = $("#dev_channel").jqxDropDownList('getItems'); 
	
 	$("#ch_button").on('click',function(){
		var checkedItems = "";
		var items = $("#dev_channel").jqxDropDownList("getCheckedItems");
		
		$.each(items, function(index) {
			 checkedItems += this.label + ", ";		
		});	
	});  
	
	$('#btn_save').click(function() { 
		if (confirm(getTranslate('questionSave'))) {
			var jsonUrl = "/eventSetupInfo/";
	 		
	 		var obj = new Object();
	 		//dev_channel 채널값
	 		obj.model_name = getTranslate(model_name); //이벤트 내용
	 		obj.dev_title = $("#dev_channel").val(); //채널 값
	 		obj.dev_ch = dev_ch; //장치이름
			obj.opt = $('input[name="onoff"]:checked').val();
	 		obj.chk = $("input:checkbox[id='ch_check']").is(':checked');
	 		
	 		if ($("#name_textarea").val() == '') {
	 			alert(getTranslate('setSensitivity'));
	 			return false;
	 		}
	 		obj.confidence = $("#name_textarea").val();
	 		
	 		if ($("#password_text").val() == '') {
	 			alert(getTranslate('setHoldingTime'));
	 			return false;
	 		}
	 		obj.duration = $("#password_text").val();
	 		
	 		if (obj.chk && $("#dev_channel").val() == '') {
	 			alert(getTranslate('setChannel'));
	 			return false;
	 		}
	 		
			var jsonData = JSON.stringify(obj);
	 		
			$.ajax({
	 			type : "POST",                        	 	     
	 			url : jsonUrl,                      		
	 			dataType : "text",                        	  
	 			contentType : "application/json; charset=UTF-8",       
	 			data : jsonData,          		
	 			async : false,
	 			success: function(data) {
					alert(getTranslate('completeSave'));
					self.close();
					parent.opener.location.reload();
	 			},
	 			error: function(errorThrown) {
	 				alert(errorThrown.statusText);
	 				alert(JSON.stringify(data));
	 			}
	 		});	
		}
	});
	
	$('#area_set').click(function () {
		if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed)
			popup_window[POPUP_MORE].close();
		
		popup_window[POPUP_MORE] = openWindow('./areaSet.htm?area_event=' + "${model_name}" + "&dev_ch=" + dev_ch, 'areaSet', 1400, 880);
		
	});

	$('#schedule_setup').click(function () {
		if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed)
			popup_window[POPUP_MORE].close();
		
		popup_window[POPUP_MORE] = openWindow('./schedule_setup.htm?event_name=' + "${model_name}" + "&dev_ch=" + dev_ch, 'areaSet', 1400, 880);
		
	});
});

function chkNum(obj) {
	var num = parseInt(obj.value);
	if (!(num > 0 && num < 100)) {
		alert("1 ~ 100을 입력하세요.");
		$("#name_textarea").val('');
	}
}

function password_text_chk(obj) {
	var num = parseInt(obj.value);
	if (!(num > 0 && num < 61)) {
		alert("1 ~ 60을 입력하세요.");
		$("#password_text").val('');
	}
}

function closePopupChild() {
	for(var i = 0; i < popup_window.length; i++) {
		if(popup_window[i] && popup_window[i].open && !popup_window[i].closed)
			popup_window[i].close();
	}
}

function cancel() {
	self.close();
} 
</script>
</head>
<body onunload="closePopupChild();">
	<div class="divBody">
		<div class="container status" style="width:950px;padding:0;">
			<div class="tmpMargin"></div>
			<div class="event_textbox">
				<label class="textbox"></label>
			</div>
			<div class="id_pwd">
				<div class="id">
						<div class="menu_title"><spring:message code="device.title" /></div>
						<div id="ch"></div>
						<input type=checkbox id='ch_check' name='ch_list 'value='<spring:message code="device.otherChannel" />' />
							<div id="d_ch"><spring:message code="device.otherChannel" /></div>
					<div id="id_text"></div>
				</div>
				<div class="channel">
					<button id="ch_button" type="button"><spring:message code="common.option" /></button>
					<div id='dev_channel' name='dev_ch'></div>
				</div>
				<div class="activative">
					<label class="active"><spring:message code="common.activate" /></label>
				</div>		
				<div class="check">
					<input type="radio" id="0" name="onoff" value="0"></input>
					<label for="label-a"><spring:message code="common.on" /></label>
					<input type="radio" id="1" name="onoff" value="1"></input>
					<label for="label-b"><spring:message code="common.off" /></label>
				</div>
				<div class="IP">
					<label class="IP_title"><spring:message code="device.detectionArea" /></label>
					<button id="area_set" type="button"><spring:message code="device.areaSetting" /></button>
				</div>
				<div class="schedule">
					<label class="schedule_title"><spring:message code="device.schedule" /></label>
					<button id="schedule_setup" type="button"><spring:message code="device.areaSetting" /></button>
				</div>
			</div>
			<div class="name_password">
				<div class="name">
					<label class="name_title"><spring:message code="device.responsiveness" /></label>
					<input type="number" min = '1' max = '99' id="name_textarea" onkeyup="chkNum(this);" placeholder='<spring:message code="device.setupResponsiveness" />'></input>				
				</div>
				<div class="password">
					<label class="password_title"><spring:message code="device.holdingTime" /></label>
					<input type="number" min = '1' max = '60' id="password_text" onkeyup="password_text_chk(this)" placeholder='<spring:message code="device.setupHoldingTime" />'></input>
				</div>
			</div>
		</div>
		<div class="container" style="width:950px;padding:0;margin-top:30px;margin-bottom:30px;">
			<div class="buttonDiv">
				<button class="button_modify" id="btn_save"><spring:message code="common.save" /></button>
				<button class="button_modify" id="btn_cancel" onclick="cancel();"><spring:message code="common.cancel" /></button>	
			</div>
		</div>	
	</div>
</body>
</html>