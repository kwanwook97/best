<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/main.min.css" rel="stylesheet">
  <script src="resources/js/index.global.js"></script>
  
  <style>
  :root{
      --primary-color: #30005A;
      --secondary-color: #8B6AA7;
      --accent-color: #E9396B;
      
   }

    .dashboard-body{
       margin-left: 14vw;
       width: 85vw;
       margin-top: -1vh;
       flex-wrap: wrap;
       padding: 2vh;
       color: var(--primary-color);
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
      max-height: 64%;
      margin: 31% 0 0 0;
    }
    #calendar {
    	height: 100%;
    	max-height: 84%;
    	width: 100%;
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

/* 캘린더 설정  */
.fc a[data-navlink]{
	color: black;
}
/* a 태그 비활성화 */
.fc-col-header-cell-cushion {
  pointer-events: none; /* 클릭 비활성화 */
  cursor: default; /* 커서를 기본 모양으로 변경 */
}
/* 회의실 예약 */
.meeting-add{
	position: absolute;
	top: 200px;
}
/* 회의실 정보,예약 */
.btninfo{
	margin: 0 0 50px 0;
}	
.btnadd{
	margin: 0 0 50px 50px;
}	

/* 회의실 예약 모달 */
.meetingmodal {
    display: none; /* 초기 상태는 숨김 */
    position: fixed;
    top: 8%;
    left: 50%;
    transform: translate(0%, 0%);
    background-color: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    z-index: 1000;
}

.modal-content {
    width: 100%;
    max-width: 500px;
}
.la {
	color: black;
}
#start-time {
    max-height: 100px; /* 드롭다운 최대 높이 */
    overflow-y: auto;  /* 스크롤바 활성화 */
}
#start-time option,#end-time option{
	background-color: white; 
}
.groupbtn{
	margin: 0 0 0 64%;
}
/* 미팅룸 img */
#room-image {
	width: 100%;
	margin: 0 0 0 0;
	border-radius: 10px;
	display: none; 
	height: auto;
}
.form-group{
	margin: 2% 0 0 0;
}

/* 예약자 */
.emp-name{
	display: contents;
}
.room-box{
	background-color: white;
}
/* 모달 제목 라인 */
.box-line{
	width: 100%;
	height: 1px;
	background-color: rgb(0 0 0 0); 
}
.room-btn-container {
    display: flex; /* 버튼 정렬을 위해 flex 사용 */
    gap: 10px; /* 버튼 간격 */
    margin: 10px;
}
.room-btn {
	border-radius: 10px;
}
#room-name {
	display: contents;
}
/* .thing{
	list-style: none; 
	display: flex;	
	gap: 10px; 
	padding: 0px;
}
.thing li {
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 14px;
	text-align: center;
}
.thing-box{
	display: inline-flex;
} */

/* 캘린더 이벤트 폰트색상 */
.fc-event-time,.fc-event-title {
	color: black;
}
.fc-list-event-title {
	color: black;
}
.fc-list-event-time {
	color: black;
}

/* 캘린더 이벤트 폰트색 */
.fc-event-main {
	color: black !important;
}
.fc-event span {
	color: black !important;
}
.fc-event b {
	color: black !important;
}
.event-box {
	background-color: #3788d8;
	border-radius: 10px;
	padding: 4px;
}

/* 회의실 예약 현황  */
        .table-container {
            border: 2px solid #30005A;
            border-radius: 10px;
            padding: 20px;
            background-color: #fdf8fc00;
            width: 628px;
            height: 466px;
            position: relative;
            top:92px;
            overflow-y: auto;
        }
        .table-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: white;
            font-size: 24px;
            font-weight: bold;
            background-color: #30005A;
            border-radius: 10px;
        }
        .table-row {
            display: flex;
            padding: 10px;
            border-bottom: 1px solid #8B6AA7;
        }
        .table-row.header {
            background-color: #8B6AA7;
            color: #30005A;
            font-weight: bold;
        }
        .table-row div {
            flex: 1;
            text-align: center;
            padding: 5px;
        }

		.table-row-point:hover {
		    background-color: #f0f8ff; 
		    color: #000000;
		    cursor: pointer;
		}
        
