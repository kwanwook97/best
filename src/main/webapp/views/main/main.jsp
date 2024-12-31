<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href="resources/css/dashBoard.css" rel="stylesheet"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
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
 		<div><span>연간 매출</span></div>
 		<div class="year-graph2">
 			<div>
 				<div class="year-graph3"></div><span>1월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>2월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>3월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>4월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>5월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>6월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>7월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>8월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>9월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>10월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>11월</span>
 			</div>
 			<div>
 				<div class="year-graph3"></div><span>12월</span>
 			</div>
 		</div>
 	</div>
 	<div class="dash-calendar">
 	
 	</div>
 	<div class="todoList">
 		<div><span>To Do List!</span></div>
 		<div class="todoList2"></div>
 	</div>
 	<div class="road-info">
 		<div><span>오늘의 교통 정보</span></div>
 		<div>
 			<ul>
 				<li><span>2024년 12월 04일 13시 58분</span></li>
 				<li><span>[사고] 올림픽대로성수대교영동대교3차로교통사고</span></li>
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
                console.log(data); // API 응답 확인
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



</script>
</html>
