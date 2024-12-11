<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <style>
  :root{
      --primary-color: #30005A;
      --secondary-color: #8B6AA7;
      --accent-color: #E9396B;
      
   }
    .dashboard-body{
       margin-left: 14vw;
       width: 85vw;
       margin-top: 7vh;
       flex-wrap: wrap;
       padding: 2vh;
       color: var(--primary-color);
       border: 1px solid black;
       height: 92%;
       display: flex;
       flex-direction: column;
       align-content: center;
       align-items: flex-start;
       justify-content: center;
   } 

    .messenger-container {
      display: flex;
      height: 66vh;
      color: #fff;
      width: 84%;
      border-radius: 10px;
      margin: 1px 16px 1px 16px;
    }

    .sidebar {
      width: 20%;
      background-color: #4a225d;
      padding: 10px;
      display: flex;
      flex-direction: column;
      gap: 10px;
      margin: 0 2% 0 0;
      border-radius: 10px;
    }

    .sidebar h3 {
      margin: 0;
      text-align: center;
      font-size: 18px;
      margin-bottom: 20px;
    }

    .chat-window {
      width: 60%;
      display: flex;
      flex-direction: column;
      background-color: #8B6AA7;
      padding: 20px;
      border-left: 2px solid #4a225d;
      border-right: 2px solid #4a225d;
      border-radius: 10px;

    }

    .chat-header {
      font-size: 18px;
      margin-bottom: 10px;
    }

    .messages {
      flex-grow: 1;
      overflow-y: auto;
      padding-right: 10px;
    }

    .message {
      margin-bottom: 10px;
      padding: 10px;
      border-radius: 5px;
      max-width: 70%;
      line-height: 1.4;
    }

    .message.sent {
      background-color: #9a57c6;
      align-self: flex-end;
    }

    .message.received {
      background-color: #8339a5;
    }

    .message-input {
      display: flex;
      gap: 10px;
    }

    .message-input input {
      flex-grow: 1;
      padding: 10px;
      border-radius: 5px;
      border: none;
      outline: none;
    }

    .message-input button {
      padding: 10px 20px;
      border-radius: 5px;
      border: none;
      background-color: #9a57c6;
      color: #fff;
      cursor: pointer;
      transition: background-color 0.3s;
    }

    .message-input button:hover {
      background-color: #b06ed5;
    }

	#main-name {
	  display: flex; /* 가로로 나열 */
	  list-style: none; /* 불필요한 점 제거 */
	  padding: 0; /* 기본 패딩 제거 */
	  margin: 1px 1px 1px 25px; /* 기본 여백 제거 */
	}
	
	#main-name li {
	  margin-right: 10px; /* 각 항목 사이 간격 */
	  font-size: 20px;
	}
	
	/* 대화방 */
	#chat-name{
		font-weight: 700;
	}
	
	.chat-item {
	  display: flex;
	  align-items: center;
	  background-color: #FFFBF2;
	  padding: 10px;
	  border-radius: 10px;
	  margin-bottom: 10px;
	  color: #fff;
      transition: background-color 0.3s;
	}
    .chat-item:hover {
      background-color: #FFF3D9;
      cursor: pointer;
    }
	
	.chat-avatar {
	  width: 50px;
	  height: 50px;
	  border-radius: 20%;
	  overflow: hidden;
	  margin-right: 10px;
	  background-color: #fff; /* 기본 배경 (이미지 없을 때) */
	}
	
	.chat-avatar img {
	  width: 100%;
	  height: 100%;
	  object-fit: cover;
	}
	
	.chat-details {
	  flex-grow: 1;
	}
	
	.chat-header {
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	  margin-bottom: 5px;
	}
	
	.chat-title {
	  font-weight: bold;
	  font-size: 16px;
	  color: #30005A;
	}
	
	.chat-time {
	  font-size: 12px;
	  color: #8B6AA7;
	}
	
	.chat-preview {
	  font-size: 14px;
	  color: #8B6AA7;
	  overflow: hidden;
	  text-overflow: ellipsis;
	  white-space: nowrap;
	}
	
