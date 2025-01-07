<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
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
	    right: 8%;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    margin: 50 25;
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
		height: 81%;
	}
/* 기간	 */
.date-navigation {
	position: relative;
	margin: 0 0;
	font-size: 24px;
	font-weight: bold;
	text-align: center;
	width: 51%;
	position: relative;
	left: 20%;
}

.date-content {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	width: 50%;
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
<!-- 			<h3 class="document">매출현황</h3>
			<h3 class="midle-subject">>&nbsp;&nbsp;월별 현황&nbsp;&nbsp;</h3>
			<h3 class="last-subject">>&nbsp;&nbsp;2024-12월</h3> -->
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
		       <!--  <h3 class="docbox-subject">&lt;&lt; &nbsp;&nbsp;&lt;&nbsp;&nbsp; 2024-12 &nbsp;&nbsp; &gt;&nbsp;&nbsp;&gt;&gt;</h3> -->
				<div class="date-navigation">
					<div class="date-content">
<!-- 						<button class="date-button">
							<i class="fas fa-angle-double-left"></i>
						</button> -->
						<button class="date-button">
							<i class="fas fa-angle-left"></i>
						</button>
						<span class="current-date"></span>
						<button class="date-button">
							<i class="fas fa-angle-right"></i>
						</button>
<!-- 						<button class="date-button">
							<i class="fas fa-angle-double-right"></i>
						</button> -->
					</div>
				</div>
				
		        <div class="docnav">
		            <div class="searchbox">
		                <select class="drop" id="searchField">
<!-- 		                    <option value="subject">카드사</option>
		                    <option value="content">이름</option> -->
						    <option value="all">전체</option> 
		                </select>
<!-- 		                <div class="search">
		                    <input type="text" id="searchInput" placeholder="검색어 입력">
		                    <i class="fas fa-search" onclick="performSearch()"></i>
		                </div> -->
		            </div>
		        </div>
		    </div>
		    
		    <div class="container-wrapper">
<!-- 				<div class="table-box">
				    <table class="card-table">
				        <thead>
				            <tr>
				                <th>카드사</th>
				                <th>금액(원)</th>
				                <th>정산월</th>
				                <th>담당자</th>
				            </tr>
				        </thead>
      				    <tbody id="tableBody">

				        </tbody>
				    </table>
					 <div class="pagination-wrapper">
					     <nav aria-label="Page navigation">
					         <ul class="pagination activ" id="pagination"></ul>
					     </nav>
					 </div>
			    </div> -->
	
	
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
/* const inputField = document.getElementById("card_company");
let isComposing = false;
function validateInput() {
  const value = inputField.value;
  const filteredValue = value.replace(/[^가-힣]/g, "");
  if (value !== filteredValue) {
    modal.showAlert("카드사 이름은 한글로만 입력해주세요.");
    inputField.value = filteredValue; 
  }
}
inputField.addEventListener("compositionstart", () => {
  isComposing = true;
});
inputField.addEventListener("compositionend", () => {
  isComposing = false;
  validateInput();
});
inputField.addEventListener("input", () => {
  if (!isComposing) {
    validateInput();
  }
}); */

let myChart; 

function renderChart(labels,amounts){
    if (myChart) {
        myChart.destroy();
    }

	const maxValue = Math.max(...amounts);
	const minValue = Math.min(...amounts);
	
	const barColors = amounts.map(value => {
	  if (value === maxValue) return '#E9396B'; 
	  /* if (value === minValue) return '#6C0F6C'; */
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
		  	//console.log("테스트종원:"+JSON.stringify(data, null, 2));
	        const labels = data.list? data.list.map(item => item.month): null;
	        const amounts = data.list? data.list.map(item => item.totalAmount): null;
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
	        const labels = data.list? data.list.map(item => item.month): null;
	        const amounts = data.list? data.list.map(item => item.amount): null;
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



/* 모달*/
/* function addSattlementModal(){
	$(".driver_modal.modal_change").css("display","flex").hide().fadeIn();
}  	

function hideSattlementModal() {
	$(".driver_modal.modal_change").fadeOut();
	$('#card_company').val('');
	$('#amount').val('');
	$('#month').val('');
}

$('.full_btn_regist').on('click', function() {
    modal.showConfirm('등록 하시겠습니까?', function () {
    	saveSettlement(); 
    });
}); */


/* function saveSettlement(){
    const company = $('#card_company').val(); 
    const amount = $('#amount').val();
    const month = $('#month').val();

    if (!loginId) {
        modal.showAlert("로그인 해주세요");
        return;
    }
    if (!company) {
    	modal.showAlert("카드사를 입력해주세요.");
        $('#card_company').focus();
        return;
    }

    if (!amount || isNaN(amount) || Number(amount) <= 0) {
    	modal.showAlert("올바른 금액을 입력해주세요.");
        $('#amount').focus();
        return;
    }
    if (!month) {
    	modal.showAlert("정산월를 선택해주세요.");
        $('#month').focus();
        return;
    }
	
	$.ajax({
		method: 'POST',
		url: 'saveSettlement.ajax',
		data: {
			'loginId': loginId,
			'company': $('#card_company').val(),
			'amount': $('#amount').val(),
			'month': $('#month').val()
		},
		dataType: 'JSON',
		success: function(data){
			if(data.msg == '성공'){
				modal.showAlert('등록 되었습니다.');   
				hideSattlementModal();
        	}else{
        		modal.showAlert('등록 안 되었습니다.');
				hideSattlementModal();
        	}
		},
		error: function(e){
			modal.showAlert('잠시 후 다시 시도해주세요.');
		}
	});
}
 */
/* 날짜 바꾸는 기능 */
//현재 날짜 객체를 저장
let currentDate = new Date();
var year = '';
// 현재 날짜를 화면에 표시하는 함수{
function updateDateDisplay() {
    const currentDateElement = document.querySelector('.current-date');
    const dateHeaderElement = document.querySelector('.dateHeader');
    year = currentDate.getFullYear();
    //const month = currentDate.getMonth() + 1;
    currentDateElement.textContent = year + '년';
    dateHeaderElement.textContent = year + '년';
    //fetchData('','', page, currentDateElement.textContent);
    fetchChart(year);
}
/* function incrementMonth() {
    currentDate.setMonth(currentDate.getMonth() + 1);
    updateDateDisplay();
}
function decrementMonth() {
    currentDate.setMonth(currentDate.getMonth() - 1);
    updateDateDisplay();
} */
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
/* document.querySelector('.date-button:nth-child(4)').addEventListener('click', incrementMonth);  
document.querySelector('.date-button:nth-child(5)').addEventListener('click', incrementYear);  */ 
updateDateDisplay();
//여기 까지}



/* 검색바 와 기본 리스트 조절 하기  */
//var page = 1;
//var getDate = document.querySelector('.current-date') ? document.querySelector('.current-date').textContent : '';
//fetchData('','', page, getDate);
/* function performSearch() {
    const searchField = document.getElementById('searchField') ? document.getElementById('searchField').value : '';
    const searchInput = document.getElementById('searchInput') ? document.getElementById('searchInput').value : '';
    const selectDate = document.querySelector('.current-date') ? document.querySelector('.current-date').textContent : '';
    const searchInputElement = document.getElementById('searchInput');
//    fetchData(searchField, searchInput, page, selectDate);
    if (searchInputElement) {
        searchInputElement.value = '';
    }
}
document.getElementById('searchInput').addEventListener('keydown', function(event) {
    if (event.key === 'Enter') {
        performSearch(); 
        
    }
}); */

/* function fetchData(searchField = '없음', searchInput = '없음', page = 1, selectDate = '없음') {
    console.log('Fetch Data 호출:', { searchField, searchInput, page, selectDate });
    $.ajax({
        url: 'filterSettlement.ajax',
        type: 'POST',
        data: {
            'page': page,
            'cnt': 10,
            'searchField': searchField || '없음',
            'searchInput': searchInput || '없음',
            'month': selectDate || '없음'
        },
        dataType: 'json',
        success: function(data) {
            console.log('AJAX 데이터:', data);
            if (data.msg == '성공') {
                renderTable(data.list);
                    $('#pagination').twbsPagination('destroy');
                    $('#pagination').twbsPagination({
                        startPage: data.currentPage,
                        totalPages: data.totalPages,
                        visiblePages: 5,
                        onPageClick: function(evt, clickedPage) {
                            if (clickedPage !== page) {
                                fetchData(searchField, searchInput, clickedPage, selectDate);
                            }
                        }
                    });
            } else {
                noList();
            }
        },
        error: function(error) {
            console.error('Error:', error);
            noList();
        }
    });
} */

/* function renderTable(records) {
    var tbody = $('#tableBody');
    tbody.empty();
    records.forEach(function(record) {
        var tr = $('<tr></tr>');
        tr.html(
            '<td>' + record.company + '</td>' +
            '<td>' + record.amount + '</td>' +
            '<td>' + record.month + '</td>' +
            '<td>' + record.name + '</td>'
        );
        tbody.append(tr);
    });
}

function noList() {
    var tbody = $('#tableBody');
    tbody.empty();
    tbody.append('<tr><td colspan="4">등록된 데이터가 없습니다.</td></tr>');
    if ($('#pagination').data("twbsPagination")) {
        $('#pagination').twbsPagination('destroy');
    }
} */

</script>
</html>
