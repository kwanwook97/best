<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
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
    width: 100%;
    height: 728px;
    display: flex;
    flex-direction: column;
    border: 2px solid #30005A;
    border-radius: 10px;
    align-items: center;
    justify-content: center;
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
	width: 70%;
    height: 78%;
}
.content-body{
	width: 100%;
	height: 100%;
	border: 2px solid #30005A;
	border-radius: 10px;
}
.header{
	display: flex;
    padding: 10px;
}
.filter{
	width: fit-content;
   	margin-left: 15px;
   	cursor: pointer;
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
					<div class="filter purple bold">결재</div>
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
			</div>
		</div>
	</div>
</body>
<script>
var loginId = ${sessionScope.loginId};
var emp_idx = parseInt(loginId);

$(document).ready(function() {
    function fetchAlarms(type = null, flag = null) {
        $.ajax({
            url: "alarmList.ajax",
            type: "GET",
            data: { emp_idx:emp_idx, type: type, flag: flag },
            success: function(data) {
                renderAlarmList(data);
            },
            error: function(err) {
                console.error("알림 데이터를 가져오는 중 오류 발생", err);
            }
        });
    }

    function renderAlarmList(data) {
        const alarmList = $("#alarmList");
        alarmList.empty();

        if (data.length === 0) {
            alarmList.append('<tr><td colspan="4">알림이 없습니다.</td></tr>');
            return;
        }

        data.forEach(function(alarm, index) {
            const alarmDate = new Date(alarm.date);
            const today = new Date();

            // 오늘인지 확인
            const isToday =
                alarmDate.getDate() === today.getDate() &&
                alarmDate.getMonth() === today.getMonth() &&
                alarmDate.getFullYear() === today.getFullYear();

            // 날짜 포맷
            const formattedDate = isToday
                ? alarmDate.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }) // 12:10
                : alarmDate.toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric' }); // 2024년 11월 11일

            alarmList.append(
                '<tr>' +
                '<td>' + (index + 1) + '</td>' +
                '<td>' + alarm.type + '</td>' +
                '<td style="cusor: pointer;">' + alarm.content + '</td>' +
                '<td>' + formattedDate + '</td>' +
                '<td>' + (alarm.flag === false ? "안읽음" : "읽음") + '</td>' +
                '</tr>'
            );
        });
    }



    // 초기 데이터 로드
    fetchAlarms();

    // 필터 클릭 이벤트
    $(".filter").on("click", function() {
        const type = $(this).text().toLowerCase(); // mail, calendar, document로 변환
        const flag = type === "전체" ? null : type === "읽음" ? 1 : 0;
        const empIdx = emp_idx; // 여기에 실제 emp_idx 값을 넣어야 함

        fetchAlarmList(empIdx, type === "전체" ? null : type, flag);
    });
});


</script>
</html>
