<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/root.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="resources/js/document-modal.js"></script>
<style>
.docnav {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 0 48px;
	padding: 0 5px;
}

.opt {
	width: 30%;
	display: flex;
	justify-content: space-between;
}

.opt div {
	display: flex;
	align-content: center;
	align-items: center;
	font-size: 20px;
	font-weight: bold;
	height: 60px;
}

.opt div span {
	color: var(--accent-color);
	margin-left: 5px;
}

.searchbox {
	width: 22%;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.search {
	position: relative;
	display: inline-block;
}

.search input {
	border-radius: 10px;
	padding-left: 10px;
	border: 1px solid var(--primary-color);
}

.search i {
	position: absolute;
	right: 10px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 18px;
	pointer-events: none;
	color: var(--accent-color);
}

.editbtn {
	color: white;
	background-color: var(--accent-color);
	border-radius: 10px;
	width: 70px;
}
/* 모달 기본 스타일 */
.custom-modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5); /* 반투명 배경 */
	z-index: 1000;
}
/* 모달 내용 */
.custom-modal-content {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 355px;
	height: auto;
	background-color: var(--background-color);
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	padding: 10px 0 0 10px;
}
/* 모달 내부 요소 */
.modal-header {
	margin-bottom: 20px;
}

.docSearch input {
	color: var(--primary-color);
	font-weight: bold;
}

.modal-input {
	width: 160px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.modal-list {
	list-style: none;
	padding: 0;
}

.modal-item {
	padding: 0 0 10 40px !important;
	cursor: pointer;
	border-radius: 4px;
}

.modal-item:hover {
	background-color: var(--secondary-color);
	color: white;
}
</style>
</head>
<body>
	<div class="docnav">
		<div class="opt">
			<div>
				<a href="documentBoard.go">진행중<span>12</span></a>
			</div>
			<div>
				<a href="documentApproved.go"> 완료</a>
			</div>
			<div>
				<a href="documentDraft.go">임시저장<span>3</span></a>
			</div>
			<div>
				<a href="documentReject.go">반려문서<span>3</span></a>
			</div>
		</div>
		<div class="searchbox">
			<div class="search">
				<input type="text" name=""><i class="fas fa-search"></i>
			</div>
			<button class="editbtn">
				<i class="far fa-edit"></i>작성
			</button>
		</div>
	</div>
	<!-- 모달 -->
	<div id="customModal" class="custom-modal">
		<div class="custom-modal-content">
			<i class="far fa-arrow-alt-circle-left"></i>
			<!-- 입력 필드 -->
			<div class="search docSearch">
				<input type="text" class="modal-input" name="item"
					placeholder="양식 검색"> <i class="fas fa-search"></i>
			</div>
			<hr />
			<!-- 항목 리스트 -->
			<ul class="modal-list">
				<li class="modal-item" onclick="documentForm('vacation')">휴가신청서</li>
				<li class="modal-item" onclick="documentForm('annual')">연차신청서</li>
				<li class="modal-item" onclick="documentForm('half')">반차신청서</li>
				<li class="modal-item" onclick="documentForm('sick')">병가신청서</li>
				<li class="modal-item" onclick="documentForm('incident')">경위서</li>
				<li class="modal-item" onclick="documentForm('statement')">시말서</li>
				<li class="modal-item" onclick="documentForm('reason')">사유서</li>
				<li class="modal-item" onclick="documentForm('report')">업무 보고서</li>
			</ul>
		</div>
	</div>
</body>
<script>
$(document).ready(function() {
	// 작성 버튼 클릭 시 모달 열기
	$(".editbtn").click(function() {
		$("#customModal").fadeIn(); // 모달 열기 (fade 효과)
	});

	// 화살표 뒤로가기
	$(".far.fa-arrow-alt-circle-left").click(function() {
		$("#customModal").fadeOut(); // 뒤로가기 기능 실행
	});

	
	// 양식 불러오기
	function documentForm(documentType) {
	    // AJAX 요청
	    $.ajax({
	        type: 'GET',
	        url: 'getForm.ajax',
	        data: { documentType: documentType }, 
	        dataType: 'JSON',
	        success: function(response) {
	            // 서버에서 응답 받은 문서 데이터를 처리
	            console.log(response);
	            // 예시: 서버에서 받아온 문서 내용으로 모달에 내용 채우기
	            openModal(response); 
	        },
	        error: function(xhr, status, error) {
	            console.error('문서 요청 실패:', error);
	        }
	    });
	}

	// 모달에 양식 내용을 표시하는 함수
	function displayFormInModal(data) {
		var modal = $('#formModal'); // 모달 요소
		modal.find('.modal-content').html(data.formContent); // 서버에서 받은 양식 내용을 모달에 삽입
		modal.show(); // 모달을 표시
	}

});
</script>
</html>