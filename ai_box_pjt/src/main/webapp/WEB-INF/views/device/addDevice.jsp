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
	width:33%;
	overflow:auto;
	padding-bottom:80px;
	float:left;
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
.text-box {
	width:365px;
	padding-top:5px;
	padding-right:15px;
	padding-left:5px;
	float:right;
	background-color:#505050;
	color:#fff;
	/* height:23px; */
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
    var web_user = JSON.parse(get('userdata')).user_id;
	var webSocket = new WebSocket("ws://" + "${address}");
    //var rtsp_url = "${dev_rtsp_url}";

    if (web_user == 'admin') {
    	web_user = "${login_id}";
    }
    
	var isCheck = false;
	var IPCheck = false;
	var checkId = "";
	var checkTokken = "";

	var deviceSource = [];
	deviceSource.push('ipc');
	deviceSource.push('nvr');
	
	var rtspSource = [];
	rtspSource.push('UDP');
	rtspSource.push('TCP');
	
	var index = 1;
	if ("${dev_rtsp}" == 'UDP') {
		index = 0;
	}
	
	$('#rtsp_text').jqxDropDownList({selectedIndex: index, source:rtspSource, scrollBarSize:10, autoDropDownHeight: true, width: 355, height: 25, theme: 'metrodark'});

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

	$('#id_text').text("${dev_ch}");
	$('#type_text').text("${dev_mac_address}");

	$('#IP_text').val("${dev_title}");
	$('#name_text').val("${dev_ip}");
	
	$('#password_text').val("${dev_web_port}");
	
	$('#webport_text').val("${dev_id}");
	$('#pwd_text').val("${dev_pwd}");


	$('#falldown').val("${falldown}");
	$('#fire').val("${fire}");
	$('#flood').val("${flood}");
	$('#glove').val("${glove}");
	$('#invasion').val("${invasion}");
	$('#leak').val("${leak}");
	$('#loitering').val("${loitering}");
	$('#signal').val("${hadnaction}");
	$('#spin').val("${spin}");

	$('#cmtank').val("${cmtank}");
	$('#outtank').val("${outtank}");
	$('#overflow').val("${overflow}");

    //$("#pwd_text").jqxDropDownList('selectItem','Empty');
    //$("#rtsp_text").jqxDropDownList('selectItem',"${dev_rtsp}");
    
	//$('#type_text').val(row.dev_mac);
	
	$('#joinDevice').click(function () {
		var item = $("#rtsp_text").jqxDropDownList('getSelectedItem');
		/* if ($('#type_text').val() == '') {
			alert('mac을 입력해주세요.');
			return false;
		} */
		if ($('#IP_text').val() == '') {
			alert('장치 이름을 입력해주세요.');
			return false;
		}
		if ($('#name_text').val() == '') {
			alert('IP/DDNS를 입력해주세요.');
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
		if (item == null) {
			alert('RTSP를 선택해주세요.');
			return false;
		}

		var msg = {
			command:"RF_REQ_IPCAMERA_UPDATE",
			sender:"web",
			web_user:web_user,
			login_id:web_user,
			dev_mac:$('#type_text').text(),
			dev_ip:$('#name_text').val(),
			dev_id:$('#webport_text').val(),
			dev_pwd:$('#pwd_text').val(),
			dev_title:$('#IP_text').val(),
			dev_port:$('#password_text').val(),
			dev_rtsp:item.label,
			dev_title:$('#IP_text').val(),
			dev_ch:$('#id_text').text(),
			port: $('#password_text').val(),
			dev_rtsp: item.label,
			dev_manufacturer: $('#IP_text').val(),
			
			dev_falldown: $('#falldown').val(),
			dev_fire : $('#fire').val(),
			dev_flood : $('#flood').val(),
			dev_glove : $('#glove').val(),
			dev_invasion : $('#invasion').val(),
			dev_leak : $('#leak').val(),
			dev_loitering : $('#loitering').val(),
			dev_handaction : $('#signal').val(),
			dev_spin : $('#spin').val(),
			
			dev_cmtank : $('#cmtank').val(),
			dev_outtank : $('#outtank').val(),
			dev_overflow : $('#overflow').val()
		};

		// Send the msg object as a JSON-formatted string.
		webSocket.send(JSON.stringify(msg));

		self.close();		
		parent.opener.location.reload();
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
		<div class="container status" style="width:600px;padding:0;max-width:1110px;">
			<div class="tmpMargin"></div>
			<div class="id_pwd">
				<div class="id">
					<label class="id_title">채널</label>
					<div id="id_text"></div>
				</div>
			</div>
			<div class="type_pwd">
				<div class="type">
					<label class="type_title">mac</label>
					<div id="type_text"></div>
				</div>
				<div class="IP">
					<label class="IP_title" for="IP_text">장치 이름</label>
					<!-- <div id="IP_text"></div> -->
					<input type="text" id="IP_text">
				</div>
			</div>
			<div class="name_password">
				<div class="name">
					<label class="name_title" for="name_text">IP/DDNS</label>
					<input type="text" id="name_text">
				</div>
				<div class="password">
					<label class="password_title" for="password_text">포트</label>
					<input type="text" id="password_text">
				</div>
			</div>
			<div class="port_webport">
				<div class="port">
					<label class="port_title">ID/PW</label>
					<div id="port_text"></div>
				</div>
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
				<div class="rtsp">
					<label class="rtsp_title">RTSP</label>
					<div id="rtsp_text"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="divBody">
		<div class="container status" style="width:600px;padding:0;max-width:1110px;">
			<div class="tmpMargin"></div>
			<div class="id_pwd">
				<div class="name">
					<label class="name_title" for="falldown">쓰러짐</label>
					<input class="text-box" type="text" id="falldown">
				</div>
				<div class="password">
					<label class="password_title" for="fire">화재</label>
					<input class="text-box" type="text" id="fire">
				</div>
				<div class="name">
					<label class="name_title" for="flood">침수</label>
					<input class="text-box" type="text" id="flood">
				</div>
				<div class="password">
					<label class="password_title" for="glove">장갑미착용</label>
					<input class="text-box" type="text" id="glove">
				</div>
				<div class="name">
					<label class="name_title" for="invasion">침입</label>
					<input class="text-box" type="text" id="invasion">
				</div>
				<div class="password">
					<label class="password_title" for="leak">누수</label>
					<input class="text-box" type="text" id="leak">
				</div>
				<div class="name">
					<label class="name_title" for="loitering">배회</label>
					<input class="text-box" type="text" id="loitering">
				</div>
				<div class="password">
					<label class="password_title" for="signal">수신호</label>
					<input class="text-box" type="text" id="signal">
				</div>
				<div class="name">
					<label class="name_title" for="spin">약품미투입</label>
					<input class="text-box" type="text" id="spin">
				</div>
			</div>
		</div>
		<div class="container" style="width:600px;padding:0;max-width:1110px;margin-top:30px;margin-bottom:30px;">
			<div class="buttonDiv">
				<button class="button_modify" id="joinDevice">등록</button>
			</div>
		</div>
	</div>
	<div class="divBody">
		<div class="container status" style="width:600px;padding:0;max-width:1110px;">
			<div class="tmpMargin"></div>
			<div class="id_pwd">
				<div class="password">
					<label class="password_title" for="cmtank">약품탱크 누액</label>
					<input class="text-box" type="text" id="cmtank">
				</div>
				<div class="name">
					<label class="name_title" for="outtank">옥외탱크 누액</label>
					<input class="text-box" type="text" id="outtank">
				</div>
				<div class="password">
					<label class="password_title" for="overflow">배출수 월류</label>
					<input class="text-box" type="text" id="overflow">
				</div>
			</div>
		</div>
	</div>
</body>
</html>