/* 참여자리스트 */

    .member-list {
      width: 100%;
      background-color: #4a225d;
      padding: 10px;
      display: flex;
      flex-direction: column;
      gap: 10px;
      margin: 0 0 0 0;
      border-radius: 10px 10px 0 0;
      height: 92%;
    }
    
	.image-label-wrapper {
	    display: flex;
	    align-items: center;
	    background-color: #fdf6e4; /* 배경색 */
	    border: 2px solid #30005A; /* 외곽선 */
	    border-radius: 10px; /* 둥근 모서리 */
	    padding: 5px 10px; /* 내부 여백 */
	    width: auto; /* 내용에 맞게 크기 조정 */
	}
	
	.custom-image {
	    width: 30px; /* 이미지 크기 */
	    height: 30px;
	    border-radius: 5px; /* 이미지 둥글게 */
	    border: 2px solid #30005A; /* 이미지 외곽선 */
	    margin-right: 10px; /* 텍스트와의 간격 */
	}
	
	.custom-label {
	    color: #30005A; /* 텍스트 색상 */
	    font-size: 14px; /* 텍스트 크기 */
	    font-weight: bold; /* 텍스트 굵게 */
	}
	.line-box{
		border: 3px solid #30005A;
		width: 100%;
		display: flex;
		padding: 1% 1% 1% 1%; 
		border-radius: 10px;
	}
/* 대화방 검색 바 */
	.chat-controls {
	  display: flex;
	  align-items: center;
	  gap: 15px;
	  padding: 10px;
	  margin-left: auto; /* 오른쪽으로 정렬 */

	}
	
	.start-chat-button {
	  display: flex;
	  align-items: center;
	  gap: 8px;
	  background-color: #ff527b;
	  color: white;
	  border: none;
	  padding: 10px 15px;
	  border-radius: 13px;
	  font-size: 14px;
	  cursor: pointer;
	  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	  transition: background-color 0.3s;
	  margin: 0 0 0 1px;
	  height: 31px;
	}
	
	.start-chat-button i {
	  font-size: 16px;
	}
	
	.start-chat-button:hover {
	  background-color: #ff385d;
	}
	
	.searchbar {
	  display: flex;
	  align-items: center;
	  border: 2px solid #6b3f86;
	  border-radius: 10px;
	  padding: 5px 10px;
	  background-color: white;
	  height: 31px;
	}
	
	.searchbar input {
	  border: none;
	  outline: none;
	  flex-grow: 1;
	  padding: 5px;
	  font-size: 14px;
	  height: 29px;
	}
	
	.searchbar i {
	  color: #ff527b;
	  font-size: 21px;
	  cursor: pointer;
	}
/* 방설정 아이콘들	 */
    .footer-menu {
      padding: 10px;
      background-color: #8B6AA7;
      border-radius: 0 0 10px 10px;
      box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1);
      margin:0 0 0 0;
      height: 8%;
      display: flow;
    }

    .footer-menu i {
      font-size: 20px;
      color: white;
      margin: 0 0 0 17%;
      cursor: pointer;
      transition: color 0.3s ease;
    }

    .footer-menu i:hover {
      color: #E9396B;
    }

    .footer-menu i:first-child {
      margin-left: auto; /* 첫 번째 아이콘을 왼쪽으로 붙임 */
    }
    .member-list-wrapper{
	    display: flex;
	    flex-direction: column;
	    justify-content: space-between;
	    height: 100%; /* 부모 컨테이너의 높이 */
	    width: 20%;
	    margin: 0 0 0 2%;
    }
    /* 메시지 프로필 css */
/* 채팅 전체 스타일 */
.chat-message {
  display: flex; /* 프로필과 채팅 버블을 나란히 */
  align-items: flex-start; /* 위쪽 정렬 */
  gap: 10px; /* 프로필과 채팅 버블 간격 */
  background-color: #8B6AA7; /* 배경색 */
  padding: 10px; /* 내부 여백 */
  border-radius: 8px; /* 둥근 모서리 */
  color: #FFF5E2; /* 텍스트 색상 */
  width: fit-content; /* 내용에 맞는 너비 설정 */
}

/* 프로필 이미지와 이름 */
.chat-profile {
  display: flex; /* 프로필 이미지와 이름을 세로로 배치 */
  flex-direction: column;
  align-items: center; /* 중앙 정렬 */
  min-width: 60px; /* 프로필 영역 최소 너비 */
}

.profile-image {
  width: 40px; /* 프로필 이미지 크기 */
  height: 40px;
  background-color: #D9D9D9; /* 회색 배경 */
  border-radius: 10px; /* 원형 모양 */
  border: 2px solid #30005A; /* 테두리 */
}

.profile-name {
  margin-top: 5px; /* 이미지와 이름 간격 */
  font-size: 12px; /* 이름 글씨 크기 */
  color: #30005A; /* 이름 텍스트 색상 */
  text-align: center;
}

