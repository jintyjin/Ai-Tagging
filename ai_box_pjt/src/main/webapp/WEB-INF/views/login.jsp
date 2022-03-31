<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="./resources/js/jqwidgets/styles/jqx.metro.css" type="text/css" />
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> -->
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxcore.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxinput.js"></script>
<script type="text/javascript" src="./resources/js/jqwidgets/jqxbuttons.js"></script>
<script type="text/javascript" src="/resources/js/translate.js"></script>
<style>
input:focus {
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
html{
	width:100%;
	height:100%;
	margin:0;
	padding:0;
	background-color:#252525;
}
body {
	width:100%;
	height:100%;
	margin:0;
	padding:0;
	color:#fff;
	font-size:14px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	background-color:#252525;
}
.login {
	width:100%;
	height:100%;
	margin:0;
	padding:0;
}
table {
	position:absolute;
	top:50%;
	left:50%;
	margin-left:-160px;
	margin-top:-80px;
	border:none;
}
tr {
	padding:0;
	margin:0;
}
td {
	padding:0;
	margin:0;
}
.user_id_title {
	text-align:right;
	width:76px;
	height:20px;
	padding:0 15px 15px 0;
	margin:0;
}
.user_pwd_title {
	text-align:right;
	width:76px;
	height:20px;
	padding:0 15px 0 0;
	margin:0;
}
.btn {
	margin:0;
	padding:0;
	width:77px;
	height:55px;
	color:#fff;
	background-color:#505050;
	border:none;
	border-radius:3px;
	outline:0;
}
.btn:focus {
	border-color:transparent!important;
	outline:none;
}
.user_id_text {
	padding:0 15px 15px 0;
	margin:0;
	height:100%;
} 
.user_pwd_text {
	padding:0 15px 0 0;
	margin:0;
	height:100%;
} 
.user_id, .user_pwd {
	width:170px;
	height:30px;
	background-color:#505050;
	margin:0;
	padding:0 0 0 3px;
	border:none;
	color:#252525;
	border-radius:3px;
	font-size:14px;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-weight:bold;
	height:20px;
}
</style>
<script type="text/javascript">
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

var Base64 = {

	// private property
	_keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",

	// public method for encoding
	encode : function (input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;

		while (i < input.length) {

		  chr1 = input.charCodeAt(i++);
		  chr2 = input.charCodeAt(i++);
		  chr3 = input.charCodeAt(i++);

		  enc1 = chr1 >> 2;
		  enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
		  enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
		  enc4 = chr3 & 63;

		  if (isNaN(chr2)) {
			  enc3 = enc4 = 64;
		  } else if (isNaN(chr3)) {
			  enc4 = 64;
		  }

		  output = output +
			  this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
			  this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

		}

		return output;
	},

	// public method for decoding
	decode : function (input)
	{
	    var output = "";
	    var chr1, chr2, chr3;
	    var enc1, enc2, enc3, enc4;
	    var i = 0;

	    input = input.replace(/[^A-Za-z0-9+/=]/g, "");

	    while (i < input.length)
	    {
	        enc1 = this._keyStr.indexOf(input.charAt(i++));
	        enc2 = this._keyStr.indexOf(input.charAt(i++));
	        enc3 = this._keyStr.indexOf(input.charAt(i++));
	        enc4 = this._keyStr.indexOf(input.charAt(i++));

	        chr1 = (enc1 << 2) | (enc2 >> 4);
	        chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
	        chr3 = ((enc3 & 3) << 6) | enc4;

	        output = output + String.fromCharCode(chr1);

	        if (enc3 != 64) {
	            output = output + String.fromCharCode(chr2);
	        }
	        if (enc4 != 64) {
	            output = output + String.fromCharCode(chr3);
	        }
	    }

	    return output;
	}
}
/* function setUserLogin(level, userdata, deviceid) {
	sessionStorage.setItem('userlevel', level);
	if(userdata != null)
		sessionStorage.setItem('userdata', JSON.stringify(userdata));
	sessionStorage.setItem('deviceid', deviceid);
} */
function setUserLogin(level, userdata) {
	sessionStorage.setItem('userlevel', level);
	if(userdata != null)
		sessionStorage.setItem('userdata', JSON.stringify(userdata));
}
function get(key) {
	return sessionStorage.getItem(key);
}
$(document).ready(function (){
	if (typeof window.parent.loginUser != 'function') {
		location.replace('index');
	}
	$(".user_id").focus();
	
	$('input').keyup(function(e) {
		if (e.keyCode == 13) $(".btn").click();
	});
	
	$(".btn").click(function () {
		if($('.user_id').val() == '') {
			alert(getTranslate('enterId'));
			$(".user_id").focus();
			return;
		}

		if($('.user_pwd').val() == '') {
			alert(getTranslate('enterPassword'));
			$(".user_pwd").focus();
			return;
		}
		
		var user_id = $('.user_id').val();
		var user_pw = SHA256($('.user_pwd').val());
		
		window.parent.loginUser(user_id, user_pw);
		
		/* var obj = new Object();
		obj.command = "RINFRA_LOGIN";
		obj.user_id = $('.user_id').val();
		obj.user_pw = SHA256($('.user_pwd').val());
		
		obj.app_type = "W";
		
		var jsonData = JSON.stringify(obj);
		var jsonUrl = "/loginList";
		
		$.ajax({
			type : "POST",
			dataType : "json",
			contentType : "application/json;charset=UTF-8",
			url : jsonUrl,
			data : jsonData,
			success : function(data) {
				if (data.return == "incorrect") {
					alert(getTranslate('wrongIDorPassword'));
				} else if (data.return == "null") {
					alert(getTranslate('specifyNewPassword'));
				} else if (data.return == "success") {
					alert(getTranslate('welcome') + data.user_id + getTranslate('sir'));
					setUserLogin(data.user_level, data);
					$(window.parent.location).attr('href', './index.htm');
				}
			},
			error : function(request, status, error) {
				alert(getTranslate('errorLogin'));
			}
		}); */
	});
});
</script>
</head>
<body>
<div class="login">
	<table>
		<tr>
			<td class="user_id_title">ID</td>
			<td class="user_id_text">
				<input type="text" class="user_id" />
			</td>
			<td rowspan="2">
				<button class="btn">Login</button>
			</td>
		</tr>
		<tr>
			<td class="user_pwd_title">PASSWORD</td>
			<td class="user_pwd_text">
				<input type="password" class="user_pwd" />
			</td>
		</tr>
	</table>
</div>
</body>
</html>