<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/0e9db4cdc9.js"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css"
	rel="stylesheet">
<style>
.body {
	height: auto;
	width: 83%;
	margin-top: 110px;
	margin-left: 320px;
}

table {
	text-align: center;
}

thead {
	background-color: #30005A;
	color: #FFFBF2;
}

thead tr {
	height: 41px;
}

tbody tr {
	height: 30px;
	border-bottom: 1px solid #8B6AA7;
}

.bus-list {
	display: flex;
	flex-direction: column;
	width: 100%;
	height: 100%;
}

.bus-card {
	border: 2px solid #30005A;
	border-radius: 10px;
	padding: 3%;
	display: flex;
	flex-direction: column;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	height: 100%;
	font-weight: bold;
}

.route-filter {
	border-bottom: 3px solid #FFFBF2;
	cursor: pointer;
	font-size: 24px;
	text-align: center;
	font-weight: bold;
}

.route-filter.active {
	border-bottom: 3px solid #E9396B;
}

.route-filter:hover {
	border-bottom: 3px solid #E9396B;
}

.bus-filter {
	display: flex;
	width: 60%;
	flex-direction: column;
	height: 626px;
	margin-left: 14vw;
}

.route-filters {
	width: 20%;
	display: flex;
	justify-content: space-between;
	margin-left: 1vw;
}

/* 초록색 글씨 */
.cGreen {
	color: #1DD20C;
}

/* 파란색 글씨 */
.cBlue {
	color: #2A33DD;
}

