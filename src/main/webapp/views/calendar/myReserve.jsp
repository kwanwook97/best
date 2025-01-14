<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/main.min.css" rel="stylesheet">
  <script src="/BEST/resources/js/index.global.js"></script>
  <script src="resources/jquery.twbsPagination.js"></script>
  <link rel="stylesheet" href="/BEST/resources/css/pagination.css">
  
  
  <style>
  :root{
      --primary-color: #30005A;
      --secondary-color: #8B6AA7;
      --accent-color: #E9396B;
   }
    .dashboard-body{
       margin-left: 14vw;
       width: 85vw;
       margin-top: 7vh;
       flex-wrap: wrap;
       padding: 2vh;
       color: var(--primary-color);
       border: 1px solid #00000000;
       height: 857px;
       display: flex;
       flex-direction: column;
       align-content:center;
       justify-content: center;
   }
   
/*  기본 css   */
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
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        border: 1px solid #ddd;
        text-align: center;
        padding: 8px;
    }
    th {
        background-color: #f4f4f400;
    }
    tr:hover {
        background-color: #f1f1f1;
    }
    .status-button {
        display: inline-block;
        padding: 5px 10px;
        margin: 2px;
        border-radius: 4px;
        color: white;
        text-decoration: none;
        font-size: 0.9em;
        cursor: pointer;
    }
    .status-cancelled {
        background-color: #E9396B;
    }
    .status-modify {
        background-color: #6C0F6C;
    }
    .status-done {
        background-color: gold;
        color: black;
    }
    .status-disabled {
        background-color: #ccc;
        cursor: not-allowed;
    }
    .table-container {
    	text-align: center;
    	display: flex;
    	flex-direction: column;
    	align-items:center;
    	width: 95%;
    	height: 91%;
    	position: relative;
    	top: 6%;
    }
    .status-running {
    	background-color: #7b42d3;
    }
    
    
/* 모달 css */
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
	margin: 0 0 0 47%;
	display: flex;
	gap: 10px;
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
.lPurple {
	color: #8B6AA7;
}
.cPurple {
	color: #30005A;
}
.headerBox {
	font-size: 32px;
}
.headerBox {
	margin-top: 0%;
	width: 22%;
	display: flex;
	flex-direction: row;
	align-items:center;
	justify-content: space-between;
	margin-bottom: 1.5rem;
}
.headerBox {
	font-weight: bold;
}
.reserveBtn {
	width: 100px;
	color: white;
	border: 1px solid;
	border-radius: 10px;
	padding: 5px;
}
.reserveBtn.first {
	background-color: #6C0F6C;
}
.reserveBtn.second {
	background-color: #E9396B;
}
.reserveBtn:hover {
	opacity: 0.5;
}
.pagination-container {
	display: flex;
	flex-direction: column;
	align-items: center;
}
.pagination {
	margin: 0 0;
}
    
	
  </style>
  
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 <jsp:include page="../modal/modal.jsp"></jsp:include>
 
 	<div class="title-name">
		<div class="headerBox">
			<span class="lPurple">회의실</span>
			<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
			<span class="cPurple">내 예약 현황</span>
		</div>
	</div>
 	<div class="dashboard-body">
	    <div class="table-container">
	        <table>
	            <thead>
	                <tr>
	                    <th>No.</th>
	                    <th>회의실</th>
	                    <th>회의명</th>
	                    <th>예약일정</th>
	                    <th>상태</th>
	                </tr>
	            </thead>
	            <tbody id="myReserve-list">

	            </tbody>
	            <tr>
	               <th colspan="5">
	                  <div class="pagination-container">
	                      <nav aria-label="Page navigation">
	                          <ul class="pagination" id="pagination"></ul>
	                      </nav>
	                  </div>
	               </th>
	            </tr>
	        </table>
	    </div>
 	</div>

<div class="meetingmodal">
  <div class="modal-content">
	<h3>회의실 예약</h3>
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
	<input type="hidden" id="emp_idx" value="${sessionScope.loginId}" >    
      <div class="form-group">
        <label class="la" for="room">회의실:</label>
		<p id="room-name"></p>
 		<input id="hidden-room-idx" value="" name="room_idx" type="hidden">
 		<input id="hidden-reserve-idx" value="" name="reserve_idx" type="hidden">
      </div>
      <div class="form-group">
        <label class="la" for="date">예약자:</label>
        <p class="emp-name">사원 이름 부서</p> 
      </div>
      
		<div class="form-group">
		  <label class="la" for="date">날짜:</label>
		  <input type="date" id="date" name="date" min="">
		</div>

      
		<div class="form-group">
			  <label class="la" for="start-time">시작 시간:</label>
			  <select id="start-time" name="start-time">
			  	<option value="">선택</option>
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
			  	<option value="">선택</option>
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
      <button type="submit" class="reserveBtn first">예약</button>
      <button class="modalClose reserveBtn second" type="button" onclick="closeModal()">취소</button>
      </div>
    </form>
  </div>
