<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
  <style>
	.dashboard-body{
		transform: scale(0.9);
	    margin-left: 22vw;
	    width: 70vw;
	    margin-top: 6vh;
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
        width: 22%;
	    display: flex;
	    margin-left: -46vw;
	    margin-bottom: 10px;
	    justify-content: space-between;
	    align-items: baseline;	
	}
	.maintext i,
	.maintext span{
		font-size: 36px !important;
		font-weight: bold !important;
	}
	.maintext span:first-child{
		color: var(--secondary-color);
	}
	.docbox{
		position: absolute;
	    top: 108px;
	    border: 2px solid var(--primary-color);
	    width: 100%;
	    min-height: 765px;
	    border-radius: 10px;
	}
	.opt div:nth-child(5){
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div:nth-child(5) a{
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
	    width: 1203px;
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
	    width: 14%;
	}
	table.receivedTable th:nth-child(4) {
	    width: 30%;
	}
	table.receivedTable th:nth-child(5) {
	    width: 14%;
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
	div.content_emp div.modal-box{
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
			<span class="document">결재문서</span>
			<i class="fa-solid fa-angle-right" style="color: #8B6AA7;"></i>
			<span class="text">참조</span>
		</div>
		<div class="docbox">
			<jsp:include page="documentModal.jsp"/>
			<!-- 받은 문서 -->
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
							<select id="status" onchange="pageCall(1, this.value)">
					          <option value="all">전체</option>
					          <option value="read">읽음</option>
					          <option value="unread">읽지않음</option>
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
 	</div>
</body>
<script>

var showPage = 1;
var text = "참조";
var readStatus = "all";
var cnt = 15;

pageCall(showPage, readStatus);

function pageCall(page, readStatus){
    $.ajax({
        type: 'GET',
        url: 'documentList.ajax',
        data: {
        	'readStatus': readStatus,
        	'text': text,
            'page': page,
            'cnt': 15 
        },
        dataType: 'JSON',
        success: function(data) {
        	var startNumber = (page - 1) * cnt + 1;
                        
            if(data.receivedList.length>0){
                received(data.receivedList,startNumber);
                
	            $('#receivedPage').twbsPagination({
	                startPage: 1,
	                totalPages: data.receivedTotalPages,
	                visiblePages: 5,
	                onPageClick: function(evt, page){
	                    console.log("evt", evt);
	                    console.log("page", page);
	                    receivedPageCall(page, readStatus);
	                }
	            });
            }else{
            	if(readStatus === 'all'){
	            	var content = '<tr>';
	        		content += '<td colspan="8"> 받은 문서가 없습니다. </td>';
	        		content += '</tr>';            	
            	}else if(readStatus === 'read'){
            		var content = '<tr>';
	        		content += '<td colspan="8"> 읽은 문서가 없습니다. </td>';
	        		content += '</tr>';    
            	}else if(readStatus === 'unread'){
            		var content = '<tr>';
	        		content += '<td colspan="8"> 읽지않은 문서가 없습니다. </td>';
	        		content += '</tr>';    
            	}
        		$('.receivedList').html(content);
            }
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

// 받은 문서 리스트
function received(document,startNumber) {
	
    var content = '';
	var i = startNumber;
	for(var item of document){
		content += '<tr>';
		content += '<td>' + i++ + '</td>';
		content += '<td>' + item.doc_number + '</td>';
		content += '<td>' + item.form_subject + '</td>';
		content += '<td onclick="receivedDetail(' + item.doc_idx + ')">' + item.doc_subject + '</td>';
		content += '<td>' + item.name +'('+item.depart_name+'/'+item.rank_name+')</td>';
		
		var doc_date = new Date(item.doc_date);
		var docDate = doc_date.toISOString().split('T')[0];

		content += '<td>' + docDate + '</td>';
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

// 받은 문서
function receivedPageCall(page, readStatus) {
	var startNumber = (page - 1) * cnt + 1;
    $.ajax({
        type: 'GET',
        url: 'documentList.ajax',
        data: {
        	'readStatus': readStatus,
        	'text': text,
            'page': page,
            'cnt': 15
        },
        dataType: 'JSON',
        success: function(data) {
        	received(data.receivedList,startNumber);
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
