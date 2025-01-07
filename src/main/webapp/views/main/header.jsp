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
.work-time {
	width: 100%;
}
.spanAction span {
	display: none;
	width: 30%;
	margin: 0 0 0 14px;
}
.spanAction {
	width: 45%;
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
					<li class="dropD-item"><a href="mail.go?tabData=receive"> <i
							class="bi bi-envelope-paper-fill"></i> <span>받은 메일함</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="mail.go?tabData=send"> <i
							class="bi bi-send"></i> <span>보낸 메일함</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="mail.go?tabData=draft"> <i
							class="bi bi-envelope-exclamation-fill"></i> <span>임시저장</span> <i
							class="fa-solid fa-angle-right"></i>
					</a></li>
					<li class="dropD-item"><a href="mail.go?tabData=trash"> <i
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
					<li class="dropD-item"><a href="documentWrite.go"> <i
							class="bi bi-file-earmark-arrow-up-fill"></i> <span>양식 만들기</span> <i
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
			<li><a href="alarm.go"> <i
					class="fa-regular fa-bell"></i> <span>알림</span> <i
					class="fa-solid fa-angle-right"></i>
			</a></li>
			<li><a href="myDetail.go?emp_idx=${sessionScope.loginId}"> <i
					class="bi bi-person-fill-gear"></i> <span>내 정보관리</span> <i
					class="fa-solid fa-angle-right"></i>
			</a></li>
			
			<!-- 관욱추가 시작 2025.01.05 -->
			<li><a href="accessManage.go"> 
			    <i class="bi bi-shield-check"></i> 
			    <span>권한관리</span> 
			    <i class="fa-solid fa-angle-right"></i>
			</a></li>
			<!-- 관욱추가 끝 2025.01.05 -->
			
			
			<li><a href="logout.do"><i
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
  			<ul id="alarmHeader" class="alarmHeader">
  				
  			</ul>

			<ul class="navbar-nav align-items-center right-nav-link">
			
				<!-- 메시지 알림 드롭다운 -->
				<li class="nav-item dropdown-lg" style="position: relative;">
					<div id="newMessageIndicator3"></div>
					<div class="dropdown">
						<a class="nav-link headerDropdownToggle" href="javascript:void(0);">
							<i class="fa-regular fa-message"></i>
						</a>
						<div class="dropdown-menu-custom messageDropdown dropdownMenu">
							<!-- 드롭다운 내용이 여기에 추가됩니다 -->
						</div>
					</div>
				</li>
				
				<!-- 결재 / 캘린더 / 메일 / 알림리스트 드롭다운 -->
				<li class="nav-item dropdown-lg" style="position: relative;">
				<div id="alarmIndicator"></div>
				<div class="dropdown">
						<a class="nav-link headerDropdownToggle" href="javascript:void(0);">
							<i class="fa fa-bell-o"></i>
						</a>
						<div class="dropdown-menu-custom alarmDropdown dropdownMenu">
							<!-- 드롭다운 내용이 여기에 추가됩니다 -->
						</div>
					</div>

				</li>
						
						
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

function showMailNotification(content, type) {
    const notification = $("#alarmHeader");

    const notificationContent = '<li>' + content + '</li>';
    notification.html(notificationContent);

    // 알림 표시
    notification.addClass("show");

    // 클릭 시 URL 이동
    notification.off("click").on("click", function () {
        let redirectUrl = '';
        switch (type) {
            case 'mail':
                redirectUrl = 'mail.go';
                break;
            case 'document':
                redirectUrl = 'documentPending.go';
                break;
            case 'calendar':
                redirectUrl = 'calendar.go';
                break;
            case 'reserve':
                redirectUrl = 'myReserve.go';
                break;
            default:
                console.warn('Unknown type:', type);
                return;
        }
        window.location.href = redirectUrl;
    });

    // 알림 자동 숨김
    setTimeout(() => {
        notification.removeClass("show");
    }, 5000); // 5초 후 숨김
}

$(document).ready(function () {
    const mailDropdown = $(".alarmDropdown");

    // 초기 알림 리스트 로드
    function loadAlarmList() {
        $.ajax({
            url: "unreadAlarm.ajax",
            type: "GET",
            data: { emp_idx: loginId }, // emp_idx 세션이나 전역 상태에서 가져옴
            success: function (data) {
                renderDropdown(data.alarms);
            },
            error: function (err) {
                console.error("알림 데이터를 가져오는 중 오류 발생", err);
            }
        });
    }

    // 드롭다운 렌더링 함수
    function renderDropdown(data) {
        mailDropdown.empty(); // 기존 드롭다운 초기화

        if (data.length === 0) {
            mailDropdown.append('<div class="dropdown-item">알림이 없습니다.</div>');
            return;
        }

        const limitedData = data.slice(0, 5); // 최신 5개의 데이터만 유지
        limitedData.forEach(function (alarm) {
            const alarmItem =
                '<div class="dropdown-item" data-type="' + alarm.type + '">' +
                    '<div class="notification-profile">' +
                        '<div class="notifi-profile">' +
                            '<div>' + alarm.content + '</div>' +
                        '</div>' +
                    '</div>' +
                '</div>';
            mailDropdown.append(alarmItem);
        });
    }

    // 초기 호출
    loadAlarmList();

    // 이벤트 위임으로 클릭 이벤트 처리
    mailDropdown.on("click", ".dropdown-item", function () {
        const itemType = $(this).data("type");
        let redirectUrl = '';
        switch (itemType) {
            case 'mail': redirectUrl = 'mail.go'; break;
            case 'document': redirectUrl = 'documentPending.go'; break;
            case 'calendar': redirectUrl = 'calendar.go'; break;
            case 'reserve': redirectUrl = 'myReserve.go'; break;
            default: return;
        }
        window.location.href = redirectUrl;
    });
});

function updateMailDropdown(content, type) {
    const mailDropdown = $(".alarmDropdown");

    // 새로 받은 알림 추가
    const mailItem =
        '<div class="dropdown-item" data-type="' + type + '">' +
            '<div class="notification-profile">' +
                '<div class="notifi-profile">' +
                    '<div>' + content + '</div>' +
                '</div>' +
            '</div>' +
        '</div>';

    mailDropdown.prepend(mailItem);

    // 최대 5개의 메일만 유지
    if (mailDropdown.children().length > 5) {
        mailDropdown.children().last().remove();
    }
}



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

































/* 권한에 따른 메뉴바 숨기기기 */
$(document).ready(function () {
    // 서버에서 전달된 접근 불가능한 URL 목록 (JSON 데이터)
    const inaccessibleUrls = ${inaccessibleUrls}; // 서버에서 전달된 배열
    console.log('Inaccessible URLs:', inaccessibleUrls); // 디버깅용 콘솔 출력

    // 모든 a 태그를 순회하며 숨김 처리
    $('.sidebar-menu a').each(function () {
        const href = $(this).attr('href'); // 각 a 태그의 href 속성 가져오기

        // 접근 불가능한 URL 목록에 해당 href가 포함된 경우
        if (href && inaccessibleUrls.includes(href)) {
            // 해당 태그의 부모 li 요소 숨기기
            $(this).closest('li').hide();
        }
    });

    // `dropD-menu` 하위의 모든 `li`가 숨김 처리된 경우, 해당 `dropD`도 숨김 처리
    $('.dropD').each(function () {
        const dropDMenu = $(this).find('.dropD-menu'); // `dropD-menu` 찾기
        const visibleItems = dropDMenu.find('li').filter(function () {
            return $(this).css('display') !== 'none'; // 보이는 항목 필터링
        });

        if (visibleItems.length === 0) {
            // 보이는 항목이 없으면 해당 `dropD` 숨김 처리
            $(this).hide();
        } else {
            // 보이는 항목이 하나라도 있으면 `dropD`는 보임 상태 유지
            $(this).show();
        }
    });
});











</script>

	<!-- 우측 하단 알림 메시지 -->
	<div id="notification" class="notification"></div>

</body>

</html>