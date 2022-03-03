var lang = {
	"ko" : {
		// 이벤트
		fire : "화재",
		falldown : "쓰러짐",
		flood : "침수",
		glove : "장갑미착용",
		invasion : "침입",
		leak : "누수",
		loitering : "배회",
		handaction : "수신호",
		spin : "약품미투입",
		cmtank : "약품탱크누액",
		outtank : "옥외탱크누액",
		overflow : "배출수월류",
		
		// 이벤트 소스
		지능형안전관리시스템 : "지능형안전관리시스템",
		SCADA : "스카다", 
		
		// 날짜
		year : "년 ",
		month : "월 ",
		day : "일 ",
		hour : "시 ",
		minute : "분 ",
		second : "초",
		date : "요일",
		monday : "월요일",
		mon : "월",
		tuesday : "화요일",
		tue : "화",
		wednesday : "수요일",
		web : "수",
		thursday : "목요일",
		thu : "목",
		friday : "금요일",
		fri : "금",
		saturday : "토요일",
		sat : "토",
		sunday : "일요일",
		sun : "일",
		
		// 고정값
		event_source : "이벤트 소스",
		device_title : "장치 이름",
		device_ip : "장비 아이피",
		channel : "채널",
		event_info : "이벤트 정보",
		popup : "팝업",
		event_name : "이벤트",
		action : "동작",
		event_time : "발생 시간",
		run : "실행",
		cancel : "취소",
		delete_data : "삭제",
		display : "보기",
		reject : "무시",
		move : "이동",
		noImage : "이미지가 없습니다."
	},
	"en" : {
		// Event
		fire : "Fire",
		falldown : "Falldown",
		flood : "Flood",
		glove : "Glove",
		invasion : "Invasion",
		leak : "Leak",
		loitering : "Loitering",
		handaction : "Handaction",
		spin : "Spin",
		cmtank : "Cmtank",
		outtank : "Outtank",
		overflow : "Overflow",

		// Event Source
		지능형안전관리시스템 : "KWATER",
		SCADA : "SCADA", 
		
		// Date
		year : "-",
		month : "-",
		day : " ",
		hour : ":",
		minute : ":",
		second : "",
		date : "",
		monday : "Monday",
		mon : "Mon",
		tuesday : "Tuesday",
		tue : "Tue",
		wednesday : "Wednesday",
		wed : "Wed",
		thursday : "Thursday",
		thu : "Thu",
		friday : "Friday",
		fri : "Fri",
		saturday : "Saturday",
		sat : "Sat",
		sunday : "Sunday",
		sun : "Sun",

		// 고정값
		event_source : "Event Source",
		device_title : "Device Title",
		device_ip : "Device IP",
		channel : "Channel",
		event_info : "Event Info",
		popup : "Popup",
		event_name : "Event Name",
		action : "Action",
		event_time : "Event Time",
		run : "Run",
		cancel : "Cancel",
		delete_data : "Delete",
		display : "display",
		reject : "reject",
		move : "move",
		noImage : "No image to display"
	}
}
function getLanguage() {
    return navigator.language || navigator.userLanguage;
}
function getTranslate(tag) {
	return eval('lang.' + getLanguage().substring(0, 2) + '.' + tag);
}