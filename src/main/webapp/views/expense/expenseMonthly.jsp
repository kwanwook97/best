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
	    color: var(--primary-color);
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: baseline;
	    justify-content: center;
	    width: 84%;
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
	    width: 1190px;
    	display: flex;
    	padding: 0 0 10px 0;
	    justify-content: space-between;
	}
	.chartOption{
	    display: flex;
	    margin-left: 5px;
	    align-items: flex-end;
	}
	.chartOption div{
		cursor: pointer;
	    font-size: large;
	    margin-right: 10px;
	    color: var(--secondary-color);
	}
	.chartOption div:hover{
		font-weight: bold;
		color: var(--primary-color);
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
   	    flex-direction: column;
    	justify-content: space-evenly;
        align-items: center;
		border: 2px solid var(--primary-color);
	    width: 1200px;
	    height: 710px;
	    border-radius: 10px;
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
    .container {
		transform: scale(0.9);
     	width: 1300px;
     	height: 680px;
		display: flex;
      	border-radius: 8px;
      	overflow: hidden;
    }
    .leftPanel, .rightPanel {
      	padding: 20px;
      	overflow-y: auto;
    }
    .leftPanel div:first-child{
    	margin-bottom: 20px;
    }
	.categoryTable{

	}
	.categoryList{

	}
	.dailyTable{
		
	}
	.dailyList{

	}
    .leftPanel {
      	width: 600px;
    }
    .rightPanel {
   		padding: 5px;	
		width: 650px;
		display: flex;
		flex-direction: column;
		gap: 20px;
		align-items: center;
    }
	h4.chartText{
		position: absolute;
    	left: 995px;
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
    th {
      background-color: #f4f4f4;
    }
    canvas {
      display: block;
      margin: 0 auto;
    }
    #categoryChart {
      transform: scale(0.9);
      max-width: 135%;
      max-height: 330px;
    }
    #dailyChart {
      max-width: 200%;
      max-height: 300px;
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
</style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="document">지출정산</h3>
			<h3>>&nbsp;&nbsp;월별현황(전체)</h3>
		</div>
		<div class="docnav">
			<div class="chartOption">
				<div class="empOpt" onclick="changeList('일반')">일반</div>
				<div class="busOpt" onclick="changeList('버스관리')">버스관리</div>
				<div class="salaryOpt" onclick="changeList('급여')">급여</div>
			</div>	
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
			<div class="container">
				<div class="leftPanel">
					<div>
						<h4>카테고리별 지출금액</h4>
						<table class="categoryTable">
							<thead>
								<tr>
									<th>카테고리</th>
									<th>금액</th>
								</tr>
							</thead>
							<tbody id="categoryList">
							</tbody>
						</table>
					</div>
					<div>
						<h4>날짜별 지출내역</h4>
						<table class="dailyTable">
							<thead>
								<tr>
									<th>날짜</th>
									<th>카테고리</th>
									<th>내용</th>
									<th>금액</th>
									<th>비고</th>
								</tr>
							</thead>
							<tbody id="dailyList">
							</tbody>
						</table>
						<div class="dailyContainer" id="dailyListCont">
					        <nav aria-label="Page navigation">
					            <ul class="pagination">
					                <li class="page-item" id="prevWeek"><a class="page-link" href="#">← 이전 주</a></li>
					                <li class="page-item"><span class="page-link" id="weekRange"></span></li>
					                <li class="page-item" id="nextWeek"><a class="page-link" href="#">다음 주 →</a></li>
					            </ul>
					        </nav>
					    </div>
					</div>
				</div>
				<div class="rightPanel">
					<h4 class="chartText">지출 차트</h4>
					<canvas id="categoryChart"></canvas>
					<canvas id="dailyChart" style="width: 574px;"></canvas>
				</div>
			</div>
		</div>
 	</div>
</body>
<script>
	
$(document).ready(function() {
	
	var currentDate = new Date();
	var year = '';
	
	function updateDateDisplay() {
	    var currentDateElement = document.querySelector('.current-date');
	    var year = currentDate.getFullYear();
	    var month = currentDate.getMonth() + 1; // 0부터 시작하므로 +1
	    currentDateElement.textContent = year + '년 ' + month + '월';
	    
	    // 변수로 연도와 월 저장
	    window.currentYear = year; // 연도 변수
	    window.currentMonth = month; // 월 변수
	    console.log("현재 연도:", currentYear);
	    console.log("현재 월:", currentMonth);
	}

	// 다음 달로 이동
	function incrementMonth() {
	    currentDate.setMonth(currentDate.getMonth() + 1); // 월 증가
	    updateDateDisplay();
	}

	// 이전 달로 이동
	function decrementMonth() {
	    currentDate.setMonth(currentDate.getMonth() - 1); // 월 감소
	    updateDateDisplay();
	}

	// 이벤트 핸들러 연결
	document.querySelector('.date-button:nth-child(1)').addEventListener('click', decrementMonth);
	document.querySelector('.date-button:nth-child(3)').addEventListener('click', incrementMonth);

	// 초기 날짜 설정
	var currentDate = new Date();
	updateDateDisplay();
	
	window.changeList = function (name) {
	    pageName = name;
	    categoryList(name);
	    fetchWeeklyData(pageName);
	    console.log("tq" + pageName);
	};
	
	window.addEventListener('resize', function() {
		lineChart.resize();
	});
	
	document.addEventListener('DOMContentLoaded', function () {
	    console.log("Page loaded. Fetching initial data...");
	    fetchWeeklyData(pageName); // 페이지 로드 시 초기 실행
	});
	
	var pageName = '일반';
	var categoryChart;
	var dailyExpenseChart;
	
    categoryList(pageName);
    
	function categoryList(pageName){
		$.ajax({
			type: 'GET',
			url: 'categoryList.ajax',
			data: {pageName: pageName},
			success: function(data) {
				var categoryData = [];
				data.forEach(function (item) {
			        categoryData.push({
			            category: item.category,
			            amount: item.amount
			        });
			    });
			    // 카테고리별 지출 금액 테이블 생성
			    var categoryTable = '';
			    $.each(categoryData, function(index, item) {
			      categoryTable += '<tr><td>' + item.category + '</td><td>' + item.amount.toLocaleString() + '원</td></tr>';
			    });
			    $('#categoryList').html(categoryTable);
			    
			    if (categoryChart) {
	                // 기존 차트 데이터 갱신
	                categoryChart.data.labels = categoryData.map(function (item) { return item.category; });
	                categoryChart.data.datasets[0].data = categoryData.map(function (item) { return item.amount; });
	                categoryChart.update();
	            } else {
	                // 새 차트 생성
	                var ctxCategory = document.getElementById('categoryChart').getContext('2d');
	                categoryChart = new Chart(ctxCategory, {
	                    type: 'pie',
	                    data: {
	                        labels: categoryData.map(function (item) { return item.category; }),
	                        datasets: [{
	                            data: categoryData.map(function (item) { return item.amount; }),
	                            backgroundColor: ['#30005A', '#44196A', '#59327A', '#6E4C8B', '#82669C', '#977FAC', '#AC99BD', '#C0B2CD', '#D5CCDE', '#EAE5EE'],
	                        }]
	                    },
	                    options: {
	                        responsive: true,
	                        maintainAspectRatio: false,
	                        plugins: {
	                            legend: {
	                                position: 'bottom',
	                            }
	                        }
	                    }
	                });
	            }
	        },error: function(e) {
			    console.log("오류 발생", e);
			}
		});
	}

	var currentWeekStart = new Date(); // 현재 날짜
	currentWeekStart.setDate(currentWeekStart.getDate() - currentWeekStart.getDay()); // 주의 첫날(일요일)

	function formatDate(date) {
	    return date.toISOString().split('T')[0]; // 'YYYY-MM-DD' 형식으로 변환
	}

	function updateWeekRange() {
	    const weekEnd = new Date(currentWeekStart);
	    weekEnd.setDate(currentWeekStart.getDate() + 6); // 주의 마지막 날(토요일)
	    $('#weekRange').text(formatDate(currentWeekStart) + " ~ " + formatDate(weekEnd));
	}
	
	function fetchWeeklyData(pageName) {
	    const startDate = formatDate(currentWeekStart);
	    const endDate = formatDate(new Date(currentWeekStart.getTime() + 6 * 24 * 60 * 60 * 1000)); // 6일 후

	    console.log("Received pageName in fetchWeeklyData:", pageName);

	    $.ajax({
	        type: 'GET',
	        url: 'dailyList.ajax',
	        data: {
	            pageName: pageName,
	            startDate: startDate,
	            endDate: endDate
	        },
	        dataType: 'JSON',
	        success: function (data) {
	            console.log(data);

	            // 테이블 업데이트
	            var dailyExpenseTable = '';
	            $.each(data.dailyExpenses, function (index, item) {
	                dailyExpenseTable += '<tr>' +
	                    '<td>' + item.ex_date + '</td>' +
	                    '<td>' + item.ex_item + '</td>' +
	                    '<td>' + item.description + '</td>' +
	                    '<td>' + item.ex_amount.toLocaleString() + '원</td>' +
	                    '<td>' + item.remark + '</td>' +
	                    '</tr>';
	            });
	            $('#dailyList').html(dailyExpenseTable);

	            // 데이터 그룹화
	            function groupBy(array, key) {
	                return array.reduce((result, currentValue) => {
	                    (result[currentValue[key]] = result[currentValue[key]] || []).push(currentValue);
	                    return result;
	                }, {});
	            }

	            var groupedData = groupBy(data.dailyExpenses, 'ex_item'); // 종류별 데이터 그룹화
	            var colorPalette = ['#30005A', '#44196A', '#59327A', '#6E4C8B', '#82669C', '#977FAC', '#AC99BD', '#C0B2CD'];

	            var datasets = Object.keys(groupedData).map(function (item, index) {
	                return {
	                    label: item, // 종류 이름
	                    data: groupedData[item].map(function (entry) { return entry.ex_amount; }),
	                    borderColor: colorPalette[index % colorPalette.length], // 고정된 색상 배열에서 순환
	                    borderWidth: 2,
	                    tension: 0.4
	                };
	            });


	            // 차트 관리: 기존 차트가 있으면 업데이트, 없으면 새로 생성
	            var ctxDaily = document.getElementById('dailyChart').getContext('2d');
	            if (dailyExpenseChart) {
	                // 기존 차트 데이터 갱신
	                dailyExpenseChart.data.labels = data.dailyExpenses.map(function (item) { return item.ex_date; });
	                dailyExpenseChart.data.datasets = datasets;
	                dailyExpenseChart.update();
	            } else {
	                // 새 차트 생성
	                dailyExpenseChart = new Chart(ctxDaily, {
	                    type: 'line',
	                    data: {
	                        labels: data.dailyExpenses.map(function (item) { return item.ex_date; }),
	                        datasets: datasets
	                    },
	                    options: {
	                        responsive: true,
	                        maintainAspectRatio: false,
	                        scales: {
	                            x: {
	                                title: {
	                                    display: true,
	                                    text: '날짜'
	                                }
	                            },
	                            y: {
	                                title: {
	                                    display: true,
	                                    text: '지출 금액 (원)'
	                                },
	                                ticks: {
	                                    callback: function (value) {
	                                        return value.toLocaleString() + '원'; // 금액을 원 단위로 표시
	                                    }
	                                }
	                            }
	                        }
	                    }
	                });
	            }
	        },
	        error: function (e) {
	            console.error("오류 발생:", e);
	        }
	    });
	}

	// 이전 주로 이동
	$('#prevWeek').on('click', function (e) {
	    e.preventDefault();
	    currentWeekStart.setDate(currentWeekStart.getDate() - 7); // 이전 주로 이동
	    updateWeekRange();
	    fetchWeeklyData(pageName);
	    console.log("전"+pageName);
	    console.log("After moving to previous week:", currentWeekStart);
	});

	// 다음 주로 이동
	$('#nextWeek').on('click', function (e) {
	    e.preventDefault();
	    currentWeekStart.setDate(currentWeekStart.getDate() + 7); // 다음 주로 이동
	    updateWeekRange();
	    fetchWeeklyData(pageName);
	    console.log("g후"+pageName);
	});

	// 초기화
	$(document).ready(function () {
	    updateWeekRange();
	    fetchWeeklyData(pageName);
	});


});
</script>
</html>
