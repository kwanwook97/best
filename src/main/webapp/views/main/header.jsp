<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BEST</title>
<!-- side-bar CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="resources/css/simplebar.css" rel="stylesheet"/>
<link href="resources/css/bootstrap.min.css" rel="stylesheet"/>
<link href="resources/css/app-style.css" rel="stylesheet"/>
<link href="resources/css/sidebar-menu.css" rel="stylesheet"/>
<link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
<!-- side-bar JS -->
<script>
var loginId = ${sessionScope.loginId};
</script>
<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
<script src="resources/js/sidebar-menu.js"></script>
<script src="resources/js/simplebar.js"></script>
<!-- <script src="resources/js/bootstrap.min.js"></script> -->
<script src="resources/js/bestWS.js"></script>
</head>
<style>
.btn-finish-work {
   display: none;
}

/* 알림 메시지 css */
.notification {
    position: fixed;
    bottom: 20px;
    right: 20px;
    background-color: #FFF5E2;
    color: #30005A;
    padding: 7px;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
    z-index: 1000;
    display: none; /* 초기 상태는 숨김 */
    width: 200px; /* 고정 너비 */
    height: 80px; /* 고정 높이 */
    overflow: hidden; /* 넘치는 내용 숨김 */
    text-overflow: ellipsis; /* 초과 부분을 ...으로 표시 */
    white-space: nowrap; /* 한 줄로 제한 */
}

.notification.show {
    display: block; /* 표시 */
    animation: fadeInOut 5s ease-in-out; /* 5초간 표시 후 사라짐 */
}

@keyframes fadeInOut {
    0% { opacity: 0; transform: translateY(10px); }
    10% { opacity: 1; transform: translateY(0); }
    90% { opacity: 1; transform: translateY(0); }
    100% { opacity: 0; transform: translateY(10px); }
}
.notification-profile{
	background-color: #FFFBF2;
    display: flex;
    align-items: center;
    cursor: pointer;
    padding: 7px;
    border-radius: 5px;
}
.notifi-profile{
    display: flex;
    align-items: flex-start;
    flex-direction: column;
    color: #30005A;
}
.notification-profile .custom-image{
	width: 45px !important;
    height: 45px !important;
}

/* 드롭 다운 css */
.dropdown {
    position: relative; /* 드롭다운과 아이콘을 연결 */
}
.dropdown-menu-custom {
    display: none;
    position: absolute;
    top: 100%; /* 아이콘 바로 아래에 위치 */
    left: -140px;
    background-color: #8B6AA7;
    border: 1px solid #ddd;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.15);
    border-radius: 5px;
    z-index: 1000;
    min-width: 180px;
}
.dropdown-menu-custom.show {
    display: block;
}
.dropdown-item {
    padding: 7px;
    cursor: pointer;
    white-space: nowrap;
}



#newMessageIndicator {
	background-color: #E9396B;
	border-radius: 50%;
	width: 20px;
	text-align: center;
	display: none;
	position: absolute;
	top: 41px;
    left: 111px;
}

.unread-message-count {
	color: #FFF5E2;
}

</style>