/* 채팅 말풍선 컨테이너 */
.chat-bubble-container {
  display: flex; /* 말풍선을 오른쪽으로 정렬 */
  align-items: flex-end; /* 텍스트를 왼쪽 정렬 */
  width: 100%;
}

/* 말풍선 스타일 */
.chat-bubble {
  background-color: #FFF5E2; /* 말풍선 배경색 */
  color: #30005A; /* 텍스트 색상 */
  padding: 10px 15px; /* 내부 여백 */
  border-radius: 15px; /* 둥근 모서리 */
  font-size: 14px; /* 텍스트 크기 */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
  position: relative; /* 시간 위치를 조정하기 위한 상대 위치 */
  width: fit-content; /* 내용에 맞는 너비 설정 */
  max-width: 300px; /* 말풍선 최대 너비 */
  word-break: break-word; /* 텍스트 줄바꿈 처리 */
}

/* 채팅 시간 스타일 */
.message-time {
  font-size: 12px; /* 시간 글씨 크기 */
  color: #ffffff; /* 시간 텍스트 색상 */
  white-space: nowrap; /* 줄바꿈 방지 */
}
/* send message css */
.send-messages{
	display: flex;
	flex-direction:row;
	justify-content: flex-end;
	align-items:flex-end;
}
.sent-time{
	font-size: 12px;
}

  </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
 	<ul id="main-name">
 		<li>메신져</li>
 		<li>></li>
 		<li id="chat-name">녹두장군 방</li>
 	</ul>
	<div class="chat-controls">
	  <button class="start-chat-button">
	    <i class="fas fa-comment-alt"></i> 대화하기
	  </button>
	  <div class="searchbar">
	    <input type="text" placeholder="검색">
	    <i class="fas fa-search"></i>
	  </div>
	</div>
		  <div class="messenger-container">
		  	<div class="line-box">
			    <div class="sidebar">
					<div class="chat-item">
					  <div class="chat-avatar">
					    <img src="path-to-avatar-image.jpg" alt="Avatar">
					  </div>
					  <div class="chat-details">
					    <div class="chat-header">
					      <span class="chat-title">방이름 6</span>
					      <span class="chat-time">오후 5:33</span>
					    </div>
					    <div class="chat-preview">
					      메시지 내용 
					    </div>
					  </div>
					</div>
			    </div>
			
			    <div class="chat-window">
			      <div class="messages" id="messages">
						<div class="chat-message">
						  <div class="chat-profile">
						    <div class="profile-image"></div>
						    <div class="profile-name">이종원</div>
						  </div>
						  <div class="chat-bubble-container">
						    <div class="chat-bubble">
						      아니 난 모르겠어ㅠㅠ
						    </div>
						    <div class="message-time">오후 4:47</div>
						  </div>
						</div>
						<div class="send-messages">
							<div class="sent-time">오후 4:47</div>
					        <div class="chat-bubble send-message">안녕하세요! 반갑습니다.</div>
						</div>
			      </div>
			      <div class="message-input">
			        <input type="text" id="messageInput" placeholder="메시지 입력">
			        <button id="sendButton">전송</button>
			      </div>
			    </div>
			
				<div class="member-list-wrapper">
				    <div class="member-list">
						<div class="image-label-wrapper">
						    <img src="https://via.placeholder.com/40" alt="이미지" class="custom-image">
						    <span class="custom-label">김철수</span>
						</div>
						<div class="image-label-wrapper">
						    <img src="https://via.placeholder.com/40" alt="이미지" class="custom-image">
						    <span class="custom-label">이영희</span>
						</div>
						<div class="image-label-wrapper">
						    <img src="https://via.placeholder.com/40" alt="이미지" class="custom-image">
						    <span class="custom-label">박지훈</span>
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
	    const sendButton = document.getElementById('sendButton');
	    const messageInput = document.getElementById('messageInput');
	    const messages = document.getElementById('messages');
	
	    sendButton.addEventListener('click', function () {
	      const text = messageInput.value.trim();
	
	      if (text) {
	        const messageDiv = document.createElement('div');
	        messageDiv.className = 'message sent';
	        messageDiv.innerText = text;
	        messages.appendChild(messageDiv);
	        messages.scrollTop = messages.scrollHeight; // Scroll to the bottom
	        messageInput.value = '';
	      }
	    });
	
	    messageInput.addEventListener('keypress', function (event) {
	      if (event.key === 'Enter') {
	        sendButton.click();
	      }
	    });
    </script>
</html>
