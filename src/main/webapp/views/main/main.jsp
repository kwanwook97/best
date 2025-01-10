<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href="resources/css/dashBoard.css" rel="stylesheet"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <script src="/BEST/resources/js/index.global.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
#newMessageIndicator2 {
	background-color: #E9396B;
	border-radius: 50%;
	width: 20px;
	text-align: center;
	display: none;
	position: absolute;
	top: 7px;
    left: 159px;
}

.unread-message-count2 {
	color: #FFF5E2;
}


.iPhone::-webkit-scrollbar {
    display: none;
}

.iPhone {
    width: 17vw;
    height: 45vh;
    background-color: #30005A;
    border-radius: 10px;
    margin: 0;
    padding: 10px;
    font-family: Arial, sans-serif;
    color: white;
    text-align: center;
    overflow-y: auto; /* 스크롤 활성화 */
}

.current-weather {
    margin-bottom: 20px;
}

.current-weather h2 {
    font-size: 18px;
    margin: 5px 0;
}

.current-weather .temperature {
    font-size: 48px;
    font-weight: bold;
    margin: 10px 0;
}

.current-weather p {
    font-size: 14px;
    margin: 5px 0;
}

.hourly-weather, .weekly-weather {
    margin-top: 20px;
}

.hourly-weather h3, .weekly-weather h3 {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 10px;
}

.hourly-forecast {
  display: flex;
  gap: 10px;
  overflow: hidden; /* 스크롤바 숨김 */
  cursor: grab; /* 드래그 가능한 커서 표시 */
}

.hourly-forecast.active {
  cursor: grabbing; /* 드래그 중 커서 표시 */
}

.hour, .day {
  background: #8B6AA7;
  padding: 10px;
  border-radius: 10px;
  text-align: center;
  min-width: 80px;
}
.day{
  margin-bottom: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.hour img, .day img {
  width: 40px;
  height: 40px;
}

.hour p, .day p {
  font-size: 12px;
  margin: 5px 0;
}





.temperature-bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 57%;
    margin: 10px 0;
}

.min-temp, .max-temp {
    font-size: 14px;
    color: #fff;
    margin: 0 5px;
}

.bar {
    position: relative;
    flex-grow: 1;
    height: 10px;
    background: #30005A; /* 기본 바 색상 */
    border-radius: 5px;
    margin: 0 10px;
    overflow: hidden;
}

.fill {
    position: absolute;
    top: 0;
    bottom: 0;
    left: var(--start);
    right: calc(100% - var(--end));
    background: linear-gradient(to right, #FFF5E2, #E9396B); /* 색상 그라디언트 */
    border-radius: 5px;
}
#current-location{
	font-size: 20px;
}

/* 캘린더 css */
.fc-daygrid-day-frame.fc-scrollgrid-sync-inner {
	height: 68px;
}
#calendar {
	max-height: 93% !important;
	width: 97% !important;
	
}
.fc-scroller.fc-scroller-liquid-absolute::-webkit-scrollbar {
    display: none !important;
}
.fc-scroller::-webkit-scrollbar{
    display: none !important;
}
.fc.fc-scrollgrid-liquid .fc-col-header {
	width: 100% !important;
}
.fc-col-header {
	width: 100% !important;
}
.fc-daygrid-body.fc-daygrid-body-balanced {
	width: 100% !important;
}
.fc-scrollgrid-sync-table {
	width: 100% !important;
}


.fc-event-main {
	background-color: #30005A;
	border-radius: 10px;
	padding: 0 0 2px 5px;
}
.fc-event-time {
	color: #6C0F6C;
    white-space: nowrap;      
    overflow: hidden;         
    text-overflow: ellipsis; 
    max-width: 100%;        
    display: block;
}
.fc-event-title {
	color: #6C0F6C;
}
.fc-sticky {
	color: white;
}
#visibilityFilter {
	position: relative;
	top: 1px;
	left: 108px;
	border: 0px;
	background-color: #00000000;
	color: #30005A;
}
.fc-header-toolbar button {
	background-color : #30005a00 !important;
	color: #30005A !important;
	border: 0px !important;
	border-radius: 10px !important;
}

