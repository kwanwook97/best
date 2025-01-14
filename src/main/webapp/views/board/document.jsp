<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
	:root{
		--primary-color: #30005A;
		--secondary-color: #8B6AA7;
		--accent-color: #E9396B;
		--background-color: #FFFBF2;
	}
	.dashboard-body{
	    margin-left: 14vw;
	    width: 85vw;
	    margin-top: 7vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    height: 92%;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: flex-start;
	    justify-content: center;
	    transform:scale(0.7);
	}
	.maintext{
		display: flex;
		margin-left: 0.625rem;
	}
	.document{
		color: var(--secondary-color);
		margin-right: 1.875rem;
	    margin-bottom: 1.75rem;
	}
	.docbox{
		border: 2px solid var(--primary-color);
	    width: -webkit-fill-available;
		height: 90%;
	    border-radius: 0.625rem;
	}
	.docnav{
		display: flex;
    	justify-content: space-between;
		align-items: center;
		margin: 0 3rem;
		padding: 0 0.3125rem;
	}
	.opt{
		width: 30%;
		display: flex;
		justify-content: space-between;
		color: var(--secondary-color);
	}
	.opt div{
		display: flex;
		align-content: center;
	    align-items: center;
		font-size: 1.25rem;
		font-weight: bold;
		height: 3.75rem; 
	}
	.opt div:first-child{
		color: var(--primary-color);
		font-weight: bold;
		border-bottom: 0.1875rem solid var(--accent-color);
	}
	.opt div:hover{
		cursor: pointer;
		color: var(--primary-color);
		font-weight: bold;
		border-bottom: 0.1875rem  solid var(--accent-color);
	}
	.opt div span{
	    color: var(--accent-color);
    	margin-left: 0.3125rem;
	}
	.searchbox{
		width: 20%;
		display: flex;
		align-items: center;
		justify-content: space-between;
	}
	.search{
		position: relative;
    	display: inline-block;
	}
	.search input{
		border-radius: 0.625rem;
		padding-left: 0.625rem;
		border: 1px solid var(--primary-color);
	}
	.search i{
		position: absolute;
		right: 0.625rem;
		top: 50%;
		transform: translateY(-50%);
		font-size: 1.125rem;
		pointer-events: none;
		color: var(--accent-color);
	}
	.editbtn{
		color: white;
		background-color: var(--accent-color);
		border-radius: 0.625rem;
		width: 4.375rem;
	}
	table{
		width: -webkit-fill-available;
		border: 1px solid var(--primary-color);
		border-radius: 0.625rem;
		margin: 0 3rem 3.4375rem 3rem;
	}
	th, td{
		padding-left: 0.625rem;
   		text-align: inherit;
	}
	.fa-arrow-alt-circle-left{
		font-size: 20px;
	    margin: 5px;
	}
	.fa-arrow-alt-circle-left:hover{
		cursor: pointer;
		font-weight: bold;
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
	.docSearch input{
		color: var(--primary-color);
	 	font-weight: bold;
	}
	.docSearch input::placeholder {
	  color: #a0a0a0;
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
	table.my-table{
		border-collapse: separate !important;
        border-spacing: 0;
	}
	table.my-table tr:not(:last-child) td, table.my-table th {
        border-bottom: 1px solid var(--primary-color) !important;
    }
    table.my-table tr{
		height: 36px;
	}
	hr {
	  border-top: 1px solid rgba(0, 0, 0, .1) !important;
	  margin: 10px 0;
	}

  @media (max-width: 960px) {
    .dashboard-body {
      transform: scale(0.8);
      margin-left: 17vw;
      width: 93vw;
    }
    .opt {
      width: 60%;
      flex-wrap: wrap;
    }
    .searchbox {
      width: 40%;
    }
    .editbtn {
      width: 100%;
      margin-top: 10px;
    }
    table {
      margin: 0 10px 55px 10px;
    }
  }
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="document">결재문서</h3>
			<h3>>&nbsp;&nbsp;진행중</h3>
		</div>
		<div class="docbox">
			<div class="docnav">
				<div class="opt">
					<div>진행중<span>12</span></div>
					<div>완료</div>
					<div>임시저장<span>3</span></div>
					<div>반려문서<span>3</span></div>
				</div>
				<div class="searchbox">
					<div class="search">
						<input type="text" name="">
						<i class="fas fa-search"></i>
					</div>
					<button class="editbtn"><i class="far fa-edit"></i>작성</button>
				</div>
			</div>
			<!-- 모달 -->
			<div id="customModal" class="custom-modal">
			  <div class="custom-modal-content">
			    <i class="far fa-arrow-alt-circle-left"></i>
			    <!-- 입력 필드 -->
			    <div class="search docSearch">
			      <input type="text" class="modal-input" name="item" placeholder="양식 검색">
			      <i class="fas fa-search"></i>
			    </div>
			    <hr/>
			    <!-- 항목 리스트 -->
			    <ul class="modal-list">
			      <li class="modal-item">휴가신청서</li>
			      <li class="modal-item">연차신청서</li>
			      <li class="modal-item">반차신청서</li>
			      <li class="modal-item">병가신청서</li>
			      <li class="modal-item">경위서</li>
			      <li class="modal-item">시말서</li>
			      <li class="modal-item">사유서</li>
			      <li class="modal-item">업무 보고서</li>
			    </ul>
			  </div>
			</div>
			<table class="table1 my-table">
				<thead>
					<tr>
						<th colspan="4">내 승인을 기다리는 문서 (3)</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>example1@example.com</td>
						<td>읽지 않은 메일 제목</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-07 10:30</td>
					</tr>
					<tr>
						<td>example2@example.com</td>
						<td>읽은 메일 제목</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-06 18:45</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
				</tbody>
			</table>
			<table class="table2 my-table">
				<thead>
					<tr>
						<th colspan="4">진행 중인 문서 (8)</th>
					</tr>
				</thead>
				<tbody>
					<!-- 읽지 않은 메일 -->
					<tr class="unread">
						<td>example1@example.com</td>
						<td>읽지 않은 메일 제목</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-07 10:30</td>
					</tr>
					<!-- 읽은 메일 -->
					<tr>
						<td>example2@example.com</td>
						<td>읽은 메일 제목</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-06 18:45</td>
					</tr>
					<tr>
						<td>example2@example.com</td>
						<td>읽은 메일 제목</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-06 18:45</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
				</tbody>
			</table>
		</div>
 	</div>
</body>
<script>
	$(document).ready(function () {
	  // 작성 버튼 클릭 시 모달 열기
	  $(".editbtn").click(function () {
	    $("#customModal").fadeIn(); // 모달 열기 (fade 효과)
	  });

	  // 모달 외부 클릭 시 닫기
	  $("#customModal").click(function (event) {
	    if ($(event.target).is("#customModal")) {
	      $("#customModal").fadeOut(); // 모달 닫기 (fade 효과)
	    }
	  });
	  
	  // 화살표 뒤로가기
	  $(".far.fa-arrow-alt-circle-left").click(function() {
		$("#customModal").fadeOut();  // 뒤로가기 기능 실행
	  });
	});
	
	$('.opt div').click(function(){
		$('.maintext').find(':last-child').html('>&nbsp;&nbsp;' + $(this).clone().children('span').remove().end().text());
		$(this).css({
			"color": "var(--primary-color)",
			"font-weight": "bold",
			"border-bottom": "3px solid var(--accent-color)"
		});
		$(this).siblings().css({
			"color": "var(--secondary-color)",
			"border-bottom": "none"
		});
	});


</script>
</html>