.tm2 {
	margin-left: -1%;
	margin-top: -2%;
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

/* 날짜 네비게이션 */
.date-navigation {
	position: relative;
	margin: 20px 0;
	font-size: 24px;
	font-weight: bold;
	text-align: center;
	width: 70%;
	margin-left: 24vw;
}

.date-content {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	width: 50%;
}

.date-button {
	color: #30005A; /* 보라색 글씨 */
	background-color: transparent; /* 배경색 제거 */
	border: none; /* 테두리 제거 */
	cursor: pointer;
	margin: 0 10px;
	font-weight: bold; /* 강조 효과 */
}

.date-button:hover {
	text-decoration: underline;
}

.current-date {
	margin: 0 20px;
	color: #30005A;
}

.search-bar-container {
	position: absolute; /* 부모 요소(date-navigation)를 기준으로 배치 */
	right: 0; /* 오른쪽 끝으로 정렬 */
	top: 50%; /* 수직 가운데 정렬 */
	transform: translateY(-50%);
	display: flex;
	align-items: center;
}

.search-bar {
	border: 2px solid #30005A;
	border-radius: 5px;
	padding: 10px 40px 10px 10px;
	font-size: 18px;
	width: 300px;
}

.search-icon {
	position: absolute;
	right: 15px;
	top: 50%;
	transform: translateY(-50%);
	color: #E9396B; /* 핑크색 */
	font-size: 18px;
	z-index: 1;
}

.body-content {
	width: 100%;
}

.bus-details {
	font-size: 16px;
	color: #8B6AA7;
	width: 100%;
	display: flex;
	justify-content: center;
	flex-direction: column;
}

.docnav {
	width: 21%;
	display: flex;
}

.startBtn {
	font-family: "Noto Sans KR", sans-serif;
	font-size: 16px;
	margin-right: 12px;
	border-radius: 5px;
	background-color: #E9396B;
	color: #FFF5E2;
	display: flex;
    align-items: center;
    gap: 8px;
    border: none;
    padding: 4px 15px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    margin: 0 6px 0 1px;
}

.stopBtn {
	background-color: #30005A;
	color: #FFF5E2;
	font-family: "Noto Sans KR", sans-serif;
	font-size: 16px;
	border-radius: 5px;
	display: flex;
    align-items: center;
    gap: 8px;
    border: none;
    padding: 4px 15px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    margin: 0 0 0 1px;
}

tbody i {
	color: #E9396B;
    margin-left: 6px;
}
.bus-route{
    display: flex;
    width: 100%;
    justify-content: space-between;
}
</style>
</head>
<body class="bg-theme bg-theme1">
	<jsp:include page="../main/header.jsp"></jsp:include>
	<div class="body">
		<!-- 페이지 제목 -->
		<div class="naviPath bold f32 w100 tm2">
			<span class="lPurple">버스정보</span> <i class="fa-solid fa-angle-right"
				style="color: #8B6AA7;"></i> <span class="purple">배차현황</span>
			<div class="bus-drive-info"></div>
		</div>
		<div class="date-navigation">
			<div class="date-content">
				<button class="date-button">
					<i class="fas fa-angle-double-left"></i>
				</button>
				<button class="date-button">
					<i class="fas fa-angle-left"></i>
				</button>
				<span class="current-date"></span>
				<button class="date-button">
					<i class="fas fa-angle-right"></i>
				</button>
				<button class="date-button">
					<i class="fas fa-angle-double-right"></i>
				</button>
			</div>
		</div>
		<div class="bus-filter">
			<div class="bus-route">
				<div class="route-filters"></div>
				<div class="docnav">
					<div>
						<button class="startBtn">운행 시작</button>
					</div>
					<div>
						<button class="stopBtn">운행 종료</button>
					</div>
				</div>
			</div>
			<!-- 버스 목록 -->
			<div class="bus-list">
				<div class="bus-card">
					<table>
						<thead>
							<tr>
								<th>차량 번호</th>
								<th>첫 차 ~ 14:00</th>
								<th>운행 상태</th>
								<th>14:00 ~ 막차</th>
								<th>운행 상태</th>
							</tr>
						</thead>
						<tbody class="list-tbody">

						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
var loginId = ${sessionScope.loginId};
var emp_idx = parseInt(loginId);

window.onload = function () {

    const loadDispatchList = function (date, selectedRouteName = "") {
        const $listTbody = $(".list-tbody");
        const $routeFilters = $(".route-filters");

        $.ajax({
            url: "dispatchList.ajax",
            method: "GET",
            data: { date: date },
            success: function (response) {
                $listTbody.empty(); // tbody 초기화
                $routeFilters.empty(); // 필터 초기화

                if (response.success) {
                    // 1. 노선 필터 버튼 생성
                    response.routes.forEach(function (route) {
                        const div = $('<div></div>') // div 생성
                            .addClass("route-filter")
                            .addClass("bus-number")
                            .attr("data-route", route)
                            .text(route);

                        if (route.length === 4) {
                            div.addClass("cGreen");
                        } else {
                            div.addClass("cBlue");
                        }

                        if (route === selectedRouteName) {
                            div.addClass("active");
                        }

                        $routeFilters.append(div); // div 추가
                    });

                    // 2. 데이터 그룹화
                    const groupedData = {};
                    response.result.forEach(function (info) {
                        const routeName = info.route_name;
                        const licensePlate = info.license_plate;

                        if (!groupedData[routeName]) {
                            groupedData[routeName] = {};
                        }

                        if (!groupedData[routeName][licensePlate]) {
                            groupedData[routeName][licensePlate] = {
                                shift_1: '-',
                                shift_2: '-',
                                dispatch_1_idx: null,
                                dispatch_2_idx: null,
                                status_1: null,
                                status_2: null
                            };
                        }

                        if (info.shift_idx === 1) {
                            groupedData[routeName][licensePlate].shift_1 =
                                info.driver_name + ' / <span style="color:#8B6AA7;">' + info.emp_idx + '</span>';
                            groupedData[routeName][licensePlate].dispatch_1_idx = info.dispatch_idx;
                            groupedData[routeName][licensePlate].status_1 = info.status; // status 추가
                        } else if (info.shift_idx === 2) {
                            groupedData[routeName][licensePlate].shift_2 =
                                info.driver_name + ' / <span style="color:#8B6AA7;">' + info.emp_idx + '</span>';
                            groupedData[routeName][licensePlate].dispatch_2_idx = info.dispatch_idx;
                            groupedData[routeName][licensePlate].status_2 = info.status; // status 추가
                        }
                    });

                    // 3. tbody 데이터 추가
                    if (groupedData[selectedRouteName]) {
                        const selectedData = groupedData[selectedRouteName];
                        for (const licensePlate in selectedData) {
                            const shifts = selectedData[licensePlate];
                            const row =
                                '<tr>' +
                                '<td>' + licensePlate + '</td>' +
                                '<td>' + (shifts.shift_1 || '-') + '</td>' +
                                '<td data-dispatch-idx="' + (shifts.dispatch_1_idx || '') + '">' +
                                (shifts.status_1 || '-') + '</td>' +
                                '<td>' + (shifts.shift_2 || '-') + '</td>' +
                                '<td data-dispatch-idx="' + (shifts.dispatch_2_idx || '') + '">' +
                                (shifts.status_2 || '-') + '</td>' +
                                '</tr>';
                            $listTbody.append(row);
                        }
                    } else {
                        const emptyRow =
                            '<tr>' +
                            '<td colspan="5">데이터가 없습니다.</td>' +
                            '</tr>';
                        $listTbody.append(emptyRow);
                    }
                } else {
                    alert("데이터를 불러오는 데 실패했습니다.");
                }
            },
            error: function () {
                alert("서버와 통신 중 오류가 발생했습니다.");
            }
        });
    };


    $("body").on("click", ".route-filter", function () {
        const $this = $(this);
        const selectedRouteName = $this.data("route");
        const currentDate = $(".current-date").text();

        // 모든 필터에서 active 클래스 제거 후 클릭된 요소에 추가
        $(".route-filter").removeClass("active");
        $this.addClass("active");

        // 데이터 갱신 호출
        loadDispatchList(currentDate, selectedRouteName);
    });

    
    

    // 현재 날짜 설정 및 초기 데이터 로드
    const today = new Date();
    today.setHours(today.getHours() + 9); // UTC 시간을 KST(UTC+9)로 변환
    const $currentDate = $(".current-date");
    $currentDate.text(today.toISOString().split("T")[0]);
    loadDispatchList($currentDate.text(), "5714");

    // 날짜 이동 버튼 이벤트
    $(".date-button").on("click", function () {
        const currentDate = new Date($currentDate.text());
        const buttonClass = $(this).find("i").attr("class");

        if (buttonClass.includes("fa-angle-double-left")) {
            currentDate.setDate(currentDate.getDate() - 7);
        } else if (buttonClass.includes("fa-angle-left")) {
            currentDate.setDate(currentDate.getDate() - 1);
        } else if (buttonClass.includes("fa-angle-right")) {
            currentDate.setDate(currentDate.getDate() + 1);
        } else if (buttonClass.includes("fa-angle-double-right")) {
            currentDate.setDate(currentDate.getDate() + 7);
        }

        const newDate = currentDate.toISOString().split("T")[0];
        $currentDate.text(newDate);

        // 새로운 날짜로 데이터 로드
        loadDispatchList(newDate, "5714");
    });
};

//tbody에 데이터 추가 후 '운행 대기' 상태인 셀 색상 변경
$(document).on("ajaxComplete", function () {
    $(".list-tbody td").each(function () {
        const cellText = $(this).text().trim(); // 셀의 텍스트 가져오기
        if (cellText === "운행 대기") {
            $(this).css("color", "#8B6AA7"); // 텍스트 색상 변경
        }
    });
});

$(".startBtn").on("click", function () {
    const empIdx = emp_idx;
    const date = $(".current-date").text();

    if (!empIdx || !date) {
        alert("필요한 정보가 누락되었습니다.");
        return;
    }

    $.ajax({
        url: "updateDriveStatus.ajax",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            emp_idx: empIdx,
            date: date,
        }),
        success: function (response) {
            if (response.success) {
                alert("운행이 시작되었습니다.");
                location.reload();
            } else {
                alert(response.message || "운행 상태 업데이트에 실패했습니다.");
            }
        },
        error: function () {
            alert("서버와 통신 중 오류가 발생했습니다.");
        },
    });
});

$(".stopBtn").on("click", function () {
    const empIdx = emp_idx; // emp_idx 가져오기
    const date = $(".current-date").text(); // 현재 날짜 가져오기

    if (!empIdx || !date) {
        alert("필요한 정보가 누락되었습니다.");
        return;
    }

    // AJAX 요청
    $.ajax({
        url: "stopDriveStatus.ajax",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            emp_idx: empIdx,
            date: date
        }),
        success: function (response) {
            if (response.success) {
                alert("운행 종료 되었습니다!");
                location.reload();
            } else {
                alert(response.message || "운행 상태 업데이트에 실패했습니다.");
            }
        },
        error: function () {
            alert("서버와 통신 중 오류가 발생했습니다.");
        }
    });
});


</script>
</html>