select option {
	background-color: #30005A !important;
	color: white !important;
}
.fc-daygrid-event-dot {
	border: calc(var(--fc-daygrid-event-dot-width) / 2) solid #30005A;
}

/* 투두리스트 */
	#todo-container {
	  flex: 1;
	  background-color: #8b6aa700;
	  border-radius: 8px;
	  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	  display: flex;
	  flex-direction: column;
	  overflow-y: auto; /* 넘칠 경우 스크롤 표시 */
	  height: 100%;
	  width: 100%;
	  margin: 14px 0 0 0;
	}

    #todo-container h2 {
      margin: 0 0 0 0;
      text-align: center;
      font-size: 24px;
      color: #FFF5E2;
      
    }
    
.list-box {
  display: flex; 
  align-items: center;
  justify-content: space-between;
  background-color: #ffffff00; 
  border: 2px solid #30005A; 
  border-radius: 10px;
  padding: 5px; 
  margin-bottom: 10px;
  font-size: 14px;
  color: #30005A; 
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); 
}
.date-time {
  font-weight: bold; 
  margin-right: 20px;
  flex-shrink: 0; 
}

.date-content {
  flex-grow: 1; 
  text-align: left; 
  color: #30005A; 
}


#todolist {
  flex: 1;
  overflow-y: auto;
  display: flex; /* Flexbox 활성화 */
  flex-direction: column; /* 세로 방향으로 정렬 */
  padding: 10px; /* 내부 여백 추가 (선택 사항) */
  width: 90%;
}
#todolist::-webkit-scrollbar {
	display: none;
}


    .todo-item {
      background-color: #fff;
      padding: 10px;
      border: 1px solid var(--primary-color);
      border-radius: 5px;
      margin-bottom: 10px;
    }
	#todo-subject-box{
	  background-color: #30005A;
	  border-radius: 10px;
	  display: flex; 
	  align-items: center; 
	  justify-content: center; 
	  padding: 10px; 
	}

	
	/* 차트 css */
#cardChart {
	width: 94% !important;
	height: 82% !important;
	margin: 1% 0 0 0 !important;
	
}
.box-wrapper {
	display: flex;
}
.span-active {
	margin: 0 0 0 1%;
}
	

  </style>
</head>
 <jsp:include page="../main/header.jsp"></jsp:include>
<body class="bg-theme bg-theme1">
 	<div class="dashboard-body">
 		<div class="dash-profile">
 		<div class="user-profile"></div>
 		<ul class="user-Info">
 			<li style="font-size:20px; font-weight:400;"></li>
 			<li class="user-Info-depart" style="color: #8B6AA7;"></li>
 		</ul>
 		<ul class="sidebar-menu">
 			<li>
 				<a href="#">
          			<i class="fa-regular fa-clipboard"></i> <span>결재 할 문서</span>
          			<i class="fa-solid fa-angle-right"></i>
        		</a>
 			</li>
 			<li>
 				<a href="#">
          			<i class="bi bi-envelope-fill"></i><span>새로운 메일</span>
          			<i class="fa-solid fa-angle-right"></i>
        		</a>
 			</li>
 			<li style="position: relative;">
 				<a href="chatList.go">
          			<i class="bi bi-chat-left-text-fill"></i> <span>새로운 메시지</span>
          			<i class="fa-solid fa-angle-right"></i>
        		</a>
        		<div id="newMessageIndicator2" class="newMessageIndicator">
        
    			</div>
 			</li>
 		</ul>
 	</div>
 	<div class="drive-info">
 		<div class="drive-info2"><span>현재 운행 정보</span></div>
 		<div class="drive-info3"> 		
 			
 		</div>
 	</div>
	<div class="year-graph">
		<div class="box-wrapper">
			<div class="date-navigation">
				<div class="date-content">
					<span class="current-date"></span>
				</div>
			</div>
			<span class="span-active">정산</span>
		</div>
		<div class="year-graph2">
			<canvas id="cardChart"></canvas>
		</div>
	</div>
 	<div class="dash-calendar">
		<select id="visibilityFilter">
		    <option value="all">전체</option>
		    <option value="private">개인</option>
		    <option class="departName" value="public">부서</option>
		</select>
		<div id="calendar" class="calendar-calendar"></div>
 	</div>
 	<div class="todoList">
