<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
	<script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  
  <style>
	.dashboard-body{
	    margin-left: 15vw;
	    margin-top: 10vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    color: var(--primary-color);
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: baseline;
	    justify-content: center;
	}
	.maintext{
		display: flex;
		margin-left: -34vw;
	}
	.document{
		color: var(--secondary-color);
		margin-right: 30px !important;
	}
	.docnav{
	    width: 1290px;
    	display: flex;
    	padding: 0 0 15px 0;
	    justify-content: flex-end;
	}
	.searchbox{
		display: flex;
		align-items: center;
		justify-content: space-evenly;
	}
	.searchbox div{
		margin: 0 5px;
	}
	.searchCont{
		display: flex;
	}
	.drop{
	    font-size: 14px;
	    border: 1px solid var(--primary-color);
	    border-radius: 4px;
	    color: var(--primary-color);
	}
	select option{
		background-color: white !important;
		border-radius: 5px;
	}
	.search{
		position: relative;
    	display: inline-block;
	}
	.search input{
		border-radius: 10px;
		padding-left: 10px;
		border: 1px solid var(--primary-color);
	}
	.search i{
		position: absolute;
		right: 10px;
		top: 50%;
		transform: translateY(-50%);
		font-size: 18px;
		pointer-events: none;
		color: var(--accent-color);
	}
	.docbox{
    	display: flex;
    	justify-content: space-evenly;
        align-items: center;
		border: 2px solid var(--primary-color);
	    width: 1300px;
	    height: 680px;
	    border-radius: 10px;
	    flex-direction: column;
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
	@media (max-width: 960px) {
	    .dashboard-body {
            transform: scale(0.7);
	        margin-left: 18vw;
	        margin-top: 0;
	        height: 102vh;
	        width: 93vw;
	    }
  	}
  	.date-navigation {
		font-size: 24px;
		font-weight: bold;
		text-align: center;
		width: 100%;
	}
	
	.date-content {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 10px;
		width: 100%;
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
	.chart-container {
	      display: flex;
	      justify-content: space-between;
	  }
	.table-container {
	    width: 40%;
	    padding: 20px;
	}
	.chart-wrapper {
	    width: 55%;
	    padding: 20px;
	}
	table {
	    width: 100%;
	    border-collapse: collapse;
	}
	th, td {
	    border: 1px solid #ddd;
	    padding: 8px;
	    text-align: center;
	}
   .chart-container {
	    display: flex;
	    justify-content: space-between;
	    width: 100%;  /* 차트가 컨테이너를 꽉 채우도록 설정 */
	}
	.chart-wrapper {
	    width: 100%;  /* 부모 컨테이너 크기에 맞춰 차트 크기 조정 */
	    padding: 20px;
	}
	#stackedChart {
	    width: 100% !important;  /* 차트가 100% 너비를 차지하도록 설정 */
	    height: 521px;  /* 원하는 높이로 설정 */
	}
	/* 차트 크기 지정 */
	#stackedChart {
	    max-width: 500%;
	    max-height: 800px;
	}
</style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="document">지출정산</h3>
			<h3>>&nbsp;&nbsp;월별현황</h3>
		</div>
		<div class="docnav">
			<div class="searchbox">
				<div class="searchCont">
				</div>
				<select class="drop">
				  <option value="month">월</option>
				  <option value="category">품목</option>
				</select>
				<div class="search">
					<input type="text" name="search" class="searchInp">
					<i class="fas fa-search"></i>
				</div>
			</div>
		</div>
		<div class="docbox">
			<div class="date-navigation">
				<div class="date-content">
					<button class="date-button">
						<i class="fas fa-angle-left"></i>
					</button>
					<span class="current-date"></span>
					<button class="date-button">
						<i class="fas fa-angle-right"></i>
					</button>
				</div>
			</div>		
		 	<div class="chart-container">
	        <!-- 왼쪽: 월별 지출 금액 테이블 -->
	        <div class="table-container">
	            <table id="monthlyExpenseTable">
	                <thead>
	                    <tr>
	                        <th>월</th>
	                        <th>총 지출 금액 (원)</th>
	                    </tr>
	                </thead>
	                <tbody></tbody>
	            </table>
	        </div>
	        <!-- 오른쪽: 연별 지출 금액 막대그래프와 선그래프 -->
	        <div class="chart-wrapper">
	            <canvas id="stackedChart"></canvas>
	        </div>
	    	</div>
		</div>
 	</div>
