<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
<style>

:root{
	--primary-color: #30005A;
	--secondary-color: #8B6AA7;
	--accent-color: #E9396B;
	--background-color: #FFFBF2;
}
.dashboard-body {
	color: #30005A;
	height: 92%;
	display: flex;
	flex-direction: column;
	align-content: center;
	align-items: flex-start;
	justify-content: center;
	height: auto;
	width: 83%;
	margin-top: 80px;
	margin-left: 300px;
	margin-right: 100%;
}
.content-size {
    width: 56vw;
    height: 728px;
    display: flex;
    flex-direction: column;
    border: 2px solid #30005A;
    border-radius: 10px;
    align-items: center;
    justify-content: center;
    margin-left: 13vw;
}
.tm2 {
	width: 21%;
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 1.5rem;
}
.f32 {
	font-size: 32px;
}
.bold {
	font-weight: bold;
}
.lPurple {
	color: #8B6AA7;
}
.purple{
	color: #30005A;
}
.content-main{
    width: 90%;
    height: 90%;
    margin-top: -4vh;
}
.content-body{
	width: 100%;
	height: 95%;
	border: 2px solid #30005A;
	border-radius: 10px;
}
.header{
	display: flex;
}
.body{
	margin-top: 12px;
}
.filter{
	width: fit-content;
   	margin-left: 15px;
   	cursor: pointer;
   	height: 36px;
   	font-size: 18px;
   	color: #8B6AA7;
}
.filter:hover{
	border-bottom: 2px solid #E9396B;
	color: #30005A;
}
/* 위쪽 필터 활성화 */
.content-header .filter.active {
    border-bottom: 2px solid #E9396B;
    color: #30005A;
}

/* 아래쪽 필터 활성화 */
.body.header .filter.active {
    border-bottom: 2px solid #E9396B;
    color: #30005A;
}

table, th, td{
	border-collapse: collapse;
}
table{
	width: 100%;
	text-align: center;
	border: 1px solid #30005A;
}
thead{
	background-color: #30005A;
	color: #FFF5E2;
	font-weight: bold;
}
td{
	border-bottom: 1px solid #8B6AA7;
}



.container nav{
		display:flex;
		justify-content: center;
	}
	.pagination .page-link {
		color: var(--primary-color); /* 글자 색상 */
		background-color: var(--background-color); /* 배경 색상 */
		border: var(--background-color) !important; /* 테두리 */
		font-family: 'Arial', sans-serif; /* 폰트 */
		font-size: 16px; /* 글자 크기 */
		box-shadow: none !important;
	}
	/* 호버 시 스타일 */
	.pagination .page-link:hover {
		font-weight: bold;
		color: var(--accent-color) !important;
		background-color: var(--background-color) !important;
	}
	/* 활성화된 페이지 스타일 */
	.pagination .active .page-link {
		font-weight: bold;
		color: var(--accent-color) !important;
		background-color: var(--background-color) !important;
	}
	/* 클릭 시 생기는 테두리 제거 */
	.pagination .page-link:focus {
	  outline: none;
	  box-shadow: none; /* 부가적인 그림자 효과도 제거 */
	}
	/* 비활성화된 페이지 스타일 */
	.pagination .disabled .page-link {
		color: var(--background-color) !important;
		background-color: var(--background-color) !important;
	}	
	@media ( min-width :1200px) {
		.container {
			max-width: 100% !important;
		}
	}
	.alarmContent{
		cursor: pointer;
	}
	.alarmContent i{
		color: #E9396B;
		-webkit-text-stroke: 0.5px #E9396B;
	}
</style>
</head>
<body class="bg-theme bg-theme1">
	<jsp:include page="../main/header.jsp"></jsp:include>
	<div class="dashboard-body">

		<div class="naviPath purple bold f32 w100 tm2">
			<span>알림</span>
		</div>

		<div class="content-size">
			<div class="content-main">
				<div class="content-header header">
					<div class="filter purple bold">전체</div>
					<div class="filter purple bold">메일</div>
					<div class="filter purple bold">캘린더</div>
					<div class="filter purple bold">회의실</div>
					<div class="filter purple bold">기자재</div>
					<div class="filter purple bold">결재</div>
					<div class="filter purple bold">게시판</div>
				</div>
				<div class="content-body">
					<div class="body header">
						<div class="filter purple bold">전체</div>
						<div class="filter purple bold">읽음</div>
						<div class="filter purple bold">안읽음</div>
					</div>
					<table>
						<thead>
							<tr>
								<th>NO</th>
								<th>분류</th>
								<th>내용</th>
								<th>날짜</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody id="alarmList">
				
						</tbody>
					</table>
				</div>
				<div class="container" id="sentCont">
				    <nav aria-label="Page navigation">
				        <ul class="pagination" id="sentPage"></ul>
				    </nav>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
var loginId = ${sessionScope.loginId};
var emp_idx = parseInt(loginId);

