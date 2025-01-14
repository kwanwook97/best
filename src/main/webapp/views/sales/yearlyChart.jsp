<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="resources/jquery.twbsPagination.js"></script>
  <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
  <link rel="stylesheet" href="resources/css/pagination.css">
  

  <style>
	:root{
		--primary-color: #30005A;
		--secondary-color: #8B6AA7;
		--accent-color: #E9396B;
		--background-color: #FFFBF2;
	}
	.dashboard-body{
	    margin-left: 14vw;
	    width: 85vw;
	    margin-top: 7vh;
	    flex-wrap: nowrap;
	    padding: 2vh;
	    color: var(--primary-color);
	    height: 92%;
	    display: flex;
	    flex-direction: column;
	    position: absolute;
	    align-items: center;
	}
	.maintext{
		display: flex;
		width: 100%;
	}
	.document{
		color: var(--secondary-color);
		margin-right: 30px !important;
	}
	.midle-subject{
		color: var(--secondary-color);
	}
	.last-lastsubject{
		color: var(--primary-color);
	}
	
	.docbox{
		border: 2px solid var(--primary-color);
	    width: -webkit-fill-available;
		height: 100%;
	    border: 2px solid var(--primary-color);
	    border-radius: 10px;
	}


	.drop{
	    font-size: 14px;
	    border: 1px solid var(--primary-color);
	    border-radius: 4px;
	    color: var(--primary-color);
	    padding: 6px;
	}
	select option{
		background-color: white !important;
		border-radius: 5px;
	}

	.search input{
		border-radius: 10px;
		padding-left: 10px;
		border: 1px solid var(--primary-color);
	}
	.search i{
		position: absolute;
		right: 10%;
		font-size: 18px;
		color: var(--accent-color);
		z-index: 100;
		cursor: pointer;
	}

	@media (max-width: 960px) {
    .dashboard-body {
      transform: scale(0.8);
      margin-left: 17vw;
      width: 93vw;
    }
    .opt {
      width: 60%;
      flex-wrap: wrap;
    }
    .searchbox {
      width: 42%;
    }

  }
  /*  */
/* 상위 컨테이너를 Flexbox로 설정 */
	.docbox-header {
	    display: flex;
	    justify-content: space-between; /* 좌우로 정렬 */
	    align-items: center; /* 세로 중앙 정렬 */
	    margin: 20px 4% 0 0;
	}
	
	/* 왼쪽 텍스트 스타일 */
	.docbox-subject {
	    margin: 0 0 0 20%; /* 기본 마진 제거 */
	    font-weight: bold;
	}
	
	/* 오른쪽 정렬 */
	.docnav {
	    display: flex;
	    align-items: center; /* 세로 중앙 정렬 */
	    gap: 10px; /* 요소 간 간격 */
	}
	
	.searchbox {
	    display: flex;
	    align-items: center; /* 세로 중앙 정렬 */
	    gap: 10px;
	}
	
	.searchbox .search {
	    display: flex;
	    align-items: center;
	    gap: 5px;
	}
	
	.searchbox input {
	    padding: 0px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	}
	
	.editbtn {
	    padding: 2px 0px;
	   	background-color: var(--accent-color);
	    color: white;
	    border: none;
	   	border-radius: 10px;
	    cursor: pointer;
	    width: 70px;
	}
	
	.editbtn i {
	    margin-right: 5px;
	}
	
	.editbtn:hover {
	    opacity: 0.8;
	}
	/* 차트 */
	.year-graph {
	    width: 100%; 
	    height: 100%; 
	    border-radius: 10px;
	    border: 2px solid #30005A;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    margin: 16px 50px;
	}
	.year-graph span{
		font-size: 24px;
		font-weight: 700;
	}
	.year-graph > div:first-child{
	    margin-left: 1vw;
	    margin-top: 1vw;
	}
	.year-graph2{
		display: flex;
		width: 100%;
		height: 88%;
	    flex-direction: row;
	    justify-content: center;
	}
