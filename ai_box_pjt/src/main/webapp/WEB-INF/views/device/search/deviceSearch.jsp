<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
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
body {
	margin:0;
	padding:70px 0 0 0;
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
button {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	color:white;
	font-weight:bold;
	line-height: 1.5;
}
input[type="text"], input[type="password"] {
	height:25px;
	padding-top:0;
	border:none;
}

.jqx-fill-state-normal-metrodark, .jqx-fill-state-hover-metrodark, .jqx-widget-content-metrodark {
	font-size:14px;
	font-weight:bold;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
}
.jqx-dropdownlist-content {
	padding-left:0px;
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
	width:325px;
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
	border:none;
	padding-right:5px;
	padding-left:5px;
	float:right;
	background-color:#505050;
	/* background-color:#252525; */
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
	display:none;
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
    text-align:end;
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


.loading {
	display:none;
}
.divBody2 {
	width:900px;
	padding:0;
	margin:0;
	/* padding-left:100px; */
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
.tag_content_tag_content_2 {
	width:450px;
	float:left;
}
.tag_content_device {
	width:650px;
	padding-right:15px;
	padding-left:15px;
	padding-bottom:40px;
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
	padding-bottom:40px;
}
.tag_content_channel_title {
	width:180px;
	height:30px;
	float:left;
	padding-top:6px;
}
.tag_content_channel_content {
	width:450px;
	float:left;
}
.tag_content_channel_content_2 {
	width:450px;
	float:left;
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
.action_content_action_content {
	width:510px;
	float:left;
}
.action_content_action_content_2 {
	width:510px;
	float:left;
}
.action_content_manager {
	width:460px;
	padding-right:15px;
	padding-left:15px;
	padding-bottom:40px;
}
.action_content_manager_title {
	width:130px;
	height:30px;
	float:left;
	padding-top:9px;
	padding-top:6px;
}
.action_content_manager_content {
	width:310px;
	float:left;
}
.action_content_manager_content_2 {
	width:310px;
	float:left;
}
.btnDiv {
	width:902px;
	padding-left:15px;
	padding-top:20px;
	padding-bottom:20px;
	display:inline-flex;
	justify-content:flex-end;
	align-items:center;
}
.button_check {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
	/* margin-right:20px; */
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
	if (window.parent.userId == null) {
		location.replace('/index');
	}
	if (typeof window.parent.loginUser != 'function') {
		location.replace('/index/deviceSearch');
	}
	var actionArr = new Array();
	var source = {
		dataType : "json",
		localdata: actionArr,
		datafields: [
        	{ name: 'idx', type: 'string'},
        	{ name: 'dev_isChk', type: 'bool'},
        	{ name: 'dev_command', type: 'string'},
        	{ name: 'dev_sender', type: 'string'},
        	{ name: 'dev_web_user', type: 'string'},	
        	{ name: 'dev_type', type: 'string'},	
        	{ name: 'dev_ip', type: 'string'},			
        	{ name: 'dev_port', type: 'string'},			
        	{ name: 'dev_mac', type: 'string'},
        	{ name: 'dev_manufacturer', type: 'string'}
		]
	};
	
	var dataAdapter = new $.jqx.dataAdapter(source);
	
	$(".grid").jqxGrid({
		width: '900px',
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
				var boundindex = $(".grid").jqxGrid('getrowboundindex', t);
				$(".grid").jqxGrid('setcellvalue', boundindex, 'dev_idx', false);
			} 
		},
		columns: [
			{ text: getTranslate('idx'), datafield: 'idx', width: '4%', hidden:true},
            {
             text: '', menu: false, sortable: false,
             datafield: 'dev_isChk', columntype: 'checkbox', width: '3%', align: 'center', 
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
                         $(".grid").jqxGrid('setcellvalue', boundindex, 'dev_isChk', event.args.checked);
                     }
                     
                     //$(".grid").jqxGrid('endupdate');
                 });
                 return true;
             }
         },
			{ text: getTranslate('device_ip'), datafield: 'dev_ip', width: '25%', editable: false },
			{ text: getTranslate('device_web_port'), datafield: 'dev_port', width: '22%', editable: false },
			{ text: getTranslate('device_model_name'), datafield: 'dev_manufacturer', width: '25%', editable: false },
			{ text: getTranslate('device_mac'), datafield: 'dev_mac', width: '25%'/* '216.41px' */, editable: false }
		]
	});
	
	var webSocket = new WebSocket("ws://" + "${address}");
	webSocket.onmessage = function(message) {
	// 콘솔 텍스트에 메시지를 출력한다.
		var data = JSON.parse(message.data);
		var command = data.command;
		var web_user = data.web_user;
		if (command == 'RF_RES_DISCOVERY_ONVIF' && web_user == window.parent.userId) {
			var rows = $(".grid").jqxGrid('getrows');
			var isEqual = false;
			for (var i = 0; i < rows.length; i++) {
				if (rows[i].dev_mac == data.mac) {
					isEqual = true;
					break;
				}
			}
			if (!isEqual) {
				var row = { 
	        		dev_isChk: false, dev_command: data.command, dev_sender: data.sender, dev_web_user: data.web_user, dev_type: data.type,
	        		dev_ip: data.ip, dev_port: data.port, dev_mac: data.mac, dev_manufacturer: data.MANUFACTURER
	        	};
				//var rows = $('.grid').jqxGrid('getrows');
				//var rowID = $('.grid').jqxGrid('getrowid', rows.length-1);
				$('.grid').jqxGrid('addrow', null, row);
				if (rows.length == 1) {
					
				}				
			}
		}
	};

	webSocket.onclose = function () {
		console.log('close');
	}
	
	webSocket.onerror = function () {
		console.log('error');
	}
	
	$('#Progress_Loading').hide();
	$('.loading').attr('class','divBody2');
	
	$("#ex6").slider();
	$("#ex6").on("slide", function(slideEvt) {
		$("#ex6SliderVal").text(slideEvt.value);
	});

	var joinRows = new Array();
	
	// When the user clicks the button, open the modal 
	$('#modify').click(function() {
		joinRows = new Array();
		$(this).text(getTranslate('research'));
		var msg = {
			command: 'RF_REQ_DISCOVERY_ONVIF',
			web_user: window.parent.userId,
			sender: 'web'
		};

		// Send the msg object as a JSON-formatted string.
		webSocket.send(JSON.stringify(msg));
	
	});
	
	$('.button_check').click(function(event) {
		var rows = $(".grid").jqxGrid('getrows');
		
		for (var i = 0; i < rows.length; i++) {
			if(rows[i].dev_isChk) {
				joinRows.push(rows[i]);
			}
		}

		for (var i = rows.length - 1; i > -1; i--) {
			if (rows[i].dev_isChk) {
				var rowID = $('.grid').jqxGrid('getrowid', rows[i].uid);
				$('.grid').jqxGrid('deleterow', rowID);
			}
		}
		
		$('.divBody2').hide();

		$('.divBody').show();
		
		if (joinRows.length > 0) {
			var row = joinRows.shift();
		
			//loadPage(row);

			chkChannelByType('ipc', row);
		} else {
			chkChannelByType('ipc', row);
		}
	});
	
	var deviceSource = [];
	deviceSource.push('ipc');
	deviceSource.push('nvr');
	
	var rtspSource = [];
	rtspSource.push('UDP');
	rtspSource.push('TCP');
	
	$('#rtsp_text').jqxDropDownList({source:rtspSource, scrollBarSize:10, autoDropDownHeight: true, width: 355, height: 25, theme: 'metrodark'});

	var idPwdSource = [];
	idPwdSource.push('Empty');
	idPwdSource.push('admin / 12345');

	$('#port_text').jqxDropDownList({source:idPwdSource, scrollBarSize:10, autoDropDownHeight: true, width: 355, height: 25, theme: 'metrodark'});
	
	$('#port_text').on('select', function (event) {
	    var args = event.args;
	    if (args) {
		    var item = args.item;
		    
		    var label = item.label;
		    
		    if (label != 'Empty') {
			    var id = label.split(' / ')[0];
			    var pwd = label.split(' / ')[1];
			    
			    $('#webport_text').val(id);
			    $('#pwd_text').val(pwd);
		    } else {			    
			    $('#webport_text').val('');
			    $('#pwd_text').val('');
		    }
		}                        
	});
	$('#joinDevice').click(function () {
		var item = $("#rtsp_text").jqxDropDownList('getSelectedItem');
		/* if ($('#type_text').val() == '') {
			alert('mac을 입력해주세요.');
			return false;
		} */
		var dev_ch = $("#id_text").jqxDropDownList('getSelectedItem').label;
		if ($('#IP_text').val() == '') {
			alert(getTranslate('enterDeviceTitle'));
			return false;
		}
		if ($('#name_text').val() == '') {
			alert(getTranslate('enterIPDDNS'));
			return false;
		}
		if ($('#password_text').val() == '') {
			alert(getTranslate('enterPort'));
			return false;
		}
		if ($('#webport_text').val() == '') {
			alert(getTranslate('enterId'));
			return false;
		}
		if ($('#pwd_text').val() == '') {
			alert(getTranslate('enterPassword'));
			return false;
		}
		if (item == null) {
			alert(getTranslate('enterRTSP'));
			return false;
		}
		
		var obj = new Object();
		obj.dev_type = 'ipc';
		obj.dev_title = $('#IP_text').val();
		obj.dev_ch = dev_ch;
		obj.port = $('#password_text').val();
		obj.dev_rtsp = item.label;
//		obj.dev_mac = $('#type_text').val();
		obj.dev_manufacturer = $('#IP_text').val();
		
		var msg = {
			command:"RF_REQ_IPCAMERA_INFO",
			sender:"web",
			web_user:window.parent.userId,
			ip:$('#name_text').val(),
			id:$('#webport_text').val(),
			pw:$('#pwd_text').val(),
			title:$('#IP_text').val(),
			port:$('#password_text').val(),
			rtsp:item.label,
			req_info:obj
		};

		// Send the msg object as a JSON-formatted string.
		webSocket.send(JSON.stringify(msg));

		//$("#device_join").
		
		if (joinRows.length > 0) {
			$('.divBody2').hide();

			var row = joinRows.shift();

			//loadPage(row);

			$('.divBody').show();

			/* $('#webport_text').val(''); */
			/* $('#pwd_text').val(''); */
			
			chkChannelByType('ipc', row);
		} else {
			location.href = '/device';
			$('.divBody').hide();
			$('.divBody2').show();

			$("#port_text").jqxDropDownList('selectItem', 'Empty');
			/* $('#webport_text').val('');
			$('#pwd_text').val(''); */
		}

		$('#id_text').text('');
		$('#type_text').val('');
		$('#IP_text').val('');
		$('#name_text').val('');
		$('#password_text').val('');
		$("#rtsp_text").jqxDropDownList('selectItem', 'UDP');
	});

	webSocket.onopen = function () {
		console.log('open');
		$('#modify').click();
	}
	
});