<body>
   <div id="sidebar-wrapper" data-simplebar="" data-simplebar-auto-hide="true">
     <div class="brand-logo">
      <a href="main.go">
       <h4><span style="color:#E9396B;">BEST</span></h4>
       <h5 class="logo-text"><span style="color:#E9396B;">B</span>us <span style="color:E9396B;">E</span>mployee 
       <span style="color:#E9396B;">S</span>ervice <span style="color:#E9396B;">T</span>ool</h5>
     </a>
      </div>
      <div class="member-profile">
         <div class="profile-photo"></div>
         <ul>
            <li> 촉촉이 / 대리
            </li>
            <li> chockchock@gmail.com
            </li>
         </ul>
      </div>
   <ul class="sidebar-menu do-nicescrol">
      <li class="sidebar-header"></li>
      <li>
        <a href="main.go">
          <i class="mdi mdi-view-dashboard"></i> <span>대쉬보드</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>
      
      <li>
        <a href="attendance.go">
          <i class="bi bi-clock-fill"></i> <span>근태관리</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>
      
      <li class="dropD">
        <a href="calendar.go">
          <i class="fa-regular fa-calendar-check"></i> <span>캘린더</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>
      
      <li class="dropD">
        <a href="javaScript:void(0);">
          <i class="bi bi-bus-front-fill"></i> <span>버스정보</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
        
        <ul class="dropD-menu">
          <li class="dropD-item">
               <a href="driveInfo.go">
                 <i class="fa-solid fa-road"></i> <span>운행현황</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
          </li>
          <li class="dropD-item">
               <a href="dispatchList.go">
                 <i class="fa-solid fa-user-tie"></i> <span>배차현황</span>
                <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
          <li class="dropD-item">
               <a href="busDispatch.go">
                 <i class="fa-solid fa-user-tie"></i> <span>배차관리</span>
                <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
            <li class="dropD-item">
               <a href="busDetail.go">
                 <i class="bi bi-bus-front"></i> <span>버스관리</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
        </ul>
      </li>
      
      <li style="position: relative;">
   		<a href="chatList.go">
        	<i class="bi bi-chat-left-text-fill"></i> <span>메신져</span>
        	<i class="fa-solid fa-angle-right"></i>
    	</a>
    	<div id="newMessageIndicator">
        
    	</div>
	</li>
      
     <li class="dropD">
        <a href="javaScript:void(0);">
          <i class="bi bi-envelope-fill"></i> <span>메일함</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
        <ul class="dropD-menu">
          <li class="dropD-item">
               <a href="mailWrite.go">
                 <i class="bi bi-envelope-paper-fill"></i> <span>메일작성</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
          </li>
          <li class="dropD-item">
               <a href="mail.go">
                 <i class="bi bi-envelope-paper-fill"></i> <span>받은 메일함</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
          </li>
          <li class="dropD-item">
               <a href="test.go">
                 <i class="bi bi-send"></i> <span>보낸 메일함</span>
                <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
            <li class="dropD-item">
               <a href="javaScript:void(0);">
                 <i class="bi bi-envelope-exclamation-fill"></i> <span>임시저장</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
          <li class="dropD-item">
               <a href="javaScript:void(0);">
                 <i class="bi bi-trash-fill"></i> <span>휴지통</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
        </ul>
   </li>
      
      
      <li class="dropD">
        <a href="javaScript:void();">
          <i class="fa-regular fa-clipboard"></i> <span>결재문서</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
        
        <ul class="dropD-menu">
          <li class="dropD-item">
               <a href="documentPending.go">
                 <i class="bi bi-file-text-fill"></i> <span>대기</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
          </li>
          <li class="dropD-item">
               <a href="documentBoard.go">
                 <i class="bi bi-file-text-fill"></i> <span>진행중</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
          </li>
          <li class="dropD-item">
               <a href="documentApproved.go">
                 <i class="bi bi-file-earmark-check-fill"></i> <span>완료</span>
                <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
          <li class="dropD-item">
               <a href="documentReject.go">
                 <i class="bi bi-file-earmark-break-fill"></i> <span>반려</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
            <li class="dropD-item">
               <a href="documentReference.go">
                 <i class="bi bi-file-earmark-arrow-up-fill"></i> <span>참조</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
            <li class="dropD-item">
               <a href="documentDraft.go">
                 <i class="bi bi-file-earmark-arrow-up-fill"></i> <span>임시저장</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
        </ul>
        
      </li>

      <li>
        <a href="orgChart.go">
          <i class="bi bi-diagram-3-fill"></i> <span>조직도</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>

       <li class="dropD">
        <a href="javaScript:void();">
          <i class="bi bi-layout-text-window-reverse"></i> <span>게시판</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
        
        <ul class="dropD-menu">
          <li class="dropD-item">
               <a href="noticeBoard.go">
                 <i class="bi bi-megaphone-fill"></i> <span>공지사항</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
          </li>
          <li class="dropD-item">
               <a href="freeBoard.go">
                 <i class="bi bi-window-stack"></i> <span>자유 게시판</span>
                <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
          </ul>
      </li>
      
      
    <li class="dropD">
        <a href="javaScript:void(0);">
          <i class="fa-regular fa-calendar-check"></i> <span>회의실</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
     
        <ul class="dropD-menu">
          <li class="dropD-item">
               <a href="meetingRoomCalendar.do">
                 <i class="fa-regular fa-calendar-check"></i> <span>회의실 예약</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
          </li>
          <li class="dropD-item">
               <a href="myReserve.go">
                 <i class="fa-regular fa-calendar-check"></i> <span>내 예약 현황</span>
                <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
            <li class="dropD-item">
               <a href="roomInfo.go">
                 <i class="fa-regular fa-calendar-check"></i> <span>회의실 정보</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
        </ul>
   </li>
   
   <!-- 종원 기자재 -->
       <li class="dropD">
           <a href="javaScript:void(0);">
             <i class="fa-regular fa-calendar-check"></i> <span>기자재</span>
             <i class="fa-solid fa-angle-right"></i>
           </a>
        
           <ul class="dropD-menu">
             <li class="dropD-item">
                  <a href="material.go">
                    <i class="fa-regular fa-calendar-check"></i> <span>기자재 관리</span>
                    <i class="fa-solid fa-angle-right"></i>
                  </a>
             </li>
           </ul>
      </li>
   
   
      <!-- 관욱수정 2024.12.12 시작 -->
      <li class="dropD">
           <a href="javaScript:void();">
            <i class="bi bi-person-vcard"></i> <span>사원관리</span>
            <i class="fa-solid fa-angle-right"></i>
          </a>
      
         <ul class="dropD-menu">
             <li class="dropD-item">
                  <a href="empList.go">
                   <i class="bi bi-person-vcard"></i> <span>사원목록</span>
                   <i class="fa-solid fa-angle-right"></i>
                 </a>
               </li>
             <li class="dropD-item">
                  <a href="empCreate.go">
                   <i class="bi bi-person-vcard"></i> <span>사원등록</span>
                   <i class="fa-solid fa-angle-right"></i>
                 </a>
               </li>
           </ul>
         </li>
         
         <!-- 관욱수정 2024.12.12 끝 -->
       <li class="dropD">
        <a href="javaScript:void();">
          <i class="bi bi-bar-chart-fill"></i> <span>매출현황</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
        
        <ul class="dropD-menu">
          <li class="dropD-item">
               <a href="javaScript:void();">
                 <i class="bi bi-bar-chart-fill"></i> <span>월별현황</span>
                <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
            <li class="dropD-item">
               <a href="javaScript:void();">
                 <i class="bi bi-graph-up"></i> <span>연별현황</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
            <li class="dropD-item">
               <a href="javaScript:void();">
                 <i class="bi bi-file-earmark-bar-graph-fill"></i> <span>매출등록</span>
                 <i class="fa-solid fa-angle-right"></i>
               </a>
            </li>
        </ul>
      </li>
      
       <li>
        <a href="javaScript:void();">
          <i class="bi bi-wallet-fill"></i> <span>지출정산</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>
      
       <li>
        <a href="javaScript:void();">
          <i class="fa-solid fa-video"></i> <span>CCTV</span>
          <i class="fa-solid fa-angle-right"></i>
        </a>
      </li>

      <li class="sidebar-header"></li>
      <li>
      <a href="javaScript:void(0);">
         <i class="fa-regular fa-bell"></i> <span>알림</span>
         <i class="fa-solid fa-angle-right"></i>
         </a>
      </li>
      <li>
      <a href="javaScript:void(0);">
         <i class="bi bi-person-fill-gear"></i> <span>내 정보관리</span>
         <i class="fa-solid fa-angle-right"></i>
         </a>
      </li>
      <li>
         <a href="login.go"><i class="fa-solid fa-right-to-bracket"></i> <span>로그인</span>
         <i class="fa-solid fa-angle-right"></i>
         </a>
      </li>
      <li>
         <a href="javaScript:void(0);"><i class="fa-solid fa-right-to-bracket"></i> <span>로그아웃</span>
         <i class="fa-solid fa-angle-right"></i>
         </a>
      </li>

    </ul>
   
   </div>