</div>
 	
</body> 
<script>
var paginationBoolean= false;
	
if (!paginationBoolean) {
	var page = 1;
}

pageCall();

function pageCall(page) {
    $.ajax({
        type: 'POST',
        url: 'myReserve.ajax',
        data: {
            'page': page,
            'cnt': 10,
            'loginId': loginId
        },
        dataType: 'JSON',
        success: function(data) {
            ////console.log('AJAX 데이터:', data);

            if (data.list && data.list.length) {
                drawList(data.list);

                if (!paginationBoolean) {
                    $('#pagination').twbsPagination({
                        startPage: data.currentPage, 
                        totalPages: data.totalPages, 
                        visiblePages: 5, 
                        onPageClick: function(evt, page) {
                            pageCall(page); 
                        }
                    });
                    paginationBoolean = true; 
                }
            } else {
                noList();
            }
        },
        error: function(e) {
            //console.log(e);
        }
    });
}

function drawList(list) {
    const $listBody = $('#myReserve-list');
    $listBody.empty(); // 기존 리스트 초기화
    
    list.forEach(function(item, index) {
        // Helper 함수: 날짜 포맷 변경
        function formatDate(dateStr) {
            const date = new Date(dateStr);
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            return year + '-' + month + '-' + day + ' ' + hours + ':00';
        }

        // 시작 날짜와 종료 시간 포맷팅
        const formattedStart = formatDate(item.start_datetime);
        const endTime = new Date(item.end_datetime).getHours().toString().padStart(2, '0') + ':00';
		//console.log(formattedStart);
		//console.log(endTime);
    	
        const row = 
            '<tr>' +
                '<td>' + item.reserve_idx + '</td>' +
                '<td>' + item.room_name + '</td>' +
                '<td>' + item.subject + '</td>' +
                '<td>' + formattedStart.split(" ")[0] + ' ' + formattedStart.split(" ")[1] + ' - ' + endTime + '</td>' +
                '<td>' +
                    (item.status === '이용 완료' 
                        ? '<button class="status-button status-done" disabled>이용 완료</button>'
                        : item.status === '이용중' 
                            ? '<button class="status-button status-running" disabled>이용중</button>'
                            : '<button class="status-button status-modify" onclick="openModal(\'' + item.room_name + '\', ' + item.room_idx + ', ' + item.reserve_idx + ')">일정변경</button>' +
                          	  '<button class="status-button status-cancelled" onclick="cancelReserve(' + item.reserve_idx + ', ' + item.room_idx + ')">예약취소</button>'
                    ) +
                '</td>' +
            '</tr>';

        $listBody.append(row);
    });
}
/* 노예약 */
function noList() {
    const $listBody = $('#myReserve-list');
    $listBody.empty();
    $listBody.append('<tr><td colspan="5">예약된 회의가 없습니다.</td></tr>');
}


// 예약 취소 함수
function cancelReserve(no,roomIdx) {
	modal.showConfirm('예약을 취소하시겠습니까?', function () {

	    $.ajax({
	        url: "cancelReserve.ajax",
	        method: "POST",
	        data: {
	            reserveIdx: no,
	            empIdx: loginId,
	            roomIdx: roomIdx
	            
	        },
	        dataType: 'json',
	        success: function (response) {
	            if (response && response.msg) {
	                modal.showAlert(response.msg);
	            } else {
	                modal.showAlert("예약이 취소되었습니다.");
	            }
	            pageCall();
	        },
	        error: function (error) {
	            console.error("AJAX 오류:", error);
	            modal.showAlert("삭제 중 오류가 발생했습니다.");
	        }
	    });
	});
}


/* 모달 구동 */
function openModal(no,idx,reserve) {
	$('#room-name').text(no);
	$('#hidden-room-idx').val(idx);
	$('#hidden-reserve-idx').val(reserve);
    document.querySelector('.meetingmodal').style.display = 'block';
    
}
function closeModal() {
	
    document.querySelector('.meetingmodal').style.display = 'none';
}
const startValue = $('#start-time').val();
//console.log(startValue);
const endValue = $('#end-time').val();
//console.log(endValue);

