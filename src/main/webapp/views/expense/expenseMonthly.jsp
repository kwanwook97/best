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
	    width: 1200px;
	    height: 690px;
	    border-radius: 10px;
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
    .container {
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

window.addEventListener('resize', function() {
	  lineChart.resize();
	});
$(document).ready(function() {
    var categoryData = [
      { category: '식비', amount: 50000 },
      { category: '교통비', amount: 30000 },
      { category: '기타', amount: 20000 }
    ];

    var dailyExpenseData = [
      { date: '01-01', category: '식비', content: '점심 식사', amount: 2500000, note: '' },
      { date: '01-02', category: '교통비', content: '지하철', amount: 300000, note: '' },
      { date: '01-03', category: '기타', content: '커피', amount: 4500000, note: '' },
      { date: '01-04', category: '기타', content: '커피', amount: 5000000, note: '' },
      { date: '01-05', category: '식비', content: '점심 식사', amount: 10000, note: '' },
      { date: '01-06', category: '교통비', content: '지하철', amount: 3000, note: '' },
      { date: '01-07', category: '기타', content: '커피', amount: 4500, note: '' }
    ];

    // 카테고리별 지출 금액 테이블 생성
    var categoryTable = '';
    $.each(categoryData, function(index, item) {
      categoryTable += '<tr><td>' + item.category + '</td><td>' + item.amount.toLocaleString() + '원</td></tr>';
    });
    $('#categoryList').html(categoryTable);

    // 날짜별 지출 내역 테이블 생성
    var dailyExpenseTable = '';
    $.each(dailyExpenseData, function(index, item) {
      dailyExpenseTable += '<tr>' +
        '<td>' + item.date + '</td>' +
        '<td>' + item.category + '</td>' +
        '<td>' + item.content + '</td>' +
        '<td>' + item.amount.toLocaleString() + '원</td>' +
        '<td>' + item.note + '</td>' +
        '</tr>';
    });
    $('#dailyList').html(dailyExpenseTable);

    // 원형 차트 데이터 및 옵션
    var ctxCategory = document.getElementById('categoryChart').getContext('2d');
    var categoryChart = new Chart(ctxCategory, {
      type: 'pie',
      data: {
        labels: categoryData.map(function(item) { return item.category; }),
        datasets: [{
          data: categoryData.map(function(item) { return item.amount; }),
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

 // 멀티 축 차트 데이터 및 옵션
    var ctxDaily = document.getElementById('dailyChart').getContext('2d');
    var dailyExpenseChart = new Chart(ctxDaily, {
      type: 'line',
      data: {
        labels: dailyExpenseData.map(function(item) { return item.date; }),
        datasets: [{
          label: '일별 지출 금액',
          data: dailyExpenseData.map(function(item) { return item.amount; }),
          borderColor: '#E9396B',
          borderWidth: 2,
          tension: 0.4,
          yAxisID: 'y1'
        }, {
          label: '비고',
          data: dailyExpenseData.map(function(item) { return item.note.length; }), // 예시로 note의 길이를 표시
          borderColor: '#2C7BB6',
          fill: false,
          borderWidth: 2,
          tension: 0.4,
          fill: false,
          yAxisID: 'y2'
        }]
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
          y1: {
            position: 'left',
            title: {
              display: true,
              text: '금액 (원)'
            },
            ticks: {
              // y축의 금액 범위를 0원부터 500만원으로 설정
              min: 0, // 최소값 0원
              max: 5000000, // 최대값 500만원
              stepSize: 1000000,
              callback: function(value) {
                return value.toLocaleString() + '원'; // 금액을 원 단위로 표시
              }
            }
          },
          y2: {
            position: 'right',
            title: {
              display: true,
              text: '비고 길이' // 비고의 길이를 표시
            },
            ticks: {
              min: 0,
              max: 10, // 비고 길이에 대한 범위 설정
              stepSize: 1
            }
          }
        }
      }
    });
});
</script>
</html>