/*   예약 상세   */
        .detail-table-container {
            border: 2px solid #30005A;
            border-radius: 10px;
            padding: 10px;
            background-color: #fdf8fc00;
            width: 628px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            position: relative;
            top: 120px;
        }
        .detail-table-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #30005A;
            font-size: 24px;
            font-weight: bold;
            background-color: #30005A;
            color: white;
            border-radius: 10px;
        }
        .detail-table {
            width: 100%;
            border-collapse: collapse;
        }
        .detail-table th, .detail-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #8B6AA7;
        }
        .detail-table th {
            width: 30%;
            background-color: #8B6AA7;
            color: #30005A;
            font-weight: bold;
        }
        .detail-table td {
            color: #333;
        }
        .detail-table tr:last-child td {
            border-bottom: none;
        }
        
/* 회의실 헤더 */
	.title-name{
		display: block;
		position: absolute;
		top: 12%;
		left: 17%;
		width: 79%;
	}
	.title-line{
		width: 100%;
		height: 1px;
		background-color: #100f0f4a;
	}
  </style>
  
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
  	<div class="title-name">
	    <h1>회의실 예약</h1>
	    <div class="title-line"></div>
	</div>
 	<div class="dashboard-body">
		  <div class="container">
				<!-- <h2 class="meeting-add">회의실 예약</h2> -->
		    <div id="calendar-container">
				<button class="btninfo btn-primary" onclick="getInfo()">회의실정보</button>
				<button class="btnadd btn-primary" onclick="openModal()">예약하기</button>
				<div id='calendar'></div>
		    </div>
		  </div>
		    <div class="table-container" id="table-container">
		        <h2>회의실 예약 현황</h2>
		        <!-- Header Row -->

			        <div class="table-row header">
			            <div>시간</div>
			            <div>회의실</div>
			            <div>회의 부서</div>
			            <div>직급</div>
			            <div>예약자</div>
			        </div>
			        <!-- Data Rows -->
		        <div id="reservation-list">
					<div class="table-row" >
						선택하신 날짜가 없습니다.
					</div>
		        </div>
		    </div>
		    <div class="detail-table-container">
		        <h2>예약 상세</h2>
		        <table class="detail-table">
		            <tr>
		                <th>시간</th>
		                <td></td>
		            </tr>
		            <tr>
		                <th>회의실</th>
		                <td></td>
		            </tr>
		            <tr>
		                <th>회의 부서</th>
		                <td></td>
		            </tr>
		            <tr>
		                <th>회의 목적</th>
		                <td></td>
		            </tr>
		            <tr>
		                <th>예약자</th>
		                <td></td>
		            </tr>
		            <tr>
		                <th>기자재</th>
		                <td></td>
		            </tr>
		        </table>
		    </div>

 	</div>
 	
 	
 	
 	
 	
 	
 	
