<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
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
	padding-bottom:80px;
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

.name {
	width:600px;
	float:left;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.name_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#name_text {
	width:365px;
	padding-top:5px;
	padding-right:15px;
	padding-left:5px;
	float:right;
	background-color:#505050;
	color:#fff;
	/* height:23px; */
}
.password {
	width:600px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.password_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#password_text {
	width:365px;
	float:right;
	/* padding-top:5px; */
	padding-right:15px;
	padding-left:5px;
	padding-bottom:0;
	background-color:#505050;
	color:#fff;
}
.id {
	width:600px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
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
	width:365px;
	float:right;
	/* padding-top:5px; */
	padding-right:15px;
	padding-left:5px;
	padding-bottom:0;
	color:#fff;
}
.type {
	width:600px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.type_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#type_text {
	width:365px;
	float:right;
	/* padding-top:5px; */
	padding-right:15px;
	padding-left:5px;
	padding-bottom:0;
	color:#fff;
}
.port {
	width:600px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.port_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#port_text {
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
.webport {
	width:600px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.webport_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#webport_text {
	width:365px;
	float:right;
	/* padding-top:5px; */
	padding-right:15px;
	padding-left:5px;
	padding-bottom:0;
	background-color:#505050;
	color:#fff;
}
.IP {
	width:600px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.IP_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#IP_text {
	width:365px;
	padding-top:5px;
	padding-right:15px;
	padding-left:5px;
	float:right;
	background-color:#505050;
	color:#fff;
	/* height:23px; */
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
.buttonDiv {
    text-align:center;
    margin-right:20px;
}
.pwd {
	width:600px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.pwd_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#pwd_text {
	width:365px;
	padding-top:5px;
	padding-right:15px;
	padding-left:5px;
	float:right;
	background-color:#505050;
	color:#fff;
	/* height:23px; */
}
.rtsp {
	width:600px;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:20px;
}
.rtsp_title {
	width:200px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	/* background-color:#3e3e42; */
	color:#fff;
}
#rtsp_text {
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
/* 오디오 */
#audio-left {
	width:50%;
	float:left;
	padding:0px 15px 0px 15px;
	border:none;
	border-right:1px solid #35353A;
}
.titleValue {
	margin-bottom:19px;
}
.eventTitle {
	width:170px;
	float:left;
}
.eventValue {
	
}
.titleValue2 {
	margin-bottom:10px;
}
.eventTitle2 {
	width:350px;
	float:left;
}
.eventValue2 {
	
}
#audio-right {
	width:50%;
	float:right;
	border:none;
	padding:0px 15px 0px 15px;
	text-align:center;
}
#getAudioBtn {
	width:200px;
	height:30px;
	background-color: transparent;
	margin:0;
	margin-bottom:19px;
	padding:0;
	border:1px solid #35353A;
}
#getAudioBtn:hover {
	color:#1c97ea;
}
#setAudioBtn {
	width:200px;
	height:30px;
	background-color: transparent;
	margin:0;
	margin-bottom:19px;
	padding:0;
	border:1px solid #35353A;
}
#setAudioBtn:hover {
	color:#1c97ea;
}
.glyphicon:hover {
	cursor:pointer;
	color:#1c97ea;
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
function get(key) {
	return sessionStorage.getItem(key);
}
$(document).ready(function () {
    var web_user = JSON.parse(get('userdata')).user_id;

	$('#falldown').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	$('#fire').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	$('#flood').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	$('#glove').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	$('#invasion').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	$('#leak').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	$('#loitering').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	$('#handAction').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	$('#spin').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	$('#cmtank').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	$('#outtank').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	$('#overflow').jqxDropDownList({displayMember: 'text', valueMember: 'value', scrollBarSize:10, dropDownHeight: 200,  width: 230, height: 25, theme: 'metrodark'});
	
    var pageStatus = "${status}";
    var idx = "";
    
    /* if (web_user == 'admin') {
    	web_user = "${login_id}";
    } */
    
    var speakerArr = new Array();
    
    if (pageStatus == 'modify') {
    	idx = "${speakerIdx}";
    	
		var jsonUrl = "/getNetworkSpeaker";
		var obj = new Object();
		
		obj.idx = idx;
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",
			data : jsonData,        		     		 
			success: function(data) {
		    	$('#IP_text').val(data.network_title);
		    	$('#name_text').val(data.network_ip);
		    	$("#name_text").attr("disabled",true);
		    	$('#password_text').val(data.network_port);
		    	$("#password_text").attr("disabled",true);
		    	$('#webport_text').val(data.network_id);
		    	$("#webport_text").attr("disabled",true);
		    	$('#pwd_text').val(data.network_pwd);
		    	$("#pwd_text").attr("disabled",true);
		    	
		    	var speakObj = new Object();
		    	if (data.network_falldown != '') {
			    	speakObj.text = data.network_falldown.split(', ')[0];
			    	speakObj.value = data.network_falldown.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_falldown.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 0) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_falldown.split(', ')[1]);
						}
					}
		    	}
					
		    	if (data.network_fire != '') {
					speakObj = new Object();
			    	speakObj.text = data.network_fire.split(', ')[0];
			    	speakObj.value = data.network_fire.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_fire.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 1) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_fire.split(', ')[1]);
						}
					}
		    	}

		    	if (data.network_flood != '') {
					speakObj = new Object();
			    	speakObj.text = data.network_flood.split(', ')[0];
			    	speakObj.value = data.network_flood.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_flood.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 2) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_flood.split(', ')[1]);
						}
					}
		    	}

		    	if (data.network_glove != '') {
					speakObj = new Object();
			    	speakObj.text = data.network_glove.split(', ')[0];
			    	speakObj.value = data.network_glove.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_glove.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 3) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_glove.split(', ')[1]);
						}
					}
		    	}
				
		    	if (data.network_invasion != '') {
					speakObj = new Object();
			    	speakObj.text = data.network_invasion.split(', ')[0];
			    	speakObj.value = data.network_invasion.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_invasion.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 4) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_invasion.split(', ')[1]);
						}
					}
		    	}

		    	if (data.network_leak != '') {
					speakObj = new Object();
			    	speakObj.text = data.network_leak.split(', ')[0];
			    	speakObj.value = data.network_leak.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_leak.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 5) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_leak.split(', ')[1]);
						}
					}
		    	}

		    	if (data.network_loitering != '') {
					speakObj = new Object();
			    	speakObj.text = data.network_loitering.split(', ')[0];
			    	speakObj.value = data.network_loitering.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_loitering.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 6) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_loitering.split(', ')[1]);
						}
					}
		    	}

		    	if (data.network_handaction != '') {
					speakObj = new Object();
			    	speakObj.text = data.network_handaction.split(', ')[0];
			    	speakObj.value = data.network_handaction.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_handaction.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 7) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_handaction.split(', ')[1]);
						}
					}
		    	}

		    	if (data.network_spin != '') {
					speakObj = new Object();
			    	speakObj.text = data.network_spin.split(', ')[0];
			    	speakObj.value = data.network_spin.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_spin.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 8) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_spin.split(', ')[1]);
						}
					}
		    	}

		    	if (data.network_cmtank != '') {
					speakObj = new Object();
			    	speakObj.text = data.network_cmtank.split(', ')[0];
			    	speakObj.value = data.network_cmtank.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_cmtank.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 9) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_cmtank.split(', ')[1]);
						}
					}
		    	}

		    	if (data.network_outtank != '') {
					speakObj = new Object();
			    	speakObj.text = data.network_outtank.split(', ')[0];
			    	speakObj.value = data.network_outtank.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_outtank.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 10) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_outtank.split(', ')[1]);
						}
					}
		    	}

		    	if (data.network_overflow != '') {
					speakObj = new Object();
			    	speakObj.text = data.network_overflow.split(', ')[0];
			    	speakObj.value = data.network_overflow.split(', ')[1];
					for (var j = 0; j < 12; j++) {
						var item = $('.event' + j).jqxDropDownList('getItemByValue', data.network_overflow.split(', ')[1]);
						if (item == null) {
							$('.event' + j).jqxDropDownList('addItem', speakObj);
						}
						if (j == 11) {
							$('.event' + j).jqxDropDownList('selectItem', data.network_overflow.split(', ')[1]);
						}
					}
		    	}
			},
			error: function(errorThrown) {
				alert(errorThrown.statusText);
				alert(JSON.stringify(data));
			}
		});
    }
	
	$('#joinDevice').click(function () {
		if ($('#IP_text').val() == '') {
			alert('이름을 입력해주세요.');
			return false;
		}
		if ($('#name_text').val() == '') {
			alert('아이피를 입력해주세요.');
			return false;
		}
		if ($('#password_text').val() == '') {
			alert('포트를 입력해주세요.');
			return false;
		}
		if ($('#webport_text').val() == '') {
			alert('아이디를 입력해주세요.');
			return false;
		}
		if ($('#pwd_text').val() == '') {
			alert('비밀번호를 입력해주세요.');
			return false;
		}
		
		var title = $('#IP_text').val();
		var ip = $('#name_text').val();
		var port = $('#password_text').val();
		var id = $('#webport_text').val();
		var pwd = $('#pwd_text').val();
		
		var falldown = $(".event0").jqxDropDownList('getSelectedItem');
		var fire = $(".event1").jqxDropDownList('getSelectedItem');
		var flood = $(".event2").jqxDropDownList('getSelectedItem');
		var glove = $(".event3").jqxDropDownList('getSelectedItem');
		var invasion = $(".event4").jqxDropDownList('getSelectedItem');
		var leak = $(".event5").jqxDropDownList('getSelectedItem');
		var loitering = $(".event6").jqxDropDownList('getSelectedItem');
		var handaction = $(".event7").jqxDropDownList('getSelectedItem');
		var spin = $(".event8").jqxDropDownList('getSelectedItem');
		var cmtank = $(".event9").jqxDropDownList('getSelectedItem');
		var outtank = $(".event10").jqxDropDownList('getSelectedItem');
		var overflow = $(".event11").jqxDropDownList('getSelectedItem');
		
		var jsonUrl = "/addNetworkSpeaker";
		var obj = new Object();
		
		if (pageStatus == 'modify') {
			obj.idx = idx;
		}
		
		obj.status = pageStatus;
		
		obj.title = title;
		obj.ip = ip;
		obj.port = port;
		obj.id = id;
		obj.pwd = pwd;

		if (falldown != null) {
			obj.falldown = falldown.label + ', ' + falldown.value;
		} else {
			obj.falldown = '';
		}

		if (fire != null) {
			obj.fire = fire.label + ', ' + fire.value;
		} else {
			obj.fire = '';
		}
		if (flood != null) {
			obj.flood = flood.label + ', ' + flood.value;
		} else {
			obj.flood = '';
		}
		if (glove != null) {
			obj.glove = glove.label + ', ' + glove.value;
		} else {
			obj.glove = '';
		}
		if (invasion != null) {
			obj.invasion = invasion.label + ', ' + invasion.value;
		} else {
			obj.invasion = '';
		}
		if (leak != null) {
			obj.leak = leak.label + ', ' + leak.value;
		} else {
			obj.leak = '';
		}
		if (loitering != null) {
			obj.loitering = loitering.label + ', ' + loitering.value;
		} else {
			obj.loitering = '';
		}
		if (handaction != null) {
			obj.handaction = handaction.label + ', ' + handaction.value;
		} else {
			obj.handaction = '';
		}
		if (spin != null) {
			obj.spin = spin.label + ', ' + spin.value;
		} else {
			obj.spin = '';
		}
		if (cmtank != null) {
			obj.cmtank = cmtank.label + ', ' + cmtank.value;
		} else {
			obj.cmtank = '';
		}
		if (outtank != null) {
			obj.outtank = outtank.label + ', ' + outtank.value;
		} else {
			obj.outtank = '';
		}
		if (overflow != null) {
			obj.overflow = overflow.label + ', ' + overflow.value;
		} else {
			obj.overflow = '';
		}
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "json",                        	  
			contentType : "application/json; charset=UTF-8",
			data : jsonData,        		     		 
			success: function(data) {
				self.close();		
				parent.opener.location.reload();
			},
			error: function(errorThrown) {
				alert(errorThrown.statusText);
				alert(JSON.stringify(data));
			}
		});
	});
	
	$('#cancel').click(function () {
		self.close();
	});
	
	$('#getAudioBtn').click(function () {
		var jsonUrl = "/getSpeakerList";

		var ip = $('#name_text').val();
		var id = $('#webport_text').val();
		var pwd = $('#pwd_text').val();
		
		var obj = new Object();
		obj.ip = ip;
		obj.id = id;
		obj.pwd = pwd;
		
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "text",                        	  
			contentType : "application/json; charset=UTF-8",
			data : jsonData,        		     		 
			success: function(data) {
				var arr = data.split('\n');
				$('#audioList').remove();
				$("#audio-right").append('<div id="audioList"></div>');
				for (var i = 0; i < arr.length; i++) {
					if (arr[i].indexOf('Name') > 0) {
						var speakerNum = arr[i].split('.')[2].substring(1);
						var speakerName = arr[i].split('=')[1];
						$("#audioList").append('<div class="titleValue2"><div class="eventTitle2">' + speakerName + '</div><div class="eventValue2"><span class="glyphicon glyphicon-play" style="margin-right:0.7em;" onclick="sendSpeakerNumber(' + "'" + speakerNum + "'" + ');"></div></div>');
						var speakerObj = new Object();
						speakerObj.text = speakerName;
						speakerObj.value = speakerNum;
						for (var j = 0; j < 12; j++) {
							var item = $('.event' + j).jqxDropDownList('getItemByValue', speakerNum);
							if (item == null) {
								$('.event' + j).jqxDropDownList('addItem', speakerObj);
							}
						}
					}
				}
			},
			error: function(errorThrown) {
				alert(errorThrown.statusText);
				alert(JSON.stringify(data));
			}
		});
	});
	
	$('#setAudioBtn').click(function () {
		var ip = $('#name_text').val();
		var port = $('#password_text').val();
		
		if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed)
			popup_window[POPUP_MORE].close();
		
		popup_window[POPUP_MORE] = openWindow('http://' + ip + ":" + port + '/#/audioclips', 'setNetworkSpeaker', 1400, 880);
	});
});
function sendSpeakerNumber(num) {
	var jsonUrl = "/sendSpeakerNumber";
	var obj = new Object();

	var ip = $('#name_text').val();
	var port = $('#password_text').val();
	var id = $('#webport_text').val();
	var pwd = $('#pwd_text').val();
	
	obj.num = num;
	obj.ip = ip;
	obj.port = port;
	obj.id = id;
	obj.pwd = pwd;
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "text",                        	  
		contentType : "application/json; charset=UTF-8",
		data : jsonData,        		     		 
		success: function(data) {
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});
}
var POPUP_MORE = 0;

