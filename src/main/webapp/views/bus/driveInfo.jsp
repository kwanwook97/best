<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <style>
.body {
	height: auto;
	width: 83%;
	margin-top: 110px;
	margin-left: 320px;
	margin-right: 100%;
}

/* 보라색 배경 */
.purple {
	background-color: #30005A;
	border: 2px solid #30005A;
	color: white;
}

.cPurple {
	color: #30005A;
}

/* 보라색 선 + 보라색 글씨 */
.pLine {
	border: 2px solid #30005A;
	color: #30005A;
	height: 100%;
}

/* 기본 굵은 글씨 */
.bold {
	font-weight: bold;
}

/* inline-block */
.inBlock {
	display: inline-block;
	border: 2px solid #30005A;
	vertical-align: top; /* 상단 정렬 */
	text-align: center;
	margin: 10px;
	border-radius: 10px;
}

.p25 {
	width: 23%;
}

.p18 {
	width: 18%;
}

.m20 {
	margin-right: 15%;
	margin-top: 15%;
	margin-bottom: 15%;
}

.content {
	width: 100%;
	height: 80%;
	display: flex;
	justify-content: space-between;
}

.lContent {
	width: 48%;
}

.rContent {
	width: 48%; 
	height: 100%;
	border : 2px solid #30005A;
	border-radius: 10px;
}


/* 가운데 정렬 */
.center {
	display: flex; /* Flexbox 활성화 */
	flex-direction: column; /* 세로 방향 정렬 */
	justify-content: center; /* 세로 기준 가운데 정렬 */
	align-items: center; /* 가로 기준 중앙 정렬 */
	height: 100%; /* 부모 높이에 맞게 */
	text-align: center; /* 텍스트 중앙 정렬 */
	box-sizing: border-box; /* 패딩 포함 크기 계산 */
}

.w100 {
	width: 100%;
}

/* 위아래 마진 10% */
.m10 {
	margin: 10% 0;
}

/* 패딩 1% */
.p1 {
	padding: 1%;
}

/* 위 마진 2% */
.tm2 {
	margin-top: 2%;
}

.h28 {
	height: 28%;
}

.h72 {
	height: 72%;
}

/* 연한 보라색 */
.lPurple {
	color: #8B6AA7;
}

.wr50 {
	display: inline-block;
	width: 50%;
	text-align: right;
	padding-right: 10%;
}

.wl50 {
	display: inline-block;
	width: 50%;
	text-align: left;
	padding-left: 10%;
}

/* 폰트사이즈 24 */
.f24 {
	font-size: 24px;
}

/* 폰트사이즈 48 */
.f48 {
	font-size: 48px;
}

/* 폰트사이즈 32 */
.f32 {
	font-size: 32px;
}

/* 폰트사이즈 16 */
.f16 {
	font-size: 16px;
}

/* 배경색(베이지) */
.bgColor {
	background-color: #FFFBF2;
	border-bottom-left-radius: 10px;
	overflow: hidden;
}

/* 높이 */
.h10 {
	height: 10%;
}
/* 높이 */
.h90 {
	height: 90%;
}

table {
	width: 100%;
	height: 100%;
	border-collapse: collapse;
	text-align: center;
	font-size: 24px;
}

thead {
	height: 15%;
}

th, td {
	/* padding: 5px; */
	border-bottom: 1px solid #30005A; /* 보라색 선 */
}

th {
	color: #30005A; /* 보라색 글씨 */
	font-weight: bold;
}

td {
	color: #8B6AA7; /* 연 보라색 글씨 */
	font-weight: bold;
}

.bus-info-container {
	display: flex;
	flex-direction: column;
	padding: 20px 0;
	background-color: #fdf5e6;
	height: 100%;
	max-height: 100%; /* 최대 높이 제한 */
	overflow-y: auto; /* 세로 스크롤바 추가 (내용이 넘칠 때만 표시) */
}

/* 버스 카드 스타일 */
.bus-info {
	border: 2px solid #6a1b9a;
	border-radius: 10px;
	padding: 15px;
	margin-bottom: 15px;
	background-color: white;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	overflow: hidden; /* 넘치는 텍스트 숨기기 */
	text-overflow: ellipsis; /* ...으로 표시 (옵션) */
	flex: 0 0 220px; /* 높이 고정 */
}

/* 상단 정보 섹션 */
.bus-header {
	margin-bottom: 15px;
}