<div class="meetingmodal">
  <div class="modal-content">
	<h2>회의실 예약</h2>
	<div class="box-line"></div>
	<div class="room-btn-container">
		<c:forEach var="room" items="${roomList}">
			<button value="${room.room_idx}" class="btn-primary room-btn" data-photo="${room.photo}" data-name="${room.name}">${room.name}</button>
		</c:forEach>
	</div>
		<div id="room-image-container">
		    <img id="room-image" src="" alt="회의실 이미지"/>
		</div>
    <form>
	<input type="hidden" id="emp_idx" value="1" >    
      <div class="form-group">
        <label class="la" for="room">회의실:</label>
		<p id="room-name"></p>
 		<input id="hidden-room-idx" value="" name="room_idx" type="hidden">
      </div>
      <div class="form-group">
        <label class="la" for="date">예약자:</label>
        <p class="emp-name">사원 이름 부서</p> 
      </div>
      
      <div class="form-group">
        <label class="la" for="date">날짜:</label>
        <input type="date" id="date" name="date">
      </div>
      
		<div class="form-group">
			  <label class="la" for="start-time">시작 시간:</label>
			  <select id="start-time" name="start-time">
			  	<option>01:00</option>
			  	<option>02:00</option>
			  	<option>03:00</option>
			  	<option>04:00</option>
			  	<option>05:00</option>
			  	<option>06:00</option>
			  	<option>07:00</option>
			  	<option>08:00</option>
			  	<option>09:00</option>
			  	<option>10:00</option>
			  	<option>11:00</option>
			  	<option>12:00</option>
			  	<option>13:00</option>
			  	<option>14:00</option>
			  	<option>15:00</option>
			  	<option>16:00</option>
			  	<option>17:00</option>
			  	<option>18:00</option>
			  	<option>19:00</option>
			  	<option>20:00</option>
			  	<option>21:00</option>
			  	<option>22:00</option>
			  	<option>23:00</option>
			  	<option>24:00</option>
			  </select>
			
			  <label class="la" for="end-time">종료 시간:</label>
			  <select id="end-time" name="end-time">
			  	<option>01:00</option>
			  	<option>02:00</option>
			  	<option>03:00</option>
			  	<option>04:00</option>
			  	<option>05:00</option>
			  	<option>06:00</option>
			  	<option>07:00</option>
			  	<option>08:00</option>
			  	<option>09:00</option>
			  	<option>10:00</option>
			  	<option>11:00</option>
			  	<option>12:00</option>
			  	<option>13:00</option>
			  	<option>14:00</option>
			  	<option>15:00</option>
			  	<option>16:00</option>
			  	<option>17:00</option>
			  	<option>18:00</option>
			  	<option>19:00</option>
			  	<option>20:00</option>
			  	<option>21:00</option>
			  	<option>22:00</option>
			  	<option>23:00</option>
			  	<option>24:00</option>
			  </select>
		</div>
      <p class="sometext"> 
      <div class="form-group">
        <label class="la" for="title">회의 제목:</label>
        <input type="text" id="title" name="title">
      </div>
      <div class="groupbtn">
      <button type="submit">예약</button>
      <button class="modalClose" type="button" onclick="closeModal()">취소</button>
      </div>
    </form>
  </div>