/* 	.year-graph3{
		width: 5.5vh;
		height: 5vw;
		background-color: #30005A;
		border-top-left-radius: 10px;
	    border-top-right-radius: 10px;
	    margin: 0.3vw;
	}
	.year-graph2 > div {
	    text-align: center;
	}
	 */
	.card-table {
	    width: 100%;
	    margin: 0 0;
	    border-collapse: collapse;
	    border: 2px solid #30005A; /* 테두리 색상 */
	    height: 100%;
	    border-radius: 10px;
	    /* overflow: hidden;  */
	}
	.card-table th {
	    background-color: #30005A; /* 헤더 배경색 */
	    color: white; /* 헤더 텍스트 색상 */
	    padding: 15px;
	    text-align: center;
	}
	.card-table td {
	    padding: 15px;
	    text-align: center;
	    border-bottom: 2px solid #30005A; /* 셀 구분선 */
	}
	.table-box {
		width: 42%;
		height: 100%;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	    border: 2px solid #30005A; /* 테두리 */
	    border-radius: 10px; /* 둥근 모서리 */
	    overflow: hidden; /* 테두리 안쪽 내용 잘리지 않도록 */
	    margin: 50 0px 18px 25px;
	}
	.driver_modal_title {
		font-size: 28px !important;
		font-weight: 500 !important;
		
	}
	.container-wrapper {
		display: flex;
		width: 100%;
		height: 88%;
	}
/* 기간	 */
.date-navigation {
	position: relative;
	margin: 0 0;
	font-size: 24px;
	font-weight: bold;
	text-align: center;
	position: relative;
	left: 43%;
}

