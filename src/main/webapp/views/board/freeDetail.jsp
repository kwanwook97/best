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
  
  <style>
	.dashboard-body{
	    margin-left: 15vw;
	    margin-top: 7vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    color: var(--primary-color);
	    height: 92%;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: center;
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
	.docbox{
	    position: relative;
	    border: 2px solid var(--primary-color);
        width: 1000px;
    	min-height: 640px;
    	border-radius: 10px;
   	    padding: 15px 5px;
		display: flex;
		justify-content: center;
	}
	.contentBox{
		width: 950px;
		min-height: 640px; 
	}
	.doc-header{
		border-bottom: 1px solid var(--primary-color);
	}
	.doc-content{
	    min-height: 200px;
        border-bottom: 1px solid var(--primary-color);
	}
	.doc-content p{
	    padding: 10px;
	}
	.reaction-section {
		display: flex;
		justify-content: space-between;
		align-items: center;
		border-top: 1px solid var(--primary-color);
		padding-top: 10px;
		margin-top: 20px;
		font-size: 0.9em;
		color: gray;
	}
	.comment-section {
		margin-top: 30px;
	}
	.comment-box textarea {
		width: 100%;
		height: 80px;
		border-radius: 10px;
		padding: 10px;
		border: 1px solid var(--primary-color);
		resize: none;
		font-size: 14px;
	}
	.comment-box button {
		width: 100px;
		margin-top: 10px;
		align-self: flex-end;
		background-color: var(--primary-color);
		color: white;
		border: none;
		border-radius: 10px;
		padding: 5px;
	}
	.comment-list {
		border-top: 1px solid var(--primary-color);
		padding-top: 10px;
	}
	.comment-item {
		border: 1px solid var(--primary-color);
		border-radius: 10px;
		padding: 10px;
		margin-bottom: 10px;
		background-color: #f9f9f9;
	}
	.comment-item strong {
		font-weight: bold;
		color: var(--primary-color);
	}
	.comment-item p {
		margin: 5px 0;
		font-size: 0.9em;
	}
	
	table{
		width: 45vw;
		height: 36rem;
		border-radius: 10px;
		margin: 33px 48px 55px 48px;
		border-collapse: separate !important;
        border-spacing: 0;
	}
	table tr{
		height: 35px;
	}
	table tr:last-child{
   		padding: 20px;
		position: absolute;
		height: 490px;
	}
	table tr:not(:last-child) td{
		padding-left: 20px;
        border-bottom: 1px solid var(--primary-color) !important;
    }
	table tr:nth-child(3) td{
		overflow: auto;
		overflow-y: hidden;
	    max-width: 45vw;
    }
	td{
	    font-size: small;
	}
	.gobtn{
		position: absolute;
	    right: 50px;
	    bottom: 0;
	}
	input[type="button"]{
		width: 120px;	
		color: var(--primary-color);
		border-radius: 10px;
		border: 2px solid var(--secondary-color);
		background-color: var(--background-color);
	}
	input[type="button"]:hover{
		background-color: var(--accent-color);
	}
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="document">게시판</h3>
			<h3>>&nbsp;&nbsp;자유 게시판</h3>
		</div>
		<div class="docbox">
			<div class="contentBox">
				<!-- 게시글 헤더 -->
				<div class="doc-header">
					<h3>${info.subject}</h3>
					<p>작성자: ${info.name} | 작성일: ${info.date} | 조회수: ${info.bhit}</p>
				</div>
				<!-- 게시글 내용 -->
				<div class="doc-content">
					<p>${info.content}</p>
				</div>
				<!-- 댓글 섹션 -->
				<div class="comment-section">
					<h4>댓글</h4>
					<!-- 댓글 목록 -->
					<div class="comment-list">
					</div>
					<div class="container" id="commentCont">
					    <nav aria-label="Page navigation">
					        <ul class="pagination" id="commentPagination"></ul>
					    </nav>
					</div>
					<!-- 댓글 작성 -->
					<div class="comment-box">
						<textarea id="commentInput" placeholder="댓글을 입력하세요. 300자 이내" maxlength="300"></textarea>
						<p id="charCount">0 / 300</p>
						<button onclick="addComment()">댓글 작성</button>
					</div>
				</div>
			</div>
			<div class="gobtn">
			    <input type="button" value="리스트" onclick="location.href='freeBoard.go'"/>
			    <!-- 글 작성자와 로그인 사용자가 같을 때만 버튼 표시 -->
			    <c:if test="${info.name == sessionScope.loginName}">
			        <input type="button" value="수정하기" onclick="location.href='freeUpdate.go?idx=${info.board_idx}'"/>
			        <input type="button" value="삭제하기" onclick="location.href='freeDelete.go?idx=${info.board_idx}'"/>
			    </c:if>
			</div>
		</div>
 	</div>
</body>
<script>

	var board_idx = ${info.board_idx};
	var emp_idx = "${sessionScope.loginId}";
	var emp_name = "${sessionScope.loginName}";
	
	var showPage = 1;

	loadComments(showPage);

	var cnt = 5;

	// 댓글 목록 로드 및 페이지네이션 초기화
	function loadComments(boardIdx, page, itemsPerPage) {
	    $.ajax({
	        type: 'GET',
	        url: 'commentList.ajax',
	        data: {
	            board_idx: board_idx,
	            page: page,
	            cnt: itemsPerPage
	        },
	        dataType: 'JSON',
	        success: function(response) {
	            var commentList = $('.comment-list');
	            commentList.empty();
	
	            // 댓글과 대댓글 렌더링
	            for (var i = 0; i < response.comments.length; i++) {
	                var comment = response.comments[i];
	
	                // 원 댓글
	                var commentHtml = 
	                    '<div class="comment-item">' +
	                        '<strong>' + comment.emp_name + '</strong>' +
	                        '<div class="comment-content">' + comment.content + '</div>' +
	                        '<div class="comment-date">' + comment.date + '</div>' +
	                        '<div class="reply-list" id="replies-' + comment.comment_idx + '"></div>' +
	                    '</div>';
	                commentList.append(commentHtml);
	
	                // 대댓글 출력
	                if (comment.children && comment.children.length > 0) {
	                    var replyList = $('#replies-' + comment.comment_idx);
	                    for (var j = 0; j < comment.children.length; j++) {
	                        var reply = comment.children[j];
	                        var replyHtml = 
	                            '<div class="reply-item">' +
	                                '<strong>' + reply.emp_name + '</strong>' +
	                                '<div class="comment-content">' + reply.content + '</div>' +
	                                '<div class="comment-date">' + reply.date + '</div>' +
	                            '</div>';
	                        replyList.append(replyHtml);
	                    }
	                }
	            }
	
	            // 페이지네이션 처리
	            $('#commentPagination').twbsPagination('destroy');
	            $('#commentPagination').twbsPagination({
	                startPage: page,
	                totalPages: response.totalPages,
	                visiblePages: 5,
	                onPageClick: function(evt, page) {
	                    loadComments(boardIdx, page, itemsPerPage);
	                }
	            });
	        },
	        error: function(e) {
	            alert('댓글 로드 중 오류가 발생했습니다.');
	            console.log(e);
	        }
	    });
	}

	// 댓글 작성
	function addComment() {
	    var content = $('#commentInput').val().trim();
	    if (content === '') {
	        alert('댓글 내용을 입력해주세요!');
	        return;
	    }

	    $.ajax({
	        type: 'POST',
	        url: 'addComment.ajax',
	        data: {
	            board_idx: 101, // 게시판 ID
	            content: content,
	            emp_idx: 1, // 로그인된 사용자 ID
	            emp_name: '에이스' // 로그인된 사용자 이름
	        },
	        success: function(response) {
	            alert('댓글이 작성되었습니다.');
	            $('#commentInput').val(''); // 입력 필드 초기화
	            loadComments(1); // 첫 페이지로 댓글 목록 새로고침
	        },
	        error: function(e) {
	            alert('댓글 작성 중 오류가 발생했습니다.');
	            console.log(e);
	        }
	    });
	}

	// 댓글 입력 시 글자 수 표시
	$('#commentInput').on('input', function() {
	    var charCount = $(this).val().length;
	    $('#charCount').text(charCount + ' / 300');
	});

	// 페이지 로드 시 첫 페이지 댓글 로드
	$(document).ready(function() {
	    loadComments(1); // 첫 번째 페이지 댓글 로드
	});

</script>
</html>