</div>
</body> 
<script>
document.addEventListener('DOMContentLoaded', function loadEvt() {
    var calendarEl = document.getElementById('calendar');
    


    var calendar = new FullCalendar.Calendar(calendarEl, {
    	locale:"ko",
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
        },
        initialView: 'dayGridMonth',
        initialDate: new Date(),
/*        slotMinTime: '09:00:00', // 캘린더 시작 시간
        slotMaxTime: '18:00:00', // 캘린더 종료 시간
        businessHours: {
            daysOfWeek: [1, 2, 3, 4, 5], // 월~금
            startTime: '09:00',
            endTime: '18:00',
        }, */
        weekends: false,
        allDaySlot: false,
        editable: true,
        selectable: true,
        dateClick: function (info) {
            console.log("클릭된 날짜:", info.dateStr);

            // 해당 날짜에 있는 이벤트 필터링
const events = calendar.getEvents();
console.log("캘린더에 로드된 이벤트:", events);

if (events.length === 0) {
    console.error("캘린더에 로드된 이벤트가 없습니다.");
}
            const filteredEvents = calendar.getEvents().filter(event => {
                console.log("이벤트 시작 날짜 (event.start):", event.start);
                console.log("event.start instanceof Date:", event.start instanceof Date); // 출력: true
                console.log(event.start.toISOString()); // 정상 출력되면 Date 객체임
                const eventDate = new Date(event.start.getTime() + 9 * 60 * 60 * 1000) // 9시간 더하기
                .toISOString()
                .split('T')[0]; // ISO 형식으로 변환 후 날짜 부분만 추출
                console.log("날짜 테스트 :",eventDate); // 정상 출력되면 Date 객체임
                console.log("날짜 테스트 :",info.dateStr); // 정상 출력되면 Date 객체임
                return eventDate === info.dateStr; // 클릭된 날짜와 비교
            console.log("해당 eventDate:", eventDate);
            console.log("해당 info.dateStr",info.dateStr);
            });
            console.log("해당 날짜의 이벤트:", filteredEvents);

            // 회의실 예약 현황 리스트 업데이트
            const listContainer = document.querySelector('#reservation-list'); // 리스트 컨테이너 div
            listContainer.innerHTML = ""; // 기존 리스트 초기화

            filteredEvents.forEach(event => {
                const row = document.createElement('div'); // 각 행을 나타낼 div
                row.classList.add('table-row'); // 스타일링을 위해 클래스 추가
                row.classList.add('table-row-point'); // 스타일링을 위해 클래스 추가

                // 각 열을 나타내는 div 생성 및 추가
				 const timeDiv = document.createElement('div');
				timeDiv.textContent = event.start.toLocaleTimeString('ko-KR', { 
				    hour: '2-digit', 
				    minute: '2-digit', 
				    hour12: false // 24시간 형식
				}) + ' ~ ' + 
				event.end.toLocaleTimeString('ko-KR', { 
				    hour: '2-digit', 
				    minute: '2-digit', 
				    hour12: false // 24시간 형식
				});
				row.appendChild(timeDiv);
				
                const roomDiv = document.createElement('div');
                roomDiv.textContent = event.extendedProps.room_name || '정보 없음';
                row.appendChild(roomDiv);

                const departDiv = document.createElement('div');
                departDiv.textContent = event.extendedProps.depart_name || '정보 없음';
                row.appendChild(departDiv);

                const rankDiv = document.createElement('div');
                rankDiv.textContent = event.extendedProps.rank_name || '정보 없음';
                row.appendChild(rankDiv);

                const reserverDiv = document.createElement('div');
                reserverDiv.textContent = (event.extendedProps.name || '정보 없음')
                row.appendChild(reserverDiv);

                // 숨겨진 입력 필드 (회의 목적)
                const purposeInput = document.createElement('input');
                purposeInput.type = 'hidden';
                purposeInput.value = event.title || '정보 없음';
                row.appendChild(purposeInput);
                console.log(" 회의 제목 : " , purposeInput);

                // 숨겨진 입력 필드 (기자재)
                const equipmentInput = document.createElement('input');
                equipmentInput.type = 'hidden';
                equipmentInput.value = event.extendedProps.equipment || '정보 없음';
                row.appendChild(equipmentInput);
                
                // 리스트 컨테이너에 추가
                listContainer.appendChild(row);
                
             // 클릭 이벤트 추가
                row.addEventListener('click', () => {
                    const detailTable = document.querySelector('.detail-table-container .detail-table');

                    // 디테일 컨테이너 업데이트
					detailTable.innerHTML = 
					    '<tr>' +
					        '<th>시간</th>' +
					        '<td>' + event.start.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit', hour12: false }) + 
					        ' ~ ' + event.end.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit', hour12: false }) + '</td>' +
					    '</tr>' +
					    '<tr>' +
					        '<th>회의실</th>' +
					        '<td>' + (event.extendedProps.room_name || '정보 없음') + '</td>' +
					    '</tr>' +
					    '<tr>' +
					        '<th>회의 부서</th>' +
					        '<td>' + (event.extendedProps.depart_name || '정보 없음') + '</td>' +
					    '</tr>' +
					    '<tr>' +
					        '<th>회의 목적</th>' +
					        '<td>' + (event.title || '정보 없음') + '</td>' +
					    '</tr>' +
					    '<tr>' +
					        '<th>예약자</th>' +
					        '<td>' + (event.extendedProps.name || '정보 없음') + 
					        ' (' + (event.extendedProps.rank_name || '직급 없음') + ')</td>' +
					    '</tr>' +
					    '<tr>' +
					        '<th>기자재</th>' +
					        '<td>' + (event.extendedProps.equipment || '정보 없음') + '</td>' +
					    '</tr>';


                    // 디테일 컨테이너 표시
                    document.querySelector('.detail-table-container').style.display = 'block';
                });
            });

            // 데이터가 없을 경우 메시지 표시
            if (filteredEvents.length === 0) {
                const row = document.createElement('div');
                row.classList.add('table-row'); // 스타일 추가
                row.textContent = "해당 날짜에 예약된 회의가 없습니다.";
                listContainer.appendChild(row);
            }
        },
        eventClick: function(arg) {
            if (confirm('일정을 삭제하시겠습니까?')) {
                const reserveIdx = arg.event.id; // FullCalendar 이벤트의 ID (reserve_idx)
                
                // 서버로 삭제 요청
                $.ajax({
                    url: 'removeCalendarEvents.ajax',
                    method: 'POST',
                    data: { reserve_idx: reserveIdx },
                    success: function(response) {
                        if (response.success) {
                            arg.event.remove(); // 캘린더에서 이벤트 제거
                        } else {
                            alert('일정 삭제에 실패했습니다.');
                        }
                    },
                    error: function() {
                        alert('삭제 요청 중 오류가 발생했습니다.');
                    }
                });
            }
        },
        events: function(info, successCallback, failureCallback) {
            $.ajax({
                url: 'getCalendarEvents.ajax',
                method: 'GET',
                data: {
                    start: info.start.toISOString(), // ISO 형식으로 변환된 시작 날짜
                    end: info.end.toISOString()     // ISO 형식으로 변환된 종료 날짜
                },
                success: function(response) {
                    console.log("서버 응답 데이터: ", response);

                    // FullCalendar 형식으로 데이터 변환
                    const events = response.map(event => {
                        console.log("이벤트 데이터 변환: ", event); // 여기서 각 이벤트 데이터를 확인
                        return {
                            id: event.id,
                            title: event.title,
                            start: event.start,
                            end: event.end,
                            extendedProps: {
                                room_idx: event.room_idx,
                                room_name: event.room_name,
                                name: event.name,
                                rank_idx: event.rank_idx,
                                rank_name: event.rank_name,
                                depart_idx: event.depart_idx,
                                depart_name: event.depart_name,
                                emp_idx: event.emp_idx
                            }
                        };
                    });

                    console.log("변환된 이벤트 목록: ", events); // 변환된 배열 전체를 확인
                    successCallback(events); // FullCalendar에 전달
                },

                error: function() {
                    console.error("이벤트 데이터를 가져오는 데 실패했습니다.");
                    failureCallback(); // 실패 처리
                }
            });
        },
        eventContent: function(arg) {
            console.log("전체 이벤트 객체 확인:", arg.event);
            console.log("extendedProps 데이터 확인 (from _def):", arg.event._def.extendedProps);

            // `_def.extendedProps`에서 데이터 가져오기
            const extendedProps = arg.event._def.extendedProps;

            // 시간 포맷 설정
            const startTime = arg.event.start.toLocaleTimeString('ko-KR', {
                hour: '2-digit',
                minute: '2-digit'
            });

            const endTime = arg.event.end.toLocaleTimeString('ko-KR', {
                hour: '2-digit',
                minute: '2-digit'
            });
            console.log("startTime :", startTime);
            console.log("endTime :", startTime);
            console.log("extendedProps :", extendedProps);

            const roomName = extendedProps.room_name || '정보 없음';
            const reserverName = extendedProps.name || '알 수 없음';
            const rankName = extendedProps.rank_name || '직급 없음';

            console.log("렌더링 데이터 확인:", { roomName, reserverName, rankName, startTime, endTime });

            return {
                html: 
                    '<div class="event-box">' +
                        '<b>회의실: ' + roomName + '</b><br>' +
                        '<b>시간: ' + startTime + ' - ' + endTime + '</b><br>' +
                        '<b>예약자: ' + reserverName + ' (' + rankName + ')</b><br>' +
                        '<b>회의 제목:' + (arg.event.title || '제목 없음') + '</b>' +
                    '</div>'
            };
        }

    });

    calendar.render();
});

