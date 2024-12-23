<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
	.dashboard-body{
		transform: scale(0.9);
	    margin-left: 22vw;
        width: 70vw;
	    margin-top: 7vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: flex-start;
	    justify-content: center;
	}
	.maintext{
		display: flex;
		margin-left: 10px;
	}
	.document{
		color: var(--secondary-color);
		margin-right: 30px;
	    margin-bottom: 40px;
	}
	.docbox{
		border: 2px solid var(--primary-color);
	    width: 100%;
	    height: 745px;
	    border-radius: 10px;
	}
	.opt div:nth-child(1){
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div:nth-child(1) a{
		color: var(--primary-color) !important;
	}
	.opt div:hover{
		cursor: pointer;
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div a:hover{
		color: var(--primary-color);
	}
	table.myTable{
		border-collapse: separate !important;
        border-spacing: 0;
	    width: 90%;
		border: 1px solid var(--primary-color);
		border-radius: 10px;
		margin: 0 48px 15px 48px;
	    text-align: center;
	}
	table.myTable caption.caption{
		color: var(--primary-color) !important;
	    font-size: large;
	    font-weight: bold;
	    text-align: left;
	    caption-side: top;
	}
	table.myTable caption.sentCap{
		padding-top: 0;
	}
	table.myTable tr:not(:last-child) td{
        border-bottom: 1px solid var(--primary-color) !important;
    }
	table.myTable tr{
		border-bottom: 1px solid var(--primary-color);
		height: 35px;
	}
	.receivedList tr td:hover:nth-child(4) {
	    color: var(--accent-color);
	    cursor: pointer;
	}
	.sentList tr td:hover:nth-child(4) {
	    color: var(--accent-color);
	    cursor: pointer;
	}
	table.myTable thead tr{
		background-color: var(--primary-color);
		color: white;
	}
	table.myTable thead tr th:first-child{
		border-top-left-radius: 10px;
	}
	table.myTable thead tr th:last-child{
		border-top-right-radius: 10px;
	}
	table.receivedTable th:nth-child(1) {
	    width: 4%;
	}
	table.receivedTable th:nth-child(2) {
	    width: 12%;
	}
	table.receivedTable th:nth-child(3) {
	    width: 10%;
	}
	table.receivedTable th:nth-child(4) {
	    width: 30%;
	}
	table.receivedTable th:nth-child(5) {
	    width: 8%;
	}
	table.receivedTable th:nth-child(6) {
	    width: 10%;
	}
	table.receivedTable th:nth-child(7) {
	    width: 10%;
	}
	table.receivedTable th:nth-child(8) {
	    width: 7%;
	}
	.table1{
	    position: fixed;
	  	width: 100%;
	}
	table.sentTable th:nth-child(1) {
	    width: 4%;
	}
	table.sentTable th:nth-child(2) {
	    width: 12%;
	}
	table.sentTable th:nth-child(3) {
	    width: 10%;
	}
	table.sentTable th:nth-child(4) {
	    width: 30%;
	}
	table.sentTable th:nth-child(5) {
	    width: 10%;
	}
	table.sentTable th:nth-child(6) {
	    width: 10%;
	}
	.table2{
	    position: fixed;
    	top: 30.5rem;
		width: 100%;
	}
    #status{
		background-color: var(--primary-color);
		border: none;
		color: white;
		font-weight: bold;
    }
    #status option{
    	width: 20px;
    	background-color: var(--primary-color);
    	color: white;
    	font-size: 14px;
    	font-weight: bold;
    	text-align: center;
    }
    #status option:hover{
    	background-color: var(--secondary-color) !important;
    }
	.fa-arrow-alt-circle-left{
		font-size: 20px;
	    margin: 5px;
	}
	.fa-arrow-alt-circle-left:hover{
		cursor: pointer;
		font-weight: bold;
	}
	hr {
	  border-top: 1px solid rgba(0, 0, 0, .1) !important;
	  margin: 10px 0;
	}
	.container nav{
		display:flex;
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
	@media ( min-width :1200px) {
		.container {
			max-width: 100% !important;
		}
	}
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"/>
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="document">결재문서</h3>
			<h3 class="text">>&nbsp;&nbsp;대기</h3>
		</div>
		<div class="docbox">
			<jsp:include page="documentModal.jsp"/>
			<!-- 받은 문서 -->
			<div class="table1">
				<table class="receivedTable myTable">
					<caption class="receivedCap caption">받은 문서</caption>
					<thead>
						<tr>
							<th>NO</th>
							<th>문서번호</th>
							<th>분류</th>
							<th>문서 제목</th>
							<th>기안자</th>
							<th>상신 날짜</th>
							<th>결재 상태</th>
							<th>
								<select id="status">
						          <option value="all">전체</option>
						          <option value="read">읽음</option>
						          <option value="unread">안읽음</option>
						        </select>
							</th>
						</tr>
					</thead>
					<tbody class="receivedList">
					</tbody>
				</table>
				<div class="container" id="receivedCont">
				    <nav aria-label="Page navigation">
				        <ul class="pagination" id="receivedPage"></ul>
				    </nav>
				</div>
			</div>
			<div class="table2">
				<!-- 보낸 문서 -->
				<table class="sentTable myTable">
					<caption class="sentCap caption">보낸 문서</caption>
					<thead>
						<tr>
							<th>NO</th>
							<th>문서번호</th>
							<th>분류</th>
							<th>문서 제목</th>
							<th>상신 날짜</th>
							<th>결재 상태</th>
						</tr>
					</thead>
					<tbody class="sentList">
					</tbody>
				</table>
				<div class="container" id="sentCont">
				    <nav aria-label="Page navigation">
				        <ul class="pagination" id="sentPage"></ul>
				    </nav>
				</div>
			</div>
		</div>
 	</div>
</body>
<script>
var showPage = 1;
var text = "대기";
pageCall(showPage);
var receivedData = []; 

function pageCall(page){
    console.log('pageCall');
    $.ajax({
        type: 'GET',
        url: 'documentList.ajax',
        data: {
        	'text': text,
            'page': page,  // 몇 페이지 보여줄지
            'cnt': 6      // 페이지당 보여줄 게시물 수
        },
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            if(data.receivedList.length>0){
            	receivedData = data.receivedList;
                received(data.receivedList);
	            // 받은 문서 페이징
	            $('#receivedPage').twbsPagination({
	                startPage: 1,
	                totalPages: data.receivedTotalPages,
	                visiblePages: 5,
	                onPageClick: function(evt, page){
	                    console.log("evt", evt);  // 클릭 이벤트
	                    console.log("page", page);  // 클릭한 페이지 번호
	                    receivedPageCall(page);
	                }
	            });
            }else{
            	var content = '<tr>';
        		content += '<td colspan="8"> 받은 문서가 없습니다. </td>';
        		content += '</tr>';
        		$('.receivedList').html(content);
            }                         
            if(data.sentList.length>0){
	            // 보낸 문서
	            sent(data.sentList);
	            // 보낸 문서 페이징
	            $('#sentPage').twbsPagination({
	                startPage: 1,
	                totalPages: data.sentTotalPages,
	                visiblePages: 5,
	                onPageClick: function(evt, page){
	                    console.log("evt", evt);  // 클릭 이벤트
	                    console.log("page", page);  // 클릭한 페이지 번호
	                    sentPageCall(page);
	                }
	            });
            }else{
            	var content = '<tr>';
        		content += '<td colspan="6"> 보낸 문서가 없습니다. </td>'
        		content += '</tr>';
        		$('.sentList').html(content);
            
            }
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

// 받은 문서 리스트
function received(document) {
	
    var content = '';
	var i = 1;
	for(var item of document){
		console.log(item.form_subject)
		content += '<tr>';
		content += '<td>' + i++ + '</td>';
		content += '<td>' + item.doc_number + '</td>';
		content += '<td>' + item.form_subject + '</td>';
		content += '<td onclick="draftDetail(' + item.doc_idx + ')">' + item.doc_subject + '</td>';
		content += '<td>' + item.name + '</td>';
		
		var doc_date = new Date(item.doc_date);
		var docDate = doc_date.toISOString().split('T')[0];

		content += '<td>' + docDate + '</td>';
		content += '<td>' + item.status + '</td>';
		content += '<td>' + 
		    (item.doc_read == false
		        ? '<a href="javascript:void(0);" class="update" data-doc-idx="'+ item.doc_idx + '"><i class="fas fa-envelope" title="읽지 않음"></i></a>'
		        : '<a href="javascript:void(0);" class="update" data-doc-idx="'+ item.doc_idx + '"><i class="fas fa-envelope-open-text" title="읽음"></i></a>') +
		'</td>';
		
		content += '</tr>';
	}
	$('.receivedList').html(content);
}

// 보낸 문서 리스트
function sent(document) {
	
    var content = '';
	var i = 1;
	for(var item of document){
		console.log(item.form_subject)
		content += '<tr>';
		content += '<td>' + i++ + '</td>';
		content += '<td>' + item.doc_number + '</td>';
		content += '<td>' + item.form_subject + '</td>';
		content += '<td onclick="draftDetail(' + item.doc_idx + ')">' + item.doc_subject + '</td>';
		
		var doc_date = new Date(item.doc_date);
		var docDate = doc_date.toISOString().split('T')[0];

		content += '<td>' + docDate + '</td>';
		content += '<td>' + item.status + '</td>';
		content += '</tr>';
	}
	$('.sentList').html(content);
}


// 받은 문서
function receivedPageCall(page) {
    $.ajax({
        type: 'GET',
        url: 'documentList.ajax',
        data: {
        	'text': text,
            'page': page,
            'cnt': 6
        },
        dataType: 'JSON',
        success: function(data) {
        	received(data.receivedList);
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}
// 보낸 문서
function sentPageCall(page) {
    $.ajax({
        type: 'GET',
        url: 'documentList.ajax',
        data: {
        	'text': text,
            'page': page,
            'cnt': 6
        },
        dataType: 'JSON',
        success: function(data) {
        	sent(data.sentList);
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

$(document).on('click', '.update', function() {
    var doc_idx = $(this).data('doc-idx'); // 클릭된 요소의 data-doc-idx 값을 가져옴
    var icon = $(this).find('i'); // 클릭된 요소의 아이콘을 찾음
    var doc_read = icon.hasClass('fa-envelope') ? 1 : 0; // 아이콘 상태에 따라 doc_read 값을 설정

    $.ajax({
        url: 'updateRead.ajax',
        method: 'POST',
        data: {
            doc_idx: doc_idx,
            doc_read: doc_read
        },
        success: function(response) {
            if (response.success) {
                // 서버 응답 후, 아이콘을 즉시 업데이트
                if (doc_read == 1) {
                    icon.removeClass('fa-envelope').addClass('fa-envelope-open-text').attr('title', '읽음');
                } else {
                    icon.removeClass('fa-envelope-open-text').addClass('fa-envelope').attr('title', '읽지 않음');
                }
            } else {
                alert('상태 업데이트 실패');
            }
        },
        error: function(error) {
            console.error('에러:', error);
            alert('에러 발생');
        }
    });
});

// 읽음, 읽지 않음 옵션 선택
$('#status').change(function() {
    var status = $(this).val();  // 읽음/안읽음 상태
    var filteredData = [];

    // 상태에 맞춰서 데이터 필터링
    if (status == 'read') {
        filteredData = filterRead(receivedData, 1);
    } else if (status == 'unread') {
        filteredData = filterRead(receivedData, 0);
    } else {
        filteredData = receivedData;  // 전체 보기
    }

    // 필터링된 데이터를 화면에 갱신
    received(filteredData);

    // 필터링된 데이터에 맞는 전체 페이지 수 갱신
    var totalPages = Math.ceil(filteredData.length / 6);  // 6개씩 페이지 나누기
    $('#receivedPage').twbsPagination('destroy');  // 기존 페이지네이션 초기화
    $('#receivedPage').twbsPagination({
        startPage: 1,
        totalPages: totalPages,  // 필터링된 데이터에 맞는 페이지 수
        visiblePages: 5,
        onPageClick: function(evt, page) {
            console.log("page", page);
            receivedPageCall(page);
        }
    });
});
//필터링 함수 (읽음 상태에 맞는 필터링)
function filterRead(data, readStatus) {
    var result = [];
    for (var i = 0; i < data.length; i++) {
        if (data[i].doc_read == true) {
            result.push(data[i]);
        }
    }
    return result;
}

</script>
</html>
