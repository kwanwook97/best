<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="resources/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
	.dashboard-body{
		transform: scale(0.9);
	    margin-left: 22vw;
        width: 70vw;
	    margin-top: 2vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: flex-start;
	    justify-content: center;
	}
	.maintext{
	    width: 27%;
	    display: flex	;
	    margin-left: -12vw;
	    margin-bottom: 40px;
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
		width: 92%;
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
	table.myTable th:nth-child(1) {
        width: 5.11%;
    }
    table.myTable th:nth-child(2) {
        width: 11.11%;
    }
    table.myTable th:nth-child(3) {
        width: 13.51%;
    }
    table.myTable th:nth-child(4) {
        width: 40.54%;
    }
    table.myTable th:nth-child(5) {
        width: 13.51%;
    }
    table.myTable th:nth-child(6) {
        width: 8.11%;
    }
    table.myTable th:nth-child(7) {
        width: 8.11%;
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
		color: var(--primary-color);
		background-color: var(--background-color);
		border: var(--background-color) !important;
		font-family: 'Arial', sans-serif;
		font-size: 16px;
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
	  box-shadow: none;
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
			<span class="document">결재문서</span>
			<i class="fa-solid fa-angle-right" style="color: #8B6AA7;"></i>
			<span class="text">임시저장</span>
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
						<th>작성일</th>
						<th>상태</th>
						<th><i class="fas fa-trash-alt delete-icon"></i></th>
					</tr>
				</thead>
				<tbody class="sentList">
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
var showPage = 1;
var text = "임시저장";
var cnt = 15;
pageCall(showPage);

function pageCall(page){

    $.ajax({
        type: 'GET',
        url: 'documentList.ajax',
        data: {
        	'text': text,
            'page': page,
            'cnt': 15
        },
        dataType: 'JSON',
        success: function(data) {
        	var startNumber = (page - 1) * cnt + 1;
            if(data.sentList.length>0){
            	Print(data.sentList,startNumber);
	            
	            $('#Pagination').twbsPagination({
	                startPage: 1,
	                totalPages: data.sentTotalPages,
	                visiblePages: 5,
	                onPageClick: function(evt, page){
	                    console.log("evt", evt);
	                    console.log("page", page);
	                    pageCall(page);
	                }
	            });
            }else{
            	var content = '<tr>';
        		content += '<td colspan="7"> 임시저장 문서가 없습니다. </td>'
        		content += '</tr>';
        		$('.sentList').html(content);
            }
        },
        error: function(e) {
            console.log("오류 발생", e);
        }
    });
}

// 임시저장 리스트
function Print(document,startNumber) {
	
    var content = '';
	var i = startNumber;
	for(var item of document){
		content += '<tr>';
		content += '<td>' + i++ + '</td>';
		content += '<td>' + item.doc_number + '</td>';
		content += '<td>' + item.form_subject + '</td>';
		if (item.doc_subject && String(item.doc_subject).trim().length > 0) {
		    content += '<td onclick="draftDetail(' + item.doc_idx + ')">' + item.doc_subject + '</td>';
		} else {
		    content += '<td onclick="draftDetail(' + item.doc_idx + ')">제목 없음</td>';
		}

		var date = new Date(item.doc_date);
		var formattedDate = date.toISOString().split('T')[0];

		content += '<td>' + formattedDate + '</td>';
		content += '<td>' + item.status + '</td>';
		
		content += '<td><a href="javascript:void(0);" class="delete" data-doc-idx="'+item.doc_idx+'"><i class="fas fa-trash-alt delete-icon"></i></a></td>';
		content += '</tr>';
	}
	$('.sentList').html(content);
	
	$('.delete').click(function() {
        var doc_idx = $(this).data('doc-idx');
        $.ajax({
            type: 'POST',
            url: 'documentDelete.ajax',
            data: { doc_idx: doc_idx },
            success: function(response) {
                if (response.success) {
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
        	open(response); 
        },
        error: function(xhr, status, error) {
            console.error('문서 요청 실패:', error);
        }
    });
}

//모달 열기
function open(content) {
    var modalId = 'modal-' + new Date().getTime();
    // 모달 HTML 생성
    var Html = 
        '<div id="' + modalId + '" class="modal" style="display: none;">' +
        '  <div class="modal-content">' +
        '    <div class="modal-box">' +
        '      <button class="modal-btn Approve" onclick="btnAction(\'수정기안\')">기안</button>' +
        '      <button class="modal-btn save" onclick="btnAction(\'수정\')">수정</button>' +
        '      <button class="modal-btn append" onclick="refOpenUserBoxModal()">참조자 추가</button>' +
        '      <button class="modal-btn append" onclick="openUserBoxModal()">결재선 추가</button>' +
        '      <span class="close-btn" data-modal-id="' + modalId + '">X</span>' +
        '    </div>' +
        '    <div class="content" contenteditable="true">' + content + '</div>' +
        '  </div>' +
        '</div>';

    $('body').append(Html);

    $('#' + modalId).show();

    // 닫기 버튼 이벤트 등록 (이벤트 위임)
    $(document).on('click', '.close-btn', function() {
        var targetModalId = $(this).data('modal-id');
        $('#' + targetModalId).remove();
    });
}

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



</script>
</html>
