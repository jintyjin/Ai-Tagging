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
	width:552px;
	float:left;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:15px;
}
.name_title {
	width:150px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	background-color:#3e3e42;
	color:#fff;
}
#name_text {
	width:365px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	float:right;
	background-color:#505050;
	color:#fff;
	/* height:23px; */
}
.phone {
	width:552px;
	float:left;
	padding-right:15px;
	padding-left:15px;
	margin-bottom:15px;
}
.phone_title {
	width:150px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	background-color:#3e3e42;
	color:#fff;
}
#phone_text {
	width:365px;
	float:right;
	/* padding-top:5px; */
	padding-right:15px;
	padding-left:15px;
	padding-bottom:0;
	background-color:#505050;
	color:#fff;
}
.id {
	width:552px;
	float:left;
	padding-right:18px;
	padding-left:15px;
	margin-bottom:15px;
}
.id_title {
	width:150px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	background-color:#3e3e42;
	color:#fff;
}
.idDiv {
	float:right;
	width:365px;
}
#id_text {
	width:260px;
	padding-right:15px;
	padding-left:15px;
	margin:0;
	background-color:#505050;
	color:#fff;
	padding-bottom:0;
}
.pwd {
	width:552px;
	float:left;
	padding-right:15px;
	padding-left:15px;
	margin-bottom:15px;
}
.pwd_title {
	width:150px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	background-color:#3e3e42;
	color:#fff;
}
#pwd_text {
	float:right;
	width:365px;
	padding-right:15px;
	padding-left:15px;
	padding-bottom:0;
	background-color:#505050;
	color:#fff;
}
.email_tokken {
	width:100%;
}
.email {
	width:524px;
	float:left;
	padding-right:15px;
	padding-left:15px;
	margin-bottom:15px;
}
.email_title {
	width:150px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	background-color:#3e3e42;
	color:#fff;
}
#email_text {
	width:340px;
	padding-right:15px;
	padding-left:15px;
	float:right;
	background-color:#505050;
	color:#fff;
}
.tokken {
	width:601px;
	float:left;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:15px;
}
.tokken_title {
	width:150px;
	padding-top:5px;
	padding-right:15px;
	padding-left:15px;
	background-color:#3e3e42;
	color:#fff;
}
.tokkenDiv {
	float:right;
	width:413px;
}
#tokken_text {
	width:260px;
	padding-right:15px;
	padding-left:15px;
	margin:0;
	background-color:#505050;
	color:#fff;
	padding-bottom:0;
}
/* .modify {
	width:8%;
	height:40px;
	margin-left:15px;
	margin-right:15px;
	padding:0;
	border:none;
	background-color:#505050;
	color:#252525;
	font-size:20px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	border-radius:3px;
}
.delete {
	width:8%;
	height:40px;
	margin-left:15px;
	margin-right:15px;
	padding:0;
	border:none;
	background-color:#505050;
	color:#252525;
	font-size:20px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	border-radius:3px;
} */
.add {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.add:hover {
	color:#1c97ea;
}
.check {
	width:14px;
	height:14px;
	font-size:14px;
	font-weight:bold;
	margin-right:8px;
}
.cancel {
	width:100px;
	height:30px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.cancel:hover {
	color:#1c97ea;
}
.id_check {
	width:100px;
	height:25px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.id_check:hover {
	color:#1c97ea;
}
.tokken_message {
	width:100px;
	height:25px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.tokken_message:hover {
	color:#1c97ea;
}
.tokken_help {
	width:25px;
	height:25px;
	background-color: transparent;
	margin:0;
	padding:0;
	border:1px solid #35353A;
}
.tokken_help:hover {
	color:#1c97ea;
}
.level {
	width:552px;
	float:left;
	padding-right:19px;
	padding-left:15px;
	margin-bottom:15px;
}
.level_title {
	width:150px;
	padding-top:5px;
	margin-right:4px;
	padding-left:15px;
	background-color:#3e3e42;
	color:#fff;
	float:left;
}
#level_text {
	width:340px;
	height:25px;
	padding-left:15px;
	border:none;
	display:flex;
}
.channel {
	width:552px;
	float:left;
	padding-left:15px;
	padding-right:19px;
	margin-bottom:15px;
}
.channel_title {
	width:150px;
	padding-top:5px;
	margin-right:7px;
	padding-left:15px;
	background-color:#3e3e42;
	color:#fff;
	float:left;
}
#channel_text {
	width:340px;
	height:25px;
	padding-left:15px;
	border:none;
	display:flex;
}
.jqx-grid-metrodark .jqx-widget-header-metrodark, .jqx-grid-column-header-metrodark, .jqx-grid-cell-metrodark, .jqx-widget-metrodark .jqx-grid-cell-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:white;
}
.jqx-fill-state-normal-metrodark, .jqx-fill-state-hover-metrodark, .jqx-widget-content-metrodark {
	font-size:14px;
	font-weight: bold;
}
.jqx-fill-state-normal-metrodark {
	background-color:#505050;
}

.jqx-widget-content-metrodark {
	border:none;
}
.jqx-widget-content-metrodark {
	background-color:#3e3e42;
}
/* #sampleModalPopup {
}
.modal-dialog {
	margin:0;
} */
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

$(document).ready(function () {
	var isCheck = false;
	var tokkenCheck = false;
	var checkId = "";
	var checkTokken = "";

	var jsonUrl = "/deviceList";
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",       
		success: function(data) {
			var devArr = new Array();
			
			for (var j = 0; j < data.length; j++) {
				var devObj = new Object();
				devObj.text = data[j].dev_title;
				devObj.value = data[j].dev_ch;
				
				devArr.push(devObj); 
			}
			
			$('#channel_text').jqxDropDownList({displayMember: 'text', valueMember: 'value', checkboxes:true, source:devArr, scrollBarSize:5, width: 250, height: 25, theme: 'metrodark'});
		},
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(JSON.stringify(data));
		}
	});

	var categorySource = [];

	var levelObj = new Object();
	levelObj.text = getTranslate('admin');
	levelObj.value = 'A';
	
	categorySource.push(levelObj);
	
	levelObj = new Object();
	levelObj.text = getTranslate('user');
	levelObj.value = 'U';

	categorySource.push(levelObj);

	$('#level_text').jqxDropDownList({source:categorySource, selectedIndex:1, displayMember: 'text', valueMember: 'value', scrollBarSize:5, autoDropDownHeight: true,  width: 200, height: 25, theme: 'metrodark'});
	$('.tokken_help').click(function () {
		/* var url = "./resources/Line%20Help.htm";
		
		$("#sampleModalPopup > .modal-dialog").load(url, function() { 
            $("#sampleModalPopup").modal("show"); 
        }); */
        
		if(popup_window[POPUP_MORE] && !popup_window[POPUP_MORE].closed)
			popup_window[POPUP_MORE].close();

		popup_window[POPUP_MORE] = openWindow('./resources/Line%20Help.htm', 'LINE', 1400, 880);
	});
		
	$('.add').click(function () {
		console.log(SHA256($('#pwd_text').val()));
		return false;
		if($('#name_text').val() == '') {
			alert(getTranslate('enterName'));
			$("#name_text").focus();
			return;
		}
		if($('#phone_text').val() == '') {
			alert(getTranslate('enterPhone'));
			$("#phone_text").focus();
			return;
		}
		if($('#id_text').val() == '') {
			alert(getTranslate('enterId'));
			$("#id_text").focus();
			return;
		}
		if($('#pwd_text').val() == '') {
			alert(getTranslate('enterPassword'));
			$("#pwd_text").focus();
			return;
		}
		if($('#email_text').val() == '') {
			alert(getTranslate('enterEmail'));
			$("#email_text").focus();
			return;
		}

		if(!isCheck) {
			alert(getTranslate('checkDuplicate'));
			return;
		} else {
			if (checkId != $('#id_text').val()) {
				alert(getTranslate('checkDuplicate'));
				return;
			}
		}

		/* if(!tokkenCheck && checkTokken != '') {
			alert("토큰 테스트를 해주세요");
			return;
		} else {
			if (checkTokken != $('#tokken_text').val()) {
				alert('토큰 테스트를 해주세요');
				return;
			}
		} */
		
		var jsonUrl = "/addUser";
		var obj = new Object();

		obj.user_id = $('#id_text').val();
		obj.user_pw = SHA256($('#pwd_text').val());
		obj.user_name = $('#name_text').val();
		obj.user_phone = $('#phone_text').val();
		obj.user_email = $('#email_text').val();
		obj.user_tokken = $('#tokken_text').val();
		obj.user_isadmin = $("#level_text").jqxDropDownList('getSelectedItem').value;
		obj.user_channel = $("#channel_text").val();
		obj.user_tokken_isuse = 'N';

		/* if (!tokkenCheck || (checkTokken != $('#tokken_text').val())) {
			obj.user_tokken_isuse = 'N';
		} else {
			obj.user_tokken_isuse = 'Y';
		}
		 */
		var jsonData = JSON.stringify(obj);
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "text",                        	  
			contentType : "application/json; charset=UTF-8",       
			data : jsonData,          		     		 
			success: function() {
				alert(getTranslate('completeResigtration'));		
				self.close();		
				parent.opener.location.reload();
			},
			error: function(errorThrown) {
				alert(errorThrown.statusText);
				alert(JSON.stringify(data));
			}
		}); 
	});
	$('.cancel').click(function () {
		self.close();
	});
	$('.id_check').click(function () {
		var jsonUrl = '/chkUserId';
		
		if($('#id_text').val() == '') {
			alert(getTranslate('enterId'));
			$("#id_text").focus();
			return;
		}
		
		var jsonData = $('#id_text').val();
		
		$.ajax({
			type : "POST",                        	 	     
			url : jsonUrl,                      		
			dataType : "text",                        	  
			contentType : "application/json; charset=UTF-8",       
			data : jsonData,          		     		 
			success: function(data) {
				if (data != '') {
					isCheck = false;
					checkId = data.user_id;
					alert(getTranslate('notAvailable'));
				} else {
					isCheck = true;
					checkId = $('#id_text').val();
					alert(getTranslate('available'));					
				}
			},
			error: function(errorThrown) {
				alert(errorThrown.statusText);
			}
		});
	});
	$('.tokken_message').click(function () {
		if ($('#tokken_text').val().length > 0) {
			var jsonUrl = "/chkTokken";
			
			var obj = new Object();
			obj.user_tokken = $('#tokken_text').val();
			
			var jsonData = JSON.stringify(obj);
			
			$.ajax({
				type : "POST",                        	 	     
				url : jsonUrl,                      		
				dataType : "text",                        	  
				contentType : "application/json; charset=UTF-8",       
				data : jsonData,          		     		 
				success: function(data) {
					if (data == '{"status":200,"message":"ok"}') {
						tokkenCheck = true;
						checkTokken = $('#tokken_text').val();
						alert(getTranslate('success'));
					} else if (data == "400") {
						alert(getTranslate('unauthorizedRequest'));					
					} else if (data == "401") {
						alert(getTranslate('invalidAccess'));					
					} else if (data == "500") {
						alert(getTranslate('serverError'));					
					} else {
						alert(getTranslate('overTimeError'));
					}		
				},
				error: function(errorThrown) {
					alert(errorThrown.statusText);
					alert(JSON.stringify(data));
				}
			});
		} else {
			alert(getTranslate('enterDuplicateCheck'));
		}
	});
});
function closePopupChild() {
	for(var i = 0; i < popup_window.length; i++) {
		if(popup_window[i] && popup_window[i].open && !popup_window[i].closed)
			popup_window[i].close();
	}
}
</script>
</head>
<body onunload="closePopupChild();">
	<div class="divBody">
		<div class="container status" style="width:1110px;padding:0;max-width:1110px;">
			<div class="tmpMargin"></div>
			<div class="name_phone">
				<div class="name">
					<label class="name_title" for="name_text"><spring:message code="user.name" /></label>
					<input type="text" id="name_text">
				</div>
				<div class="phone">
					<label class="phone_title"><spring:message code="user.phone" /></label>
					<input type="text" id="phone_text">
				</div>
			</div>
			<div class="id_pwd">
				<div class="id">
					<label class="id_title" for="id_text"><spring:message code="user.id" /></label>
					<div class="idDiv">
						<input type="text" id="id_text">
						<button class="id_check"><spring:message code="common.duplicateCheck" /></button>
					</div>
				</div>
				<div class="pwd">
					<label class="pwd_title"><spring:message code="user.password" /></label>
					<input type="password" id="pwd_text">
				</div>
			</div>
			<div class="level_channel">
				<div class="level">
					<label class="level_title" for="level_text"><spring:message code="user.setupAuthority" /></label>
					<div id="level_text"></div>
				</div>
				<div class="channel">
					<label class="channel_title" for="channel_text"><spring:message code="user.liveAuthority" /></label>
					<div id="channel_text"></div>
				</div>
			</div>
			<div class="email_tokken">
				<div class="email">
					<label class="email_title" for="email_text"><spring:message code="user.email" /></label>
					<input type="text" id="email_text" class="text">
				</div>
				<!-- <div class="tokken">
					<label class="tokken_title" for="tokken_text">LINE Token</label>
					<div class="tokkenDiv">
						<input type="text" id="tokken_text" class="text">
						<button class="tokken_message">테스트</button>
						<button class="tokken_help">?</button>
					</div>
				</div> -->
			</div>
		</div>
		<div class="container" style="width:1110px;padding:0;max-width:1110px;margin-top:30px;margin-bottom:30px;">
			<div style="width:50%; float:left; writing-mode:vertical-rl; padding-right:20px; margin-bottom:30px;">
				<button class="add">
				<span class="glyphicon glyphicon-plus check" aria-hidden="true"></span><spring:message code="common.add" /></button>
			</div>
			
			<div style="width:50%; float:left; padding-left:20px; margin-bottom:30px;">
				<button class="cancel"><spring:message code="common.close" /></button>
			</div>
		</div>
	</div>
	<!-- <div class="modal fade" id="sampleModalPopup" role="dialog" tabindex="-1">
	    <div class="modal-dialog modal-dialog-width1000 modal-dialog-height800">
	        <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
	        </div>
	        <div class="modal-body">
	        </div>
	        <div class="modal-footer">
	            <button type="button" name="button" class="btn btn-color2" data-dismiss="modal" >닫기</button>
	        </div>
	    </div>
	</div> -->
</body>
</html>