<!--  		<div><span>To Do List!</span></div>
 		<div class="todoList2"></div> -->
		    <div id="todo-container">
			    <div id="todo-subject-box">
			      <h2>Today To Do List !</h2>
			    </div>
		      	<div id="todolist">

		      	</div>
		    </div>
 	</div>
 	<div class="road-info">
 		<div><span>오늘의 교통 정보</span></div>
 		<div>
 			<ul>
 				<li><span></span></li>
 				<li><span></span></li>
 			</ul>
 		</div>
 	</div>
 	<div class="iPhone">
  <div class="weather-app">
    <div class="current-weather">
      <img id="current-icon" src="" alt="날씨 아이콘">
      <p id="current-location"></p>
      <h1 id="current-temp"></h1>
      <p id="feels-like"></p>
      <p id="high-low"></p>
    </div>
    <div class="hourly-weather">
      <div id="hourly-container" class="hourly-forecast"></div>
    </div>
    <div class="weekly-weather">
      <div id="weekly-container" class="weekly-forecast"></div>
    </div>
  </div>
</div>
</div>
</body>
<script>
loginId = parseInt(loginId);

$(document).ready(function () {
    loadEmpDetail();

    function loadEmpDetail() {
        $.ajax({
            url: 'empDetail.ajax', 
            type: 'GET',
            dataType: 'json',
            data: { emp_idx: loginId }, 
            success: function (data) {
                updateUserInfo(data);
            },
            error: function () {
                alert('회원 정보를 가져오는데 실패했습니다.');
            }
        });
    }

    function updateUserInfo(empDetail) {
        // 프로필 사진
        const photo = empDetail.photo; // 사진이 없으면 기본 이미지
        $('.user-profile').html('<img src="/photo/' + photo + '" alt="프로필 사진">');

        // 이름과 직급
        const name = empDetail.name;
        const rankName = empDetail.rank_name;
        $('.user-Info > li:first-child').html(name + ' / ' + rankName);

        // 부서명
        const departName = empDetail.depart_name;
        $('.user-Info-depart').html(departName);
    }
});

$(document).ready(function () {
    // 페이지 로드 시 AJAX로 데이터 가져오기
    loadBusDetails();

    function loadBusDetails() {
        $.ajax({
            url: 'busDetail.ajax', // busSum 데이터를 반환하는 API
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                // busSum 데이터 가져와서 drive-info에 뿌리기
                updateDriveInfo(data.busSum);
            },
            error: function () {
                alert('버스 정보를 불러오는데 실패했습니다.');
            }
        });
    }

    function updateDriveInfo(busSum) {
        // 현재 운행 정보 초기화
        const driveInfoContainer = $('.drive-info3');
        driveInfoContainer.empty();

        // busSum 데이터를 순서대로 추가
        busSum.forEach(function (route) {
            const routeName = route.route_name || 'N/A';
            const totalBuses = route.total_buses || 0;
            const normalCount = route.normal_count || 0;
            const maintenanceCount = route.maintenance_count || 0;

            const html = 
                '<div class="bus-header">' +
                    '<div class="bus-main-info">' +
                        '<div style="width: 6.5vw;">' +
                            (routeName.length == 3 
                                ? '<span class="bus-number blue">' + routeName + '</span>' 
                                : '<span class="bus-number green">' + routeName + '</span>') +
                        '</div>' +
                        '<input type="hidden" name="route_name" value="' + routeName + '"/>' +
                        '<div class="bus-sum">' +
                            '<ul>' +
                                '<li><strong>총 버스 : </strong>' +
                                    '<span>' + totalBuses + '</span>' +
                                '</li>' +
                                '<li><strong>운행 가능 : </strong>' +
                                    '<span>' + normalCount + '</span>' +
                                '</li>' +
                                '<li><strong>정비 중 : </strong>' +
                                    '<span>' + maintenanceCount + '</span>' +
                                '</li>' +
                            '</ul>' +
                        '</div>' +
                    '</div>' +
                '</div>';
            driveInfoContainer.append(html);
        });
    }

});