/* 
function saveCall(){
	
	
	
	$.ajax({
	    url: "your_url", // 요청을 보낼 서버의 URL
	    method: "GET", // 요청 방식 (GET, POST 등)
	    data: {
	        // 서버로 전송할 데이터 (key-value 형식)
	        param1: "value1",
	        param2: "value2"
	    },
	    success: function(response) {
	        // 요청이 성공했을 때 실행되는 함수
	        console.log(response); // 서버에서 받은 응답 데이터
	    },
	    error: function(xhr, status, error) {
	        // 요청이 실패했을 때 실행되는 함수
	        console.error(error);
	    }
	});
} */
function openModal() {
    document.querySelector('.meetingmodal').style.display = 'block';
}
function closeModal() {
    document.querySelector('.meetingmodal').style.display = 'none';
}
const startValue = $('#start-time').val();
console.log(startValue);
const endValue = $('#end-time').val();
console.log(endValue);

$(document).ready(function () {
	  const $startTimeSelect = $("#start-time");
	  const $endTimeSelect = $("#end-time");
	  const $form = $("form");
	  

	  $startTimeSelect.on("change",function(){
		    const startTime = $startTimeSelect.val();
		    const endTime = $endTimeSelect.val();
		  if (startTime >= endTime ) {
			  $(".sometext").text('시작시간은 종료시간보다 작아야 합니다.');
			  $startTimeSelect.val("01:00");			  
		}else{
			  $(".sometext").text('');
			  $endTimeSelect.val("01:00");			  

		}
		  
	  });
	  
	  
	  // 종료 시간 선택 시 검증
	  $endTimeSelect.on("change", function () {
	    const startTime = $startTimeSelect.val();
	    const endTime = $endTimeSelect.val();

	    if (endTime <= startTime) {
		  $(".sometext").text('종료 시간은 시작 시간보다 커야 합니다.');
	    }else{
			$(".sometext").text('');
	    }
	  });

	  // 폼 제출 시 검증
	  $form.on("submit", function (e) {
	    const startTime = $startTimeSelect.val();
	    const endTime = $endTimeSelect.val();

	    if (endTime <= startTime) {
	      e.preventDefault(); // 폼 제출 방지
	      alert("종료 시간이 시작 시간보다 커야 합니다.");
	    }
	  });
	});
	
