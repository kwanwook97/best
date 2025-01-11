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
	.comment-list{
	    width: 100%;
		display: flex;
	    justify-content: center;
		border: 1px solid var(--primary-color);
	}
	.commentBox {
	    width: 822px;
		border-top: 1px solid var(--primary-color);
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
	.lastBox{
		display: flex;
	}
	.replyBtn{
		cursor: pointer;
	}
	.reply-list{
		margin-left: 50px;
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
	.autocomplete {
	    position: absolute;
	    background: white;
	    border: 1px solid #ccc;
	    max-height: 200px;
	    overflow-y: auto;
	    z-index: 1000;
	}
	
	.autocomplete-item {
	    padding: 5px;
	    cursor: pointer;
	}
	
	.autocomplete-item:hover {
	    background-color: #f0f0f0;
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
						<div class="commentBox">
						</div>
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
	var boardAuthor = ${info.emp_idx};
	var emp_idx = "${sessionScope.loginId}";
	var emp_name = "${sessionScope.loginName}";
	
	var showPage = 1;

	loadComments(board_idx, showPage);

	function loadComments(board_idx, page) {
	    $.ajax({
	        type: 'GET',
	        url: 'commentList.ajax',
	        data: {
	            board_idx: board_idx,
	            page: page,
	            cnt: 10
	        },
	        dataType: 'JSON',
	        success: function(response) {
	        	console.log("뭔데: ", response.comments);
	            printComment(response.comments);
	            
	            $('#commentPagination').twbsPagination('destroy');
	            if (response.totalPages > 0) {
	                $('#commentPagination').twbsPagination({
	                    startPage: page,
	                    totalPages: response.totalPages,
	                    visiblePages: 5,
	                    onPageClick: function(evt, page) {
	                    	pageCallLoad(board_idx, page);
	                    }
	                });
	            }
	        },
	        error: function(e) {
	            alert('댓글 로드 중 오류가 발생했습니다.');
	            console.error(e);
	        }
	    });
	}

	function printComment(comments) {
	    var commentHtml = '';

	    // 원 댓글 렌더링
	    for (var item of comments) {
	        if (item.parent_idx < 1) {
	            commentHtml += 
	                '<div class="comment-item" id="comment-' + item.comment_idx + '">' +
	                    '<strong>' + item.emp_name + '</strong>' +
	                    '<input type="hidden" value="'+item.emp_idx+'">'+
	                    '<div class="comment-content">' + item.content + '</div>' +
	                    '<div class="lastBox">' +
	                        '<div class="comment-date">' + formatDate(item.com_date) + '</div>' +
	                        '<div class="replyBtn" onclick="toggleReplyBox(' + item.comment_idx + ')">💬 댓글 쓰기</div>' +
	                    '</div>' +
	                '</div>' +
	                '<div class="reply-list" id="replies-' + item.comment_idx + '"></div>';
	        }
	    }

	    // 원 댓글 HTML 추가
	    $('.commentBox').html(commentHtml);

	    // 대댓글 렌더링
	    for (var item of comments) {
	        if (item.parent_idx > 0) {
	            var replyHtml = 
	                '<div class="reply-item" id="reply-' + item.comment_idx + '">' +
	                    '<strong>' + item.emp_name + '</strong>' +
	                    '<input type="hidden" id="taggedEmpIdx" value="'+item.emp_idx+'">'+
	                    '<div class="comment-content">' + item.content + '</div>' +
	                    '<div class="comment-date">' + formatDate(item.com_date) + '</div>' +
	                '</div>';
	            
	            // 부모 댓글의 대댓글 리스트에 추가
	            $('#replies-' + item.parent_idx).append(replyHtml);
	        }
	    }
	}

	// 댓글 쓰기 박스 토글 함수
	function toggleReplyBox(commentIdx) {
	    var replyBoxId = "#replyBox-" + commentIdx;
	    var existingReplyBox = $(replyBoxId);
	
	    if (existingReplyBox.length > 0) {
	        // 이미 존재하는 경우 삭제 (댓글 쓰기 박스 닫기)
	        existingReplyBox.remove();
	    } else {
	        // 다른 댓글에 열린 박스가 있으면 닫기
	        $('.replyBox').remove();
	
	        // 새로운 박스 생성
	        var replyBoxHtml = 
	            '<div class="replyBox" id="replyBox-' + commentIdx + '">' +
	                '<textarea id="replyInput-' + commentIdx + '" placeholder="댓글을 입력하세요. 300자 이내" maxlength="300"></textarea>' +
	                '<p class="replycharCount" id="replycharCount-' + commentIdx + '">0 / 300</p>' +
	                '<div class="autocomplete" id="autocomplete-' + commentIdx + '"></div>'+
	                '<button onclick="addReply(' + commentIdx + ')">댓글 작성</button>' +
	                '<button onclick="toggleReplyBox(' + commentIdx + ')">취소</button>' +
	            '</div>';
	        
	        // 해당 댓글 바로 아래 추가
	        $('#comment-' + commentIdx).after(replyBoxHtml);
	
	     	// @ 입력 시 대댓글 작성자 목록 표시
	        $('#replyInput-' + commentIdx).on('input', function(e) {
	            var value = $(this).val();
	            if (value.endsWith('@')) {
	                // 대댓글 작성자 목록 가져오기
	                var replyAuthors = getReplyAuthors(commentIdx);
	                if (replyAuthors.length > 0) {
	                    var autocompleteList = replyAuthors.map(function(author) {
	                        return '<div class="autocomplete-item" onclick="selectUser(' + commentIdx + ', \'' + author.name + '\', \'' + author.empIdx + '\')">' + author.name + '</div>';
	                    }).join('');
	                    $('#autocomplete-' + commentIdx).html(autocompleteList).show();
	                } else {
	                    $('#autocomplete-' + commentIdx).hide(); // 대댓글 작성자가 없으면 숨기기
	                }
	            } else {
	                $('#autocomplete-' + commentIdx).hide();
	            }
	        });

	    }
	}

	// 특정 댓글의 대댓글 작성자 목록 추출
	function getReplyAuthors(commentIdx) {
	    var authors = [];
	    var loggedInEmpIdx = emp_idx; // 현재 로그인한 사용자의 emp_idx

	    $('#replies-' + commentIdx + ' .reply-item').each(function() {
	        var replyAuthor = $(this).find('strong').text(); // 대댓글 작성자의 이름
	        var replyEmpIdx = $(this).find('input[type="hidden"]').val(); // 대댓글 작성자의 emp_idx

	        // 자신을 제외하고 중복되지 않는 작성자만 추가
	        if (replyEmpIdx !== loggedInEmpIdx && !authors.some(a => a.empIdx === replyEmpIdx)) {
	            authors.push({ name: replyAuthor, empIdx: replyEmpIdx });
	        }
	    });

	    return authors;
	}


	// 사용자 선택 시 텍스트 입력란에 추가
	function selectUser(commentIdx, user, empIdx) {
	    var input = $('#replyInput-' + commentIdx);
	    var value = input.val();

	    // 현재 입력 값에 선택된 사용자 이름 추가
	    input.val(value.slice(0, -1) + '@' + user + ' '); // '@' 포함하여 추가
	    input.data('tagged-emp-idx', empIdx); // 태그된 사용자 emp_idx 저장
	    $('#autocomplete-' + commentIdx).hide();
	}




	// 대댓글 작성 함수
	function addReply(parent_idx) {
	    var content = $('#replyInput-' + parent_idx).val().trim();
	    var taggedEmpIdx = $('#replyInput-' + parent_idx).data('tagged-emp-idx'); // 태그된 사용자의 empIdx
	    if (content === '') {
	        alert('댓글 내용을 입력하세요!');
	        return;
	    }
	
	    if (!taggedEmpIdx) {
	        // 태그된 사용자가 없으면 원댓글 작성자의 empIdx 가져오기
	        taggedEmpIdx = $('#comment-' + parent_idx).find('input[type="hidden"]').val();
	    }
	
	    $.ajax({
	        type: 'POST',
	        url: 'addReply.ajax',
	        data: {
	            parent_idx: parent_idx,
	            content: content,
	            board_idx: board_idx,
	            emp_idx: emp_idx,
	            emp_name: emp_name,
	            taggedEmpIdx: taggedEmpIdx
	        },
	        success: function(response) {
	            alert('댓글이 작성되었습니다!');
	            toggleReplyBox(parent_idx);
	            loadComments(board_idx, 1); // 댓글 새로고침
	        },
	        error: function(error) {
	            alert('댓글 작성 중 오류가 발생했습니다.');
	            console.error(error);
	        }
	    });
	}

	// 날짜 포맷 함수
	function formatDate(dateString) {
	    var date = new Date(dateString);
	    return date.toISOString().split('T')[0];
	}


	function pageCallLoad(board_idx, page){
	    $.ajax({
	        type: 'GET',
	        url: 'commentList.ajax',
	        data: {
	            board_idx: board_idx,
	            page: page,
	            cnt: 10
	        },
	        dataType: 'JSON',
	        success: function(response) {
	            printComment(response.comments);	            
	        },
	        error: function(e) {
	            alert('댓글 로드 중 오류가 발생했습니다.');
	            console.error(e);
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
	            board_idx: board_idx,
	            content: content,
	            emp_idx: emp_idx,
	            emp_name: emp_name,
	            boardAuthor: boardAuthor
	        },
	        success: function(response) {
	            alert('댓글이 작성되었습니다.');
	            $('#commentInput').val('');
	            loadComments(board_idx, 1); 
	        },
	        error: function(e) {
	            alert('댓글 작성 중 오류가 발생했습니다.');
	            console.error(e);
	        }
	    });
	}


	// 댓글 입력 시 글자 수 표시
	$('#commentInput').on('input', function() {
	    var charCount = $(this).val().length;
	    $('#charCount').text(charCount + ' / 300');
	});
	
	


</script>
</html>