$(document).ready(function () {
    const API_KEY = 'a0a9424fe3fb4874ba371725243012';
    const LOCATION = '37.477308,126.887745';
    const URL = 'https://api.weatherapi.com/v1/forecast.json';

    function fetchWeather() {
        $.ajax({
            url: URL,
            type: 'GET',
            dataType: 'json',
            data: {
                key: API_KEY,
                q: LOCATION,
                days: 3,
                aqi: 'no',
                alerts: 'no',
                lang: 'ko' // 언어를 한국어로 설정
            },
            success: function (data) {
                renderWeather(data);
            },
            error: function () {
                alert('날씨 정보를 불러오는데 실패했습니다.');
            }
        });
    }

    function renderWeather(data) {
        // 현재 날씨
        let locationName = data.location.name;

    // 서울을 한국어로 표시
    	if (locationName === "Seoul") {
        	locationName = "서울특별시";
    	}

    	$('#current-location').text(locationName);
        $('#current-temp').text(data.current.temp_c + '°');
        $('#current-condition').text(data.current.condition.text);
        $('#current-icon').attr('src', 'https:' + data.current.condition.icon); // 아이콘 경로 수정
        $('#feels-like').text('체감 온도: ' + data.current.feelslike_c + '°');
        $('#high-low').text(
            '최고: ' + data.forecast.forecastday[0].day.maxtemp_c + '° / 최저: ' + data.forecast.forecastday[0].day.mintemp_c + '°C'
        );

        // 시간별 날씨
        const hourlyContainer = $('#hourly-container');
        hourlyContainer.empty();
        data.forecast.forecastday[0].hour.forEach(function (hour, index) {
            if (index % 1 === 0) { // 3시간 간격
                hourlyContainer.append(
                    '<div class="hour">' +
                    '<p>' + hour.time.split(' ')[1] + '</p>' +
                    '<img src="https:' + hour.condition.icon + '" alt="weather icon">' +
                    '<p>' + hour.temp_c + '°C</p>' +
                    '</div>'
                );
            }
        });

        // 주간 예보
        const weeklyContainer = $('#weekly-container');
weeklyContainer.empty();
const minGlobal = -10; // 예상 최소 온도
const maxGlobal = 10; // 예상 최대 온도

// 오늘 날짜 확인
const todayDate = new Date().toISOString().split('T')[0];

data.forecast.forecastday.forEach(function (day) {
    const minTemp = day.day.mintemp_c;
    const maxTemp = day.day.maxtemp_c;
    const isToday = day.date === todayDate; // 오늘인지 확인
    const weatherIcon = day.day.condition.icon; // 날씨 아이콘 경로

    // 온도 백분율 계산
    const startPercent = ((minTemp - minGlobal) / (maxGlobal - minGlobal)) * 100;
    const endPercent = ((maxTemp - minGlobal) / (maxGlobal - minGlobal)) * 100;

    weeklyContainer.append(
        '<div class="day">' +
        '<p>' + (isToday ? '오늘' : new Date(day.date).toLocaleDateString('ko-KR', { weekday: 'short' })) + '</p>' +
        '<img src="https:' + weatherIcon + '" alt="날씨 아이콘" class="weather-icon">' + // 날씨 아이콘 추가
        '<div class="temperature-bar">' +
        '<span class="min-temp">' + minTemp + '°</span>' +
        '<div class="bar">' +
        '<div class="fill" style="--start: ' + startPercent + '%; --end: ' + endPercent + '%;"></div>' +
        '</div>' +
        '<span class="max-temp">' + maxTemp + '°</span>' +
        '</div>' +
        '</div>'
    );
});



    }

    fetchWeather();

    // 시간별 날씨 드래그 기능
    let isDown = false;
    let startX;
    let scrollLeft;

    const hourlyForecast = document.querySelector('.hourly-forecast');
    hourlyForecast.addEventListener('mousedown', (e) => {
        isDown = true;
        hourlyForecast.classList.add('active');
        startX = e.pageX - hourlyForecast.offsetLeft;
        scrollLeft = hourlyForecast.scrollLeft;
    });

    hourlyForecast.addEventListener('mouseleave', () => {
        isDown = false;
        hourlyForecast.classList.remove('active');
    });

    hourlyForecast.addEventListener('mouseup', () => {
        isDown = false;
        hourlyForecast.classList.remove('active');
    });

    hourlyForecast.addEventListener('mousemove', (e) => {
        if (!isDown) return;
        e.preventDefault();
        const x = e.pageX - hourlyForecast.offsetLeft;
        const walk = (x - startX) * 2; // 드래그 속도 조절
        hourlyForecast.scrollLeft = scrollLeft - walk;
    });
});