$(document).ready(function () {
	  const $form = $("form");

	  $form.on("submit", function (e) {
	    e.preventDefault(); // 폼 기본 제출 방지

	    // 폼 데이터 가져오기
	    const formData = {
	    		
	      emp_idx: $("#emp_idx").val(),
	    	room_idx : $("#hidden-room-idx").val(),
	      subject: $("#title").val(),
	      startTime: $("#start-time").val(),
	      endTime: $("#end-time").val(),
	      date : $("#date").val(),
	      status:1
	    };
	    
        // 폼 데이터 유효성 검사
        for (const [key, value] of Object.entries(formData)) {
            if (!value) { // 값이 비어있으면
                alert("항목을 입력해주세요.");
                return; // 폼 제출 중단
            }
        }
        
	    console.log(formData);
	    // 서버에 데이터 저장
	    $.ajax({
	      url: "saveCalendar.ajax", // 서버의 엔드포인트 URL
	      method: "POST",
	      data: formData,
	      success: function (response) {
	        alert(response.msg);
	        // 저장 후 캘린더에 이벤트 추가
	        closeModal(); // 모달 닫기
	        calendar.refetchEvents(); // 캘린더 새로고침
	      },
	      error: function (error) {
	        alert("저장 중 오류가 발생했습니다: " + error);
	      }
	    });
	  });
	});

/* 회의실 버튼 클릭 이미지 변동 구현 */
document.querySelectorAll('.room-btn').forEach(button => {
    button.addEventListener('click', function() {
        // 클릭된 버튼에서 data-photo 값 가져오기
        const photoUrl = this.getAttribute('data-photo');
        const roomName = this.getAttribute('data-name');
        const roomIdx = this.value;
        // 이미지 요소 가져오기
        const imageElement = document.getElementById('room-image');
        const ptagElement = document.getElementById('room-name');
        document.getElementById('hidden-room-idx').value = roomIdx;

        if (photoUrl) {
        	ptagElement.textContent = roomName;
            // 이미지 URL 설정
            imageElement.src = "/photo/"+photoUrl;
            imageElement.style.display = 'block'; // 이미지 표시
            
        } else {
            // 이미지 숨기기
            imageElement.style.display = 'none';
        }
    });
});
</script>
</html>