.date-content {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
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
.lPurple {
	color: #8B6AA7;
}
.cPurple {
	color: #30005A;
}
.headerBox {
	font-size: 32px;
}
.headerBox {
	margin-top: 0%;
	width: 36%;
	display: flex;
	flex-direction: row;
	align-items:center;
	justify-content: space-between;
	margin-bottom: 1.5rem;
}
.headerBox {
	font-weight: bold;
}
.pagination {
	margin: 0 0 !important;
}
  
   </style>
   <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 <jsp:include page="../modal/modal.jsp"></jsp:include>

 	<div class="dashboard-body">
		<div class="maintext">
			<div class="headerBox">
				<span class="lPurple">매출현황</span>
				<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
				<span class="lPurple">연별 현황</span>
				<i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
				<span class="cPurple dateHeader">날짜</span>
			</div>
		</div>

		<div class="docbox">
		    <div class="docbox-header">
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
				
		        <div class="docnav">
		            <div class="searchbox">
		                <select class="drop" id="searchField">
						    <option value="all">전체</option> 
		                </select>
		            </div>
		        </div>
		    </div>
		    
		    <div class="container-wrapper">
			 	<div class="year-graph">
			 		<div><span>연별 정산</span></div>
			 		<div class="year-graph2">
						<canvas id="cardChart"></canvas>
			 		</div>
			 	</div>
		 	</div>
		</div>
	</div>
</body>
<script>
let myChart; 

function renderChart(labels,amounts){
    if (myChart) {
        myChart.destroy();
    }

	const maxValue = Math.max(...amounts);
	const minValue = Math.min(...amounts);
	
	const barColors = amounts.map(value => {
	  if (value === maxValue) return '#E9396B'; 
	  if (value === minValue) return '#FFD700';
	  return '#30005A'; 
	});
	const ctx = document.getElementById('cardChart').getContext('2d');
	 myChart = new Chart(ctx, {
	  type: 'bar',
	  data: {
	    labels: labels, 
	    datasets: [{
	      label: '월별 정산',
	      data: amounts, 
	      backgroundColor: barColors, 
	      borderRadius: 10, 
	      borderSkipped: false, 
	    }]
	  },
	  options: {
	    plugins: {
	      legend: {
	        display: false, 
	      }
	    },
	    scales: {
	      x: {
	        ticks: {
	          color: '#30005A', 
	          font: {
	              size: 14, 
	              weight: 'bold', 
	            }
	        }
	      },
	      y: {
	        beginAtZero: true, 
	        ticks: {
	          color: '#30005A', 
	          font: {
	              size: 14, 
	              weight: 'bold', 
	            }
	        }
	      }
	    }
	  }
	});
};

function fetchChart(date){
	$.ajax({
		method: 'POST',
		url: 'fetchYearChart.ajax',
		data: {
			'year': date
		},
		dataType: 'JSON',
		success: function(data){
		  	console.log("테스트종원:"+JSON.stringify(data, null, 2));
	        //const labels = data.list? data.list.map(item => item.month): null;
	        //const amounts = data.list? data.list.map(item => item.totalAmount): null;
            const baseLabels = ['1월', '2월', '3월', '4월', '5월', '6월', 
                '7월', '8월', '9월', '10월', '11월', '12월'];
			let labels = [];
			let amounts = [];
			
			if (data.list) {
			
				baseLabels.forEach(month => {
				    const item = data.list.find(d => d.month === month);
				    if (item) {
				        labels.push(item.month);
				        amounts.push(item.totalAmount);
				    } else {
				        labels.push(month);
				        amounts.push(0); 
				    }
				});
			} else {
			labels = baseLabels;
			amounts = Array(12).fill(0);
			}
	        if(data.msg == '성공'){
	            renderChart(labels, amounts);
        	}else{
	            renderChart([], []);
        	}
	        if(data.msg == '성공'){
	            renderChart(labels, amounts);
        	}else{
	            renderChart([], []);
        	}
	        
	        if (data.msgList == '성공') {
	            const selectField = $('#searchField');
	            selectField.empty();
	            selectField.append('<option value="all">전체</option>');
	       //     console.log("테스트종원:"+JSON.stringify(data.companyList, null, 2));
	            data.companyList.forEach(function(option) {
	                selectField.append('<option>'+option+'</option>');
	            });
			}else {
	            const selectField = $('#searchField');
	            selectField.empty();
	            selectField.append('<option value="all">전체</option>');
			}
		},
		error: function(e){
			modal.showAlert('잠시 후 다시 시도해주세요.');
		}
	});
	
}

$(document).on('change', '#searchField', function() {
	const selectedValue = $(this).val();
	console.log("종원테스트2:"+selectedValue);
	if (selectedValue == 'all') {
		return fetchChart(year);
	}
	
    $.ajax({
        url: 'getChartData.ajax',
        type: 'POST',
        data: { 
        	'company': selectedValue,
        	'year': year
        }, 
        dataType: 'json',
		success: function(data){
		  	console.log("테스트종원:"+JSON.stringify(data, null, 2));
            const baseLabels = ['1월', '2월', '3월', '4월', '5월', '6월', 
                '7월', '8월', '9월', '10월', '11월', '12월'];
			let labels = [];
			let amounts = [];
			
			if (data.list) {
			
				baseLabels.forEach(month => {
				    const item = data.list.find(d => d.month === month);
				    if (item) {
				        labels.push(item.month);
				        amounts.push(item.amount);
				    } else {
				        labels.push(month);
				        amounts.push(0); 
				    }
				});
			} else {
			labels = baseLabels;
			amounts = Array(12).fill(0);
			}
	        if(data.msg == '성공'){
	            renderChart(labels, amounts);
        	}else{
	            renderChart([], []);
        	}

		},
		error: function(e){
			modal.showAlert('잠시 후 다시 시도해주세요.');
		}
    });
});



/* 날짜 바꾸는 기능 */
//현재 날짜 객체를 저장
let currentDate = new Date();
var year = '';
// 현재 날짜를 화면에 표시하는 함수{
function updateDateDisplay() {
    const currentDateElement = document.querySelector('.current-date');
    const dateHeaderElement = document.querySelector('.dateHeader');
    year = currentDate.getFullYear();
    currentDateElement.textContent = year + '년 정산';
    dateHeaderElement.textContent = year + '년';
    fetchChart(year);
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




</script>
</html>
