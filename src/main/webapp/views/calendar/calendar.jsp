<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="/BEST/resources/js/index.global.js"></script>
  <style>
  :root{
      --primary-color: #30005A;
      --secondary-color: #8B6AA7;
      --accent-color: #E9396B;
      
   }
  .calendar-calendar{
    width: 100%; 
    height: 96%; 
  }
    .dashboard-body{
       margin-left: 14vw;
       width: 85vw;
       margin-top: 7vh;
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
    .container-calendar {
      display: flex;
      width: 100%;
      /* max-width: 1200px; */
      gap: 20px;
      position: relative;
      left: -33px;
      top: -6px;
      height: 104%;
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
	  gap: 15px; /* 자식 요소 간격 */
	  height: 100%;
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
	  display: flex; 
	  align-items: center; 
	  justify-content: center; 
	  padding: 10px; 
	}
	
	/* 캘린더 날짜 색 */
	.fc-daygrid-day-number{
		color: black;
	}
	
	.fc-daygrid-day {
	    height: 100px !important; 
	    box-sizing: border-box; 
	}
	
	/* 캘린더 이벤트 등록된 배경색 */
	.fc-event-main {
	  background-color: #6C0F6C; 
	  color: white; 
	  border: 2px solid #6C0F6C; 
	  border-radius: 5px; 
	  display: block;
	}
	/* 투두리스트 */
.list-box {
  display: flex; 
  align-items: center;
  justify-content: space-between;
  background-color: #ffffff00; 
  border: 2px solid #30005A; 
  border-radius: 10px;
  padding: 10px; 
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

/* 캘린더 텍스트 컬러 */
.fc-event-time, .fc-event-title{
	color: black;
}
.fc-sticky {
	color: white !important;
}

/* 캘린더 리사이즈 css */
/* 이벤트 리사이즈 핸들 활성화 */
.fc-event-resizer {
    width: 100% !important; 
    height: 10px !important; 
    background-color: #00000000 !important; 
    position: absolute !important; 
    bottom: 0 !important; 
    right: 0 !important;
    z-index: 9999 !important; 
    cursor: se-resize !important; 
}
.fc-event {
	margin: 0 0 0 0 !important;
	padding: 0 0 0 0 !important;
	border: none !important;
	
}

.fc-v-event .fc-event-main-frame {
	display: block;
}
select option {
	background-color: white !important;
}
#visibilityFilter {
	position: relative;
	left: 18%;
	top: 4%;
}

/* 투두 모달 스타일 */
    #todoModal {
        display: none; /* 초기에는 숨김 */
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 1000;
        justify-content: center;
        align-items: center;
    }
    .modal-content {
        background-color: #FFF5E2;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        width: 252px;
        margin: auto;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    #todoInput {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .ss {
    	background-color: #30005A;
    	color: #FFF5E2;
    	text-align: center;
    }
    .ss h2 {
    	font-size: 20px;
    	margin: 0 0 0 0;
    }
    .modal-content table {
    	border-spacing: 0; 
    	display: flex;
    	flex-direction: column;
    	align-items: center;
    	border: 2px solid #30005A;
    }
    .modal-content table tr {
    	margin: 0 0 0 0 !important;
	    padding: 0;
    }
	.modal-content table *{
		width: 100%;
	}
	#saveTodo {
		width: 100%;
		background-color: #E9396B;
		border: 1px solid #E9396B;
    	color: #FFF5E2;
	}
	#closeModal{
		width: 100%;
		background-color: #30005A;
		border: 1px solid #30005A;
    	color: #FFF5E2;
	}
	.modal-content table td {
	    padding: 0;
	    margin: 0;
	}
	.fc .fc-toolbar.fc-header-toolbar button {
		background-color: #30005A;
		color: #FFF5E2;
	}
	.fc-direction-ltr .fc-button-group > .fc-button:not(:last-child) {
		background-color: #30005A;
		color: #FFF5E2;
	}
	.fc-direction-ltr .fc-button-group > .fc-button:not(:first-child) {
		background-color: #30005A !important;
		color: #FFF5E2 !important;
	}
    
    
  </style>
  
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 <jsp:include page="../modal/modal.jsp"></jsp:include>
 
 	<div class="dashboard-body">
 		<!-- <h2 id="clock">00:00:00</h2> -->
		  <div class="container-calendar">
		    <div id="calendar-container">
				<select id="visibilityFilter">
				    <option value="all">전체</option>
				    <option value="private">개인</option>
				    <option value="public">부서</option>
		    	</select>
		      <div id="calendar" class="calendar-calendar"></div>
		    </div>
		    <div id="todo-container">
			    <div id="todo-subject-box">
			      <h2>Today To Do List !</h2>
			    </div>
		      	<div id="todolist">

		      	</div>
		    </div>
		  </div>
 	</div>
 	
