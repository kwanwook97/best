<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
  <style>
	.dashboard-body{
		transform: scale(0.9);
	    margin-left: 22vw;
	    width: 70vw;
	    margin-top: 4vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    color: var(--primary-color);
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
		height: 740px;
	    border-radius: 10px;
	}
	.opt div:nth-child(3){
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div:nth-child(3) a{
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
	table.myTable th{
		background-color: var(--primary-color);
		color: white;
	}
	.receivedList tr td:hover:nth-child(4) {
	    color: var(--accent-color);
	    cursor: pointer;
	}
	.sentList tr td:hover:nth-child(4) {
	    color: var(--accent-color);
	    cursor: pointer;
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
	table.sentTable th:nth-child(7) {
	    width: 10%;
	}
	table.sentTable th:nth-child(8) {
	    width: 10%;
	}
	table.sentTable th:nth-child(9) {
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
	div.content div.modal-box{
		display: none;
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
			<h3 class="text">>&nbsp;&nbsp;완료</h3>
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
							<th>최종 결재 날짜</th>
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
			<!-- 보낸 문서 -->
			<div class="table2">
				<table class="sentTable myTable">
					<caption class="sentCap caption">보낸 문서</caption>
					<thead>
						<tr>
							<th>NO</th>
							<th>문서번호</th>
							<th>분류</th>
							<th>문서 제목</th>
							<th>상신 날짜</th>
							<th>최종 결재 날짜</th>
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
var text = "완료";
pageCall(showPage);

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
            	// 받은 문서
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
        		content += '<td colspan="8"> 받은 문서가 없습니다. </td>'
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
        		content += '<td colspan="7"> 보낸 문서가 없습니다. </td>'
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
		var approv_date = new Date(item.approv_date);
		var approvDate = approv_date.toISOString().split('T')[0];

		content += '<td>' + docDate + '</td>';
		content += '<td>' + approvDate + '</td>';
		content += '<td>' + item.status + '</td>';
		content += '<td>' + 
		    (item.doc_read == false
		        ? '<a href="javascript:void(0);" class="update" data-doc-idx="'+ item.doc_idx + '" data-approv-num="'+ item.approv_num + '"><i class="fas fa-envelope" title="읽지 않음"></i></a>'
		        : '<a href="javascript:void(0);" class="update" data-doc-idx="'+ item.doc_idx + '" data-approv-num="'+ item.approv_num + '"><i class="fas fa-envelope-open-text" title="읽음"></i></a>') +
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
		var approv_date = new Date(item.approv_date);
		var approvDate = approv_date.toISOString().split('T')[0];

		content += '<td>' + docDate + '</td>';
		content += '<td>' + approvDate + '</td>';
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

//모달 열기
function receivedOpen(content) {
    var modalId = 'modal-' + new Date().getTime(); // 유니크한 ID 생성
    // 모달 HTML 생성
    var Html = 
        '<div id="' + modalId + '" class="modal" style="display: none;">' +
        '  <div class="modal-content">' +
        '    <div class="modal-box">' +
        '      <span class="close-btn" data-modal-id="' + modalId + '">X</span>' +
        '    </div>' +
        '    <div class="content_emp" contenteditable="true">' + content + '</div>' +
        '  </div>' +
        '</div>';
        
    // body에 추가
    $('body').append(Html);

    // 모달 표시
    $('#' + modalId).show();

    // 닫기 버튼 이벤트 등록 (이벤트 위임)
    $(document).on('click', '.close-btn', function() {
        var targetModalId = $(this).data('modal-id');
        $('#' + targetModalId).remove();
    });
}
</script>
</html>
