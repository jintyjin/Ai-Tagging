<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../include/searchBar.jsp" %> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script src="./resources/js/jquery-3.3.1.min.js"></script>
<script src="./resources/js/bootstrap.min.js"></script>
<script src="./resources/js/sockjs.min.js"></script> 
<script src="./resources/js/stomp.min.js"></script>
<style>
.loading {
	display:none;
}
body {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:black; 
	margin:0;
	text-size-adjust:100%;
	background-color:#252525;
}
.top {
	left:0;
	right:0;
	top:0;
	height:72px;
	position:fixed;
	z-index :99999;
}
.searchHr {
	position:absolute;
	height:5px;
	width:100%;
	top:59px;
	left:0;
	opacity:0;
}
.search {
	align-items:center;
	display:flex;
	background:#252525;
	padding:0 14px;
	height:64px;
	right:0;
	top:0;
	width:100%;
	-webkit-box-pack:center;
	justify-content:center;
}
.searchDiv {
	display:flex;
	flex:0 1 50vw;
	max-width:720px;
}
.searchBar {
	background:#f1f3f4;
	border-radius:8px;
	display:flex;
	flex:0 1 50vw;
	height:48px;
	margin:12px 0;
	transition:background linear 270ms,box-shadow linear 0ms 270ms;
}
.svgDiv {
	color:#5f6368;
	margin:12px 16px;
	vertical-align:top;
}
svg {
	border-radius:8px;
}
.svg {
	fill:none;
	stroke:currentColor;
	vertical-align:top;
}
.searchTextDiv {
	height:100%;
	display:flex;
	flex:1;
}
.searchText {
	height:100%;
	background:none;
	border:none;
	vertical-align:top;
	z-index:auto;
	color:#3c4043;
	text-overflow:ellipsis;
	font-size:14px;
	font-weight:500;
	line-height:1.5rem;
	flex-grow:1;
	outline:none;
}
.bottom {
	top:0;
	left:0;
	right:0;
	bottom:0;
	margin-top:72px;
	padding-top:24px;
	padding-left:72px;
	padding-right:72px;
}
svg {
	border-radius:8px;
}
.imageDiv {
	margin-bottom:24px;
}
.allImage {
	top:0px;
	left:0px;
	border-top:0;
	contain:layout;
}
a {
	color:black;
}
a.imageA:hover {
	color:#008aff;
	cursor:pointer;
}
.images {
	contain:layout;
	width:270px;
	height:314px;
	margin-right:32px;
	float:left;
	transform:translateZ(0);
	transition:all .135s cubic-bezier(0.0,0.0,0.2,1);
}
.imageInA {
	background-repeat:no-repeat;
	background-size:100% 100%;
	bottom:0;
	right:0;
	top:0;
	transition:transform .135s cubic-bezier(0.0,0.0,0.2,1),opacity linear .15s;
	width:270px;
	height:270px;
}
/* .imageA {
	bottom:0;
	left:0;
	right:0;
	top:0;
	transition:transform .135s cubic-bezier(0.0,0.0,0.2,1);
	width:100%;
	height:50%;
} */
.fail img { display: none; }
img {
	transition:transform .135s cubic-bezier(0.0,0.0,0.2,1), opacity linear .15s;
	border-radius:8px;
}
.previousDiv {
	left:14px;
	position:absolute;
}
.previousA {
	height:24px;
}
.previous {
	height:100%;
}
.h2 {
	font-family: Lucida Sans, Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: bold;
	color:white;
	width:100%; 
	line-height:44px; 
	left:0;
	margin:0;
}
</style>
<script>
const hasSupport = 'loading' in HTMLImageElement.prototype;
document.documentElement.className = hasSupport ? 'pass' : 'fail';

