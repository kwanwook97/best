<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/main.min.css" rel="stylesheet">
  <script src="/BEST/resources/js/index.global.js"></script>
  <style>
  :root{
      --primary-color: #30005A;
      --secondary-color: #8B6AA7;
      --accent-color: #E9396B;
      
   }
  #calendar1 {
    width: 80%; 
    margin: 0 0 0 0; 
    background-color: #ffffff;
    padding: 20px; 
    border-radius: 8px; 
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border: 2px solid #30005A;
  }
    .dashboard-body{
       margin-left: 14vw;
       width: 85vw;
       margin-top: 7vh;
       flex-wrap: wrap;
       padding: 2vh;
       color: var(--primary-color);
       border: 1px solid black;
       height: 92%;
       display: flex;
       flex-direction: column;
       align-content: center;
       align-items: flex-start;
       justify-content: center;
   }
  /* 시계 스타일 */
  #clock {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
    text-align: center; 
  }
    .container {
      display: flex;
      width: 90%;
      max-width: 1200px;
      gap: 20px;
    }

    #calendar-container {
      flex: 2;
      background-color: #8b6aa700;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      border:2px solid #30005A;
    }

	#todo-container {
	  flex: 1;
	  background-color: #8b6aa700;
	  border-radius: 8px;
	  padding: 20px;
	  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	  display: flex;
	  flex-direction: column;
	  border: 2px solid #30005A;
	  overflow-y: auto; /* 넘칠 경우 스크롤 표시 */
	  height: 400px; /* 고정 높이 설정 */
	  gap: 15px; /* 자식 요소 간격 */
	  height: 600px;
	}

    #todo-container h2 {
      margin: 0 0 0 0;
      text-align: center;
      font-size: 24px;
      color: #FFF5E2;
      
    }



#todolist {
  flex: 1;
  overflow-y: auto;
  display: flex; /* Flexbox 활성화 */
  flex-direction: column; /* 세로 방향으로 정렬 */
  gap: 15px; /* 자식 요소 간의 간격 */
  padding: 10px; /* 내부 여백 추가 (선택 사항) */
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
	  display: flex; /* Flexbox 활성화 */
	  align-items: center; /* 세로 중앙 정렬 */
	  justify-content: center; /* 가로 중앙 정렬 */
	  padding: 10px; /* 내부 여백 추가 (선택 사항) */
	}
	
	/* 캘린더 날짜 색 */
	.fc-daygrid-day-number{
		color: black;
	}
	
	/* 캘린더 이벤트 등록된 배경색 */
	.fc-event-main {
	  background-color: #3788d8; /* 원하는 배경색 */
	  color: white; /* 텍스트 색상 */
	  border: none; /* 테두리를 제거하려면 */
	  border-radius: 5px; /* 둥근 모서리 */
	}
	/* 투두리스트 */
.list-box {
  display: flex; /* Flexbox 활성화 */
  align-items: center; /* 세로 중앙 정렬 */
  justify-content: space-between; /* 요소 간의 공간을 균등 분배 */
  background-color: #ffffff00; /* 배경색 */
  border: 2px solid #30005A; /* 테두리 색 */
  border-radius: 10px; /* 둥근 모서리 */
  padding: 10px; /* 내부 여백 */
  margin-bottom: 10px; /* 리스트 간 간격 */
  font-size: 14px; /* 글씨 크기 */
  color: #30005A; /* 텍스트 색상 */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
}

.date-time {
  font-weight: bold; /* 텍스트를 굵게 */
  margin-right: 20px; /* 오른쪽 여백 */
  flex-shrink: 0; /* 시간이 축소되지 않도록 설정 */
}

.date-content {
  flex-grow: 1; /* 남은 공간을 채움 */
  text-align: left; /* 텍스트 왼쪽 정렬 */
  color: #30005A; /* 텍스트 색상 */
}

	
  </style>
  
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
 		<h2 id="clock">00:00:00</h2>
 		
		  <div class="container">
		    <div id="calendar-container">
		      <div id="calendar"></div>
		    </div>
		    <div id="todo-container">
			    <div id="todo-subject-box">
			      <h2>Today To Do List !</h2>
			    </div>
		      	<div id="todolist">
		      		<div class="list-box">
		      			<div class="date-time">9:00</div>
		      			<div class="date-content">이러쿵저러쿵</div>
		      		</div>
		      		<div class="list-box">
		      			<div class="date-time">9:00</div>
		      			<div class="date-content">이러쿵저러쿵</div>
		      		</div>
		      		<div class="list-box">
		      			<div class="date-time">9:00</div>
		      			<div class="date-content">이러쿵저러쿵</div>
		      		</div>
		      		<div class="list-box">
		      			<div class="date-time">9:00</div>
		      			<div class="date-content">이러쿵저러쿵</div>
		      		</div>
		      	</div>
		    </div>
		  </div>
 	</div>
</body> 
<script>
document.addEventListener('DOMContentLoaded', function() {
	  var calendarEl = document.getElementById('calendar');

	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    headerToolbar: {
	      left: 'prev,next today',
	      center: 'title',
	      right: 'dayGridMonth,timeGridWeek'
	    },
	    initialDate: new Date(), // 현재 날짜로 초기화
	    navLinks: true, // can click day/week names to navigate views
	    selectable: true,
	    selectMirror: true,
	    select: function(arg) {
	      var title = prompt('할일 등록:');
	      if (title) {
	        calendar.addEvent({
	          title: title,
	          start: arg.start,
	          end: arg.end,
	          allDay: arg.allDay
	        })
	      }
	      calendar.unselect();
	    },
	    eventClick: function(arg) {
	      if (confirm('일정을 삭제하시겠습니까?')) {
	        arg.event.remove();
	      }
	    },
	    editable: true,
	    dayMaxEvents: true, // allow "more" link when too many events
	    events: []
	  });

	  calendar.render();
	});
	
function updateClock() {
    const curtime = new Date()
    const timeString = String(curtime.getHours()).padStart(2, "0") + ":" +
        String(curtime.getMinutes()).padStart(2, "0") + ":" +
        String(curtime.getSeconds()).padStart(2, "0")

    $('#clock').text(timeString)
}

setInterval(updateClock, 1000)
updateClock()
</script>
</html>