<div id="todoModal" class="todoModal">
    <div class="modal-content">
	    <table>
	    	<tr>
	    		<td class="ss">
			        <h2>할일 등록</h2>
	    		</td>
	    	</tr>
	    	<tr>
				<td>
			        <input type="text" id="todoInput" placeholder="할 일을 입력하세요" />
				</td>	    	
	    	</tr>
	    	<tr>
	    		<td>
	  		      <button id="saveTodo">확인</button>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>
	    		   <button id="closeModal">닫기</button>
	    		</td>
	    	</tr>
	    </table>
    </div>
</div>

</body> 



<script>
var userDepartment = ${employee.depart_idx};
console.log("userDepartment종원테스트:"+userDepartment );
var specialDays = ${specialDaysJson};

$('#closeModal').on('click', function () {
    closeModal();
});

function closeModal(){
    const inputValue = $('#todoInput').val('');
	$("#todoModal").fadeOut(); 
}

function saveModal(title, arg, calendar) {
    const visibility = document.getElementById('visibilityFilter').value;
    const newEvent = {
        title: title,
        start: arg.start.toISOString(),
        end: arg.end.toISOString(),
        allDay: arg.allDay,
        visibility: visibility,
        loginId: loginId
    };

    fetch('addMyCalendar.ajax', {
        method: 'POST',
        body: JSON.stringify(newEvent),
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            closeModal();
            modal.showAlert('일정이 저장되었습니다.');
            calendar.refetchEvents();
        } else {
        	modal.showAlert('일정 저장 실패');
        }
    })
    .catch(error => {
        console.error('Error saving event:', error);
        alert('일정 저장 중 오류 발생');
    });
}