$(document).ready(function () {
    const API_URL = 'http://openapi.seoul.go.kr:8088/594172616a6a616e3931644566524c/xml/AccInfo/1/100';

    $.ajax({
        url: API_URL,
        type: 'GET',
        dataType: 'text', // XML 응답을 텍스트로 처리
        success: function (response) {
            // XML 파싱
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(response, "application/xml");

            // API 응답 코드 확인
            const resultCodeElement = xmlDoc.getElementsByTagName("CODE")[0];
            if (!resultCodeElement || resultCodeElement.textContent.trim() !== "INFO-000") {
                const errorMessageElement = xmlDoc.getElementsByTagName("MESSAGE")[0];
                const errorMessage = errorMessageElement ? errorMessageElement.textContent : "알 수 없는 오류";
                alert("API 오류: " + errorMessage);
                return;
            }

            // row 데이터 추출 및 파싱
            const rows = xmlDoc.getElementsByTagName("row");
            const trafficData = [];
            for (let i = 0; i < rows.length; i++) {
                const row = rows[i];
                const dateElement = row.getElementsByTagName("occr_date")[0];
                const timeElement = row.getElementsByTagName("occr_time")[0];
                const infoElement = row.getElementsByTagName("acc_info")[0];

                // 날짜와 시간을 결합하여 정렬 가능한 데이터 생성
                const rawDate = dateElement ? dateElement.textContent.trim() : null;
                const rawTime = timeElement ? timeElement.textContent.trim() : null;
                const formattedDate = rawDate ? formatDate(rawDate) : "날짜 정보 없음";
                const formattedTime = rawTime ? formatTime(rawTime) : "시간 정보 없음";

                const dateTime = rawDate && rawTime ? rawDate + rawTime : null;

                trafficData.push({
                    datetime: dateTime || "000000000000", // 정렬을 위해 기본값 설정
                    date: formattedDate,
                    time: formattedTime,
                    info: infoElement ? infoElement.textContent.trim() : "정보 없음"
                });
            }

            // 최신순으로 정렬 (datetime 기준 내림차순)
            trafficData.sort((a, b) => b.datetime.localeCompare(a.datetime));

            // 데이터를 화면에 렌더링
            renderTrafficInfo(trafficData);
        },
        error: function (xhr, status, error) {
            console.error("AJAX 호출 오류:", xhr.status, status, error);
            console.error("응답 내용:", xhr.responseText);
            alert("API 호출 중 오류가 발생했습니다.");
        }
    });

 // 날짜를 "YYYY년 MM월 DD일" 형식으로 변환하는 함수
    function formatDate(rawDate) {
        const year = rawDate.substring(0, 4);
        const month = rawDate.substring(4, 6);
        const day = rawDate.substring(6, 8);
        return year + "년 " + month + "월 " + day + "일";
    }

    // 시간을 "HH시 MM분" 형식으로 변환하는 함수
    function formatTime(rawTime) {
        const hour = rawTime.substring(0, 2);
        const minute = rawTime.substring(2, 4);
        return hour + "시 " + minute + "분";
    }


    // 화면에 데이터를 렌더링하는 함수
    function renderTrafficInfo(trafficData) {
        const roadInfoContainer = $('.road-info > div:last-child');
        const ulElement = $('<ul></ul>');

        trafficData.forEach(function (info) {
            const listItem =
                '<li class="road-info-date">' +
                    '<span>' + info.date + ' ' + info.time + '</span>' +
                '</li>' +
                '<li class="road-info-detail">' +
                    '<span>' + info.info + '</span>' +
                '</li>';

            ulElement.append(listItem);
        });

        // 기존 데이터를 초기화하고 새 데이터를 추가
        roadInfoContainer.empty();
        roadInfoContainer.append(ulElement);
    }
});

