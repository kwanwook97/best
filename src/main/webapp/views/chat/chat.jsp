<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>var loginId = ${sessionScope.loginId};</script>
    <script src="resources/js/chat/chat.js"></script>
  <link href="resources/css/chat/chat.css" rel="stylesheet"/>

  <style>

  </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
 	
 		<div class="naviPath bold f32 w100 tm2">
			<span class="lPurple" onclick="switchPage()">메신져</span> <i class="fa-solid fa-angle-right"
				style="color: #8B6AA7;"></i> <span class="purple"></span>
		</div>

		  <div class="messenger-container">
		  	<div class="line-box">
		  	
		  	<!-- 내가 참여하고있는 대화방 리스트 -->
			    <div class="sidebar">
					<div class="chat-item">
					  <div class="chat-avatar">
					    <img src="" alt="Avatar">
					  </div>
					  <div class="chat-details">
					    <div class="chat-header">
					      <span class="chat-title"><!-- 대화방 이름 --></span>
					      <span class="chat-time"><!-- 해당 대화방의 최신 메시지 전송 시간 --></span>
					    </div>
					    <div class="chat-preview">
					      <!-- 해당 대화방의 최신 메시지 내용 -->
					    </div>
					  </div>
					</div>
			    </div>
			
			    <div class="chat-window">
			      <div class="messages" id="messages">
			      	<div class="chat-notice" id="chatNotice">
    					<!-- 공지사항 내용이 여기에 표시됩니다 -->
					</div>
					
			      </div>
			      <div class="message-input">
			        <input type="text" id="messageInput" placeholder="메시지 입력">
			        <button id="sendButton">전송</button>
			      </div>
			    </div>
			
			
			<!-- 현재 입장해있는 대화방 참여자 리스트 -->
				<div class="member-list-wrapper">
				    <div class="member-list">
				    
				    <!-- 참여자 프로필 -->
						
						
				    </div>
					<div class="footer-menu">
					    <i class="fas fa-door-open"></i> <!-- 문 아이콘 -->
					    <i class="fa-solid fa-user-plus"></i>
					    <i class="bi bi-megaphone-fill"></i>
					    <i class="fas fa-cog"></i>
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
        </div>
        <div class="modal-body">
        
        </div>
    </div>
</div>

<!-- Member Modal -->
<div id="memberModal" class="modal" style="display: none;">
  <div class="modal-content">
  	<div class="modal-header">
    	<span class="close-modal" onclick="closeModal(memberModal);">&times;</span>
    	<h5>메신져 초대</h5>
    	<button onclick="addSelectedMembersToChat()">확인</button>
    </div>
    <div id="selectedMembersContainer">
        <!-- 선택된 회원 정보가 여기에 표시됩니다 -->
    </div>
    <div class="search_bar-container">
        <input type="text" id="memberSearchBar" name="keyword" class="search_bar" placeholder="이름 검색" value=""> 
        <i class="fas fa-search search-icon"></i>
      </div>
    <div class="member-list-container">
      <ul id="memberList">
        <!-- 회원 리스트가 여기에 추가됩니다 -->
      </ul>
    </div>
  </div>
</div>

<!-- Edit Chat Subject Modal -->
<div id="editChatSubjectModal" class="modal" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <span class="close-modal" onclick="closeModal('editChatSubjectModal');">&times;</span>
            <h5><i class="fas fa-edit"></i> 메신져 이름</h5>
        </div>
        <div class="subject-div">
    		<input type="text" id="chatSubject" name="chat_subject" placeholder="제목을 작성하세요. " value=""/>
    	</div>
        <div class="modal-footer">
            <button type="button" class="btn confirmBtn" onclick="updateChatSubject()">수정</button>
            <button type="button" class="btn confirmBtn" onclick="closeModal('editChatSubjectModal');">취소</button>
        </div>
    </div>
</div>

<!-- Notice Modal -->
<div id="noticeModal" class="modal" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <span class="close-modal" onclick="closeModal('noticeModal');">&times;</span>
            <h5><i class="bi bi-megaphone-fill"></i> 공지사항</h5>
        </div>
        <div class="subject-div">
            <textarea id="noticeContent" placeholder="공지사항 내용을 입력하세요" rows="5" style="width: 100%;"></textarea>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn confirmBtn" onclick="submitNotice()">등록</button>
            <button type="button" class="btn confirmBtn" onclick="closeModal('noticeModal');">취소</button>
        </div>
    </div>
</div>

<!-- Confirm Modal -->
<div id="confirmModal" class="modal" style="display: none;">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close-modal">&times;</button>
        </div>
        <div class="modal-body">
            <p id="confirmMessage"></p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn confirmBtn" id="confirmYes">확인</button>
            <button type="button" class="btn confirmBtn">취소</button>
        </div>
    </div>
</div>


<script>

</script>
</html>
