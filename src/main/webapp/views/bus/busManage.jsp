<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://kit.fontawesome.com/6282a8ba62.js"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css"
	rel="stylesheet">
<link href="resources/css/app-style.css" rel="stylesheet" />
<style>
.body {
	height: auto;
	width: 83%;
}

.bus-info-card {
	padding: 3px;
	height: auto;
	width: 100%;
	margin-top: 6vh;
}

.bus-number {
	font-size: 48px;
	font-weight: bold;
	color: #1DD20C;
	margin-right: 20px;
	flex: 0 0 10%;
}

span {
	width: 50%;
}

.purple {
	color: #30005A; /* 보라색 */
}

.green {
	color: #1DD20C;
}

.blue {
	color: #2A33DD;
}

select {
	width: 26.1vw;
	border-radius: 10px;
	padding: 3 10px;
	color: #30005A;
}

.bus-details {
	width: 100%;
	display: flex;
	flex-direction: column;
	align-items: flex-start;
}

.bus-details p {
	display: flex;
	align-items: center;
	margin: 0;
}

.bus-details p strong {
	min-width: 100px; /* 제목 너비 고정 */
	margin-right: 10px; /* 제목과 내용 사이 간격 */
	text-align: left; /* 제목 왼쪽 정렬 */
	color: #8B6AA7; /* 연한 보라색 */
	font-weight: bold; /* Bold 효과 추가 */
}

.bus-drive-info {
	color: #30005A;
}

.lPurple {
	color: #8B6AA7;
}

.tm2 {
	margin-top: 2%;
	width: 60%;
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

.content {
    width: 500px;
    height: 100%;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    overflow: auto;
}
.content::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Edge */
}

.docnav {
	width: 100%;
	display: flex;
	justify-content: flex-end;
	margin-bottom: 0.5rem;
}

.searchbox {
	width: 24%;
	display: flex;
	align-items: center;
	justify-content: space-evenly;
}

.drop {
	font-size: 14px;
	border: 1px solid #30005A;
	border-radius: 4px;
	color: #30005A;
}

select option {
	background-color: white !important;
	border-radius: 5px;
	color: #30005A;
}

.search {
	position: relative;
	display: inline-block;
}

.search input {
	border-radius: 10px;
	padding-left: 10px;
	border: 1px solid #30005A;
}

.search i {
	position: absolute;
	right: 10px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 18px;
	pointer-events: none;
	color: #E9396B;
}

.editbtn {
	color: #FFFBF2;
	background-color: #E9396B;
	border-radius: 5px;
	width: 100%;
	height: 5vh;
}

.bus-info-subject {
	background-color: #30005A;
	color: #FFFBF2;
	margin-bottom: -6vh;
	width: 100%;
	font-size: 24px;
	margin-top: 1vh;
	border-radius: 10px 10px 0 0;
	padding: 5px;
	text-align: center;
}

.bus-insert-btn {
	margin-top: 1vh;
	width: 100%;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.bus-details ul {
	width: 100%;
	display: flex;
	flex-direction: column;
	margin: 0px;
	padding: 0px;
	align-items: flex-start;
}

.bus-details>ul>li {
	list-style: none;
	width: 100%;
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 4px;
	border-bottom: 1px solid #8B6AA7;
	padding-bottom: 5px;
}

.bus-details>ul>li>span {
	margin-right: 30px;
}

.bus-details>ul>li>strong {
	margin-left: 15px;
}

.bus-details input {
	width: 100%;
	border-radius: 10px;
	padding: 3 10px;
	color: #30005A;
}

.naviPath i {
	margin-right: 1vw;
}

input[readonly] {
	border: none; /* 테두리 제거 */
	background: transparent; /* 배경 투명 */
	pointer-events: none; /* 마우스 클릭 막기 */
}

.modal {
	display: none; /* 기본적으로 숨김 */
	position: fixed;
	z-index: 1001;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4); /* 반투명 배경 */
}

/* 모달 내용 */
.modal-content {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%); /* 중앙 정렬 */
	background-color: #FFFBF2;
	padding: 10px;
	border: 1px solid #888;
	width: 100%;
	height: 70%;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
}

/* 닫기 버튼 */
.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
	width: 32px;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}