/*  캘린더 js */

var userDepartment = ${employee.depart_idx};
var specialDays = ${specialDaysJson};

    const calendarEl = document.getElementById('calendar');

    const calendar = new FullCalendar.Calendar(calendarEl, {
        dayMaxEventRows: true,
        dayMaxEvents: 3,
        locale: "ko",
        timeZone: "Asia/Seoul",
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek'
        },
        views: {
            timeGridWeek: {
                titleFormat: {month: 'short', day: 'numeric' } 
            }
        },
        initialDate: new Date(),
        eventDidMount: function(info) {
            const resizer = info.el.querySelector('.fc-event-resizer');
            if (resizer) {
                resizer.style.width = '10px';
                resizer.style.height = '10px';
                resizer.style.backgroundColor = '#007bff';
                resizer.style.cursor = 'se-resize';
            }
        },
            events: function(fetchInfo, successCallback, failureCallback) {
            const filter = document.getElementById('visibilityFilter').value;

            fetch('events.ajax')
                .then(response => response.json())
                .then(data => {
                    const addNineHours = (utcTime) => {
                        const date = new Date(utcTime);
                        date.setHours(date.getHours() + 9);
                        return date.toISOString();
                    };
                    const filteredEvents = data.map(event => ({
                        ...event,
                        start: addNineHours(event.start),
                        end: addNineHours(event.end)
                    })).filter(event => {
                        if (filter === 'public') {
                            return event.department === userDepartment && event.visibility === 'public';
                        } else if (filter === 'private') {
                        	return event.employeeIdx === loginId && event.visibility === 'private';
                        } else if (filter === 'all') {
                        	return event.visibility === 'all';
                        }
                        return false;
                    });
                    //console.log("Filtered Events (JSON):", JSON.stringify(filteredEvents, null, 2));
                   // console.log("filteredEvents테스트:"+filteredEvents);
                    successCallback(filteredEvents);
                    updateTodoList(new Date());
                })
                .catch(error => {
                    failureCallback(error);
                });
        },
        dayCellDidMount: function(info) {
            const viewType = info.view.type;
            const day = info.date.getDay();
            const formattedDate = info.date.toISOString().split('T')[0];
            if (specialDays[formattedDate]) {
                // 날짜 셀에 텍스트 추가
                const dayNumberElement = info.el.querySelector('.fc-daygrid-day-frame');
                if (dayNumberElement) {
                    const label = document.createElement('span');
                    label.textContent = ' (' + specialDays[formattedDate] + ')'; // 문자열 연결 방식
                    label.style.color = '#D32F2F'; // 텍스트 색상
                    label.style.fontSize = '0.8em'; // 텍스트 크기
                    dayNumberElement.appendChild(label);
                    
                    const dayNumberText = info.el.querySelector('.fc-daygrid-day-number');
                    if (dayNumberText) {
                        dayNumberText.style.color = '#D32F2F'; // 빨간색
                    }
                }
            }

            if (viewType === 'timeGridWeek') {
                if (day === 6 || day === 0 ) {
                    const timeSlots = document.querySelectorAll(
                        '.fc-timegrid-col[data-date="' + formattedDate + '"]'
                    );
                    timeSlots.forEach(slot => {
                        slot.style.setProperty('background-color', '#FFEBEE00', 'important');
                    });
                }
                return;
            }

            const dayCellElement = info.el;
            if (dayCellElement) {
                if (day === 6 || day === 0) {
                    const dayNumberElement = info.el.querySelector('.fc-daygrid-day-number');
                    if (dayNumberElement) {
                        dayNumberElement.style.setProperty('color', '#D32F2F', 'important');
                    }
                    info.el.style.setProperty('background-color', '#FFEBEE00', 'important');
                }
            }
        }
    });

    calendar.render();
    const todayDate = new Date(); 
    updateTodoList(todayDate);
    function updateTodoList(date){
        const clickedDate = date.toISOString().split('T')[0];

        const subjectBox = document.querySelector('#todo-subject-box h2');
        if (subjectBox) {
            subjectBox.textContent = clickedDate + ' To Do List!';
        }
        const visibilityFilter = document.getElementById('visibilityFilter').value; 
        const allEvents = calendar.getEvents();
        	//console.log("테스트종qweqwe:"+JSON.stringify(allEvents, null, 2));
        const eventsForDate = allEvents.filter(function(event) {
            const eventStartDate = event.start.toISOString().split('T')[0]; 
            const eventEndDate = event.end.toISOString().split('T')[0]; 
            const isInDateRange = clickedDate == eventStartDate && clickedDate <= eventEndDate;
            return isInDateRange;

        });

        // 3. `todolist`에 들어갈 데이터 업데이트
        const todoList = document.getElementById('todolist');
        if (todoList) {
            // 기존 내용 제거
            todoList.innerHTML = '';

            // 이벤트 데이터 추가
            eventsForDate.forEach(function(event) {
                const listBox = document.createElement('div');
                listBox.className = 'list-box';

                // `date-time` 생성 및 내용 추가
                const dateTime = document.createElement('div');
                dateTime.className = 'date-time';
                const eventTime = event.allDay
                ? 'All Day' // 하루 종일 이벤트
                : formatTimeWithOffset(event.start, -9) + 
                  ' ~ ' + (event.end ? formatTimeWithOffset(event.end, -9) : 'End');

                function formatTimeWithOffset(date, offsetHours) {
                    const adjustedDate = new Date(date.getTime());
                    
                    adjustedDate.setHours(adjustedDate.getHours() + offsetHours);
                    
                    const hours = adjustedDate.getHours().toString().padStart(2, '0');
                    const minutes = adjustedDate.getMinutes().toString().padStart(2, '0');
                    return hours + ':' + minutes;
                }

                dateTime.textContent = eventTime;

                // `date-content` 생성 및 내용 추가
                const dateContent = document.createElement('div');
                dateContent.className = 'date-content';
                dateContent.textContent = event.title + ' - ' + event.extendedProps.employeeName;

                // `list-box`에 추가
                listBox.appendChild(dateTime);
                listBox.appendChild(dateContent);

                // `todolist`에 추가
                todoList.appendChild(listBox);
            });

            // 이벤트가 없을 경우 메시지 표시
            if (eventsForDate.length === 0) {
                const emptyMessage = document.createElement('div');
                emptyMessage.textContent = '등록된 일정이 없습니다.';
                todoList.appendChild(emptyMessage);
            }
        }
        
    }


    // 필터 변경 시 이벤트 갱신
    document.getElementById('visibilityFilter').addEventListener('change', function() {
        // 기존 이벤트 소스 제거
        calendar.getEventSources().forEach(source => source.remove());

        // 새 이벤트 소스 추가
        calendar.addEventSource({
            events: function(fetchInfo, successCallback, failureCallback) {
                const filter = document.getElementById('visibilityFilter').value;

                fetch('events.ajax')
                    .then(response => response.json())
                    .then(data => {
                        const addNineHours = (utcTime) => {
                            const date = new Date(utcTime);
                            date.setHours(date.getHours() + 9);
                            return date.toISOString();
                        };

                        const filteredEvents = data.map(event => ({
                            ...event,
                            start: addNineHours(event.start),
                            end: addNineHours(event.end)
                        })).filter(event => {
                            if (filter === 'public') {
                                return event.department === userDepartment && event.visibility === 'public';
                            } else if (filter === 'private') {
                            	return event.employeeIdx === loginId && event.visibility === 'private';
                            } else if (filter === 'all') {
                            	return event.visibility === 'all';
                            }
                            return false;
                        });

                        successCallback(filteredEvents);
                        updateTodoList(todayDate);
                    })
                    .catch(error => {
                        failureCallback(error);
                    });
            }
        });

        // 캘린더 다시 로드
        calendar.refetchEvents();
    }); 

