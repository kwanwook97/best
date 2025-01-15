<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
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
	    min-height: 90%;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: center;
	    justify-content: center;
	}
	.maintext{
	    width: 20%;
	    display: flex;
	    margin-left: -67vw;
	    margin-bottom: 10px;
	    justify-content: space-between;
	    align-items: baseline;
	}
	.maintext i,
	.maintext span{
		font-size: 32px !important;
		font-weight: bold !important;
	}
	.maintext span:first-child{
		color: var(--secondary-color);
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
		width: 800px;
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
	    margin-top: 7px;
	}
	.comm{
	    font-size: 17px;
	    font-weight: bold;
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
		margin-top: 5px;
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
	}
	.commentBox {
	  	display: flex;
	    width: 822px;
	    margin-top: 10px;
	    flex-direction: column;
	}
	#charCount{
		padding-left: 5px;
	}
	.textBox{
		display: flex;
	    align-items: flex-end;
	    justify-content: space-between;
	}
	.comment-item {
        border-bottom: 1px solid var(--primary-color);
    	padding: 5px 37px;
	}
	.comment-item div{
	    margin-right: 10px;
	    margin-top: 1px;
	    transform: scale(0.99);
	}
	.empInfoBox{
		display: flex;
	}
	.empInfoBox strong{
		margin-right: 5px;
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
    	justify-content: space-between;
	}
	.comBox,
	.commBox{
		display: flex;
	}
	.commBox div:last-child{
		margin-left: 5px;
	}
	.replyBtn, .updateBtn, .deleteBtn{
		cursor: pointer;
	}
	.replyBtn:hover{
		font-weight: bold;
	}
	.updateBtn:hover{
		font-weight: bold;
	}
	.deleteBtn:hover{
		font-weight: bold;
	}
	.replyBox{
   		margin: 5px 36px;
	}
	.reply-item{
		padding: 8px 0 8px 36px;
	    border-bottom: 1px solid var(--primary-color);
	}
	.reply-item div{
		transform: scale(0.9);
	}
	.replyLastBox{
		display: flex;
	    justify-content: space-between;
	}
	.myBtn{
		display: flex;
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
	    right: 10px;
	    top: -42px;
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
	#commentCont{
   		display: flex;
	    flex-direction: row;
	    justify-content: center;
        margin-top: 7px;
	}
	.replyAddBtn{
	    width: 62px;
	    margin-top: 10px;
	    align-self: flex-end;
	    background-color: var(--primary-color);
	    color: white;
	    border: none;
	    border-radius: 10px;
	    padding: 5px;
	    font-size: smaller;
	    margin-right: 5px;
	}
	.replyCan{
        width: 62px;
	    margin-top: 10px;
	    align-self: flex-end;
	    background-color: var(--accent-color);
	    color: white;
	    border: none;
	    border-radius: 10px;
	    padding: 5px;
	    font-size: smaller;
	}
	.reArea{
		width: 400px;
	    height: 80px;
	    resize: none;
	}
	.replyArea{
		width: 400px;
	    height: 75px;
	    resize: none;
	    margin-right: 5px;
	}
	.comment-content{
		display: flex;
	}
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<span class="document">게시판</span>
			<i class="fa-solid fa-angle-right" style="color: #8B6AA7;"></i>
			<span>자유 게시판</span>
		</div>
		<div class="docbox">
			<div class="contentBox">
				<!-- 게시글 헤더 -->
				<div class="doc-header">
					<h3>${info.subject}</h3>
					<p>작성자: ${info.name}(${info.depart_name}/${info.rank_name}) | 작성일: ${fn:substringBefore(info.date, " ")} | 조회수: ${info.bhit}</p>
				</div>
				<!-- 게시글 내용 -->
				<div class="doc-content">
					<p>${info.content}</p>
				</div>
				<!-- 댓글 섹션 -->
				<div class="comment-section">
					<span class="comm">💬댓글</span>
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
						<textarea id="commentInput" placeholder="댓글을 입력하세요. 300자 이내" maxlength="299"></textarea>
						<div class="textBox">
							<p id="charCount">0 / 300</p>
							<button onclick="addComment()">댓글 작성</button>
						</div>
					</div>
				</div>
			</div>
			<div class="gobtn">
			    <input type="button" value="리스트" onclick="location.href='freeBoard.go'"/>
			    <!-- 글 작성자와 로그인 사용자가 같을 때만 버튼 표시 -->
			    <c:if test="${info.name == sessionScope.loginName}">
			        <input type="button" value="수정하기" onclick="location.href='freeUpdate.go?idx=${info.board_idx}'"/>
			        <input type="button" value="삭제하기" onclick="location.href='freeDelete.do?board_idx=${info.board_idx}'"/>
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
	loadCommentCount(board_idx);
	
	function loadCommentCount(board_idx){
		
		$.ajax({
		    url: 'commentsCount.ajax',
		    type: 'GET',
		    data: { board_idx: board_idx }, 
		    success: function(response) {
		    	console.log("enlwu"+response);
		    	$('.comm').append('('+response+')');
		    },
		    error: function(error) {
		        console.error('댓글 수 가져오기 실패:', error);
		    }
		});

	}	
	
	function loadComments(board_idx, page) {
	    $.ajax({
	        type: 'GET',
	        url: 'commentList.ajax',
	        data: {
	            board_idx: board_idx,
	            page: page,
	            cnt: 4
	        },
	        dataType: 'JSON',
	        success: function(response) {
	            console.log("뭐냤삘 ", response.childMap);
	            printComment(response);
	        	
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

/* 	function printComment(comments) {
	    var commentHtml = '';

	    // 원 댓글 렌더링
	    for (var item of comments) {
		    if (item.parent_idx < 1) {
		        commentHtml += 
		            '<div class="comment-item" id="comment-' + item.comment_idx + '">' +
		                '<strong>' + item.emp_name + '</strong>' +
		                '<input type="hidden" value="' + item.emp_idx + '">' +
		                '<div class="comment-content">' + item.content + '</div>' +
		                '<div class="lastBox">' +
		                    '<div class="comment-date">' + formatDate(item.com_date) + '</div>' +
		                    '<div class="replyBtn" onclick="toggleReplyBox(' + item.comment_idx + ')"> 💬 댓글쓰기</div>';
		
		        // 수정/삭제 버튼 추가 조건
		        if (item.emp_idx == emp_idx) {
		            commentHtml +=
		                '<div class="updateBtn" onclick="updateCom(' + item.comment_idx + ')">✏️ 수정하기</div>' +
		                '<div class="deleteBtn" onclick="deleteCom(' + item.comment_idx + ')">❌ 삭제</div>';
		        }
		
		        commentHtml +=
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
	    	            '<input type="hidden" id="taggedEmpIdx" value="' + item.emp_idx + '">' +
	    	            '<div class="comment-content">' + item.content + '</div>' +
	    	            '<div class="replyLastBox">' +
	    	                '<div class="comment-date">' + formatDate(item.com_date) + '</div>';
	    	    if (item.emp_idx == emp_idx) {
	    	        replyHtml +=
	    	                '<div class="updateBtn" onclick="updatReply(' + item.comment_idx + ')">✏️ 수정하기</div>' +
	    	                '<div class="deleteBtn" onclick="deleteReply(' + item.comment_idx + ')">❌ 삭제</div>';
	    	    }
	    	    replyHtml +=
	    	            '</div>' +
	    	        '</div>';
	    	}
	    	// 부모 댓글의 대댓글 리스트에 추가
	    	$('#replies-' + item.parent_idx).append(replyHtml);

	    } */
	    
/* 	    function printComment(response) {
	        var parentComments = response.parentComments; // 부모 댓글
	        var childMap = response.childMap;             // 대댓글 매핑

	        var commentHtml = '';

	        // 부모 댓글 렌더링
	        parentComments.forEach(function (parent) {
	            commentHtml += '<div class="comment-item" id="comment-' + parent.comment_idx + '">' +
                '<strong>' + parent.emp_name + '</strong>' +
                '<input type="hidden" value="' + parent.emp_idx + '">' +
                '<div class="comment-content">' + parent.content + '</div>' +
                '<div class="lastBox">' +
                    '<div class="comment-date">' + formatDate(parent.com_date) + '</div>' +
                    '<div class="replyBtn" onclick="toggleReplyBox(' + parent.comment_idx + ')"> 💬 댓글쓰기</div>';
		
		        // 수정/삭제 버튼 추가 조건
		        if (parent.emp_idx == emp_idx) {
		            commentHtml +=
		                '<div class="updateBtn" onclick="updateCom(' + parent.comment_idx + ')">✏️ 수정하기</div>' +
		                '<div class="deleteBtn" onclick="deleteCom(' + parent.comment_idx + ')">❌ 삭제</div>';
		        }
		
		        commentHtml +=
		                '</div>' +
		            '</div>' +
		            '<div class="reply-list" id="replies-' + parent.comment_idx + '"></div>';

	            // 대댓글 렌더링 (childMap에 있는 경우)
	            if (childMap[parent.comment_idx]) {
	                childMap[parent.comment_idx].forEach(function (reply) {
	                    commentHtml += '<div class="reply-item" id="reply-' + reply.comment_idx + '">' +
	    	            '<strong>' + reply.emp_name + '</strong>' +
	    	            '<input type="hidden" id="taggedEmpIdx" value="' + reply.emp_idx + '">' +
	    	            '<div class="comment-content">' + reply.content + '</div>' +
	    	            '<div class="replyLastBox">' +
	    	                '<div class="comment-date">' + formatDate(reply.com_date) + '</div>';
			    	    if (reply.emp_idx == emp_idx) {
			    	    	commentHtml +=
			    	                '<div class="updateBtn" onclick="updatReply(' + reply.comment_idx + ')">✏️ 수정하기</div>' +
			    	                '<div class="deleteBtn" onclick="deleteReply(' + reply.comment_idx + ')">❌ 삭제</div>';
			    	    }
			    	    commentHtml +=
			    	            '</div>' +
			    	        '</div>';
		                });
		            }
	        });

	        // HTML 업데이트
	        $('.commentBox').html(commentHtml);
	    } */

	    function printComment(response) {
	        var parentComments = response.parentComments || [];
	        var childMap = response.childMap || {};
			console.log("sdfsdf",childMap);
	        var commentHtml = '';
	        
	        // 부모 댓글 렌더링
	        parentComments.forEach(function (parent) {
	            commentHtml += 
	                '<div class="comment-item" id="comment-' + parent.comment_idx + '">' +
	                	'<div class="empInfoBox">' +
		                    '<strong>' + parent.emp_name+'</strong>' +
	                		'<div>('+parent.depart_name+'/'+parent.rank_name+')</div>' +
	                	'</div>' +
	                    '<input type="hidden" value="' + parent.emp_idx + '">' +
	                    '<div class="comment-content">' + parent.content + '</div>' +
	                    '<div class="lastBox">' +
	                    	'<div class="comBox">' +
		                        '<div class="comment-date">' + formatDate(parent.com_date) + '</div>' +
	                      		'<div class="replyBtn" onclick="toggleReplyBox(' + parent.comment_idx + ')"> 💬 댓글쓰기</div>' +
                      		'</div>';
	            // 수정/삭제 버튼 추가
	            if (parent.emp_idx == emp_idx) {
	                commentHtml +=
	                	'<div class="commBox">' +
	                    '<div class="updateBtn" onclick="updateCom(' + parent.comment_idx + ')">✏️ 수정하기</div>' +
	                    '<div class="deleteBtn" onclick="deleteCom(' + parent.comment_idx + ')">❌ 삭제</div>' +
	                    '</div>';
	            }
								
	            commentHtml += '</div></div>';

	            // 대댓글 리스트 컨테이너 생성
	            commentHtml += '<div class="reply-list" id="replies-' + parent.comment_idx + '"></div>';
	        });

	        // HTML 업데이트
	        $('.commentBox').html(commentHtml);

	        // 대댓글 렌더링 (부모 댓글과 별도 처리)
	        Object.keys(childMap).forEach(function (parentIdx) {
	            var replies = childMap[parentIdx];
	            replies.forEach(function (reply) {
	                var replyHtml = 
	                    '<div class="reply-item" id="reply-' + reply.comment_idx + '">' +
	                    	'<div class="empInfoBox">' +
			                    '<strong>' + reply.emp_name+'</strong>' +
		                		'<div>('+reply.depart_name+'/'+reply.rank_name+')</div>' +
		                	'</div>' +
	                        '<input type="hidden" id="taggedEmpIdx" value="' + reply.emp_idx + '">' +
	                        '<div class="comment-content">' + reply.content + '</div>' +
	                        '<div class="replyLastBox">' +
	                            '<div class="comment-date">' + formatDate(reply.com_date) + '</div>';
	                
	                if (reply.emp_idx == emp_idx) {
	                    replyHtml +=
	                    	'<div class="myBtn">' +
		                        '<div class="updateBtn" onclick="updatReply(' + reply.comment_idx + ')">✏️ 수정하기</div>' +
		                        '<div class="deleteBtn" onclick="deleteReply(' + reply.comment_idx + ')">❌ 삭제</div>' +
		                    '</div>';
	                }
	                
	                replyHtml += '</div></div>';

	                // 대댓글을 해당 부모 댓글의 reply-list에 추가
	                $('#replies-' + parentIdx).append(replyHtml);
	            });
	        });

	        // 이벤트 재바인딩
	        bindReplyInputEvents();
	        highlightMentions();

	    }
	 
	 
	 function highlightMentions() {
		    $('.commentBox .comment-content').each(function () {
		        var content = $(this).text();

		        // 모든 strong 태그의 텍스트 가져오기
		        var authors = $('.commentBox strong').map(function () {
		            return $(this).text();
		        }).get();

		        // 매칭된 부분 감싸기
		        authors.forEach(function (author) {
		            var regex = new RegExp('@' + author + '(?=\\s|$)', 'g');
		            content = content.replace(regex, function (match) {
		                return '<span class="highlight">' + match + '</span>';
		            });
		        });

		        $(this).html(content);
		    });
		}

		// 스타일 추가
		$('<style>')
		    .prop('type', 'text/css')
		    .html('.highlight { color: blue; font-weight: bold; }')
		    .appendTo('head');

	 	function bindReplyInputEvents() {
		    // 이벤트 위임 방식으로 바인딩
		    $('.commentBox').on('input', '.replyBox textarea', function () {
		        var commentIdx = $(this).closest('.replyBox').attr('id').split('-')[1];
		        var value = $(this).val();

		        if (value.endsWith('@')) {
		            // 대댓글 작성자 목록 가져오기
		            var replyAuthors = getReplyAuthors(commentIdx);
		            if (replyAuthors.length > 0) {
		                var autocompleteList = replyAuthors.map(function (author) {
		                    return '<div class="autocomplete-item" onclick="selectUser(' + commentIdx + ', \'' + author.name + '\', \'' + author.empIdx + '\')">' + author.name + '</div>';
		                }).join('');
		                $('#autocomplete-' + commentIdx).html(autocompleteList).show();
		            } else {
		                $('#autocomplete-' + commentIdx).hide();
		            }
		        } else {
		            $('#autocomplete-' + commentIdx).hide();
		        }
		    });
		}

	 

	// 대댓글 작성
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
	                '<textarea class="reArea" id="replyInput-' + commentIdx + '" placeholder="댓글을 입력하세요. 300자 이내" maxlength="299"></textarea>' +
	                '<p class="replycharCount" id="replycharCount-' + commentIdx + '">0 / 300</p>' +
	                '<div class="autocomplete" id="autocomplete-' + commentIdx + '"></div>'+
	                '<button class="replyAddBtn" onclick="addReply(' + commentIdx + ')">댓글 작성</button>' +
	                '<button class="replyCan" onclick="toggleReplyBox(' + commentIdx + ')">취소</button>' +
	            '</div>';
	        
	        // 해당 댓글 바로 아래 추가
	        $('#comment-' + commentIdx).after(replyBoxHtml);
		
	    	 // @ 입력 시 대댓글 작성자 목록 표시
	        $('#replyInput-' + commentIdx).on('input', function () {
	            var inputValue = $(this).val(); // 변수명을 명확히 변경
	            var length = inputValue.length; // 올바른 변수 사용
	            $('#replycharCount-' + commentIdx).text(length + " / 300");

	            console.log('입력 값:', inputValue); // 디버깅: 입력 값 확인
	            if (inputValue.endsWith('@')) {
	                var replyAuthors = getReplyAuthors(commentIdx);
	                console.log('대댓글 작성자 목록:'+ commentIdx); // 디버깅: 작성자 목록 확인
	                console.log('대댓글 작성자 목록:', replyAuthors); // 디버깅: 작성자 목록 확인

	                if (replyAuthors.length > 0) {
	                    var autocompleteList = replyAuthors.map(function (author) {
	                        return '<div class="autocomplete-item" onclick="selectUser(' + commentIdx + ', \'' + author.name + '\', \'' + author.empIdx + '\')">' + author.name + '</div>';
	                    }).join('');
	                    $('#autocomplete-' + commentIdx).html(autocompleteList).show();
	                } else {
	                    console.warn('대댓글 작성자가 없습니다.');
	                    $('#autocomplete-' + commentIdx).hide();
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
	    var loggedInEmpIdx = emp_idx;
	
	    console.log('현재 로그인한 사용자 ID:', loggedInEmpIdx); // 디버깅: 로그인 사용자 확인
	
	    // 대댓글 리스트 확인
	    var replyItems = $('#replies-' + commentIdx + ' .reply-item');
	    console.log('대댓글 리스트 (reply-items):', replyItems);
	
	    replyItems.each(function () {
	        var replyAuthor = $(this).find('strong').text(); // 대댓글 작성자 이름
	        var replyEmpIdx = $(this).find('input[type="hidden"]').val(); // 대댓글 작성자 ID
	
	        // 디버깅: 각 대댓글 작성자 정보 확인
	        console.log('대댓글 작성자:', replyAuthor, 'ID:', replyEmpIdx);
	
	        if (replyEmpIdx !== loggedInEmpIdx && !authors.some(a => a.empIdx === replyEmpIdx)) {
	            authors.push({ name: replyAuthor, empIdx: replyEmpIdx });
	        }
	    });
	
	    console.log("Authors for comment " + commentIdx + ":", authors); // 최종 작성자 목록 확인
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
	            cnt: 4
	        },
	        dataType: 'JSON',
	        success: function(response) {
	            printComment(response);	            
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
	            alert(response);
	            $('#commentInput').val('');
	            $('#charCount').text('0 / 300');
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
	
	
	// 댓글 삭제
	function deleteCom(comment_idx) {
	    if (!confirm("댓글을 삭제하시겠습니까?")) {
	        return;
	    }
	
	    $.ajax({
	        type: 'POST',
	        url: 'deleteComment.ajax',
	        data: {
	            comment_idx: comment_idx
	        },
	        success: function(response) {
	        	 loadComments(board_idx, 1);
	        	 alert(response);
	        },
	        error: function(e) {
	            alert('댓글 삭제 중 오류가 발생했습니다.');
	            console.error(e);
	        }
	    });
	}

	
	// 대댓글 삭제
	function deleteReply(comment_idx) {
	    if (!confirm("댓글을 삭제하시겠습니까?")) {
	        return;
	    }
	
	    $.ajax({
	        type: 'POST',
	        url: 'deleteReply.ajax',
	        data: {
	            comment_idx: comment_idx
	        },
	        success: function(response) {
	                alert(response);
	                loadComments(board_idx, 1);
	        },
	        error: function(e) {
	            alert('댓글 삭제 중 오류가 발생했습니다.');
	            console.error(e);
	        }
	    });
	}
	
	
	// 댓글 수정
	function updateCom(comment_idx) {
	    var contentDiv = $('#comment-' + comment_idx).find('.comment-content');
	    var originalContent = contentDiv.text().trim(); // 기존 댓글 내용 가져오기

	    // 수정 중인 상태인지 확인
	    if (contentDiv.find('textarea').length > 0) {
	        alert('이미 수정 중입니다.');
	        return;
	    }

	    var editHtml = 
	        '<textarea class="edit-textarea">' + originalContent + '</textarea>' +
	        '<button class="save-btn" onclick="saveCom(' + comment_idx + ')">저장</button>' +
	        '<button class="cancel-btn" onclick="cancelEdit(' + comment_idx + ', \'' + originalContent + '\')">취소</button>';

	    contentDiv.html(editHtml);
	}
	function saveCom(comment_idx) {
	    var textarea = $('#comment-' + comment_idx).find('.edit-textarea');
	    var content = textarea.val().trim();

	    if (content === '') {
	        alert('내용을 입력하세요!');
	        return;
	    }
	   
	    $.ajax({
	        type: 'POST',
	        url: 'updateComment.ajax',
	        data: {
	            comment_idx: comment_idx,
	            content: content
	        },
	        success: function(response) {
	            loadComments(board_idx, 1);
	            highlightMentions();
	            alert('댓글이 수정되었습니다.');
	        },
	        error: function(error) {
	            alert('댓글 수정 중 오류가 발생했습니다.');
	            console.error(error);
	        }
	    });
	}

	// 댓글 수정 취소
	function cancelEdit(comment_idx, originalContent) {
	    var contentDiv = $('#comment-' + comment_idx).find('.comment-content');
	    contentDiv.html(originalContent);
	}
	
	
	// 대댓글 수정
	function updatReply(comment_idx) {
	    var contentDiv = $('#reply-' + comment_idx + ' .comment-content');
	
	    // 이미 수정 중인 경우, 아무 동작도 하지 않습니다.
	    if (contentDiv.find('textarea').length > 0) {
	        return;
	    }
	
	    // 기존 내용 저장
	    var currentContent = contentDiv.text().trim();
	
	    // textarea로 대체
	    var textareaHtml = 
	        '<textarea class="replyArea" id="updateTextarea-' + comment_idx + '" class="update-textarea">' + currentContent + '</textarea>' +
	        '<button class="replyAddBtn" onclick="submitReplyUpdate(' + comment_idx + ')">저장</button>' +
	        '<button class="replyCan" onclick="cancelReplyUpdate(' + comment_idx + ', \'' + currentContent + '\')">취소</button>';
	    
	    contentDiv.html(textareaHtml);
	}

	function submitReplyUpdate(comment_idx) {
	    var content = $('#updateTextarea-' + comment_idx).val().trim();

	    if (content === '') {
	        alert('내용을 입력해주세요!');
	        return;
	    }

	    $.ajax({
	        type: 'POST',
	        url: 'updateReply.ajax',
	        data: {
	            comment_idx: comment_idx,
	            content: content
	        },
	        success: function(response) {
	            alert('댓글이 수정되었습니다!');
	            $('#reply-' + comment_idx + ' .comment-content').html(content);
	        },
	        error: function(e) {
	            alert('댓글 수정 중 오류가 발생했습니다.');
	            console.error(e);
	        }
	    });
	}
	
	function cancelReplyUpdate(commentIdx, originalContent) {
	    $('#reply-' + commentIdx + ' .comment-content').html(originalContent);
	}
	


</script>
</html>