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
	    height: 700px;
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
	table{
		border-collapse: separate !important;
        border-spacing: 0;
		width: -webkit-fill-available;
		border: 1px solid var(--primary-color);
		border-radius: 10px;
		margin: 0 48px 30px 48px;
	    text-align: center;
	}
	table.myTable tr:not(:last-child) td, table.myTable th {
        border-bottom: 1px solid var(--primary-color) !important;
    }
	table.myTable tr{
		border-bottom: 1px solid var(--primary-color);
		height: 35px;
	}
	table.myTable th, table.myTable td{
		padding-left: 10px;
   		text-align: inherit;
	}
	.saveList tr td:hover :nth-child(3) {
	    color: var(--accent-color);
	    cursor: pointer;
	}
	table.myTable th{
		background-color: var(--primary-color);
		border-radius: 9px 9px 0 0;
		color: white;
	    text-align: left;
	}
	table.myTable td:nth-child(1) {
        width: 3%;
    }
    table.myTable td:nth-child(2) {
        width: 3%;
    }
    table.myTable td:nth-child(3) {
        width: 15%;
    }
    table.myTable td:nth-child(4) {
        width: 5%;
    }
    table.myTable td:nth-child(5) {
        width: 5%;
    }
    table.myTable td:nth-child(6) {
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
				<thead>
					<tr>
						<th colspan="6">임시저장 문서</th>
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

pageCall(showPage);

function pageCall(page){
    console.log('pageCall');
    
    $.ajax({
        type: 'GET',
        url: 'saveList.ajax',
        data: {
            'page': page,  // 몇 페이지 보여줄지
            'cnt': 15       // 페이지당 보여줄 게시물 수
        },
        dataType: 'JSON',
        success: function(data) {
            console.log(data);
            $('.saveList').html('');
            Print(data.saveList);

            // 페이징
            $('#Pagination').twbsPagination({
                startPage: 1,
                totalPages: data.totalPages,
                visiblePages: 5,
                first: '<i class="fas fa-angle-double-left"></i>',
                prev: '<i class="fas fa-angle-left"></i>',
                next: '<i class="fas fa-angle-right"></i>',
                last: '<i class="fas fa-angle-double-right"></i>',
                onPageClick: function(evt, page){
                    console.log("evt", evt);  // 클릭 이벤트
                    console.log("page", page);  // 클릭한 페이지 번호
                }
            });
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
		content += '<tr>';
		content += '<td>' + i++ + '</td>';
		content += '<td>' + item.form_subject + '</td>';
		content += '<td onclick="draftDetail(' + item.doc_idx + ')">' + item.doc_subject + '</td>';

		var date = new Date(item.date);
		var formattedDate = date.toISOString().split('T')[0];

		content += '<td>' + formattedDate + '</td>';
		content += '<td>' + item.status + '</td>';
		
		content += '<td><a href="#" class="delete" data-doc-idx="'+item.doc_idx+'"><i class="fas fa-trash-alt delete-icon"></i></a></td>';
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

/* 
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
        '      <button class="modal-btn save" onclick="btnAction(\'임시저장\')">임시저장</button>' +
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
} */

// 임시저장 삭제


</script>
</html>