var popup_window = new Array();

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
	<div class="divBody">
		<div class="container status" style="width:600px;padding:0;max-width:1110px;">
			<div class="tmpMargin"></div>
			<!-- <div class="id_pwd">
				<div class="id">
					<label class="id_title">채널</label>
					<div id="id_text"></div>
				</div>
			</div> -->
			<div class="type_pwd">
				<!-- <div class="type">
					<label class="type_title">mac</label>
					<div id="type_text"></div>
				</div> -->
				<div class="IP">
					<label class="IP_title" for="IP_text">이름</label>
					<!-- <div id="IP_text"></div> -->
					<input type="text" id="IP_text">
				</div>
			</div>
			<div class="name_password">
				<div class="name">
					<label class="name_title" for="name_text">아이피</label>
					<input type="text" id="name_text">
				</div>
				<div class="password">
					<label class="password_title" for="password_text">포트</label>
					<input type="text" id="password_text">
				</div>
			</div>
			<div class="port_webport">
				<!-- <div class="port">
					<label class="port_title">ID/PW</label>
					<div id="port_text"></div>
				</div> -->
				<div class="webport">
					<label class="webport_title" for="webport_text">아이디</label>
					<input type="text" id="webport_text">
				</div>
			</div>
			<div class="pwd_rtsp">
				<div class="pwd">
					<label class="pwd_title" for="pwd_text">비밀번호</label>
					<input type="password" id="pwd_text">
				</div>
				<!-- <div class="rtsp">
					<label class="rtsp_title">RTSP</label>
					<div id="rtsp_text"></div>
				</div> -->
			</div>
		</div>
		<hr style="width:1110px; border:1px solid #35353A;">
		<div class="container" style="padding:0;max-width:1000px;">
			<div id="audio-left">
				<div class="titleValue">
					<div class="eventTitle">쓰러짐</div>
					<div class="eventValue event0" id="falldown"></div>
				</div>
				<div class="titleValue">
					<div class="eventTitle">화재</div>
					<div class="eventValue event1" id="fire"></div>
				</div>
				<div class="titleValue">
					<div class="eventTitle">침수</div>
					<div class="eventValue event2" id="flood"></div>
				</div>
				<div class="titleValue">
					<div class="eventTitle">장갑미착용</div>
					<div class="eventValue event3" id="glove"></div>
				</div>
				<div class="titleValue">
					<div class="eventTitle">침입</div>
					<div class="eventValue event4" id="invasion"></div>
				</div>
				<div class="titleValue">
					<div class="eventTitle">누수</div>
					<div class="eventValue event5" id="leak"></div>
				</div>
				<div class="titleValue">
					<div class="eventTitle">배회</div>
					<div class="eventValue event6" id="loitering"></div>
				</div>
				<div class="titleValue">
					<div class="eventTitle">수신호</div>
					<div class="eventValue event7" id="handAction"></div>
				</div>
				<div class="titleValue">
					<div class="eventTitle">약품미투입</div>
					<div class="eventValue event8" id="spin"></div>
				</div>
				<div class="titleValue">
					<div class="eventTitle">약품탱크 누액</div>
					<div class="eventValue event9" id="cmtank"></div>
				</div>
				<div class="titleValue">
					<div class="eventTitle">옥외탱크 누액</div>
					<div class="eventValue event10" id="outtank"></div>
				</div>
				<div class="titleValue">
					<div class="eventTitle">배출수 월류</div>
					<div class="eventValue event11" id="overflow"></div>
				</div>
			</div>
			<div id="audio-right">
				<div>
					<button id="getAudioBtn">오디오 리스트 가져오기</button>
					<button id="setAudioBtn">오디오 등록하기</button>
				</div>
				<div id="audioList"></div>
			</div>
		</div>
		<div class="container" style="width:600px;padding:0;max-width:1110px;margin-top:30px;margin-bottom:30px;">
			<div class="buttonDiv">
				<button class="button_modify" id="joinDevice">등록</button>
				<button class="button_modify" id="cancel">취소</button>
			</div>
		</div>
	</div>
</body>
</html>