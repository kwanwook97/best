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
	}
	.itemList{
		border: 1px solid var(--primary-color);
	    width: 35%;
    	height: 620px;
	}
	.expenseChart{
		border: 1px solid var(--primary-color);
	    width: 55%;
	    height: 620px;
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
			<div class="itemList"></div>
			<div class="expenseChart">
				<canvas id="myPieChart"></canvas>
			</div>
		</div>
 	</div>
</body>
<script>
// DOM 로드 후 실행
document.addEventListener("DOMContentLoaded", function () {
    // 차트가 그려질 canvas 요소 가져오기
    const ctx = document.getElementById('myPieChart').getContext('2d');

    // 데이터 설정
    const data = {
        labels: ['식비', '교통비', '주거비', '기타'],
        datasets: [{
            label: '지출 내역',
            data: [50000, 30000, 70000, 20000], // 각 항목의 데이터 값
            backgroundColor: [
                'rgba(255, 99, 132, 0.8)', // 각 항목 색상
                'rgba(54, 162, 235, 0.8)',
                'rgba(255, 206, 86, 0.8)',
                'rgba(75, 192, 192, 0.8)'
            ],
            hoverOffset: 4
        }]
    };

    // 차트 설정
    const config = {
        type: 'pie', // 차트 타입 (파이 차트)
        data: data
    };

    // 차트 생성
    new Chart(ctx, config);
});

</script>
</html>