<header class="topbar-nav">
 <nav class="navbar navbar-expand fixed-top">
  <ul class="navbar-nav mr-auto align-items-center">
    <li>
      <div class="work-time">
            <i class="bi bi-clock-history"></i>
            <button class="btn-start-work" onclick="updateStartTime()">출근</button>
            <button class="btn-finish-work" onclick="updateEndTime()">퇴근</button>
         </div>
    </li>
  </ul>
     
  <ul class="navbar-nav align-items-center right-nav-link">
    <li class="nav-item dropdown-lg">
    <div class="dropdown">
        <a class="nav-link" href="javascript:void(0);" id="messageDropdownToggle">
            <i class="fa-regular fa-message"></i>
        </a>
        <div class="dropdown-menu-custom" id="messageDropdown">
            <!-- 드롭다운 내용이 여기에 추가됩니다 -->
        </div>
    </div>
</li>
    <li class="nav-item dropdown-lg">
      <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();">
      <i class="fa fa-bell-o"></i></a>
    </li>
    <li class="nav-item dropdown-lg">
      <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();">
      <i class="bi bi-person-circle"></i>
      </a>
    </li>
  </ul>
</nav>
</header>
<script>
window.updateUnreadMessageCount = function (unreadTotal) {
    const newMessageIndicator = $("#newMessageIndicator");

    // 기존 내용을 초기화
    newMessageIndicator.empty();

    if (unreadTotal > 0) {
        // 읽지 않은 메시지가 있으면 표시
        const unreadHTML = 
   			'<div class="unread-count-list">' +
        		'<span>' + unreadTotal + '</span>' +
    		'</div>';

        newMessageIndicator.append(unreadHTML).css("display", "block");
    } else {
        // 없으면 숨김
        newMessageIndicator.css("display", "none");
    }
};