/* 여기까지 캘린더 */ 
/* 차트 */
let currentDate = new Date();
var year = '';
function updateDateDisplay() {
    const currentDateElement = document.querySelector('.current-date');
    year = currentDate.getFullYear();
    currentDateElement.textContent = year + '년';
    fetchChart(year);
}
updateDateDisplay();

function fetchChart(date){
	$.ajax({
		method: 'POST',
		url: 'fetchYearChart.ajax',
		data: {
			'year': date
		},
		dataType: 'JSON',
		success: function(data){
            const baseLabels = ['1월', '2월', '3월', '4월', '5월', '6월', 
                '7월', '8월', '9월', '10월', '11월', '12월'];
			let labels = [];
			let amounts = [];
			
			if (data.list) {
			
				baseLabels.forEach(month => {
				    const item = data.list.find(d => d.month === month);
				    if (item) {
				        labels.push(item.month);
				        amounts.push(item.totalAmount);
				    } else {
				        labels.push(month);
				        amounts.push(0); 
				    }
				});
			} else {
			labels = baseLabels;
			amounts = Array(12).fill(0);
			}
	        if(data.msg == '성공'){
	            renderChart(labels, amounts);
        	}else{
	            renderChart([], []);
        	}
		},
		error: function(e){
			modal.showAlert('잠시 후 다시 시도해주세요.');
		}
	});
	
}
function renderChart(labels,amounts){

	const maxValue = Math.max(...amounts);
	const minValue = Math.min(...amounts);
	
	const barColors = amounts.map(value => {
	  if (value === maxValue) return '#E9396B'; 
	  /* if (value === minValue) return '#6C0F6C'; */
	  if (value === minValue) return '#FFD700';
	  return '#30005A'; 
	});
	const ctx = document.getElementById('cardChart').getContext('2d');
	 myChart = new Chart(ctx, {
	  type: 'bar',
	  data: {
	    labels: labels, 
	    datasets: [{
	      label: '월별 정산',
	      data: amounts, 
	      backgroundColor: barColors, 
	      borderRadius: 10, 
	      borderSkipped: false, 
	    }]
	  },
	  options: {
	    plugins: {
	      legend: {
	        display: false, 
	      }
	    },
	    scales: {
	      x: {
	        ticks: {
	          color: '#30005A', 
	          font: {
	              size: 14, 
	              weight: 'bold', 
	            }
	        }
	      },
	      y: {
	        beginAtZero: true, 
	        ticks: {
	          color: '#30005A', 
	          font: {
	              size: 14, 
	              weight: 'bold', 
	            }
	        }
	      }
	    }
	  }
	});
};

getDepartmentNmae();
function getDepartmentNmae(){
	$.ajax({
	    url: "getDepartmentNmae.ajax", 
	    type: "POST",                 
	    data: { 
	        loginId: loginId         
	    },
	    dataType: 'json',            
	    success: function (response) {
	        if (response && response.msg === "성공") {  
	            $('.departName').empty();              
	            let row = response.departmentName; 
	            if (row == '미발령') {
					row = '부서';
				}
	            $('.departName').text(row);           
	        } else {
	        }
	    },
	    error: function (xhr, status, error) {
	        console.error("에러:", error);
	    }
	});

	
}

/* 여기까지 차트 end */

</script>
</html>
