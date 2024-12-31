<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<script src="https://kit.fontawesome.com/6282a8ba62.js"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>var loginId = ${sessionScope.loginId};</script>
<script src="resources/js/chat/chatList.js"></script>
<link href="resources/css/chat/chatList.css" rel="stylesheet" />
<style>
</style>
</head>
<body class="bg-theme bg-theme1">
	<jsp:include page="../main/header.jsp"></jsp:include>
	<div class="dashboard-body">

		<div class="naviPath bold f32 w100 tm2">
			<span style="var(- -primary-color);">메신져</span>
		</div>

		<div class="content-size">
			<div class="chat-controls">
				<button class="start-chat-button" onclick="openMemberModal();">
					<i class="fas fa-comment-alt"></i> 대화하기
				</button>
				<div class="searchbar">
					<input type="text" name="keyword" id="searchBar" placeholder="검색"> 
					<i class="fas fa-search"></i>
				</div>
		 </div>
		


		<div class="messenger-container">
			<div class="line-box">
				<div class="sidebar">


				</div>

				<!-- 사용자 리스트 -->
				<div class="member-list-wrapper">
					<div class="member-list">
						<div class="image-label-wrapper">
							<img src="" alt="이미지" class="custom-image">
							<!-- 사용자 프로필 사진 -->
							<span class="custom-label">
								<!-- 사용자 이름 -->
							</span>
						</div>
					</div>
				</div>

			</div>
			</div>
		</div>
	</div>
</body>

<!-- Profile Modal -->
<div id="profileModal" class="modal" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close-modal" onclick="closeModal('profileModal');">&times;</button>
            <button type="button" class="btn-secondary" id="profileChat"><i class="fas fa-comment-alt"></i></button>
        </div>
        <div class="modal-body">
        
        </div>
    </div>
</div>

<!-- Member Modal -->
<div id="memberModal" class="modal" style="display: none;">
  <div class="modal-content">
  	<div class="modal-header">
    	<span class="close-modal" onclick="closeModal('memberModal');">&times;</span>
    	<h5>메신져 생성</h5>
    	<button id="createChatButton">확인</button>
    </div>
    <div class="subject-div">
    	<input type="text" id="chatSubject" name="chat_subject" placeholder="제목을 작성하세요. " value=""/>
    	<i class="fas fa-edit"></i>
    </div>
    <div id="selectedMembersContainer">
    
    </div>
    <div class="search_bar-container">
        <input type="text" id="memberSearchBar" name="keyword" class="search_bar" placeholder="이름 검색" value=""> 
        <i class="fas fa-search search-icon"></i>
      </div>
    <div class="member-list-container">
      <ul id="memberList">
      
      </ul>
    </div>
  </div>
</div>

<!-- Confirm Modal -->
<div id="confirmModal" class="modal" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close-modal" onclick="closeModal('confirmModal');">&times;</button>
        </div>
        <div class="modal-body">
            <p id="confirmMessage"></p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn confirmBtn" id="confirmYes">확인</button>
            <button type="button" class="btn confirmBtn" onclick="closeModal('confirmModal');">취소</button>
        </div>
    </div>
</div>



<script>

</script>
</html>
