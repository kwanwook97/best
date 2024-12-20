<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="resources/js/chat.js"></script>
  <link href="resources/css/chat.css" rel="stylesheet"/>

  <style>

  </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
 	
 		<div class="naviPath bold f32 w100 tm2">
			<span class="lPurple">메신져</span> <i class="fa-solid fa-angle-right"
				style="color: #8B6AA7;"></i> <span class="purple">녹두장군방</span>
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
						<div class="chat-message">
						  <div class="chat-profile">
						    <div class="profile-image"><!-- 전송한 사용자 프로필 사진 --></div>
						    <div class="profile-name"><!-- 전송한 사용자 이름 --></div>
						  </div>
						  <div class="chat-bubble-container">
						    <div class="chat-bubble">
						      <!-- 메시지 내용 -->
						    </div>
						    <div class="message-time"><!-- 메시지 전송 시간 --></div>
						  </div>
						</div>
						<div class="send-messages">
							<div class="sent-time"><!-- 내가 전송한 메시지 시간 --></div>
					        <div class="chat-bubble send-message"><!-- 내가 전송한 메시지 내용 --></div>
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
						<div class="image-label-wrapper">
						    <img src="https://via.placeholder.com/40" alt="이미지" class="custom-image">
						    <span class="custom-label"><!-- 사용자 이름 --></span>
						</div>
						
				    </div>
					<div class="footer-menu">
					    <i class="fas fa-door-open"></i> <!-- 문 아이콘 -->
					    <i class="fas fa-bell-slash"></i> <!-- 알림 끄기 -->
					    <i class="fas fa-star"></i> <!-- 별표 -->
					    <i class="fas fa-cog"></i> <!-- 설정 -->
					</div>
				</div>
				
		    </div>
		  </div>
	</div>
</body> 
    <script>
 
    
    </script>
</html>