document.addEventListener('DOMContentLoaded', function() {

	

    const calendarEl = document.getElementById('calendar');

    const calendar = new FullCalendar.Calendar(calendarEl, {
        //contentHeight: 300,
        dayMaxEventRows: true,
        dayMaxEvents: 3,
        locale: "ko",
        timeZone: "Asia/Seoul",
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek'
        },
        initialDate: new Date(),
        navLinks: true,
        selectable: true,
        selectMirror: true,
        editable: true, // 드래그 및 수정 가능
        eventResizableFromStart: true,
        
        navLinkDayClick: function(date, jsEvent) {
        	updateTodoList(date);
        },





        
        eventDidMount: function(info) {
            const resizer = info.el.querySelector('.fc-event-resizer');
            if (resizer) {
                resizer.style.width = '10px';
                resizer.style.height = '10px';
                resizer.style.backgroundColor = '#007bff';
                resizer.style.cursor = 'se-resize';
            }
        },
        
        // 이벤트 드래그 후 업데이트
        eventDrop: function(info) {
        	console.log("info:{}",info.event.extendedProps)
        	console.log("info.event.id:{}",info.event.id)
        	console.log("info.event.title:{}",info.event.title)
        	console.log("info.event.start.toISOString():{}",info.event.start.toISOString())
        	console.log("info.event.end ? info.event.end.toISOString() : null:{}",info.event.end ? info.event.end.toISOString() : null)
        	console.log("info.event.allDay:{}",info.event.allDay)
            if (info.event.extendedProps.employeeIdx !== loginId) {
                modal.showAlert('수정 권한이 없습니다.');
                info.revert(); // 원래 위치로 되돌림
                return;
            }
            const visibility = document.getElementById('visibilityFilter').value;
            const updatedEvent = {
            	    id: info.event.id,
            	    title: info.event.title,
            	    start: info.event.start.toISOString(),
            	    end: info.event.end ? info.event.end.toISOString() : (() => {
            	        const endDate = new Date(info.event.start); // info.event.start를 Date 객체로 변환
            	        if (info.event.allDay) {
            	            // allDay인 경우, 하루 끝으로 설정 (옵션: 시작 + 1일로 설정 가능)
            	            endDate.setDate(endDate.getDate() + 1); 
            	        } else {
            	            // allDay가 아니면 기본적으로 몇 시간 추가
            	            endDate.setHours(endDate.getHours() + 1);
            	        }
            	        return endDate.toISOString(); // ISO 문자열로 변환
            	    })(),
            	    allDay: info.event.allDay,
            	    visibility: visibility
            	};

            // 서버에 업데이트 요청
            fetch('updateEvent.ajax', {
                method: 'POST',
                body: JSON.stringify(updatedEvent),
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.response > 0) {
                	modal.showAlert('이벤트가 성공적으로 업데이트되었습니다');
                    //alert('이벤트가 성공적으로 업데이트되었습니다.');
                } else {
                	modal.showAlert('이벤트 업데이트 실패');
                    //alert('이벤트 업데이트 실패');
                    info.revert(); // 실패 시 원래 위치로 되돌림
                }
            })
            .catch(error => {
                console.error('Error updating event:', error);
                modal.showAlert('이벤트 업데이트 중 오류 발생');
                info.revert(); // 오류 시 원래 위치로 되돌림
            });
        },

        // 이벤트 리사이즈 후 업데이트
        eventResize: function(info) {
        	console.log("info:{}",info)
            if (info.event.extendedProps.employeeIdx !== loginId) {
                modal.showAlert('수정 권한이 없습니다.');
                info.revert(); // 원래 위치로 되돌림
                return;
            }
            const visibility = document.getElementById('visibilityFilter').value;
            const updatedEvent = {
            	    id: info.event.id,
            	    title: info.event.title,
            	    start: info.event.start.toISOString(),
            	    end: info.event.end ? info.event.end.toISOString() : (() => {
            	        const endDate = new Date(info.event.start); // info.event.start를 Date 객체로 변환
            	        if (info.event.allDay) {
            	            // allDay인 경우, 하루 끝으로 설정 (옵션: 시작 + 1일로 설정 가능)
            	            endDate.setDate(endDate.getDate() + 1); 
            	        } else {
            	            // allDay가 아니면 기본적으로 몇 시간 추가
            	            endDate.setHours(endDate.getHours() + 2);
            	        }
            	        return endDate.toISOString(); // ISO 문자열로 변환
            	    })(),
            	    allDay: info.event.allDay,
            	    visibility: visibility
            	};

            // 서버에 업데이트 요청
            fetch('updateEvent.ajax', {
                method: 'POST',
                body: JSON.stringify(updatedEvent),
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.response > 0) {
                    modal.showAlert('이벤트가 성공적으로 업데이트되었습니다.');
                } else {
                    modal.showAlert('이벤트 업데이트 실패');
                    info.revert(); // 실패 시 원래 상태로 되돌림
                }
            })
            .catch(error => {
                console.error('Error updating event:', error);
                modal.showAlert('이벤트 업데이트 중 오류 발생');
                info.revert(); // 오류 시 원래 상태로 되돌림
            });
        },
/*         select: function(arg) {
        	$("#todoModal").css("display","flex").hide().fadeIn();
        	
           // const title = prompt('할일 등록:');
            function saveModal(title) {
                const visibility = document.getElementById('visibilityFilter').value;
                const newEvent = {
                    title: title,
                    start: arg.start.toISOString(),
                    end: arg.end.toISOString(),
                    allDay: arg.allDay,
                    visibility: visibility,
                    loginId: loginId
                };

                 fetch('addMyCalendar.ajax', {
                    method: 'POST',
                    body: JSON.stringify(newEvent),
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                    	closeModal();
                    	modal.showAlert('일정이 저장되었습니다.');
                    	calendar.refetchEvents();
                    } else {
                        alert('일정 저장 실패');
                    }
                })
                .catch(error => {
                    console.error('Error saving event:', error);
                    alert('일정 저장 중 오류 발생');
                });
            }
            calendar.unselect();
        }, */
        select: function (arg) {
            $("#todoModal").css("display", "flex").hide().fadeIn();

            $('#saveTodo').off('click').on('click', function () {
                const inputValue = $('#todoInput').val();
                if (inputValue.trim() === "") {
                    modal.showAlert('할 일을 입력하세요.');
                    return;
                }
                saveModal(inputValue, arg, calendar);
                calendar.unselect();
            });
        },
        eventClick: function(arg) {
        	if (arg.event.extendedProps.employeeIdx !== loginId) {
				return modal.showAlert('삭제 권한이 없습니다.');
			}
        	
        		
    	    
	   		 modal.showConfirm('삭제 하시겠습니까?', function () {
	            console.log("이벤트 id:", arg.event.id); 
	            console.log("테스트 arg:", arg);        
	                // 서버로 이벤트 삭제 요청 보내기
	                $.ajax({
	                    url: 'delEvent.ajax',
	                    type: 'POST',
	                    data: JSON.stringify({ id: arg.event.id }),
	                    contentType: 'application/json',
	                    success: function(response) {
	                        if (response.success) {
	                            arg.event.remove();
	                            //modal.showAlert('이벤트가 삭제되었습니다.');
	                        } else {
	                        	modal.showAlert(response.msg);
	                        }
	                    },
	                    error: function() {
	                        modal.showAlert('오류');
	                    }
	                });
	    		});
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
                    console.log("Filtered Events (JSON):", JSON.stringify(filteredEvents, null, 2));
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

/*             const specialDays = {
                    '2024-01-01': '신정',
                    '2024-02-10': '설날',
                    '2024-02-11': '설날 연휴',
                    '2024-02-12': '설날 연휴',
                    '2024-03-01': '삼일절',
                    '2024-05-05': '어린이날',
                    '2024-05-15': '스승의 날',
                    '2024-12-25': '크리스마스'
                }; */
            
            // 특별한 날이 있는 경우
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
                        slot.style.setProperty('background-color', '#FFEBEE', 'important');
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
                    info.el.style.setProperty('background-color', '#FFEBEE', 'important');
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
        	console.log("테스트종qweqwe:"+JSON.stringify(allEvents, null, 2));
        const eventsForDate = allEvents.filter(function(event) {
            const eventStartDate = event.start.toISOString().split('T')[0]; 
            const eventEndDate = event.end.toISOString().split('T')[0]; 
        	/* console.log("테스트종:"+JSON.stringify(eventStartDate, null, 2));
        	console.log("테스트종:"+JSON.stringify(eventEndDate, null, 2));
        	console.log("테스트종clickedDate:"+JSON.stringify(clickedDate, null, 2)); */
            const isInDateRange = clickedDate == eventStartDate && clickedDate <= eventEndDate;
            return isInDateRange;

/*                 if (visibilityFilter === 'public') {
                return isInDateRange && event.extendedProps.department === userDepartment && event.extendedProps.visibility === 'public';;
            } else if (visibilityFilter === 'private') {
                return isInDateRange && event.extendedProps.employeeIdx === loginId && event.extendedProps.visibility === 'private';
            } else {
                return isInDateRange;
            } */
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
                    })
                    .catch(error => {
                        failureCallback(error);
                    });
            }
        });

        // 캘린더 다시 로드
        calendar.refetchEvents();
    });
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












































