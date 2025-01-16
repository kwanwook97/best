<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
	<script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  
  <style>
	.dashboard-body{
	    margin-left: 15vw;
	    margin-top: 9vh;
	    flex-wrap: wrap;
	    color: var(--primary-color);
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: flex-start;
	    justify-content: center;
	    width: 84%;
	}
	.maintext{
        width: 20%;
	    display: flex;
	    margin-left: -1vw;
	    margin-bottom: 15px;
	    justify-content: space-between;
	    align-items: baseline;	
	}
	.maintext i,
	.maintext span{
		font-size: 32px !important;
		font-weight: bold !important;
	}
	.maintext span:first-child{
		color: var(--secondary-color);
	}
	.drop{
	    font-size: 14px;
	    border: 1px solid var(--primary-color);
	    border-radius: 4px;
	    color: var(--primary-color);
	}
	.docbox{
	    display: flex;
	    border: 2px solid var(--primary-color);
	    width: 1535px;
	    height: 690px;
	    border-radius: 10px;
	    flex-direction: column;
    	justify-content: space-evenly;
	}
	#monthlyExpenseTable th{
		text-align: center !important;
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
	table {
	    transform: scale(0.9);
	    width: 660px;
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
	    width: 90%;
  		padding: 0 42px;
	    margin-right: 34px;
	}
	#stackedChart {
	    width: 100% !important;  /* 차트가 100% 너비를 차지하도록 설정 */
	    height: 521px;  /* 원하는 높이로 설정 */
	}
	/* 차트 크기 지정 */
	#stackedChart {
	    max-width: 500%;
	    max-height: 600px;
	}
</style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<span class="document">지출정산</span>
			<i class="fa-solid fa-angle-right" style="color: #8B6AA7;"></i>
			<span class="text">연별현황</span>
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
	                        <th>일반 지출</th>
	                        <th>버스관리 지출</th>
	                        <th>급여 지출</th>
	                        <th>월 총 지출</th>
	                    </tr>
	                </thead>
	                <tbody>
	                </tbody>
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
$(document).ready(function () {
    var currentDate = new Date();
    var year = currentDate.getFullYear(); // 기본값으로 현재 년도

    // 현재 년도 업데이트 함수
    function updateDateDisplay() {
        const currentDateElement = document.querySelector('.current-date');
        currentDateElement.textContent = year + '년';
    }

    function incrementYear() {
        year++;
        updateDateDisplay();
        fetchData(year);
    }

    function decrementYear() {
        year--;
        updateDateDisplay();
        fetchData(year);
    }

    document.querySelector('.date-button:nth-child(1)').addEventListener('click', decrementYear);
    document.querySelector('.date-button:nth-child(3)').addEventListener('click', incrementYear);

    updateDateDisplay();

    // AJAX 요청으로 데이터 가져오기
    function fetchData(year) {
        $.ajax({
            type: 'GET',
            url: 'yearlyList.ajax',
            data: { year: year },
            dataType: 'JSON',
            success: function (response) {
                var categorizedData = response.data; // 이미 분류된 데이터를 사용
                updateTable(categorizedData);
                updateChart(categorizedData);
            },
            error: function (error) {
                console.error('데이터 가져오기 실패:', error);
            }
        });
    }

    // 테이블 업데이트 함수
	function updateTable(categorizedData) {
	    var tableHtml = '';
	    for (var i = 0; i < 12; i++) {
	        var total = categorizedData.basic[i] + categorizedData.bus[i] + categorizedData.emp[i]; // 합계 계산
	        tableHtml += '<tr>' +
	            '<td>' + (i + 1) + '월</td>' +
	            '<td>' + categorizedData.basic[i].toLocaleString() + '원</td>' +
	            '<td>' + categorizedData.bus[i].toLocaleString() + '원</td>' +
	            '<td>' + categorizedData.emp[i].toLocaleString() + '원</td>' +
	            '<td>' + total.toLocaleString() + '원</td>' + // 합계를 추가
	            '</tr>';
	    }

	    $('#monthlyExpenseTable tbody').html(tableHtml);
	}


    // 차트 업데이트 함수
    function updateChart(categorizedData) {
    const ctxStacked = document.getElementById('stackedChart').getContext('2d');

    // 기존 차트가 존재하면 삭제
    if (window.stackedChart && typeof window.stackedChart.destroy === 'function') {
        window.stackedChart.destroy();
    }

    // 새로운 차트 생성
    window.stackedChart = new Chart(ctxStacked, {
        type: 'bar',
        data: {
            labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            datasets: [
                {
                    label: '일반',
                    data: categorizedData.basic,
                    backgroundColor: '#59327A'
                },
                {
                    label: '버스관리',
                    data: categorizedData.bus,
                    backgroundColor: '#82669C'
                },
                {
                    label: '급여',
                    data: categorizedData.emp,
                    backgroundColor: '#AC99BD'
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
                    beginAtZero: true // Y축 0부터 시작
                }
            }
        }
   	});
}

    // 초기화
    fetchData(year); // 기본값: 현재 년도 데이터 가져오기
});

</script>
</html>