checkButton()

function checkButton(){
    const data = {
            loginId: loginId,
        };
    fetch('checkButton.ajax', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('버튼오류');
        }
        return response.json();
    })
    .then(data => {
       console.log(data.row)
        const button = document.querySelector('.btn-start-work');
        const finish = document.querySelector('.btn-finish-work');
       if (data.startTime) {
            button.style.display = 'none';
            finish.style.display = 'block';
      }
       if (data.startTime && data.endTime) {
         finish.disabled = true;
      }
        
    })
    .catch(error => {
        console.error('출근 처리 오류:', error);
        alert(error.message);
    });   
    
}



function updateStartTime(){
    const data = {
            loginId: loginId
        };
       fetch('updateStartTime.ajax', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('출근 처리 중 문제가 발생했습니다.');
        }
        return response.json();
    })
    .then(data => {
       console.log("콘솔확인:"+ data.msg);
       if (data.msg == '성공') {
          checkButton();
          
          
            if (typeof updateTime === 'function') {
                updateTime();
            } 
      }
        
    })
    .catch(error => {
        console.error('출근 처리 오류:', error);
        alert(error.message);
    });   
}

/* 퇴근 버튼 */
function updateEndTime(){
    const data = {
            loginId: loginId
        };
    
    fetch('updateEndTime.ajax', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('출근 처리 중 문제가 발생했습니다.');
        }
        return response.json();
    })
    .then(data => {
          checkButton()
            if (typeof updateTime === 'function') {
                updateTime();
            } 
        
    })
    .catch(error => {
        console.error('출근 처리 오류:', error);
        alert(error.message);
    }); 
}

