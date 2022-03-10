<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.base.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metro.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.metrodark.css" type="text/css" />
<link rel="stylesheet" href="/resources/js/jqwidgets/styles/jqx.dark.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"> -->
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
<script type="text/javascript" src="/resources/js/jqwidgets/jqxdata.export.js"></script> 
<script type="text/javascript" src="/resources/js/jqwidgets/jqxexport.js"></script> 
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<script type="text/javascript" src="/resources/js/translate.js"></script>
<style>
body {
	background-color: #252525;
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:white;
	line-height: 1.5;
}
.jqxgrid-center-jin {
	overflow: hidden; 
	text-overflow: ellipsis; 
	text-align: center; 
	line-height: 32px;
}
.jqx-fill-state-normal-metrodark {
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
.jqx-grid-metrodark .jqx-widget-header-metrodark, .jqx-grid-column-header-metrodark, .jqx-grid-cell-metrodark, .jqx-widget-metrodark .jqx-grid-cell-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size:14px;
	font-weight: bold;
	color:#fff;
}
.jqx-widget-content-metrodark {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:#fff;
}
.jqx-widget-content-metrodark:placeholder {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:#fff;
}
</style>
<script type="text/javascript">
//var mainUrl = "https://" + window.location.hostname;

var jsonUrl = "/event/list";
//var websocketUrl = 'http://211.117.45.3:20101/websocket';
var websocketUrl = '/websocket';

function isEmpty(str) {
	if(typeof str === "undefined" || str === null || str == "" || str == "undefined")
		return true;
	else
		return false;
}

function get(key) {
	return sessionStorage.getItem(key);
}

