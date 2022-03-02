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
		sun : "일"
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
		
		// Date
		year : "-",
		month : "-",
		day : "",
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
		sun : "Sun"
	}
}
function getLanguage() {
    return navigator.language || navigator.userLanguage;
}
function getTranslate(tag) {
	return eval('lang.' + getLanguage().substring(0, 2) + '.' + tag);
}