function chkChannelByType(label, row) {
	var jsonUrl = "/chkChannelByType";
	
	var obj = new Object();
	obj.login_id = window.parent.userId;
	obj.dev_type = label;
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json;",       
		data : jsonData,          		     		 
		success: function(data) {
			var arr = data.chList;
			if (data.isJoin) {
				//$('#id_text').text(data.dev_ch);
				//$("#id_text").jqxDropDownList('clear'); 
				$('#id_text').jqxDropDownList({source:arr, selectedIndex:0, scrollBarSize:10, width: 80, height: 25, theme: 'metrodark'});
				$('#IP_text').val('ch' + arr[0]);
				if (row != null) {
					$('#type_text').val(row.dev_mac);
					$('#name_text').val(row.dev_ip);
					$('#password_text').val(row.dev_port);
				}
			} else {
				alert(getTranslate('errorCountExceeded'));
				location.href = '/device';
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
} 
</script>
</head>
<body>
	<div id="Progress_Loading" align="center" > <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" width="30%" style="margin-top:70px;"/>
	</div>
	<div class="divBody" style="display:none;">
		<div class="container status" style="width:600px;padding:0;max-width:1110px;">
			<div class="tmpMargin"></div>
			<div class="id_pwd">
				<div class="id">
					<label class="id_title"><spring:message code="device.channel" /></label>
					<div id="id_text"></div>
				</div>
			</div>
			<div class="type_pwd">
				<div class="type">
					<label class="type_title"><spring:message code="device.mac" /></label>
					<div id="type_text"></div>
				</div>
				<div class="IP">
					<label class="IP_title" for="IP_text"><spring:message code="device.title" /></label>
					<!-- <div id="IP_text"></div> -->
					<input type="text" id="IP_text">
				</div>
			</div>
			<div class="name_password">
				<div class="name">
					<label class="name_title" for="name_text"><spring:message code="device.ip" /></label>
					<input type="text" id="name_text">
				</div>
				<div class="password">
					<label class="password_title" for="password_text"><spring:message code="device.port" /></label>
					<input type="text" id="password_text">
				</div>
			</div>
			<div class="port_webport">
				<div class="port">
					<label class="port_title"><spring:message code="device.idPassword" /></label>
					<div id="port_text"></div>
				</div>
				<div class="webport">
					<label class="webport_title" for="webport_text"><spring:message code="device.id" /></label>
					<input type="text" id="webport_text">
				</div>
			</div>
			<div class="pwd_rtsp">
				<div class="pwd">
					<label class="pwd_title" for="pwd_text"><spring:message code="device.password" /></label>
					<input type="password" id="pwd_text">
				</div>
				<div class="rtsp">
					<label class="rtsp_title"><spring:message code="device.Rtsp" /></label>
					<div id="rtsp_text"></div>
				</div>
			</div>
		</div>
		<div class="container" style="width:600px;padding:0;max-width:1110px;margin-top:30px;margin-bottom:30px;">
			<div class="buttonDiv">
				<button class="button_modify" id="joinDevice"><spring:message code="common.registration" /></button>
			</div>
		</div>
	</div>
	<div class="loading">
		<div class="grid"></div>
		<div class="btnDiv">
			<button class="button_modify" id="modify">
				<spring:message code="common.search" />
			</button>
			<button class="button_check">
				<spring:message code="common.registration" />
			</button>
		</div>
	</div>
</body>
</html>