function openWindow(page, pageName, width, height) {
	var popupX = (screen.availWidth - width) / 2;
	var popupY = (screen.availHeight - height) / 2;
	var scrollbars = (pageName == 'webNoticeAdd' || pageName == 'webNoticeModify') ? 'yes' : 'no';

	var popup_window = window.open(page, pageName, 'width=' + width + ', height=' + height + ', toolbar=no, location=no, status=no, menubar=no, scrollbars=' + scrollbars + ', resizable=yes, left=' + popupX + ', top=' + popupY);

	return popup_window;
}
function setMonitoring(searchdate) {
	sessionStorage.setItem('searchdate', searchdate);
}
function setTime(time) {
	sessionStorage.setItem('time', time);
}
function openWeb(get_str, ip, port) {
	var url = '';

	/* var ip = '211.117.45.82';
	//var ip = '112.162.33.159';	
	
	url += 'https://';
	
	url += ip;
	
	url += (':' + '8080');
	
	//url += '/cgi-bin/login_chk.cgi';
	url += '/cgi-bin/login.cgi'; */
	
	//window.open(url, '_blank');
	
	//url += 'https://211.117.45.82:8000/cgi-bin/login.cgi';
	url += 'http://' + ip + ':' + port + '/cgi-bin/login_chk.cgi';	// 추후에 https로 수정 예정
	var form = document.createElement('form');
	form.setAttribute('method', 'post');
	form.setAttribute('action', url);
	form.setAttribute('target', '_blank');
	document.body.appendChild(form);

	var insert = document.createElement('input');
	insert.setAttribute('type', 'hidden');
	insert.setAttribute('name', 'me');
	insert.setAttribute('value', get_str);

	form.appendChild(insert);
	form.submit();
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
	decode : function (input) {
	    var output = "";
	    var chr1, chr2, chr3;
	    var enc1, enc2, enc3, enc4;
	    var i = 0;

	    input = input.replace(/[^A-Za-z0-9+/=]/g, "");

	    while (i < input.length) {
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
function get_me_str(d1, d2, d3, d4) {
	var str = '';

	d3 = d3.toString();
	d4 = d4.replace(/:/gi, '').toLowerCase();
//	if(d2 != "") d2 = SHA256(d2);

	var d1_l = d1.length < 10?("0" + d1.length):d1.length;
	var d2_l = d2.length < 10?("0" + d2.length):d2.length;
	var d3_l = d3.length < 10?("0" + d3.length):d3.length;
	var d4_l = d4.length < 10?("0" + d4.length):d4.length;
	var str = '' + d1_l + d1 + d2_l + d2 + d3_l + d3 + d4_l + d4;

	return Base64.encode(str);
}
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
function connectViewer(row) {
	var data = $('#grid').jqxGrid('getrowdata', row);
	
	var ip = data.dev_ip;

	var viewer_url = '';
	var viewer_path = '';
	var mainUrl = 'https://' + window.location.hostname;
	var RMS_INSTALLER_PATH = './resources/download/NETUS_NETUS-Lite_v.1.0.0.47_x64-Setup.exe';
	//var RMS_INSTALLER_PATH = '/download/rms_installer.exe';
	
	viewer_url = 'NetusLiteViewer64://sigma?policy=' + 'a' + '&ip=' + ip + '&port=' + data.dev_port + '&id=' + data.dev_id + '&hash=' + SHA256(data.dev_pwd) + '&newver=' + '1.0.0.47' + '&newurl=' + encodeURIComponent(mainUrl + RMS_INSTALLER_PATH);

	console.log(viewer_url);
	
	viewer_path = RMS_INSTALLER_PATH;

	try {
	    var objWSH = new ActiveXObject("WScript.Shell");
	    var retval = objWSH.Run(viewer_url);
	} catch (Exception) {
		alert("다운로드 해야합니다.")
		location.href = viewer_path;
		/* var download = document.createElement('a');
		download.href = viewer_path;
		download.click(); */
	}
	
	/* try {
		location.href = viewer_url;
	} catch (exception) {
		alert("다운로드 해야합니다.")
		var download = document.createElement('a');
		download.href = viewer_path;
		download.click();
	} */
	
	/* var link = document.createElement('div');
	link.href = '#';
	link.addEventListener('click', function() {
		this.setAttribute('href', viewer_url);
		window.protocolCheck(this.getAttribute('href'), function() {}, function() {
			alert('프로그램을 다운로드하여야 합니다.');
			var download = document.createElement('a');
			download.href = viewer_path;
			download.click();
		});
	});
	link.click(); */
}
(function (window) {
	function _createHiddenIframe(target, uri) {
        var iframe = document.createElement("iframe");
        iframe.src = uri;
        iframe.id = "hiddenIframe";
        iframe.style.display = "none";
        target.appendChild(iframe);
        return iframe;
    }
	function openUriWithMsLaunchUri(uri, successCb, failCb) {
        navigator.msLaunchUri(uri,
            successCb,
            failCb
        );
    }
	function _registerEvent(target, eventType, cb) {
        if (target.addEventListener) {
            target.addEventListener(eventType, cb);
            return {
                remove: function () {
                    target.removeEventListener(eventType, cb);
                }
            };
        } else {
            target.attachEvent(eventType, cb);
            return {
                remove: function () {
                    target.detachEvent(eventType, cb);
                }
            };
        }
    }
	function openUriWithTimeoutHack(uri, successCb, failCb) {

        var timeout = setTimeout(function () {
            failCb();
            handler.remove();
        }, 1000);

        var handler = _registerEvent(window, "blur", onBlur);

        function onBlur() {
            clearTimeout(timeout);
            handler.remove();
            successCb()
        }
        window.location = uri;
    }
	function openUriUsingIEInOlderWindows(uri, successCb, failCb) {
        if (getInternetExplorerVersion() === 10) {
            openUriUsingIE10InWindows7(uri, successCb, failCb);
        } else if (getInternetExplorerVersion() === 9 || getInternetExplorerVersion() === 11) {
            openUriWithHiddenFrame(uri, successCb, failCb);
        } else {
            openUriInNewWindowHack(uri, successCb, failCb);
        }
    }
	function openUriUsingFirefox(uri, successCb, failCb) {
        var iframe = document.querySelector("#hiddenIframe");
        if (!iframe) {
            iframe = _createHiddenIframe(document.body, "about:blank");
        }
        try {
            iframe.contentWindow.location.href = uri;
            successCb();
        } catch (e) {
            if (e.name == "NS_ERROR_UNKNOWN_PROTOCOL") {
                failCb();
            }
            else {
                successCb();
            }
        }
    }
	function checkBrowser() {
        var isOpera = !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
        return {
            isOpera: isOpera,
            isFirefox: typeof InstallTrigger !== 'undefined',
            isSafari: Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0,
            isChrome: !!window.chrome && !isOpera,
            isIE: /*@cc_on!@*/false || !!document.documentMode   // At least IE6
        }
    }
	window.openUriWithTimeoutHack = openUriWithTimeoutHack;
	window.protocolCheck = function (uri, successCb, failCb) {
	    function successCallBack() {
	        successCb && successCb();
	    }
	    function failCallback() {
	        failCb && failCb();
	    }

	    if (navigator.msLaunchUri) { 
	        openUriWithMsLaunchUri(uri, successCb, failCb);
	    } else {
	        var browser = checkBrowser();
	
	        if (browser.isFirefox) {
	            openUriUsingFirefox(uri, successCallBack, failCallback);
	        } else if (browser.isChrome) {
	            openUriWithTimeoutHack(uri, successCallBack, failCallback);
	        } else if (browser.isIE) {
	            openUriUsingIEInOlderWindows(uri, successCallBack, failCallback);
	        } else {
	            //not supported, implement please
	        }
	    }
    }
}(window));

$(document).ready(function(){
	$('#Progress_Loading').hide(); //첫 시작시 로딩바를 숨겨준다.
	$('#as_count').hide();
	$('#calendar').hide();
	$('#excelExport').hide();
})
.ajaxStart(function(){
	$('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.
	$('#as_count').hide();
	$('#calendar').hide();
	$('#excelExport').hide();
})
.ajaxStop(function(){
	$('#Progress_Loading').hide(); //ajax종료시 로딩바를 숨겨준다.
	$('#as_count').show();
	$('#calendar').show();
	//$('#excelExport').show();
});
$(document).ready(function () {
	var obj = new Object();
	obj.count = "100";
	
	var ascount = 0;
	
	var rowarray = [];
	
	var jsonData = JSON.stringify(obj);
	
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",         
		data : jsonData,          		   
	    success: function(data) {
	    	data = JSON.parse("[" + data + "]");
	    	
	    	ascount = data.length;

	    	for (var i = 0; i < data.length; i++) {
				data[i].event_source = getTranslate(data[i].event_source);
				data[i].event_name2 = getTranslate(data[i].event_name.toLowerCase().split('_')[1]);
	    	}
	    	
	    	var SKEY_REQUEST = 'REQUEST';
	    	$('#as_count').text('AS ' + SKEY_REQUEST + ' : ' + ascount); 
	    	
			var source = {
				dataType : "json",
				localdata:  data,
				datafields: [
		        	{ name: 'event_source', type: 'string'},
		        	{ name: 'dev_ip', type: 'string'},
		        	{ name: 'dev_channel', type: 'string'},
		        	{ name: 'event_name', type: 'string'},
		        	{ name: 'event_time', type: 'string'},
		        	{ name: 'event_info', type: 'string'},
		        	{ name: 'dev_id', type: 'string'},
		        	{ name: 'dev_pwd', type: 'string'},
		        	{ name: 'dev_port', type: 'string'},
		        	{ name: 'dev_web_port', type: 'string'},
		        	{ name: 'event_name2', type: 'string'}
				]
			};
				
			var dataAdapter = new $.jqx.dataAdapter(source);
			
			$("#grid").jqxGrid( {
				width: '100%',
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
				columns: [
					{ text: getTranslate('event_source'), datafield: 'event_source', width: '19%', editable: false },
					{ text: getTranslate('device_ip'), datafield: 'dev_ip', width: '17%', editable: false },
					{ text: getTranslate('channel'), datafield: 'dev_channel', width: '8%', editable: false },
					{ text: getTranslate('event_name'), datafield: 'event_name', width: '13%', editable: false, hidden:true},
					{ text: getTranslate('event_name'), datafield: 'event_name2', width: '13%', editable: false },
					{ text: getTranslate('event_time'), datafield: 'event_time', width: '20%', editable: false },
					{ text: getTranslate('event_info'), datafield: 'event_info', width: '15%', editable: false },
					{ datafield: 'dev_id', editable: false, hidden:true },
					{ datafield: 'dev_pwd', editable: false, hidden:true },
					{ datafield: 'dev_port', editable: false, hidden:true },
					{ datafield: 'dev_web_port', editable: false, hidden:true },
					{ text: getTranslate('popup'), columntype: 'button', align: 'center', width: '8%', editable: false, sortable: false, filterable: false, cellsrenderer: function () {
						return getTranslate('display');
					},
					buttonclick: function (row) {
						var rowData = $('#grid').jqxGrid('getrowdata', row);
						if (rowData.event_source == 'SCADA') {
							alert(getTranslate('noImage'));
						} else {
							if (get('userdata') != null) {
								if(popup_window[POPUP_SEARCH] && !popup_window[POPUP_SEARCH].closed)
									popup_window[POPUP_SEARCH].close();

								popup_window[POPUP_SEARCH] = openWindow('/logPopup?dev_ch=' + rowData.dev_channel + '&event_time=' + rowData.event_time, 'logPopup', 1920, 1080);	// 1280 + 16, 720 + 68
							}
						}
						
					}}
				]
			});
			
	    },
		error: function(errorThrown) {
			/* alert(errorThrown.statusText);
			alert(jsonUrl); */
		}
	});
	
	setInterval(function() {
		if(rowarray.length == 0)
			return;

		var scrollposition = $('#grid').jqxGrid('scrollposition').top;

		if(scrollposition == 0) {
			$("#grid").jqxGrid('beginupdate');
			for(var i = 0; i < rowarray.length; i++) {
				$('#grid').jqxGrid('addrow', null, rowarray[i], 'first');
			}
			$("#grid").jqxGrid('endupdate');
			rowarray = [];
		}
	}, 200);
	
	var socket = new SockJS(websocketUrl);
	var stompClient = Stomp.over(socket);
	stompClient.connect({}, function (frame) {
		stompClient.subscribe('/receiveMessage', function (message) {
			var obj = JSON.parse(message.body);
			var action = getTranslate(obj.event_name.toLowerCase().split('_')[1]);
			obj.event_source = getTranslate(obj.event_source);

			var row = { item_name: obj.item_name, dev_ip: obj.dev_ip, dev_channel: obj.dev_channel, event_name: obj.event_name, event_time: obj.event_time, event_info: obj.event_info, dev_id: obj.dev_id, dev_pwd: obj.dev_pwd, dev_port: obj.dev_port, event_source: obj.event_source, event_name2: action };
			$('#grid').jqxGrid('addrow', null, row, 'first');
			var rows = $('#grid').jqxGrid('getrows');
			var rowID = $('#grid').jqxGrid('getrowid', rows.length-1);
			if (rows.length > 1000) {
				$('#grid').jqxGrid('deleterow', rowID);
			}
		}); 
	});
	
	var POPUP_SEARCH = 1;
	
	var popup_window = new Array();
	
	function getFormatDate(date){
		var year = date.getFullYear();              //yyyy
		var month = (1 + date.getMonth());          //M
		month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
		var day = date.getDate();                   //d
		day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
		return  year + '-' + month + '-' + day;
	}
	
	$('#calendar').jqxDateTimeInput({ 
		width: 180, height: 30, formatString: 'yyyy-MM-dd', theme: 'metrodark', dropDownVerticalAlignment: 'top', placeHolder: getFormatDate(new Date)
	});
	
	$('#calendar').jqxDateTimeInput('setDate', null);
	
	/* if (get('searchdate') != null && get('searchdate') != '') {
		$('#calendar').jqxDateTimeInput('setDate', get('searchdate').split('-')[0] + ', ' + get('searchdate').split('-')[1] + ', ' + get('searchdate').split('-')[2]);
	} */
	
	$('#calendar').on('valueChanged', function (event) {
		if(popup_window[POPUP_SEARCH] && !popup_window[POPUP_SEARCH].closed)
			popup_window[POPUP_SEARCH].close();

		setMonitoring($('#calendar').jqxDateTimeInput('val'));
		 
		//openWindow('./index_monitoring_search.htm', '_blank', 1400, 800);
		popup_window[POPUP_SEARCH] = openWindow('./logInfo.htm', 'webMonitoringSearch', 1400, 800);
		
	});
	
    $("#excelExport").jqxButton({
    	theme: 'metrodark'
    });

    $("#excelExport").click(function () {
        $("#grid").jqxGrid('exportdata', 'csv', 'jqxGrid');           
    });
});
</script>
</head>
<body style="background-color:#252525;">
	<div id="Progress_Loading" align="center" > <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" width="30%" style="margin-top:70px;" />
	</div>
<div class="container" style="margin-top:70px;">
		<div id="grid"></div>
		<div align="right">
			<table style="margin-top: 10px; width: 100%">
				<tr>
					<td id="as_count" style="width: 22%"></td>
					<td align="right" style="width: 70%"><div id="calendar"></div></td>
					<td style="padding-left: 10px;" align="right"><input type="button" value="Export to Csv" id="excelExport"></td>
				<tr>
			</table>
		</div>
</div>
</body>
</html>