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
	    width: -webkit-fill-available;
	    height: 745px;
	    border-radius: 10px;
	}
	.opt div:nth-child(6){
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div:nth-child(6) a{
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
		width: -webkit-fill-available;
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
	.saveList tr td:hover:nth-child(4) {
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
	table.myTable td:nth-child(1) {
        width: 3%;
    }
    table.myTable td:nth-child(2) {
        width: 3%;
    }
    table.myTable td:nth-child(3) {
        width: 5%;
    }
    table.myTable td:nth-child(4) {
        width: 15%;
    }
    table.myTable td:nth-child(5) {
        width: 5%;
    }
    table.myTable td:nth-child(6) {
        width: 3%;
    }
    table.myTable td:nth-child(7) {
        width: 3%;
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
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"/>
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="document">결재문서</h3>
			<h3>>&nbsp;&nbsp;임시저장</h3>
		</div>
		<div class="docbox">
			<jsp:include page="documentModal.jsp"/>
			<table class="table1 myTable">
				<caption class="receivedCap caption">임시 저장된 문서</caption>
				<thead>
					<tr>
						<th>NO</th>
						<th>문서번호</th>
						<th>분류</th>
						<th>문서 제목</th>
						<th>기안일</th>
						<th>결재 상태</th>
						<th ></th>
					</tr>
				</thead>
				<tbody class="saveList">
				</tbody>
			</table>
			<div class="container" id="cont">
			    <nav aria-label="Page navigation">
			        <ul class="pagination" id="Pagination"></ul>
			    </nav>
			</div>
		</div>
 	</div>
</body>
<script>
var showPage = 1; // 기본으로 보여줄 페이지
var text = "임시저장";
pageCall(showPage);

function pageCall(page){
    console.log('pageCall');

    $.ajax({
        type: 'GET',
        url: 'documentList.ajax',
        data: {
        	'text': text,
            'page': page,  // 몇 페이지 보여줄지
            'cnt': 15       // 페이지당 보여줄 게시물 수
        },
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            if(data.saveList.length>0){
            	Print(data.saveList);
	            // 페이징
	            $('#Pagination').twbsPagination({
	                startPage: 1,
	                totalPages: data.totalPages,
	                visiblePages: 5,
	                onPageClick: function(evt, page){
	                    console.log("evt", evt);  // 클릭 이벤트
	                    console.log("page", page);  // 클릭한 페이지 번호
	                    pageCall(page);
	                }
	            });
            }else{
            	var content = '<tr>';
        		content += '<td colspan="7"> 임시저장 문서가 없습니다. </td>'
        		content += '</tr>';
        		$('.saveList').html(content);
            }
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

// 임시저장 리스트
function Print(document) {
	
    var content = '';
	var i = 1;
	for(var item of document){
		console.log(item.form_subject)
		content += '<tr>';
		content += '<td>' + i++ + '</td>';
		content += '<td>' + item.doc_number + '</td>';
		content += '<td>' + item.form_subject + '</td>';
		content += '<td onclick="draftDetail(' + item.doc_idx + ')">' + item.doc_subject + '</td>';

		var date = new Date(item.doc_date);
		var formattedDate = date.toISOString().split('T')[0];

		content += '<td>' + formattedDate + '</td>';
		content += '<td>' + item.status + '</td>';
		
		content += '<td><a href="javascript:void(0);" class="delete" data-doc-idx="'+item.doc_idx+'"><i class="fas fa-trash-alt delete-icon"></i></a></td>';
		content += '</tr>';
	}
	$('.saveList').html(content);
	
	$('.delete').click(function() {
        var doc_idx = $(this).data('doc-idx');
        console.log(doc_idx);
        $.ajax({
            type: 'POST',
            url: 'documentDelete.ajax',
            data: { doc_idx: doc_idx },
            success: function(response) {
                if (response.success) {
                    console.log('삭제');
                    pageCall(showPage);
                } else {
                	console.log('삭제 실패');
                }
            },
            error: function(e) {
                console.log(e);
            }
        });
    });
}

// 임시저장 상세보기
function draftDetail(doc_idx) {
    $.ajax({
        type: 'GET',
        url: 'draftDetail.ajax',
        data: { doc_idx: doc_idx },
        dataType: 'text',
        success: function(response) {
        	console.log("Response HTML: ", response);  // 서버에서 받은 HTML 확인
        	open(response); 
        },
        error: function(xhr, status, error) {
            console.error('문서 요청 실패:', error);
        }
    });
}

//모달 열기
function open(cont) {
    var modalId = 'modal-' + new Date().getTime(); // 유니크한 ID 생성
    // 모달 HTML 생성
    var Html = 
        '<div id="' + modalId + '" class="modal" style="display: none;">' +
        '  <div class="modal-content">' +
        '    <div class="modal-box">' +
        '      <button class="modal-btn Approve" onclick="btnAction(\'기안\')">기안</button>' +
        '      <button class="modal-btn save" onclick="updateBtn()">수정</button>' +
        '      <button class="modal-btn append" onclick="button3Action(\'결재선\')">결재선 추가</button>' +
        '      <span class="close-btn" data-modal-id="' + modalId + '">X</span>' +
        '    </div>' +
        '    <div class="cont" contenteditable="true">' + cont + '</div>' +
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

function updateBtn() {
    var doc_idx = $('input[name="doc_idx"]').val(); 
    var doc_subject = $('input[name="doc_subject"]').val();
    var textareaValue = $('.modal-content:last-child textarea').val();
    var updatedHtml = $('.modal-content:last-child').html();
    var start_date = $('input[name="start_date"]').val();
    var end_date = $('input[name="end_date"]').val();
    
    // 동적으로 추가된 input 값들을 values 배열에 저장
    var values = [];
    $('input[data-index]').each(function() {
        values.push($(this).val());    
    });

    // HTML 수정
    updatedHtml = updatedHtml.replace(
        /<input([^>]*name=["']doc_subject["'][^>]*)>/,
        '<input$1 value="' + doc_subject + '">'
    );
    updatedHtml = updatedHtml.replace(
        /<textarea[^>]*>.*?<\/textarea>/,
        '<textarea>' + textareaValue + '</textarea>'
    );
    $('.modal-content:last-child').html(updatedHtml);

    var doc_content = $('.modal-content:last-child .content').html();

    var data = {
        form_idx: $('input[name="form_idx"]').val(),
        doc_subject: doc_subject,
        doc_content: doc_content,
        doc_idx: doc_idx 
    };

    // 추가적으로 필요한 데이터 추가
    switch (data.form_idx) {
        case '1':
            updatedHtml = updatedHtml.replace(
                /<input([^>]*name=["']start_date["'][^>]*)>/,
                '<input$1 value="' + start_date + '">'
            );
            updatedHtml = updatedHtml.replace(
                /<input([^>]*name=["']end_date["'][^>]*)>/,
                '<input$1 value="' + end_date + '">'
            );
            $('.modal-content:last-child').html(updatedHtml);
            data.start_date = start_date;
            data.end_date = end_date;
            break;
        case '3':
            for (var i = 0; i < values.length; i++) {
                var value = values[i];
                var dataIndex = i + 1;
                updatedHtml = updatedHtml.replace(
                    new RegExp('<input([^>]*data-index=["\']' + dataIndex + '["\'][^>]*)>', 'g'),
                    '<input$1 value="' + value + '">'
                );
            }
            $('.modal-content:last-child').html(updatedHtml);
            break;
    }

    // 수정된 데이터를 서버로 전송
    $.ajax({
        type: 'POST',
        url: 'formUpdate.ajax',
        data: data,
        success: function(response) {
            alert(response.message);
            if (response.success) {
                location.reload();
            } else {
                // 실패 처리
            }
        }
    });
}


</script>
</html>