$(document).ready(function () {
    const limit = 20; // 한 페이지에 표시할 알림 수
    const empIdx = emp_idx; // 사용자 ID

    let currentType = null; // 현재 필터 타입 (메일, 캘린더, 결재 등)
    let currentFlag = null; // 현재 읽음 여부 (읽음, 안읽음)

    // 초기 알림 데이터 로드
    fetchAlarms(1, currentType, currentFlag);

    // 알림 데이터 가져오기
    function fetchAlarms(page, type, flag) {
    	const data = {
    	        emp_idx: empIdx,
    	        page: page,
    	        limit: limit,
    	    };

    	    if (type) {
    	        data.type = type;
    	    }

    	    if (flag !== null) {
    	        data.flag = flag; // 명확히 true 또는 false로 설정
    	    }
        $.ajax({
            url: "alarmList.ajax",
            type: "GET",
            data: data,
            success: function (response) {
                renderAlarmList(response.alarms);
                setupPagination(response.totalCount, page, type, flag);
            },
            error: function (err) {
                console.error("알림 데이터를 가져오는 중 오류 발생", err);
            },
        });
    }

    // 알림 리스트 렌더링
    function renderAlarmList(data) {
        const alarmList = $("#alarmList");
        alarmList.empty();

        if (!data || data.length === 0) {
            alarmList.append('<tr><td colspan="5">알림이 없습니다.</td></tr>');
            return;
        }

        data.forEach(function (alarm, index) {
            const alarmDate = new Date(alarm.date);
            const today = new Date();

            const isToday =
                alarmDate.getDate() === today.getDate() &&
                alarmDate.getMonth() === today.getMonth() &&
                alarmDate.getFullYear() === today.getFullYear();

            const formattedDate = isToday
                ? alarmDate.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })
                : alarmDate.toLocaleDateString("ko-KR", {
                      year: "numeric",
                      month: "long",
                      day: "numeric",
                  });
                
                const typeAction =
                    alarm.type === "mail"
                        ? "mail.go"
                        : alarm.type === "document"
                        ? "documentPending.go"
                        : alarm.type === "calendar"
                        ? "calendar.go"
                        : alarm.type === "reserve"
                        ? "myReserve.go"
                        : alarm.type === "borrow"
                        ? "material.go"
                        : "#";


                alarmList.append(
                		'<tr style="' + (alarm.flag === false ? '' : 'color: #8B6AA7;') + '">' +
                	        '<td>' + (index + 1) + '</td>' +
                	        '<td>' +
                	            (alarm.type === "mail"
                	                ? '<i class="far fa-envelope"></i>'
                	                : alarm.type === "document"
                	                ? '<i class="fa-regular fa-clipboard"></i>'
                	                : alarm.type === "calendar"
                	                ? '<i class="fa-regular fa-calendar-check"></i>'
                	                : alarm.type === "reserve"
                	                ? '<i class="bi bi-journal-check"></i>'
                	                : alarm.type === "borrow"
                	                ? '<i class="bi bi-box"></i>'
                	                : alarm.type === "comment"
                	                ? '<i class="fa-regular fa-comments"></i>'
                	                : '') +
                	        '</td>' +
                	        '<td class="alarmContent" onclick="handleAlarmClick(\'' + alarm.alarm_idx + '\', \'' + typeAction + '\')">' + alarm.content + '</td>' +
                	        '<td>' + formattedDate + '</td>' +
                	        '<td>' + (alarm.flag === false ? '<i class="fas fa-envelope"></i>' : '<i class="fas fa-envelope-open-text"></i>') + '</td>' +
                	    '</tr>'
                	);
        });
    }

    // 페이지네이션 설정
    function setupPagination(totalCount, currentPage, type, flag) {
        const totalPages = Math.ceil(totalCount / limit);

        $("#sentPage").twbsPagination("destroy"); // 기존 이벤트 제거
        $("#sentPage").empty(); // 기존 DOM 제거

        $("#sentPage").twbsPagination({
            totalPages: totalPages,
            visiblePages: 5,
            startPage: currentPage,
            onPageClick: function (event, page) {
                if (page !== currentPage) { // 중복 호출 방지
                    fetchAlarms(page, null, null);
                }
            },
        });
    }

    // 필터 클릭 이벤트
    $(".filter").off("click").on("click", function () {
        const parentClass = $(this).parent().attr("class"); // 부모 클래스 확인

        if (parentClass.includes("content-header")) {
            // 위쪽 필터 그룹
            $(".content-header .filter").removeClass("active");
            $(this).addClass("active");

            const filterText = $(this).text().trim();
            switch (filterText) {
                case "전체":
                    currentType = null;
                    break;
                case "메일":
                    currentType = "mail";
                    break;
                case "캘린더":
                    currentType = "calendar";
                    break;
                case "회의실":
                    currentType = "reserve";
                    break;
                case "기자재":
                    currentType = "borrow";
                    break;
                case "결재":
                    currentType = "document";
                    break;
                case "게시판":
                    currentType = "comment";
                    break;
            }
        } else if (parentClass.includes("body header")) {
            // 아래쪽 필터 그룹
            $(".body.header .filter").removeClass("active");
            $(this).addClass("active");

            const filterText = $(this).text().trim();
            switch (filterText) {
                case "전체":
                    currentFlag = null;
                    break;
                case "읽음":
                    currentFlag = true;
                    break;
                case "안읽음":
                    currentFlag = false;
                    break;
            }
        }

        fetchAlarms(1, currentType, currentFlag); // 필터 적용 후 페이지 1부터 데이터 다시 로드
    });
    
    window.handleAlarmClick = function (alarmIdx, redirectUrl) {
        $.ajax({
            url: "updateAlarmFlag.ajax",
            type: "POST",
            data: { alarm_idx: alarmIdx, flag: 1 },
            success: function () {
                location.href = redirectUrl;
            },
            error: function (err) {
                console.error("알림 flag 업데이트 중 오류 발생:", err);
            },
        });
    };
});


</script>
</html>
