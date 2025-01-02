<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BEST</title>
<!-- side-bar CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="resources/css/simplebar.css" rel="stylesheet" />
<link href="resources/css/bootstrap.min.css" rel="stylesheet" />
<link href="resources/css/app-style.css" rel="stylesheet" />
<link href="resources/css/sidebar-menu.css" rel="stylesheet" />
<link
	href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css"
	rel="stylesheet">
<!-- side-bar JS -->
<script>
var loginId = ${sessionScope.loginId};
</script>
<script src="https://kit.fontawesome.com/6282a8ba62.js"
	crossorigin="anonymous"></script>
<script src="resources/js/sidebar-menu.js"></script>
<script src="resources/js/simplebar.js"></script>
<!-- <script src="resources/js/bootstrap.min.js"></script> -->
<script src="resources/js/bestWS.js"></script>
</head>
<style>
.btn-finish-work {
	display: none;
}

</style>

<body>
	<div id="sidebar-wrapper" data-simplebar=""
		data-simplebar-auto-hide="true">
		<div class="brand-logo">
			<a href="main.go">
				<h4>
					<span style="color: #E9396B;">BEST</span>
				</h4>
				<h5 class="logo-text">
					<span style="color: #E9396B;">B</span>us <span
						style="color: E9396B;">E</span>mployee <span
						style="color: #E9396B;">S</span>ervice <span
						style="color: #E9396B;">T</span>ool
				</h5>
			</a>
		</div>
		<div class="member-profile">
			<div class="profile-photo"></div>
			<ul class="user-Info">
				<li></li>
				<li></li>
			</ul>
		</div>
		<ul class="sidebar-menu do-nicescrol">
			<li class="sidebar-header"></li>
			<li><a href="main.go"> <i class="mdi mdi-view-dashboard"></i>
					<span>대쉬보드</span> <i class="fa-solid fa-angle-right"></i>
			</a></li>

			<li class="dropD"><a href="javaScript:void(0);"> <i
					class="bi bi-clock-fill"></i> <span>근태관리</span> <i
					class="fa-solid fa-angle-right"></i>
			</a>

				<ul class="dropD-menu">
					<li class="dropD-item"><a href="attendance.go"> <i
							class="bi bi-clock-fill"></i> <span>출퇴근 기록</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="attendanceEmpList.go"> <i
							class="bi bi-person-vcard"></i><span>사원목록</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
				</ul></li>

			<li class="dropD"><a href="calendar.go"> <i
					class="fa-regular fa-calendar-check"></i> <span>캘린더</span> <i
					class="fa-solid fa-angle-right"></i>
			</a></li>

			<li class="dropD"><a href="javaScript:void(0);"> <i
					class="bi bi-bus-front-fill"></i> <span>버스정보</span> <i
					class="fa-solid fa-angle-right"></i>
			</a>

				<ul class="dropD-menu">
					<li class="dropD-item"><a href="driveInfo.go"> <i
							class="fa-solid fa-road"></i> <span>운행현황</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="dispatchList.go"> <i
							class="fa-solid fa-user-tie"></i> <span>배차현황</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="busDispatch.go"> <i
							class="fa-solid fa-user-tie"></i> <span>배차관리</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="busDetail.go"> <i
							class="bi bi-bus-front"></i> <span>버스관리</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
				</ul></li>

			<li style="position: relative;"><a href="chatList.go"> <i
					class="bi bi-chat-left-text-fill"></i> <span>메신져</span> <i
					class="fa-solid fa-angle-right"></i>
			</a>
				<div id="newMessageIndicator" class="newMessageIndicator"></div></li>

			<li class="dropD"><a href="javaScript:void(0);"> <i
					class="bi bi-envelope-fill"></i> <span>메일함</span> <i
					class="fa-solid fa-angle-right"></i>
			</a>
				<ul class="dropD-menu">
					<li class="dropD-item"><a href="mailWrite.go"> <i
							class="bi bi-envelope-paper-fill"></i> <span>메일작성</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="mail.go"> <i
							class="bi bi-envelope-paper-fill"></i> <span>받은 메일함</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="test.go"> <i
							class="bi bi-send"></i> <span>보낸 메일함</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="javaScript:void(0);"> <i
							class="bi bi-envelope-exclamation-fill"></i> <span>임시저장</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="javaScript:void(0);"> <i
							class="bi bi-trash-fill"></i> <span>휴지통</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
				</ul></li>


			<li class="dropD"><a href="javaScript:void();"> <i
					class="fa-regular fa-clipboard"></i> <span>결재문서</span> <i
					class="fa-solid fa-angle-right"></i>
			</a>

				<ul class="dropD-menu">
					<li class="dropD-item"><a href="documentPending.go"> <i
							class="bi bi-file-text-fill"></i> <span>대기</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="documentBoard.go"> <i
							class="bi bi-file-text-fill"></i> <span>진행중</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="documentApproved.go"> <i
							class="bi bi-file-earmark-check-fill"></i> <span>완료</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="documentReject.go"> <i
							class="bi bi-file-earmark-break-fill"></i> <span>반려</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="documentReference.go"> <i
							class="bi bi-file-earmark-arrow-up-fill"></i> <span>참조</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="documentDraft.go"> <i
							class="bi bi-file-earmark-arrow-up-fill"></i> <span>임시저장</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
				</ul></li>

			<li><a href="orgChart.go"> <i class="bi bi-diagram-3-fill"></i>
					<span>조직도</span> <i class="fa-solid fa-angle-right"></i>
			</a></li>

			<li class="dropD"><a href="javaScript:void();"> <i
					class="bi bi-layout-text-window-reverse"></i> <span>게시판</span> <i
					class="fa-solid fa-angle-right"></i>
			</a>

				<ul class="dropD-menu">
					<li class="dropD-item"><a href="noticeBoard.go"> <i
							class="bi bi-megaphone-fill"></i> <span>공지사항</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="freeBoard.go"> <i
							class="bi bi-window-stack"></i> <span>자유 게시판</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
				</ul></li>


			<li class="dropD"><a href="javaScript:void(0);"> <i
					class="fa-regular fa-calendar-check"></i> <span>회의실</span> <i
					class="fa-solid fa-angle-right"></i>
			</a>

				<ul class="dropD-menu">
					<li class="dropD-item"><a href="meetingRoomCalendar.do"> <i
							class="fa-regular fa-calendar-check"></i> <span>회의실 예약</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="myReserve.go"> <i
							class="fa-regular fa-calendar-check"></i> <span>내 예약 현황</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="roomInfo.go"> <i
							class="fa-regular fa-calendar-check"></i> <span>회의실 정보</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
				</ul></li>

			<!-- 종원 기자재 -->
			<li class="dropD"><a href="javaScript:void(0);"> <i
					class="fa-regular fa-calendar-check"></i> <span>기자재</span> <i
					class="fa-solid fa-angle-right"></i>
			</a>

				<ul class="dropD-menu">
					<li class="dropD-item"><a href="material.go"> <i
							class="fa-regular fa-calendar-check"></i> <span>기자재 관리</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
				</ul></li>


			<!-- 관욱수정 2024.12.12 시작 -->
			<li class="dropD"><a href="javaScript:void();"> <i
					class="bi bi-person-vcard"></i> <span>사원관리</span> <i
					class="fa-solid fa-angle-right"></i>
			</a>

				<ul class="dropD-menu">
					<li class="dropD-item"><a href="empList.go"> <i
							class="bi bi-person-vcard"></i> <span>사원목록</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="empCreate.go"> <i
							class="bi bi-person-vcard"></i> <span>사원등록</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
				</ul></li>

			<!-- 관욱수정 2024.12.12 끝 -->
			<li class="dropD"><a href="javaScript:void();"> <i
					class="bi bi-bar-chart-fill"></i> <span>매출현황</span> <i
					class="fa-solid fa-angle-right"></i>
			</a>

				<ul class="dropD-menu">
					<li class="dropD-item"><a href="javaScript:void();"> <i
							class="bi bi-bar-chart-fill"></i> <span>월별현황</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="javaScript:void();"> <i
							class="bi bi-graph-up"></i> <span>연별현황</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="javaScript:void();"> <i
							class="bi bi-file-earmark-bar-graph-fill"></i> <span>매출등록</span>
							<i class="fa-solid fa-angle-right"></i>
					</a></li>
				</ul></li>

			<li><a href="javaScript:void();"> <i
					class="bi bi-wallet-fill"></i> <span>지출정산</span> <i
					class="fa-solid fa-angle-right"></i>
			</a></li>

			<li><a href="javaScript:void();"> <i
					class="fa-solid fa-video"></i> <span>CCTV</span> <i
					class="fa-solid fa-angle-right"></i>
			</a></li>

			<li class="sidebar-header"></li>
			<li><a href="javaScript:void(0);"> <i
					class="fa-regular fa-bell"></i> <span>알림</span> <i
					class="fa-solid fa-angle-right"></i>
			</a></li>
			<li><a href="javaScript:void(0);"> <i
					class="bi bi-person-fill-gear"></i> <span>내 정보관리</span> <i
					class="fa-solid fa-angle-right"></i>
			</a></li>
			<li><a href="login.go"><i
					class="fa-solid fa-right-to-bracket"></i> <span>로그인</span> <i
					class="fa-solid fa-angle-right"></i> </a></li>
			<li><a href="javaScript:void(0);"><i
					class="fa-solid fa-right-to-bracket"></i> <span>로그아웃</span> <i
					class="fa-solid fa-angle-right"></i> </a></li>

		</ul>

	</div>

	<header class="topbar-nav">
		<nav class="navbar navbar-expand fixed-top">
			<ul class="navbar-nav mr-auto align-items-center">
    			<li>
      				<div class="work-time">
            			<i class="bi bi-clock-history"></i>
           				<button class="btn-start-work" onclick="updateStartTime()">출근</button>
            			<span class="spanAction"> 
           					<span>startTime </span>	~ <span>endTime</span>
            			</span>
           				<button class="btn-finish-work" onclick="updateEndTime()">퇴근</button>
       				</div>
    			</li>
  			</ul>

			<ul class="navbar-nav align-items-center right-nav-link">
				<li class="nav-item dropdown-lg" style="position: relative;">
					<div id="newMessageIndicator3"></div>
					<div class="dropdown">
						<a class="nav-link" href="javascript:void(0);"
							id="messageDropdownToggle"> <i class="fa-regular fa-message"></i>
						</a>
						<div class="dropdown-menu-custom" id="messageDropdown">
							<!-- 드롭다운 내용이 여기에 추가됩니다 -->
						</div>
					</div>
				</li>
				<li class="nav-item dropdown-lg"><a
					class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect"
					data-toggle="dropdown" href="javascript:void();"> <i
						class="fa fa-bell-o"></i></a></li>
				<li class="nav-item dropdown-lg"><a
					class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect"
					data-toggle="dropdown" href="javascript:void();"> <i
						class="bi bi-person-circle"></i>
				</a></li>
			</ul>
		</nav>
	</header>
	<script>