.bus-main-info {
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.bus-number {
	font-size: 2rem;
	font-weight: bold;
	width: 20%
}

/* 초록색 글씨 */
.cGreen {
	color: #1DD20C;
}

/* 파란색 글씨 */
.cBlue {
	color: #2A33DD;
}

.bus-details {
	font-size: 1rem;
	display: flex;
	justify-content: space-evenly;
	width: 80%
}

/* 기사 목록 섹션 */
.bus-drivers {
	margin-top: 15px;
}

.drivers-title {
	font-size: 1rem;
	margin-bottom: 10px;
}

.driver-names {
	display: grid;
	grid-template-columns: repeat(6, 1fr); /* 6명씩 한 줄 */
	gap: 10px;
	font-size: 0.9rem;
}

.driver-names span {
	white-space: nowrap;
}

p {
	display: inline-block;
}





.button-container {
  display: flex;
  justify-content: flex-end; /* 오른쪽 정렬 */
  gap: 10px; /* 버튼 사이 간격 */
  margin: 1% 0;
  width: 100%;
  height: 2%;
  text-align: center;
}
.start-button, .end-button {
  font-weight: bold;
  padding: 0 1%;
  border: none;
  border-radius: 20px;
  font-size: 16px;
  color: white;
  cursor: pointer;
}
.start-button {
  background-color: #5e178e; /* 보라색 */
}
.end-button {
  background-color: #e73959; /* 분홍색 */
}
.start-button:hover {
  background-color: #7a2aa9; /* 보라색 hover 효과 */
}
.end-button:hover {
  background-color: #f05b75; /* 분홍색 hover 효과 */
}
</style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="body">
 		<!-- 페이지 경로정보 -->
		<div class="naviPath bold f32 w100 tm2">
			<span class="lPurple">운행정보</span><span class="cPurple"> > 5714</span>
		</div>

		<!-- 운행시작, 운행종료 버튼 -->
		<div class="button-container">
			<button class="start-button">운행 시작</button>
			<button class="end-button">운행 종료</button>
		</div>

		<div class="content">		
			<!-- 운행정보 -->
			<div class="bus-info-container lContent f16">
				<div class="bus-info">
					<div class="bus-header">
						<div class="bus-main-info">
							<!-- 버스번호 정보 -->
							<h2 class="bus-number f48 cGreen">5714</h2>
							<!-- 현재운행중인 버스 수, 배차간격 정보 -->
							<div class="bus-details bold">
								<p>
									<span class="lPurple">현재 운행: </span><span class="cPurple">27</span>
								</p>
								<p>
									<span class="lPurple">배차 간격: </span><span class="cPurple">8 - 10</span>
								</p>
							</div>
						</div>
					</div>
					<div class="bus-drivers bold">
						<p class="drivers-title lPurple">운행중인 기사:</p>
						<div class="driver-names cPurple">
							<span>이종원 기사</span><span>전미경 기사</span><span>강관욱 기사</span><span>장희재
								기사</span><span>이진형 기사</span><span>이혜연 기사</span> 
								
								<span>이경언 기사</span><span>황수인
								기사</span><span>류경민 기사</span><span>서승범 기사</span><span>한범희 기사</span><span>김진형
								기사</span>
								
								<span>김지원 기사</span><span>진선미
								기사</span><span>김지훈 기사</span><span>김용현 기사</span><span>전다솔 기사</span><span>이원종
								기사</span>
						</div>
					</div>
				</div>
				
				<!-- 버스정보 2 -->
				<div class="bus-info">
					<div class="bus-header">
						<div class="bus-main-info">
							<!-- 버스번호 정보 -->
							<h2 class="bus-number f48 cGreen">7611</h2>
							<!-- 현재운행중인 버스 수, 배차간격 정보 -->
							<div class="bus-details bold">
								<p>
									<span class="lPurple">현재 운행: </span><span class="cPurple">27</span>
								</p>
								<p>
									<span class="lPurple">배차 간격: </span><span class="cPurple">8 - 10</span>
								</p>
							</div>
						</div>
					</div>
					<div class="bus-drivers bold">
						<p class="drivers-title lPurple">운행중인 기사:</p>
						<div class="driver-names cPurple">
							<span>이종원 기사</span><span>전미경 기사</span><span>강관욱 기사</span><span>장희재
								기사</span><span>이진형 기사</span><span>이혜연 기사</span> <span>이경언 기사</span><span>황수인
								기사</span><span>류경민 기사</span><span>서승범 기사</span><span>한범희 기사</span><span>김진형
								기사</span>
						</div>
					</div>
				</div>
				
				<!-- 버스정보 3 -->
				<div class="bus-info">
					<div class="bus-header">
						<div class="bus-main-info">
							<!-- 버스번호 정보 -->
							<h2 class="bus-number f48 cBlue">503</h2>
							<!-- 현재운행중인 버스 수, 배차간격 정보 -->
							<div class="bus-details bold">
								<p>
									<span class="lPurple">현재 운행: </span><span class="cPurple">27</span>
								</p>
								<p>
									<span class="lPurple">배차 간격: </span><span class="cPurple">8 - 10</span>
								</p>
							</div>
						</div>
					</div>
					<div class="bus-drivers bold">
						<p class="drivers-title lPurple">운행중인 기사:</p>
						<div class="driver-names cPurple">
							<span>이종원 기사</span><span>전미경 기사</span><span>강관욱 기사</span><span>장희재
								기사</span><span>이진형 기사</span><span>이혜연 기사</span> <span>이경언 기사</span><span>황수인
								기사</span><span>류경민 기사</span><span>서승범 기사</span><span>한범희 기사</span><span>김진형
								기사</span>
						</div>
					</div>
				</div>
				
				<!-- 버스정보 4 -->
				<div class="bus-info">
					<div class="bus-header">
						<div class="bus-main-info">
							<!-- 버스번호 정보 -->
							<h2 class="bus-number f48 cBlue">652</h2>
							<!-- 현재운행중인 버스 수, 배차간격 정보 -->
							<div class="bus-details bold">
								<p>
									<span class="lPurple">현재 운행: </span><span class="cPurple">27</span>
								</p>
								<p>
									<span class="lPurple">배차 간격: </span><span class="cPurple">8 - 10</span>
								</p>
							</div>
						</div>
					</div>
					<div class="bus-drivers bold">
						<p class="drivers-title lPurple">운행중인 기사:</p>
						<div class="driver-names cPurple">
							<span>이종원 기사</span><span>전미경 기사</span><span>강관욱 기사</span><span>장희재
								기사</span><span>이진형 기사</span><span>이혜연 기사</span> <span>이경언 기사</span><span>황수인
								기사</span><span>류경민 기사</span><span>서승범 기사</span><span>한범희 기사</span><span>김진형
								기사</span>
						</div>
					</div>
				</div>
				
				<!-- 버스정보 5 -->
				<div class="bus-info">
					<div class="bus-header">
						<div class="bus-main-info">
							<!-- 버스번호 정보 -->
							<h2 class="bus-number f48 cBlue">160</h2>
							<!-- 현재운행중인 버스 수, 배차간격 정보 -->
							<div class="bus-details bold">
								<p>
									<span class="lPurple">현재 운행: </span><span class="cPurple">27</span>
								</p>
								<p>
									<span class="lPurple">배차 간격: </span><span class="cPurple">8 - 10</span>
								</p>
							</div>
						</div>
					</div>
					<div class="bus-drivers bold">
						<p class="drivers-title lPurple">운행중인 기사:</p>
						<div class="driver-names cPurple">
							<span>이종원 기사</span><span>전미경 기사</span><span>강관욱 기사</span><span>장희재
								기사</span><span>이진형 기사</span><span>이혜연 기사</span> <span>이경언 기사</span><span>황수인
								기사</span><span>류경민 기사</span><span>서승범 기사</span><span>한범희 기사</span><span>김진형
								기사</span>
						</div>
					</div>
				</div>
				
				<!-- 버스정보 6 -->
				<div class="bus-info">
					<div class="bus-header">
						<div class="bus-main-info">
							<!-- 버스번호 정보 -->
							<h2 class="bus-number f48 cBlue">999</h2>
							<!-- 현재운행중인 버스 수, 배차간격 정보 -->
							<div class="bus-details bold">
								<p>
									<span class="lPurple">현재 운행: </span><span class="cPurple">27</span>
								</p>
								<p>
									<span class="lPurple">배차 간격: </span><span class="cPurple">8 - 10</span>
								</p>
							</div>
						</div>
					</div>
					<div class="bus-drivers bold">
						<p class="drivers-title lPurple">운행중인 기사:</p>
						<div class="driver-names cPurple">
							<span>이종원 기사</span><span>전미경 기사</span><span>강관욱 기사</span><span>장희재
								기사</span><span>이진형 기사</span><span>이혜연 기사</span> <span>이경언 기사</span><span>황수인
								기사</span><span>류경민 기사</span><span>서승범 기사</span><span>한범희 기사</span><span>김진형
								기사</span>
						</div>
					</div>
				</div>
			</div>
			
			
			<div class="bus-api-container rContent">
			
			</div>
			
		</div>
	</div>
</body>
<script>

</script>
</html>