function get(key) {
	return sessionStorage.getItem(key);
}
function setTagImage(tagImage) {
	sessionStorage.setItem('tagImage', tagImage);
}
function setBack(back) {
	sessionStorage.setItem('back', back);
}
function setScroll(scroll) {
	sessionStorage.setItem('scroll', scroll);
}
$(document).ready(function () {
	$('#Progress_Loading').show();
	
	/* $('#header').hide();
	$('#calendar').hide();
 	$('.card-header').hide();
 	$('.card-block').hide(); 
	$('#Progress_Loading').hide(); //첫 시작시 로딩바를 숨겨준다.*/
	
});
$(document).ajaxStart(function(){
	/* $('#header').hide();
	$('#calendar').hide();
 	$('.card-header').hide();
 	$('.card-block').hide(); 
	$('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.*/
})
$(document).ajaxStop(function(data){
	/*$('#Progress_Loading').hide(); //ajax종료시 로딩바를 숨겨준다.
	$('#header').show();
	$('#calendar').show();
 	$('.card-header').show(); 
 	$('.card-block').show(); */
}); 

$(document).ready(function () {
	var arr = [];
	var jsonUrl = '/albumInfo';

	var categoryList = [];
	var categorySmall = [];
	$.ajax({
		type : "POST",                        	 	     
		url : jsonUrl,                      		
		dataType : "json",                        	  
		contentType : "application/json; charset=UTF-8",   
		async:false,
	    success: function(data) {
	    	if (data.length > 0) {
		    	var appendStr = '';
	    		
		    	for (var i = 0; i < data.length; i++) {
		    		var category = data[i].event_name;
		    		appendStr += '<a class="imageA" id="' + category + '" onclick="" ><div class="images" id="' + category + '1"><div class="imageInA" id="' + category + '2">';
		    		for (var j = 0; j < 4; j++) {
		    			if (j == 0) {
							appendStr += '<div class="imageA" id="' + category + '3-0" style="margin-bottom:2px;">';
		    			} else if (j == 2) {
							appendStr += '</div><div class="imageA" id="' + category + '3-1" style="margin-top:2px;">';
		    			}
		    			if (parseInt(j % 2) == 0) {
			    			if (data[i].thumb_name.split(',')[j] != null && data[i].thumb_name.split(',')[j] != '') {
	    	    				var thumb_name = data[i].thumb_name.split(',')[j];
			    				appendStr += '<img loading="lazy" onError="this.src=' + "'" + thumb_name.replace('webserver', 'web_server') + "'" + '" src="' + thumb_name + '" width="133px" height="133px" alt="" style="margin-right:4px;">';
			    			} else {
			    				appendStr += '<svg xmlns="http://www.w3.org/2000/svg" width="133px" height="133px" viewBox="0 0 160 160" style="margin-right:4px;"><rect width="160" height="160" fill="#EFF0F2" rx="2"/></g></svg>';
			    			}
		    			} else {
			    			if (data[i].thumb_name.split(',')[j] != null && data[i].thumb_name.split(',')[j] != '') {
	    	    				var thumb_name = data[i].thumb_name.split(',')[j];
			    				appendStr += '<img loading="lazy" onError="this.src=' + "'" + thumb_name.replace('webserver', 'web_server') + "'" + '" src="' + thumb_name + '" width="133px" height="133px" alt="">';
	    					} else {
								appendStr += '<svg xmlns="http://www.w3.org/2000/svg" width="133px" height="133px" viewBox="0 0 160 160" style="float:right;"><rect width="160" height="160" fill="#EFF0F2" rx="2"/></g></svg>';
	    					}
		    			}
		    		}
		    		
		    		if (category.toLowerCase() == 'KWATER_Fire_Detection'.toLowerCase()) {
		    			category = '화재';
		    		}
		    		if (category.toLowerCase() == 'KWATER_Falldown_Detection'.toLowerCase()) {
		    			category = '쓰러짐';
		    		}
		    		if (category.toLowerCase() == 'KWATER_Flood_Detection'.toLowerCase()) {
		    			category = '침수';
		    		}
		    		if (category.toLowerCase() == 'KWATER_Glove_Detection'.toLowerCase()) {
		    			category = '장갑미착용';
		    		}
		    		if (category.toLowerCase() == 'KWATER_Invasion_Detection'.toLowerCase()) {
		    			category = '침입';
		    		}
		    		if (category.toLowerCase() == 'KWATER_Leak_Detection'.toLowerCase()) {
		    			category = '누수';
		    		}
		    		if (category.toLowerCase() == 'KWATER_Loitering_Detection'.toLowerCase()) {
		    			category = '배회';
		    		}
		    		if (category.toLowerCase() == 'KWATER_HandAction_Detection'.toLowerCase()) {
		    			category = '수신호';
		    		}
		    		if (category.toLowerCase() == 'KWATER_Spin_Detection'.toLowerCase()) {
		    			category = '약품미투입';
		    		}
					if (category.toLowerCase() == 'KWATER_Cmtank_Leak'.toLowerCase()) {
						category = '약품탱크누액';
					}
					if (category.toLowerCase() == 'KWATER_Outtank_Leak'.toLowerCase()) {
						category = '옥외탱크누액';
					}
					if (category.toLowerCase() == 'KWATER_Overflow'.toLowerCase()) {
						category = '배출수월류';
					}

		    		appendStr += '</div></div><div style="height:44px;"><h2 class="h2">' + category + '</h2></div></div></a>';
		    	}
	    	}
    		$(appendStr).appendTo('.allImage');
	    	
			$('#Progress_Loading').hide();
			$('div').removeClass('loading');
			
	    },
		error: function(errorThrown) {
			alert(errorThrown.statusText);
			alert(jsonUrl);
		}
	});

	$('.allImage a').click(function(e) {
		//setTagImage($(this).attr('id'));
		$("#" + $(this).attr('id')).attr("href", "./tagImage.htm?event_name=" + $(this).attr('id'));

	});
	
	$(".searchText").focus(function() {
		$(".svg").click();
	});
	$('input').keyup(function(e) {
		if (e.keyCode == 13) $(".svg").click();
	});

});
function search() {
	//alert($('.searchText').val());
  	setBack('album');
  	setScroll(document.scrollingElement.scrollTop);
	location.href = './searchBar.htm?status=first&keyword=';
}
</script>
</head>
<body>
	<div id="Progress_Loading" style="text-align:-webkit-center;"> <!-- 로딩이미지 -->
		<img src="/resources/image/124.gif" style="width:30%; margin-top:70px;" alt="loading"/>
	</div>
	<div class="loading">
		<div class="top">
			<div class="searchHr"></div>
			<div class="search">
				<div class="previousDiv">
					<a class="previousA" href="./album.htm" style="display:none;">
						<div class="previous">
							<span style="width:24px; height:24px;"><svg width="24px" height="24px" class="v1262d JUQOtc" viewBox="0 0 24 24"><path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"></path></svg></span>
						</div>
					</a>
				</div>
				<div class="searchDiv">
					<div class="searchBar">
						<div class="svgDiv">
							<svg class="svg" width="24px" height="24px" onclick="search();">
								<path d="M20.49 19l-5.73-5.73C15.53 12.2 16 10.91 16 9.5A6.5 6.5 0 1 0 9.5 16c1.41 0 2.7-.47 3.77-1.24L19 20.49 20.49 19zM5 9.5C5 7.01 7.01 5 9.5 5S14 7.01 14 9.5 11.99 14 9.5 14 5 11.99 5 9.5z"></path>
							</svg>
						</div>
						<div class="searchTextDiv">
							<input class="searchText" type="text" placeholder="내 사진 검색" />
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="bottom">
			<div class="imageDiv">
				<div class="allImage">
					<!-- <a class="imageA" id="favorites">
						<div class="images">
							<div class="imageInA"><div class="imageA" style="margin-bottom:2px;"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="133px" height="133px" viewBox="0 0 160 160" style="margin-right:4px;"><defs><linearGradient id="a" x1="69%" x2="30%" y1="50%" y2="50%"><stop offset="0%" stop-color="#EFF0F2"/><stop offset="51%" stop-color="#DFE1E5"/><stop offset="100%" stop-color="#EFF0F2"/></linearGradient><path id="b" d="M4 4h65v66H4z"/><path id="c" d="M6 6h61v62H6z"/><path id="e" d="M0 0h12v19H0z"/><linearGradient id="g" x1="0%" x2="50%" y1="133%" y2="0%"><stop offset="0%" stop-color="#C7CBD1"/><stop offset="100%" stop-color="#959CA5"/></linearGradient><path id="h" d="M0 0h11v17H0z"/><path id="j" d="M11 0v11c0 3-3 6-6 6s-5-3-5-6C0 5 5 0 11 0"/><path id="l" d="M11 0v11c0 3-3 6-6 6s-5-3-5-6"/></defs><g fill="none" fill-rule="evenodd"><path fill="#FFF" d="M-531-377H749v640H-531z"/><g><rect width="160" height="160" fill="#EFF0F2" rx="2"/><path fill="url(#a)" d="M0 91h117v1H0z" transform="translate(13 45)"/><path fill="#DFE1E5" stroke="#FFF" stroke-width="2" d="M67 91l14-42 42 14-14 42-42-14z"/><path fill="#0277BD" d="M82 78v-2a14 14 0 0 1 1-5l2-2a14 14 0 0 1 7-5 14 14 0 0 1 6 0c2 0 3 2 3 5-6-1-14 1-18 5l-1 4"/><path fill="#FFF" d="M98 64h2a13 13 0 0 1 9 11c-1-3-3-5-8-6 0-3-1-5-3-6"/><path fill="#40C4FF" d="M93 90l-2-1a13 13 0 0 1-9-11l1-4c4-4 12-7 18-5 1 10-4 21-8 21"/><path fill="#676C71" d="M109 75v2a14 14 0 0 1-1 5l-2 3a14 14 0 0 1-7 4 14 14 0 0 1-6 1c4 0 9-12 8-21 5 1 7 3 8 6"/><g transform="translate(35 45)"><use fill="#FFF" transform="rotate(-6 36 37)" xlink:href="#b"/><mask id="d" fill="#fff"><use xlink:href="#c"/></mask><use fill="#DFE1E5" transform="rotate(-6 36 37)" xlink:href="#c"/><path fill="#DFE1E5" mask="url(#d)" transform="rotate(-6 36 37)" d="M6 6h61v62H6z"/><g mask="url(#d)"><path stroke="#9AA0A6" stroke-linecap="round" stroke-linejoin="round" d="M37 39l8 46"/><g transform="rotate(170 20 21)"><mask id="f" fill="#fff"><use xlink:href="#e"/></mask><path fill="#676C71" d="M12 19V6c0-3-2-6-6-6-3 0-6 3-6 6v1c0 7 6 12 12 12" mask="url(#f)"/></g><path fill="#959CA5" d="M39 19l3 13c0 3-2 6-5 7-4 1-7-2-7-5v-1c-2-7 3-13 9-14"/><path fill="url(#g)" d="M0 19V6c0-3 3-6 6-6 4 0 6 3 6 6v1c0 7-5 12-12 12" transform="rotate(170 20 21)"/><g transform="rotate(170 18 51)"><mask id="i" fill="#fff"><use xlink:href="#h"/></mask><path fill="#EA4335" d="M11 0v11c0 3-3 6-6 6s-5-3-5-6C0 5 5 0 11 0" mask="url(#i)"/></g><g transform="rotate(170 18 51)"><mask id="k" fill="#fff"><use xlink:href="#j"/></mask><path d="M11 0v11c0 3-3 6-6 6s-5-3-5-6C0 5 5 0 11 0" mask="url(#k)"/></g><g transform="rotate(170 31 32)"><mask id="m" fill="#fff"><use xlink:href="#l"/></mask><path d="M11 0v11c0 3-3 6-6 6s-5-3-5-6C0 5 5 0 11 0" mask="url(#m)"/></g><path fill="#9AA0A6" d="M44 37a9 9 0 0 1-5 17l5-17zM31 48a9 9 0 0 0 10 14L31 48z"/></g></g></g></g></svg><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="133px" height="133px" viewBox="0 0 160 160"><defs><linearGradient id="a" x1="100%" x2="42.819%" y1="50%" y2="50%"><stop offset="0%" stop-color="#676C71"/><stop offset="100%" stop-color="#EFF0F2"/></linearGradient><path id="b" d="M37.333 0H104v66.667H37.333z"/></defs><g fill="none" fill-rule="evenodd"><path fill="#FFF" d="M-367-96h2043v640H-367z"/><rect width="160" height="160" fill="#EFF0F2" rx="2"/><g transform="translate(9.333 46.667)"><path fill="url(#a)" opacity=".3" d="M0 68.667l5.542-2H48v2.666z"/><mask id="c" fill="#fff"><use xlink:href="#b"/></mask><path stroke="#FFF" stroke-width="2" d="M36.333-1H105v68.667H36.333z"/><path fill="#959CA5" d="M119.1828 21.76h-11.613v5.76h-9.6773v-7.68H88.215v3.84l-3.871-3.6096V16h-1.9355v4.0704l-3.871 3.6096V35.2h-7.7419v-3.552L64.9892 25.6l-5.8064 6.048V40.8c0 4.4587-9.6774 5.4447-9.6774 0v-9.44H39.828v3.84h-5.8065V16H14.6667v48h120V23.68h-15.4839v-1.92z" mask="url(#c)"/><path fill="#676C71" d="M110.7097 52.8889h-5.8065v-3.9111h-9.6774V56.8h-7.742v-7.5289s-.4448-6.16-5.8064-6.16-5.8064 6.16-5.8064 6.16v3.6178h-5.8065v-3.9111H58.4516v3.911H46.8387v-7.8221h-9.6774V39.2h-9.6774v1.9556H12v32.1777h120v-40h-21.2903V52.889z" mask="url(#c)"/><path fill="#E0E0E0" mask="url(#c)" d="M126.667 29.333H128v4h-1.333zm-60 4H68v4h-1.333zm0 5.334H68v4h-1.333zm-36-21.334H32v4h-1.333zm-6.667 0h1.333v4H24zm6.667 5.334H32v4h-1.333zm14.666 10.666h1.333v1.333h-1.333zm-4 4h1.333v1.333h-1.333zm20-4h1.333v4h-1.333zm29.334-12H92v1.333h-1.333zm4 0H96v1.333h-1.333zm-4 4H92v1.333h-1.333zm4 0H96v1.333h-1.333zm-4 4H92v1.333h-1.333zm32-4H124v4h-1.333zm4 0H128v4h-1.333zm-26.667 4h1.333v4H100zm4 0h1.333v4H104zm0 8h1.333v4H104z"/></g></g></svg></div><div class="imageA" style="margin-top:2px;"><svg xmlns="http://www.w3.org/2000/svg" width="133px" height="133px" viewBox="0 0 160 160" style="margin-right:4px;"><g fill="none" fill-rule="evenodd"><path fill="#FFF" d="M-719-96h2043v640H-719z"/><rect width="160" height="160" fill="#EFF0F2" rx="2"/><path fill="#FFF" d="M42.667 49.333h74.667V110H42.667z"/><path fill="#757575" d="M45 103h4.667v4.667H45z"/><path fill="#676C71" d="M45 51.666h4.667v4.667H45zM53.167 103h4.667v4.667h-4.667zm0-51.334h4.667v4.667h-4.667zM61.334 103h4.667v4.667h-4.667zm0-51.334h4.667v4.667h-4.667zM69.5 103h4.667v4.667H69.5zm0-51.334h4.667v4.667H69.5zM77.667 103h4.667v4.667h-4.667zm0-51.334h4.667v4.667h-4.667zM85.834 103h4.667v4.667h-4.667zm0-51.334h4.667v4.667h-4.667zM94 103h4.667v4.667H94zm0-51.334h4.667v4.667H94zM102.167 103h4.667v4.667h-4.667zm8.167 0h4.667v4.667h-4.667zm-8.167-51.334h4.667v4.667h-4.667zm8.167 0h4.667v4.667h-4.667z"/><path fill="#DFE1E5" d="M53.226 58.666h53.549v42H53.226zm57.108 0h7v42h-7zm-67.667 0h7v42h-7z"/><path fill="#676C71" d="M80.0006 69.1663c-4.2468 0-8.0755 2.5583-9.7007 6.4819-1.6252 3.9235-.7269 8.4398 2.2761 11.4428s7.5192 3.9013 11.4428 2.276c3.9236-1.6251 6.4818-5.4538 6.4818-9.7007 0-5.799-4.701-10.5-10.5-10.5z"/><path fill="#FFF" d="M77.667 84.333V75l6.3 4.666z"/></g></svg><svg xmlns="http://www.w3.org/2000/svg" width="133px" height="133px" viewBox="0 0 160 160"><defs><linearGradient id="a" x1="53.155%" x2="50%" y1="0%" y2="100%"><stop offset="0%" stop-color="#FFF"/><stop offset="100%" stop-color="#DFE1E5"/></linearGradient></defs><g fill="none" fill-rule="evenodd"><path fill="#FFF" d="M-895-96h2043v640H-895z"/><rect width="160" height="160" fill="#EFF0F2" rx="2"/><path fill="#FFF" d="M45.333 45.333h69.333v69.333H45.333z"/><path fill="#DFE1E5" d="M48 48h64v30.667H48zm0 33.333h30.667V112H48zm33.333 0H112V112H81.333z"/><path fill="#676C71" d="M85.333 68.1569c-5.3333-6.8267-13.6839-11.867-20.5772-11.867-6.8933 0-12.7561 4.928-16.7561 9.5989v12.7775h26.6666c3.4134-3.9298 6.8134-7.8596 10.6667-10.5094z"/><path fill="url(#a)" d="M61.2266 14.613c-.2047-1.5393-1.5194-2.728-3.1148-2.728-.3351 0-.6576.0536-.9606.1506-.1591-2.5807-2.3016-4.6249-4.9224-4.6249-.3986 0-.7857.0484-1.157.1378-.8828-1.3345-2.3965-2.2152-4.1164-2.2152-2.7244 0-4.933 2.2086-4.933 4.933 0 .3995.0488.7877.1386 1.1597a3.1797 3.1797 0 0 0-.3487-.0203c-1.7372 0-3.1456 1.4083-3.1456 3.1456 0 .0208.0027.041.0032.0617h22.5567z" transform="translate(45.333 45.333)"/><path fill="#959CA5" d="M74.6663 78.6663h37.3334V76.361c-5.3334-6.0398-11.0667-11.5264-18-11.5264-9.1508 0-15.9334 9.7975-19.3334 13.8317z"/><path fill="#676C71" d="M47.9997 96.6663s5.8533-1.8266 10.6666.6667c8.28 4.28 20-2 20-2v16.6667H47.9997V96.6663z"/><path fill="#959CA5" d="M47.9997 104.133a95.0133 95.0133 0 0 0 11.0933-2.28c5.44-1.6133 15.4.96 16.08 1.1333.68.1734 3.4933.3734 3.4933.3734v8.64H47.9997v-7.8667zm64-7.4667c-14.9734 0-21.5067 5.3334-30.6667 5.3334v10h30.6667V96.6663z"/><path fill="#676C71" d="M104.6663 102.6032v2.7298h-1.3333v-2.7108c-1.7887-.2536-3.3333-1.7075-3.3333-7.0759 0-4.28 4-11.5466 4-11.5466s4 7.2666 4 11.5466c0 5.6044-2.074 6.8072-3.3334 7.0569zm-9.3333 4.0075v2.7223h-1.3333v-2.708c-1.7888-.238-3.3334-1.6014-3.3334-6.6253 0-4 4-10.6667 4-10.6667s4 6.5733 4 10.6667c0 5.2857-2.074 6.3871-3.3333 6.611z"/></g></svg></div></div><div style="height:44px;"><h2 class="h2">즐겨찾기</h2></div>
						</div>
					</a> -->
				</div>
			</div>
		</div>
	</div>
</body>
</html>