window.updateUnreadMessageCount = function (unreadTotal) {
    const unreadCountContainer = $(".newMessageIndicator .unread-count-list .unread-message-count");

    if (unreadTotal > 0) {
        if (unreadCountContainer.length > 0) {
            // 기존 엘리먼트가 있으면 업데이트
            unreadCountContainer.text(unreadTotal).closest(".newMessageIndicator").css("display", "block");
        } else {
            // 없으면 새로 추가
            const unreadHTML = 
                '<div class="unread-count-list">' +
                    '<span class="unread-message-count">' + unreadTotal + '</span>' +
                '</div>';
            $(".newMessageIndicator").append(unreadHTML).css("display", "block");
        }
        $("#newMessageIndicator3").css("display", "block");
    } else {
        // 읽지 않은 메시지가 없으면 숨김
    	$(".newMessageIndicator").css("display", "none");
        $("#newMessageIndicator3").css("display", "none");
    }

    console.log("읽지 않은 메시지 총 수 업데이트:", unreadTotal);
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
        const spans = document.querySelectorAll('.spanAction span');
        const spanAction = document.querySelector('.spanAction');
       if (data.startTime) {
            button.style.display = 'none';
            finish.style.display = 'block';
            spans[0].textContent = data.startTime;
            spans[0].style.display = 'block';
            spans[1].style.display = 'block';
            spanAction.style.display = 'flex';
      }
       if (data.startTime && data.endTime) {
         finish.disabled = true;
         spans[1].textContent = data.endTime;
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


</script>

	<!-- 우측 하단 알림 메시지 -->
	<div id="notification" class="notification"></div>

</body>

</html>