/* 우측 하단 알림 메시지 */
function showNotification(photo, name, message, chatIdx) {
    const notification = $("#notification");

    // 알림 메시지 설정
    const notificationContent =
        '<div class="notification-profile">' +
            '<img src="/photo/' + photo + '" alt="프로필 사진" class="custom-image">' +
            '<div class="notifi-profile">' +
                '<div>' + name + '</div>' +
                '<div>' + message + '</div>' +
            '</div>' +
        '</div>';

    notification.html(notificationContent);

    // 알림 클릭 시 채팅방으로 이동
    notification.off("click").on("click", function () {
        redirectToChat(chatIdx);
    });

    // 알림 표시
    notification.addClass("show");

    // 일정 시간 후 알림 숨김
    setTimeout(() => {
        notification.removeClass("show");
    }, 5000); // 5초 후 숨김
}

/* 헤더 드롭 다운 */
document.addEventListener("DOMContentLoaded", function () {
    const dropdownToggle = document.getElementById("messageDropdownToggle");
    const dropdownMenu = document.getElementById("messageDropdown");

    // 드롭다운 토글 클릭 시 열고 닫기
    dropdownToggle.addEventListener("click", function (event) {
        event.stopPropagation(); // 이벤트 전파 방지
        dropdownMenu.classList.toggle("show");
    });

    // 드롭다운 외부 클릭 시 닫기
    document.addEventListener("click", function () {
        dropdownMenu.classList.remove("show");
    });
});

/* 헤더 메시지 알림 */
function updateMessageDropdown(photo, name, message, chatIdx) {
    const messageDropdown = $("#messageDropdown");

    // 메시지 항목 생성
    const messageItem =
    	'<div class="dropdown-item" onclick="redirectToChat(' + chatIdx + ')">' +
            '<div class="notification-profile">' +
                '<img src="/photo/' + photo + '" alt="프로필 사진" class="custom-image">' +
                '<div class="notifi-profile">' +
                    '<div>' + name + '</div>' +
                    '<div>' + message + '</div>' +
                '</div>' +
            '</div>' +
        '</div>'; // 닫는 태그가 정상적으로 닫혔는지 확인

    // 메시지 항목을 드롭다운에 추가
    messageDropdown.prepend(messageItem);

    // 최대 5개의 메시지만 유지
    if (messageDropdown.children().length > 5) {
        messageDropdown.children().last().remove();
    }
}
/* 알림 메시지 채팅방 이동 */
function redirectToChat(chatIdx) {
    if (chatIdx) {
        window.location.href = 'chat.go?chat_idx=' + chatIdx;
    } else {
        console.error('채팅방 이동에 필요한 chatIdx가 없습니다.');
    }
}
/* 안 읽은 메시지 총 갯수 */
$(document).ready(function () {
    // 페이지 로드 시 호출
    $.ajax({
        type: 'GET',
        url: 'unreadTotal.ajax',
        success: function (totalUnreadCount) {
            const newMessageIndicator = $("#newMessageIndicator");

            // 기존 내용 초기화
            newMessageIndicator.empty();

            if (totalUnreadCount > 0) {
                // 읽지 않은 메시지가 있으면 표시
                newMessageIndicator.append(
                    '<div class="unread-count-list">' +
                        '<span>' + totalUnreadCount + '</span>' +
                    '</div>'
                ).css("display", "block");
            } else {
                // 읽지 않은 메시지가 없으면 숨김
                newMessageIndicator.css("display", "none");
            }
        },
        error: function (xhr, status, error) {
            console.error("AJAX 요청 실패: ", error);
        }
    });
});
</script>

<!-- 우측 하단 알림 메시지 -->
<div id="notification" class="notification"></div>

</body>

</html>