.icon-div{
	width: 10%;
	display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    font-size: 40px;
}
</style>
</head>
<body class="bg-theme bg-theme1">
	<div class="body">
		<!--      <div class="naviPath bold f32 w100 tm2">
		<span class="lPurple">버스정보</span>
			<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
		<span class="lPurple">버스관리</span>
			<i class="fa-solid fa-angle-right" style="color:#30005A;"></i>
		<span class="purple">버스수정</span>
		<div class="bus-drive-info">
				
		</div>
	</div> -->
		<div class="content">
			<div class="icon-div"><i class="fa-solid fa-caret-left" onclick="showPrevious()"></i></div>
			<div style="width: 80%; margin-right: 10px;">
			<div class="bus-info-subject bold purple">
				<span>버스 정보</span>
			</div>
			<div class="bus-info-card">
				<div class="bus-details">
					<input type="hidden" name="bus_idx" value="${bus.bus_idx}" />
					<ul>
						<li><strong>노선 번호:</strong> <span>${bus.route_name}</span></li>
						<li><strong>차량 번호:</strong> <span>${bus.license_plate}</span></li>
						<li><strong>연비:</strong> <span>${bus.fuel_efficiency}
								km/L</span></li>
						<li><strong>구입일:</strong> <span>${bus.buy_date}</span></li>
						<li><strong>제조사:</strong> <span>${bus.bus_company}</span></li>
						<li><strong>좌석 수:</strong> <span>${bus.seat_number}</span></li>
						<li><strong>버스 종류:</strong> <span>${bus.bus_type}</span></li>
					</ul>
				</div>
			</div>
			<div class="bus-info-subject bold purple">
				<span>정비 사항</span>
			</div>
			<input type="hidden" name="bus_manage_emp_idx"
				value="${sessionScope.loginId}" />
			<div class="bus-info-card">
				<div class="bus-details">
					<c:forEach var="busMan" items="${busManList}" varStatus="status">
						<div class="bus-details history-item" data-index="${status.index}"
							style="display: ${status.index == 0 ? 'block' : 'none'};">
							<ul>
								<li><strong>버스 상태:</strong> <span>${busMan.status}</span></li>
								<li><strong>운행거리:</strong> <span>${busMan.distance} km</span></li>
								<li><strong>점검 일:</strong> <span>${busMan.inspect_date}</span></li>
								<li><strong>다음 점검일:</strong> <span>${busMan.next_inspect_date}</span></li>
								<li><strong>담당 정비사:</strong> <span>${busMan.name}</span></li>
								<li><strong>정비 비용:</strong> <span>${busMan.amount} 원</span></li>
								<li><strong>정비 내용:</strong> <span>${busMan.content}</span></li>
							</ul>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="bus-insert-btn">
				<button class="editbtn" onclick="busUpdate(this)">
					<i class="far fa-edit"></i>&nbsp;수정
				</button>
			</div>
			</div>
			<div class="icon-div"><i class="fa-solid fa-caret-right" onclick="showNext()"></i></div>
		</div>
	</div>
</body>

<div id="busUpdateModal" class="modal">
	<div class="modal-content">
		<span class="close" onclick="closeModal('busUpdateModal')">&times;</span>
		<iframe id="busUpdateFrame" src="" frameborder="0"
			style="width: 100%; height: 100%;"></iframe>
	</div>
</div>
<script>
	function busUpdate(element) {
		// 클릭한 요소에서 bus_idx 값을 가져오기
		const busIdx = $(element).closest('.content').find(
				'input[name="bus_idx"]').val();
		if (!busIdx) {
			alert('bus_idx 값을 가져올 수 없습니다.');
			return;
		}

		// 모달 열기
		const modal = document.getElementById('busUpdateModal');
		modal.style.display = 'block';

		// bus_idx 값을 포함한 URL로 iframe을 업데이트
		const iframe = modal.querySelector('#busUpdateFrame');
		iframe.src = 'busUpdate.go?bus_idx=' + busIdx;
	}

	// 모달 닫기
	function closeModal() {
		const modal = document.getElementById('busUpdateModal');
		const iframe = modal.querySelector('#busUpdateFrame');
		iframe.src = ''; // iframe src 초기화
		modal.style.display = 'none';
	}

	// 모달 외부 클릭 시 닫기
	window.onclick = function(event) {
		const modal = document.getElementById('busUpdateModal');
		if (event.target === modal) {
			closeModal();
		}
	};
	
	
	let currentIndex = 0; // 최신 내역을 기준으로 초기화 (가장 최신이 첫 번째로 보여짐)

	function showPrevious() {
	    const items = document.querySelectorAll('.history-item');
	    if (currentIndex < items.length - 1) { // 예전 내역이 있다면
	        items[currentIndex].style.display = 'none'; // 현재 숨기기
	        currentIndex++; // 예전 내역으로 이동
	        items[currentIndex].style.display = 'block'; // 예전 내역 보이기
	    } else {
	        alert('이전 내역이 없습니다.');
	    }
	}

	function showNext() {
	    const items = document.querySelectorAll('.history-item');
	    if (currentIndex > 0) { // 최신 내역으로 이동 가능하다면
	        items[currentIndex].style.display = 'none'; // 현재 숨기기
	        currentIndex--; // 최신 내역으로 이동
	        items[currentIndex].style.display = 'block'; // 최신 내역 보이기
	    } else {
	        alert('다음 내역이 없습니다.');
	    }
	}


</script>
</html>