</body>
<script>

$(document).ready(function() {
	var currentDate = new Date();
	var year = '';
	// 현재 날짜를 화면에 표시하는 함수{
	function updateDateDisplay() {
	    const currentDateElement = document.querySelector('.current-date');
	    year = currentDate.getFullYear();
	    currentDateElement.textContent = year + '년';
	}
	
	function incrementYear() {
	    currentDate.setFullYear(currentDate.getFullYear() + 1);
	    updateDateDisplay();
	}
	function decrementYear() {
	    currentDate.setFullYear(currentDate.getFullYear() - 1);
	    updateDateDisplay();
	}
	document.querySelector('.date-button:nth-child(1)').addEventListener('click', decrementYear);  
	document.querySelector('.date-button:nth-child(3)').addEventListener('click', incrementYear);  
	
	updateDateDisplay();
	
    // 월별 지출 데이터를 예시로 제공 (2025년 1월 ~ 12월)
    var monthlyExpenseData = [
        { date: '2025-01-01', amount: 10000 },
        { date: '2025-01-15', amount: 20000 },
        { date: '2025-02-10', amount: 15000 },
        { date: '2025-02-25', amount: 25000 },
        { date: '2025-03-05', amount: 30000 },
        { date: '2025-04-12', amount: 20000 },
        { date: '2025-05-19', amount: 50000 },
        { date: '2025-06-21', amount: 40000 },
        { date: '2025-07-09', amount: 60000 },
        { date: '2025-08-13', amount: 70000 },
        { date: '2025-09-17', amount: 80000 },
        { date: '2025-10-20', amount: 90000 },
        { date: '2025-11-25', amount: 110000 },
        { date: '2025-12-30', amount: 120000 }
    ];

    // 월별 총 지출 계산
    var monthlyTotal = Array(12).fill(0); // 12개월을 위한 배열 초기화
    $.each(monthlyExpenseData, function(index, item) {
        var month = new Date(item.date).getMonth(); // 0부터 11까지
        monthlyTotal[month] += item.amount;
    });

    // 월별 지출 금액 테이블 생성
    var monthlyTableHtml = '';
    for (var i = 0; i < 12; i++) {
        monthlyTableHtml += '<tr><td>' + (i + 1) + '월</td><td>' + monthlyTotal[i].toLocaleString() + '원</td></tr>';
    }
    $('#monthlyExpenseTable tbody').html(monthlyTableHtml);

    // 연별 차트 데이터
    var ctxStacked = document.getElementById('stackedChart').getContext('2d');
    var stackedChart = new Chart(ctxStacked, {
        type: 'bar',
        data: {
            labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            datasets: [
                {
                    label: '지출 금액 (Line)',
                    data: monthlyTotal.map(amount => amount / 3), // 예시로 금액을 3으로 나누어 Line dataset
                    type: 'line',
                    fill: false,
                    borderColor: '#E9396B',
                    tension: 0.1
                },
                {
                    label: '지출 금액 (A)',
                    data: monthlyTotal, // 월별 총 지출 금액
                    backgroundColor: '#30005A',
                    stack: 'Stack 0'
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                x: {
                    title: {
                        display: true,
                        text: '월'
                    }
                },
                y: {
                    title: {
                        display: true,
                        text: '금액 (원)'
                    },
                    stacked: true, // 스택형 차트 활성화
                    beginAtZero: true
                }
            }
        }
    });
});

</script>
</html>