$(document).ready(function () {
	  const $startTimeSelect = $("#start-time");
	  const $endTimeSelect = $("#end-time");
	  const $form = $("form");
	  

	  $startTimeSelect.on("change",function(){
		    const startTime = $startTimeSelect.val();
		    const endTime = $endTimeSelect.val();
		  if (startTime >= endTime ) {
			  $(".sometext").text('시작시간은 종료시간보다 작아야 합니다.');
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

	      // 종료 시간이 시작 시간보다 작은 경우
	      if (endTime < startTime) {
	          e.preventDefault(); // 폼 제출 방지
	          modal.showAlert("종료 시간이 시작 시간보다 커야 합니다.");
	          return;
	      }

	      // 시작 시간과 종료 시간이 동일한 경우
	      if (startTime === endTime) {
	          e.preventDefault(); // 폼 제출 방지
	          modal.showAlert("시작과 종료 시간이 같으면 안됩니다.");
	          return;
	      }

	      // 시작 시간이 종료 시간보다 큰 경우
	      if (startTime > endTime) {
	          e.preventDefault(); // 폼 제출 방지
	          $(".sometext").text("시작시간은 종료시간보다 작아야 합니다.");
	          $startTimeSelect.val("01:00");
	          $endTimeSelect.val("02:00");
	          return;
	      }

	      // 유효성 검사를 통과한 경우
	      $(".sometext").text(""); // 오류 메시지 제거
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
	      reserveIdx : $("#hidden-reserve-idx").val()
	    };
	    
        // 폼 데이터 유효성 검사
        for (const [key, value] of Object.entries(formData)) {
            if (!value) { // 값이 비어있으면
                modal.showAlert("항목을 입력해주세요.");
                return; // 폼 제출 중단
            }
        }
        
	    //console.log(formData);
	    // 서버에 데이터 저장
	    $.ajax({
	      url: "myReserveUpdate.ajax", // 서버의 엔드포인트 URL
	      method: "POST",
	      data: formData,
	      success: function (response) {
	        modal.showAlert(response.msg);
	        pageCall();
	        closeModal(); // 모달 닫기
	      },
	      error: function (error) {
	        modal.showAlert("저장 중 오류가 발생했습니다: " + error);
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

/* input date 날짜 이전으로 변경 불가능 js */
// 시간 제약 조건 현재 날짜 이후만 예약 가능
document.addEventListener("DOMContentLoaded", function () {
  const dateInput = document.getElementById("date");
  const startTimeSelect = document.getElementById("start-time");
  const endTimeSelect = document.getElementById("end-time");

  // 현재 시간 객체 생성
  const now = new Date();

  // 한국 시간으로 조정 (UTC + 9시간)
  now.setHours(now.getHours());
  //console.log("now: ", now);

  // 'YYYY-MM-DD' 형식으로 변환된 오늘 날짜
  const today = now
    .toLocaleDateString("ko-KR", {
      year: "numeric",
      month: "2-digit",
      day: "2-digit",
    })
    .replace(/\. /g, "-")
    .replace(/\./g, "");
  //console.log("today", today);

  // 날짜 입력 필드에 최소 날짜 설정
  dateInput.setAttribute("min", today);

  // 날짜 선택 이벤트
  dateInput.addEventListener("change", function () {
    const selectedDate = dateInput.value;

    // 현재 시간 객체 생성 및 KST로 조정
    const currentTime = new Date();
    currentTime.setHours(currentTime.getHours());
    //console.log("currentTime: ", currentTime);

    // 오늘 날짜인 경우만 필터링
    if (selectedDate === today) {
      const currentHour = currentTime.getHours(); // 현재 시간 (시)
      const currentMinute = currentTime.getMinutes(); // 현재 시간 (분)

      // 모든 옵션을 순회하며 활성화/비활성화
      Array.from(startTimeSelect.options).forEach((option) => {
        const [hour, minute] = option.value.split(":").map(Number);

        // 현재 시간 이후의 옵션만 활성화
        if (hour > currentHour || (hour === currentHour && minute > currentMinute)) {
          option.disabled = false; // 활성화
        } else {
          option.disabled = true; // 비활성화
        }
      });

      // 유효한 옵션이 없을 경우 초기값 선택
      if (!Array.from(startTimeSelect.options).some((opt) => !opt.disabled)) {
        startTimeSelect.value = "";
      }
    } else {
      // 오늘 날짜가 아닌 경우 모든 옵션 활성화
      Array.from(startTimeSelect.options).forEach((option) => {
        option.disabled = false;
      });
    }
  });

  // 시작 시간 선택 이벤트
  startTimeSelect.addEventListener("change", function () {
    const selectedStartTime = startTimeSelect.value; // 선택된 시작 시간

    if (!selectedStartTime) {
      // 시작 시간이 선택되지 않은 경우 모든 종료 시간 옵션 비활성화
      Array.from(endTimeSelect.options).forEach((option) => {
        option.disabled = true;
      });
      endTimeSelect.value = ""; // 종료 시간 초기화
      return;
    }

    const [selectedHour, selectedMinute] = selectedStartTime
      .split(":")
      .map(Number);

    // 종료 시간 옵션 활성화/비활성화
    Array.from(endTimeSelect.options).forEach((option) => {
      const [hour, minute] = option.value.split(":").map(Number);

      // 선택된 시작 시간 이후의 옵션만 활성화
      if (hour > selectedHour || (hour === selectedHour && minute > selectedMinute)) {
        option.disabled = false; // 활성화
      } else {
        option.disabled = true; // 비활성화
      }
    });

    // 유효한 옵션이 없을 경우 초기값 선택
    if (!Array.from(endTimeSelect.options).some((opt) => !opt.disabled)) {
      endTimeSelect.value = "";
    }
  });
});

</script>
</html>
