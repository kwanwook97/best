<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.x.x/css/all.min.css" rel="stylesheet">
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
	    margin-left: -10vw;
	    margin-bottom: 10px;
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
	}
	.chartOption div:hover{
		font-weight: bold;
		color: var(--primary-color);
	}
	/* 기본 스타일 */
	.empOpt{
		color: var(--primary-color);
	    font-weight: bold;
	    border-bottom: 2px solid var(--accent-color);
	}
	.busOpt, .salaryOpt {
	    color: var(--secondary-color);
	    font-weight: normal;
	    border: none;
	}
	/* 선택된 스타일 */
	.selectedd {
	    color: var(--primary-color);
	    font-weight: bold;
	    border-bottom: 2px solid var(--accent-color);
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
	.docbox{
    	display: flex;
   	    flex-direction: column;
        align-items: center;
		border: 2px solid var(--primary-color);
	    height: 660px;
	    width: 1200px;
	    border-radius: 10px;
	}
	.date-navigation {
		margin: 47px 0;
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
	    display: flex;
	    border-radius: 8px;
	    overflow: hidden;
	    justify-content: space-between;
    }
    .leftPanel{
    	margin-left: 20px;
	    width: 85%;
	    display: flex;
	    overflow-y: auto;
    }
    .leftPanel div:first-child{
    	margin-right: 25px;
    }
    h4{
    	font-size: 20px !important;
    }
    table td, th{
    	font-size: small;
    	text-align: center !important;
    }
	.categoryTable{
		width: 31%;
	}
	.categoryList{
	
	}
	.dailyTable{
		width: 82%;
   		margin-top: 30px;
	}
	.dailyList{

	}
    .rightPanel {
		padding: 5px;
	    width: 400px;
	    height: 452px;
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
	    max-width: 85%; /* 부모 요소의 85%로 설정 */
	    max-height: 500px; /* 최대 높이를 제한 */
	    width: 85%; /* 차트가 부모 요소의 85%만 차지 */
	    height: auto; /* 비율 유지 */
	}
	#dailyPagination{
	    margin-top: 5px;
		display: flex;
	    padding-left: 0;
	    list-style: none;
	    border-radius: .25rem;
	    align-items: center;
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
	@media (min-width: 1200px) {
    .container {
        max-width: 1200px !important;
    }
</style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<span class="document">지출정산</span>
			<i class="fa-solid fa-angle-right" style="color: #8B6AA7;"></i>
			<span class="text">월별현황</span>
		</div>
		<div class="docnav">
			<div class="chartOption">
				<div class="empOpt" onclick="changeList('일반')">일반</div>
				<div class="busOpt" onclick="changeList('버스관리')">버스관리</div>
				<div class="salaryOpt" onclick="changeList('급여')">급여</div>
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
					<div  class="categoryTable">
						<h4>카테고리별</h4>
						<h4>지출금액</h4>
						<table>
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
					<div class="dailyTable">
						<h4>날짜별 지출내역</h4>
						<table>
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
						<div class="containerP" id="dailyCont">
						    <nav aria-label="Page navigation">
						        <ul class="pagination" id="dailyPagination"></ul>
						    </nav>
						</div>
					</div>
				</div>
				<div class="rightPanel">
					<h4 class="chartText">지출 차트</h4>
					<canvas id="categoryChart"></canvas>
				</div>
			</div>
		</div>
 	</div>
</body>
<script>
	
$(document).ready(function() {
	
	var pageName = '일반';
	var categoryChart;
	var dailyExpenseChart;
	
	var currentDate = new Date();
	var year = '';
	var ex_date = "";
	function updateDateDisplay() {
	    var currentDateElement = document.querySelector('.current-date');
	    var year = currentDate.getFullYear();
	    var month = currentDate.getMonth() + 1;
	    currentDateElement.textContent = year + '년 ' + month + '월';
	    
	 	// 변수로 연도와 월 저장
	    window.currentYear = year;
	    window.currentMonth = month;
	    ex_date = year + '-' + String(month).padStart(2, '0') + '-%';
	    pageCall(1, ex_date, pageName);
	    categoryList(ex_date, pageName);
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
	    // 모든 옵션 초기화
	    $('.empOpt, .busOpt, .salaryOpt').removeClass('selectedd').css({
	        color: 'var(--secondary-color)',
	        fontWeight: 'normal',
	        borderBottom: 'none'
	    });

	    // name에 따라 클래스 이름 설정
	    var newName = '';
	    if (name === '일반') {
	        newName = 'emp';
	    } else if (name === '버스관리') {
	        newName = 'bus';
	    } else if (name === '급여') {
	        newName = 'salary';
	    }

	    // 선택된 옵션에 스타일 적용
	    var $selectedOption = $('.' + newName + 'Opt');
	    if ($selectedOption.length) {
	        $selectedOption.addClass('selectedd').css({
	            color: 'var(--primary-color)',
	            fontWeight: 'bold',
	            borderBottom: '2px solid var(--accent-color)'
	        });
	    }

	    // 기존 로직 호출
	    pageName = name;
	    categoryList(ex_date, pageName);
	    console.log('ex_date: ' + ex_date);
	    pageCall(1, ex_date, pageName);
	    console.log('pageName: ' + pageName);
	};


	
	window.addEventListener('resize', function() {
		lineChart.resize();
	});
	
	document.addEventListener('DOMContentLoaded', function () {
	    console.log("Page loaded. Fetching initial data...");
	});
	
    categoryList(ex_date,pageName);
    
 /* 	function categoryList(ex_date, pageName){
		$.ajax({
			type: 'GET',
			url: 'categoryList.ajax',
			data: {
				ex_date: ex_date,
				pageName: pageName
			},
			dataType: 'JSON',
			success: function(data) {
				console.log("아~ 존나하기싫어",data);
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
	}  */
	function categoryList(ex_date, pageName) {
	    let defaultCategories = [];
	    
	    if (pageName === "일반") {
	        defaultCategories = [
	            "기자재",
	            "기타",
	            "비품",
	            "사무용품",
	            "수리비",
	            "식대",
	            "출장비",
	            "행사비"
	        ];
	    } else if (pageName === "버스관리") {
	        defaultCategories = [
	            "유류비",
	            "보험료",
	            "정비비",
	            "검사비",
	            "구매비",
	            "등록비",
	            "사고처리",
	            "기타"
	        ];
	    } else if (pageName === "급여") {
	        defaultCategories = [
	            "급여",
	            "상여금",
	            "야간근로수당",
	            "퇴직금",
	            "복리후생비",
	            "4대보험료",
	            "세금",
	            "기타"
	        ];
	    } else {
	        console.error("알 수 없는 pageName:", pageName);
	        return;
	    }

	    $.ajax({
	        type: 'GET',
	        url: 'categoryList.ajax',
	        data: {
	            ex_date: ex_date,
	            pageName: pageName
	        },
	        dataType: 'JSON',
	        success: function (data) {
	            console.log("데이터 가져옴:", data);

	            // 데이터 가공: 기본 카테고리와 합침
	            const categoryData = defaultCategories.map(category => {
	                const matchedItem = data.find(item => item.category === category);
	                return {
	                    category: category,
	                    amount: matchedItem ? matchedItem.amount : 0 // 데이터가 없으면 0으로 설정
	                };
	            });

	            // 카테고리별 지출 금액 테이블 생성
	            let categoryTable = '';
	            categoryData.forEach(item => {
	                categoryTable += '<tr><td>' + item.category + '</td><td>' + item.amount.toLocaleString() + '원</td></tr>';
	            });
	            $('#categoryList').html(categoryTable);

	            // 차트 업데이트 또는 생성
	            if (categoryChart) {
	                // 기존 차트 데이터 갱신
	                categoryChart.data.labels = categoryData.map(item => item.category);
	                categoryChart.data.datasets[0].data = categoryData.map(item => item.amount);
	                categoryChart.update();
	            } else {
	                // 새 차트 생성
	                const ctxCategory = document.getElementById('categoryChart').getContext('2d');
	                categoryChart = new Chart(ctxCategory, {
	                    type: 'pie',
	                    data: {
	                        labels: categoryData.map(item => item.category),
	                        datasets: [{
	                            data: categoryData.map(item => item.amount),
	                            backgroundColor: [
	                                '#30005A', '#44196A', '#59327A', '#6E4C8B',
	                                '#82669C', '#977FAC', '#AC99BD', '#C0B2CD'
	                            ]
	                        }]
	                    },
	                    options: {
	                        responsive: true,
	                        maintainAspectRatio: false,
	                        plugins: {
	                            legend: {
	                                position: 'bottom'
	                            }
	                        }
	                    }
	                });
	            }
	        },
	        error: function (e) {
	            console.log("오류 발생", e);
	        }
	    });
	}

	function pageCall(page, ex_date, pageName){
	    $.ajax({
	        type: 'GET',
	        url: 'dailyList.ajax',
	        data: {
	        	pageName: pageName,
	        	ex_date: ex_date,
	            page: page,
	            cnt: 8
	        },
	        dataType: 'JSON',
	        success: function(data) {
	            console.log("값 ",data);
	            dailyList(data.dailyList);
	            
	            $('#dailyPagination').twbsPagination({
	                startPage: 1,
	                totalPages: data.totalPages,
	                visiblePages: 5,
	                onPageClick: function(evt, page){
	                    console.log("evt", evt);
	                    console.log("page", page);
	                    pageCallList(page, ex_date, pageName);
	                }
	            });
	        },
	        error: function(e) {
	            console.log("오류 발생", e);
	        }
	    });
	}

	function dailyList(list){
		var content = '';
		for(var item of list){
			content += '<tr>' +
            '<td>' + item.ex_date + '</td>' +
            '<td>' + item.ex_item + '</td>' +
            '<td>' + item.description + '</td>' +
            '<td>' + item.ex_amount.toLocaleString() + '원</td>' +
            '<td>' + (item.remark !== undefined ? item.remark : '') + '</td>' +
            '</tr>';
		}
		$('#dailyList').html(content);
	}
	
	function pageCallList(page){
		 $.ajax({
	        type: 'GET',
	        url: 'dailyList.ajax',
	        data: {
	        	pageName: pageName,
	        	ex_date: ex_date,
	            page: page,
	            cnt: 8
	        },
	        dataType: 'JSON',
	        success: function(data) {
	        	dailyList(data.dailyList);
	        },
	        error: function(e) {
	            console.log("오류 발생", e);
	        }
	    });
	}
});
</script>
</html>
