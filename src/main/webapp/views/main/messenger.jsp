<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <title>BEST</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link href="resources/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="resources/css/app-style.css" rel="stylesheet"/>
  <script src="resources/js/bootstrap.min.js"></script>
  <script>var loginId = ${sessionScope.loginId};</script>
  <script src="resources/js/bestWS.js"></script>
  <style>
  body {
            margin: 0;
            background-color: #30005A;
            color: #30005A;
        }
/* 메시지 프로필 css */
/* 채팅 전체 스타일 */
.chat-message {
	display: flex; /* 프로필과 채팅 버블을 나란히 */
	align-items: flex-start; /* 위쪽 정렬 */
	gap: 10px; /* 프로필과 채팅 버블 간격 */
	background-color: #30005A; /* 배경색 */
	padding-bottom: 10px; /* 내부 여백 */
	border-radius: 8px; /* 둥근 모서리 */
	color: #FFF5E2; /* 텍스트 색상 */
	width: fit-content; /* 내용에 맞는 너비 설정 */
}

/* 프로필 이미지와 이름 */
.chat-profile {
	display: flex; /* 프로필 이미지와 이름을 세로로 배치 */
	justify-content: flex-end;
	min-width: 50px; /* 프로필 영역 최소 너비 */
}

.profile-image {
	width: 40px; /* 프로필 이미지 크기 */
	height: 40px;
	background-color: #D9D9D9; /* 회색 배경 */
	border-radius: 10px; /* 원형 모양 */
	border: 2px solid #30005A; /* 테두리 */
}

.profile-name {
	font-size: 12px; /* 이름 글씨 크기 */
	color: #bbb5a6; /* 이름 텍스트 색상 */
	text-align: center;
}

.system-message {
	display: flex;
	justify-content: center;
	background-color: #8B6AA7;
	color: #FFF5E2;
	padding: 4px 10px;
	border-radius: 5px;
	width: fit-content;
	height: fit-content;
	text-align: center; /* 텍스트 중앙 정렬 */
	margin: 5px auto; /* 가로 중앙 정렬 */
	position: relative;
}

/* 채팅 말풍선 컨테이너 */
.chat-bubble-container {
	display: flex;
	align-items: flex-start;
	width: 100%;
	flex-direction: column;
}

.content-div {
	display: flex;
	align-items: flex-end;
}

/* 말풍선 스타일 */
.chat-bubble {
	background-color: #8B6AA7;
	color: #FFF5E2;
	padding: 7px 10px;
	border-radius: 5px;
	font-size: 14px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	position: relative;
	width: fit-content;
	max-width: 300px;
	word-break: break-word;
	min-height: 30px;
	height: fit-content;
	margin: 5px 5px 0 0;
}

/* 채팅 시간 스타일 */
.message-time {
	font-size: 12px; /* 시간 글씨 크기 */
	color: #bbb5a6; /* 시간 텍스트 색상 */
	margin-right: 3px;
}
/* send message css */
.send-messages {
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
	align-items: flex-end;
}

.send-message {
	background-color: #FFF5E2;
	color: #30005A;
	padding: 7px 10px;
	border-radius: 5px;
	font-size: 14px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	position: relative;
	width: fit-content;
	max-width: 300px;
	word-break: break-word;
	min-height: 30px;
	height: fit-content;
	margin: 7px 0 0 5px;
}

.sent-time {
	font-size: 12px;
	color: #bbb5a6;
	margin-left: 3px;
}
.messages {
	position: relative;
	flex-grow: 1;
	overflow-y: auto;
	padding-right: 10px;
	margin-bottom: 10px;
	border-radius: 10px;
	height: 91%;
}

.messages::-webkit-scrollbar {
	display: none; /* Chrome/Edge에서 기본 스크롤 숨김 */
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
	height: 32px;
	padding: 0 8px;
	position: sticky; /* 입력란을 하단에 고정 */
    bottom: 0; /* 하단에 고정 */
    z-index: 1000;
}

.message-input input {
	flex-grow: 1;
	padding: 10px;
	border-radius: 5px;
	border: none;
	outline: none;
}

.message-input button {
	padding: 5px 16px;
	border-radius: 5px;
	border: none;
	background-color: #30005A;
	color: #FFFBF2;
	cursor: pointer;
	transition: background-color 0.3s;
}

.message-input button:hover {
	background-color: #b06ed5;
}
.message-modal-body {
    box-sizing: border-box;
    height: 90%;
}
.message-modal-content::-webkit-scrollbar {
	display: none;
}
.message-modal-content {
    display: flex;
    flex-direction: column;
    background-color: #30005A;
    padding: 10px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    width: 500px;
    max-width: 100%;
    text-align: center;
    height: 100%;
    right: 0; /* 오른쪽 끝으로 위치 지정 */
    overflow-y: auto;
}
.message-modal {
    background-color: #30005A;
    position: fixed;
    top: 0;
    right: 0;
    display: none;
    overflow: hidden;
    outline: 0;
    height: 100%;
}
.messenger-body {
    background-color: #30005A;
    width: 100%;
    text-align: center;
    height: 100%;
    overflow-y: auto;
    padding: 10px;
}

.header-modal-content::-webkit-scrollbar {
	display: none;
}
.header-modal-header > .close-modal{
	font-size: 20px;
	cursor: pointer;
	color: #30005A;
}
.messenger-header > .close-modal{
	font-size: 20px;
	cursor: pointer;
	color: #FFFBF2;
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
	max-width: 320px;
	overflow: hidden; /* 넘치는 내용을 숨김 */
    white-space: nowrap; /* 한 줄로 표시 */
    text-overflow: ellipsis; 
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
	max-width: 540px;
	display: flex;
	justify-content: space-between;
}
.chat-preview > span{
    max-width: 482px;
}
.header-modal-header{
	display: flex;
    align-items: center !important;
    justify-content: space-between;
    position: sticky; /* 스크롤 위치에 따라 고정 */
    top: 0; /* 상단에 고정 */
    z-index: 1000;
}
.messenger-header{
	display: flex;
    align-items: center !important;
    justify-content: space-between;
}
.modalHeaderTitle{
	font-size: 24px;
	font-weight: 700;
	color: #FFFBF2;
	display: block; /* 블록 요소로 설정 */
    white-space: nowrap; /* 한 줄로 표시 */
    overflow: hidden; /* 넘치는 텍스트 숨김 */
    text-overflow: ellipsis; /* '...'로 표시 */
    max-width: 300px;
}
.member-modal-content,
.header-modal-content{
	position: fixed;
	background-color: #FFF5E2;
	padding: 10px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	width: 400px;
	max-width: 90%;
	text-align: center;
	height: 500px;
	overflow-y: auto;
	top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 9999;
}
.member-modal-header button {
	border: 0px;
	background-color: #FFF5E2;
	color: #6C0F6C;
}
.modal-icon{
    width: 122px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    gap: 20px;
    margin-left: -100px;
}
.modal-icon2{
    width: 60px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    gap: 20px;
    margin-right: -138px;
}
.modal-icon div, .modal-icon2 div{
	width: 50px;
	height: 50px;
	color: #FFFBF2;
    display: flex;
    align-items: center;
}
.modal-icon i{
	font-size: 28px;
	cursor: pointer;
	color: #FFFBF2;
}
.modal-icon2 i{
	font-size: 20px;
	cursor: pointer;
	color: #FFFBF2;
}
.member-list {
	width: 100%;
	background-color: #30005A;
	display: flex;
	flex-direction: column;
	margin: 0 0 0 0;
	border-radius: 10px;
	height: 100%;
	overflow-y: auto;
}

.member-list::-webkit-scrollbar,
.messenger-body::-webkit-scrollbar{
	display: none;
}

.image-header-wrapper {
	display: flex;
	align-items: center;
	background-color: #FFFBF2; /* 배경색 */
	border: 2px solid #30005A; /* 외곽선 */
	border-radius: 10px; /* 둥근 모서리 */
	padding: 5px 10px; /* 내부 여백 */
	width: auto; /* 내용에 맞게 크기 조정 */
	cursor: pointer;
	margin-bottom: 5px;
}

.image-header-wrapper:hover {
	background-color: #FFF3D9;
	cursor: pointer;
}

.custom-image {
	width: 30px; /* 이미지 크기 */
	height: 30px;
	border-radius: 5px; /* 이미지 둥글게 */
	margin-right: 10px; /* 텍스트와의 간격 */
}

.custom-label {
	color: #30005A; /* 텍스트 색상 */
	font-size: 14px; /* 텍스트 크기 */
	font-weight: bold; /* 텍스트 굵게 */
}

.line-box {
	border: 3px solid #30005A;
	width: 100%;
	display: flex;
	padding: 1% 1% 1% 1%;
	border-radius: 10px;
}
.my-profile{
    position: relative;
}
.mySelf{
	position: absolute;
	border-radius: 50%;
	background-color: #30005A;
	width: 20px;
    left: 120px;
    height: 20px;
    text-align: center;
}
.mySelf > span{
	color: #FFF5E2;
	font-weight: bold;
}
.profile-header{
	display: flex;
    justify-content: space-evenly;
    margin-bottom: 15px;
}
.profile-header div{
	display: flex;
    flex-direction: column;
    justify-content: center;
}
#header-memberModal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5); /* 반투명 검정 */
	z-index: 1000;
}
#memberList {
	list-style: none;
	padding: 0px;
}

#memberList li {
	display: flex;
	justify-content: space-between;
	list-style: none;
}
#header-profileModal ul{
	width: 100%;
	margin-left: 0px;
	padding: 0px;
}
#header-profileModal li{
	list-style: none;
	display: flex;
    justify-content: space-evenly;
    margin-bottom: 10px;
    border-bottom: 1px solid #6C0F6C;
}
#header-profileModal li span:first-child{
	color: #6C0F6C;
	text-align: end;
	width: 15%;
}
#header-profileModal li span:last-child{
	text-align: start;
	width: 45%;
}
#header-profileModal .custom-image{
    width: 70px;
    height: 70px;
	
}
#header-profileModal > .header-modal-content{
	height: 320px !important;
	background-color: #FFFBF2;
}
.btn-secondary {
    color: #E9396B !important;
    font-size: 20px;
}
.btn-secondary:hover {
    color: #EF7597 !important;
    background-color: #FFF5E2 !important;
}
.header-modal-header button {
    border: 0px;
    background-color: #FFFBF2;
    color: #6C0F6C;
}
.fa-circle{
	color: #1DD20C;
}
.emoji-picker {
    z-index: 9999 !important;
}
.time-and-number {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
}
.number{
	color: #FFFBF2;
}
.unread-count-list {
	background-color: #E9396B;
	border-radius: 50%;
	width: 20px;
	text-align: center;
}

.unread-message-count {
	color: #FFF5E2;
}

.newMessageIndicator{
	background-color: #E9396B;
	border-radius: 50%;
	width: 20px !important;
	height: 20px !important;
	text-align: center;
	display: none;
	position: absolute;
	top: 15px;
    left: 200px;
}

#confirmModal .member-modal-content{
    width: 300px !important;
    height: 200px !important;
}
.modal-footer{
	display: flex;
    align-items: center !important;
    justify-content: center !important;
}
.modal-footer button:first-child{
	background-color: #6C0F6C;
	color: #FFF5E2 !important;
}
.modal-footer button:first-child:hover{
	background-color: #981798;
}
.modal-footer button:last-child{
	background-color: #E9396B;
	color: #FFF5E2 !important;
}
.modal-footer button:last-child:hover{
	background-color: #EF7597;
}
#selectedMembersContainer{
	display: flex;
    justify-content: flex-start;
    flex-wrap: wrap; /* 너비 초과 시 다음 줄로 넘기기 */
    gap: 10px; /* 멤버 간격 추가 */
    max-width: 100%; /* 컨테이너의 최대 너비 제한 */
    overflow: hidden;
}
.selected-member-container{
	display: flex;
    flex-direction: column;
}
.selected-member-container span:first-child{
	display: flex;
}
.selected-member{
	font-size: 12px;
}
.subject-div, .search_bar-container {
	position: relative;
}

.chatSubject, .search_bar {
	border: 0px;
	margin-bottom: 1rem;
	width: 100%;
	height: 36px;
	background-color: #d1c4a8e0;
	color: #30005A;
	padding: 5px;
	border-radius: 5px;
}

.fa-edit, .search-icon {
	position: absolute;
	right: 8px;
	top: 35%;
	transform: translateY(-50%);
	color: #E9396B; /* 핑크색 */
	font-size: 18px;
	z-index: 1;
	cursor: pointer;
}

search {
	position: relative;
	display: inline-block;
}

.subject-div::placeholder, .search_bar::placeholder {
	color: #8B6AA7 !important;
}

.radio-container {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.radio-container label {
	display: flex;
	align-items: center;
	cursor: pointer;
	width: 98%;
	justify-content: space-between;
	margin-left: 5px;
}

.radio-container img.custom-image {
	width: 40px;
	height: 40px;
	border-radius: 5PX;
	margin-right: 10px;
}

.radio-container span {
	color: #30005A;
	font-size: 14px;
}

.radio-container input[type="checkbox"] {
	appearance: none; /* 기본 라디오 버튼 스타일 제거 */
	margin-left: 10px;
	height: 20px;
	width: 20px;
	border: 2px solid #d1c4a8e0; /* 기본 테두리 색상 */
	background-color: #FFF5E2; /* 기본 배경색 */
	border-radius: 50%; /* 원형 라디오 버튼 */
	cursor: pointer;
	position: relative;
	display: inline-block;
}

.radio-container input[type="checkbox"]:checked {
	background-color: #E9396B; /* 체크 시 배경색 */
	border-color: #E9396B; /* 체크 시 테두리 색상 */
}

.radio-container input[type="checkbox"]::after {
	content: '\f00c'; /* Font Awesome check 아이콘 (유니코드) */
	font-family: "Font Awesome 5 Free"; /* Font Awesome 폰트 사용 */
	font-weight: 900; /* 아이콘 굵기 */
	color: #FFF; /* 아이콘 색상 */
	font-size: 14px; /* 아이콘 크기 */
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	opacity: 0; /* 기본 상태에서 보이지 않음 */
	transition: opacity 0.2s ease;
}

.radio-container input[type="checkbox"]:checked::after {
	opacity: 1; /* 체크 시 아이콘 표시 */
}
.member-modal-content::-webkit-scrollbar {
	display: none;
}
.member-modal-header {
	padding: 5px !important;
	border-bottom: 0px !important;
	display: -ms-flexbox;
    display: flex;
    -ms-flex-align: start;
    align-items: flex-start;
    -ms-flex-pack: justify;
    justify-content: space-between;
    border-bottom: 1px solid #dee2e6;
    border-top-left-radius: .3rem;
    border-top-right-radius: .3rem;
}

.member-modal-header button {
	border: 0px;
	background-color: #FFF5E2;
	color: #6C0F6C;
}

.messengerUser, .messengerBar {
    position: relative;
}
#chatMenuDropdown{
    left: 247px !important;
}
#participantsDropdown, #chatMenuDropdown {
    position: absolute; 
    top: 39px;
    left: 214px;
    z-index: 9999; 
    background: #FFF5E2;
    border-radius: 5px; 
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    display: none; 
    min-width: 200px; 
    padding: 10px;
}
#chatMenuDropdown > ul{
	list-style: none; 
	margin: 0; 
	padding: 10px; 
	text-align: left;
	color: #30005A;
}
#chatMenuDropdown > ul > li{
	border-bottom: 1px solid #8B6AA7;
    padding: 10px;
    cursor: pointer;
}
.messengerBar, .messengerUser, .close-modal{
   cursor: pointer;
}
.messengerBar > i,
.messengerUser > i,
.chatMenu > .close-modal{
	font-size: 20px;
	font-weight: bold;
	color: #FFF5E2;
}

#participantsDropdown .member-list{
	background-color: #FFF5E2;
}
.chatMenu{
    width: 25%;
    display: flex;
    justify-content: space-around;
    align-items: center;
}

#editChatSubjectModal .member-modal-content{
	width: 300px !important;
    height: 180px !important;
}
#noticeModal .member-modal-content{
    height: 245px !important;
}
.chat-notice {
    display: flex;
    justify-content: flex-start; /* 글자 왼쪽 정렬 */
    align-items: center;
    background-color: #8B6AA7;
    color: #FFF5E2;
    padding: 4px 10px;
    border-radius: 5px;
    width: 476px; /* 고정된 너비로 설정 */
    height: fit-content;
    text-align: start;
    overflow: hidden; /* 넘치는 내용을 숨김 */
    white-space: nowrap; /* 한 줄로 표시 */
    text-overflow: ellipsis; /* 넘칠 경우 말줄임표(...) 표시 */
    cursor: pointer; /* 클릭 가능하도록 포인터 추가 */
    transition: height 0.3s ease; /* 애니메이션 효과 추가 */
    box-sizing: border-box; /* padding과 border를 포함한 크기 계산 */
    position: fixed; 
    display: none;
    margin-bottom: 5px;
    top: 3rem;
}

.chat-notice.expanded {
    white-space: normal; /* 줄바꿈 허용 */
    overflow: visible; /* 내용 표시 */
    height: auto; /* 높이 자동 조정 */
}

.member-modal-header i, #chatNotice i{
	margin-right: 10px;
	color: #E9396B;
	font-size: 20px;
}

#noticeContent::placeholder {
    color: #8B6AA7 !important;
}
  </style>
</head>

<body>
	<div class="messenger-body">
        <div class="messenger-header">
            <span id="modalHeaderTitle" class="modalHeaderTitle"></span>
            <div class="modal-icon">
    			<div data-title="사원">
        			<i class="fa-solid fa-user"></i>
    			</div>
    			<div data-title="채팅">
        			<i class="fa-solid fa-comment"></i>
        			<div id="newMessageIndicator" class="newMessageIndicator"></div>
    			</div>
			</div>
			<div class="modal-icon2">
   				<div>
       				<i class="fas fa-search"></i>
   				</div>
   				<div class="start-chat-button" onclick="openMemberModal('createChat');">
       				<i class="fas fa-comment-medical"></i>
   				</div>
  			</div>
            <span class="close-modal" onclick="window.close();">&times;</span>
        </div>
        <div class="header-modal-body">
            <div id="chatContainer"></div>
        </div>
    </div>
</body>

<div id="header-profileModal" class="modal" style="display: none;">
    <div class="header-modal-content">
        <div class="header-modal-header">
            <button type="button" class="close-modal" onclick="closeModal('header-profileModal');">&times;</button>
            <button type="button" class="btn-secondary" id="profileChat"><i class="fas fa-comment-alt"></i></button>
        </div>
        <div class="header-modal-body">
        
        </div>
    </div>
</div>


<div id="chatModalTemplate" class="message-modal" style="display: none;">
    <div class="message-modal-content"> 	
        <div class="header-modal-header">
            <span class="modalHeaderTitle"></span>
            
            <div class="chatMenu">
            	<span class="messengerUser" onclick="showParticipantsDropdown();">
    				<i class="fas fa-user-plus"></i>
				</span>
				<div id="participantsDropdown" class="dropdown-menu">
    				<div class="member-list">

    				</div>
				</div>
			
            	<span class="messengerBar" onclick="toggleChatMenu();"><i class="fas fa-bars"></i></span>
            	<div id="chatMenuDropdown" class="dropdown-menu">
    				<ul>
        				<li onclick="openModal('noticeModal');"><i class="fas fa-bullhorn"></i> 공지사항</li>
        				<li onclick="openModal('editChatSubjectModal');"><i class="fas fa-eraser"></i> 대화방 제목</li>
        				<li onclick="leaveChat();"><i class="fa-solid fa-right-to-bracket"></i> 대화방 나가기</li>
    				</ul>
				</div>
            	
            	
           	 	<span class="close-modal" style="color: #FFFBF2;" onclick="closeModal('chatModalTemplate');">&times;</span>
        	</div>
        </div>
        <div class="message-modal-body">
            <div class="messages" id="messagesContainer">
            	<div class="chat-notice" id="chatNotice">
    					<!-- 공지사항 내용이 여기에 표시됩니다 -->
				</div>
            
            </div>
            <div class="message-input">
                <button id="emojiButton" class="emoji-button"><i class="fa fa-smile-o"></i></button>
                <input type="text" id="messageInput" placeholder="메시지를 입력하세요">
                <button id="sendButton">전송</button>
            </div>
        </div>
    </div>
</div>

<!-- Member Modal -->
<div id="header-memberModal" class="modal" style="display: none;">
  <div class="member-modal-content">
  	<div class="member-modal-header">
    	<span class="close-modal" onclick="closeModal('header-memberModal');">&times;</span>
    	<h5>메신져 생성</h5>
    	<button id="createChatButton">확인</button>
    </div>
    <div class="subject-div">
    	<input type="text" id="chatSubject" class="chatSubject" name="chat_subject" placeholder="제목을 작성하세요. " value=""/>
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

<div id="editChatSubjectModal" class="modal" style="display: none;">
    <div class="member-modal-content">
        <div class="member-modal-header">
            <span class="close-modal" onclick="closeModal('editChatSubjectModal');">&times;</span>
            <h5><i class="fas fa-edit"></i> 메신져 이름</h5>
        </div>
        <div class="subject-div">
    		<input type="text" id="newChatSubject" class="chatSubject" name="chat_subject" placeholder="제목을 작성하세요. " value=""/>
    	</div>
        <div class="modal-footer">
            <button type="button" class="btn confirmBtn" onclick="updateChatSubject()">수정</button>
            <button type="button" class="btn confirmBtn" onclick="closeModal('editChatSubjectModal');">취소</button>
        </div>
    </div>
</div>

<!-- Notice Modal -->
<div id="noticeModal" class="modal" style="display: none;">
    <div class="member-modal-content">
        <div class="member-modal-header">
            <span class="close-modal" onclick="closeModal('noticeModal');">&times;</span>
            <h5><i class="fas fa-bullhorn"></i> 공지사항</h5>
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
    <div class="member-modal-content">
        <div class="member-modal-header">
            <button type="button" class="close-modal" onclick="closeModal('confirmModal');">&times;</button>
        </div>
        <div class="header-modal-body">
            <p id="confirmMessage"></p>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn confirmBtn" id="confirmYes">확인</button>
            <button type="button" class="btn confirmBtn" onclick="closeModal('confirmModal');">취소</button>
        </div>
    </div>
</div>

<script>
loginId = parseInt(loginId);

function updateHeaderTitle(title) {
    const header = document.getElementById("modalHeaderTitle");
    if (header) {
        header.textContent = title; // 타이틀 업데이트
    } else {
        console.error("modalHeaderTitle 요소를 찾을 수 없습니다.");
    }

    // 타이틀에 따라 로드할 함수 호출
    if (title === "사원") {
        loadFriendList();
    } else if (title === "채팅") {
        loadChatContent();
    }
}

$(document).on("click", ".modal-icon div", function () {
    const title = $(this).data("title"); // data-title 속성 값 가져오기
    updateHeaderTitle(title);
});

$(document).ready(function () {
    updateHeaderTitle("채팅"); // 초기 실행
});

window.updateUnreadMessageCount = function (unreadTotal) {
    const newMessageIndicator = $("#newMessageIndicator"); // 특정 요소를 명확히 선택
    console.log("New Message Indicator:", newMessageIndicator); // 확인

    if (unreadTotal > 0) {
        // 읽지 않은 메시지가 있을 경우 업데이트 또는 생성
        let unreadCountContainer = newMessageIndicator.find(".unread-message-count");
        console.log("Unread Count Container Exists:", unreadCountContainer.length > 0);

        if (unreadCountContainer.length > 0) {
            // 기존 요소 업데이트
            unreadCountContainer.text(unreadTotal);
        } else {
            // 요소가 없으면 생성
            const unreadHTML =
                '<span class="unread-message-count">' + unreadTotal + '</span>';
            newMessageIndicator.append(unreadHTML);
            console.log("Unread Message Span Added:", unreadHTML);
        }

        // 표시
        newMessageIndicator.css("display", "block");
    } else {
        // 읽지 않은 메시지가 없으면 숨김
        newMessageIndicator.css("display", "none");
    }

    console.log("읽지 않은 메시지 총 수 업데이트:", unreadTotal);
};


$(document).ready(function () {
    // 페이지 로드 시 호출
    $.ajax({
        type: 'GET',
        url: 'unreadTotal.ajax',
        success: function (totalUnreadCount) {
            const newMessageIndicator = $(".newMessageIndicator");

            // 기존 내용 초기화
            newMessageIndicator.empty();

            if (totalUnreadCount > 0) {
                // 읽지 않은 메시지가 있으면 표시
                newMessageIndicator.append(
                        '<span class="unread-message-count">' + totalUnreadCount + '</span>'
                ).css("display", "block");
               
            } else {
                // 읽지 않은 메시지가 없으면 숨김
                newMessageIndicator.css("display", "none");
            }
        },
        error: function (xhr, status, error) {
            console.error("AJAX 요청 실패: ", error);
        }
    });
});


window.updateChatList = function (messageDataList) {
    const chatContainer = $("#chatContainer"); // 채팅 리스트를 표시하는 컨테이너

    // 최신순 정렬
    const sortedData = messageDataList
    .filter((data) => data.latest_time) // latest_time이 유효한 데이터만 포함
    .sort((a, b) => new Date(b.latest_time) - new Date(a.latest_time));


    chatContainer.empty(); // 기존 DOM 초기화

    sortedData.forEach(function (messageData) {
        const chatIdx = messageData.chat_idx;
        const chatTitle = messageData.chat_subject
            ? messageData.chat_subject
            : messageData.participants;

        // 읽지 않은 메시지 카운트
        const unreadCountText =
    		messageData.unread_count && Number(messageData.unread_count) > 0
       		? '<div class="unread-count-list"><span class="unread-message-count" id="unread-count-' +
          	chatIdx +
          	'">' +
          	messageData.unread_count +
          	"</span></div>"
        	: "";


        // DOM 생성 및 추가
        const chatItem =
            '<div class="chat-item" data-chat-idx="' +
            chatIdx +
            '">' +
            '<div class="chat-avatar">' +
            '<img src="/photo/' +
            messageData.photo +
            '" alt="프로필 사진" class="custom-image">' +
            "</div>" +
            '<div class="chat-details">' +
            '<div class="chat-header">' +
            '<span class="chat-title">' +
            chatTitle +
            "</span>" +
            '<span class="chat-time">' +
            formatDateTime(messageData.latest_time) +
            "</span>" +
            "</div>" +
            '<div class="chat-preview">' +
            '<span id="latest-message-' +
            chatIdx +
            '">' +
            messageData.latest_message +
            "</span>" +
            unreadCountText +
            "</div>" +
            "</div>" +
            "</div>";
        chatContainer.append(chatItem);
    });
};





function loadFriendList() {
	    const chatContainer = document.getElementById("chatContainer");
	    // 기존 AJAX 요청 사용
	    $.ajax({
	        type: "GET",
	        url: "chatList.ajax", // 기존 AJAX 요청 URL
	        data: { emp_idx: loginId, keyword: "" }, // 모든 사용자 리스트 요청
	        success: function (response) {
	            chatContainer.innerHTML = ""; // 기존 내용을 초기화

	            if (response.employeeList && response.employeeList.length > 0) {
	                // 로그인한 사용자와 나머지 사용자를 구분
	                var myProfile = null;
	                var otherEmployees = [];

	                response.employeeList.forEach(function (employee) {
	                    if (Number(employee.emp_idx) === Number(loginId)) {
	                        myProfile = employee; // 로그인한 사용자
	                    } else {
	                        otherEmployees.push(employee); // 나머지 사용자
	                    }
	                });

	                // 로그인한 사용자 정보를 상단에 추가
	                if (myProfile) {
	                    var myProfileItem =
	                        '<div class="image-header-wrapper my-profile" data-emp-idx="' + myProfile.emp_idx + '">' +
	                            '<img src="/photo/' + myProfile.photo + '" alt="프로필 사진" class="custom-image">' +
	                            '<span class="custom-label">' + myProfile.name + ' / </span>' +
	                            '<div class="mySelf"><span>나</span></div>' +
	                        '</div>';
	                    chatContainer.innerHTML += myProfileItem;
	                }

	                // 나머지 사용자 추가
	                otherEmployees.forEach(function (employee) {
	                    var memberItem =
	                        '<div class="image-header-wrapper member-item" data-emp-idx="' + employee.emp_idx + '">' +
	                            '<img src="/photo/' + employee.photo + '" alt="프로필 사진" class="custom-image">' +
	                            '<span class="custom-label">' + employee.name + ' / ' + employee.rank_name + '</span>' +
	                        '</div>';
	                    chatContainer.innerHTML += memberItem;
	                });
	                
	             // 사원 클릭 이벤트 추가
	                $(".member-item").on("click", function () {
	                    var empIdx = $(this).data("emp-idx");
	                    var empName = $(this).find(".custom-label").text();

	                    // 프로필 모달 열기
	                    openProfileModal(empIdx, empName);
	                });
	            } else {
	                chatContainer.innerHTML = "<p>등록된 사용자가 없습니다.</p>";
	            }
	        },
	        error: function () {
	            chatContainer.innerHTML = "<p>사용자 목록을 불러오는 데 실패했습니다.</p>";
	        },
	    });
	}



function loadChatContent() {
    const chatContainer = $("#chatContainer");
    chatContainer.empty(); // 기존 내용을 초기화

    $.ajax({
        type: "GET",
        url: "chatList.ajax",
        data: { emp_idx: loginId }, // 로그인한 사용자의 emp_idx
        success: function (response) {
            if (response.chatList && response.chatList.length > 0) {
                // 데이터를 updateChatList로 전달
                window.updateChatList(response.chatList);
            } else {
                chatContainer.html("<p>참여 중인 대화방이 없습니다.</p>");
            }
        },
        error: function () {
            chatContainer.html("<p>채팅방을 불러오는 데 실패했습니다.</p>");
        },
    });
}
	

	
	// 이미 정의된 openModal 함수 확인 및 개선
	function openModal(modalId, callback) {
	    $("#" + modalId).fadeIn(200, function () {
	        if (callback && typeof callback === "function") {
	            callback();
	        }
	    });
	}

	function closeModal(modalId) {
	    $("#" + modalId).fadeOut(200, function () {
	        // 채팅방 모달일 때만 WebSocket 세션 종료
	        if (modalId === "chatModalTemplate" && socket && socket.readyState === WebSocket.OPEN) {
	            socket.close(); // WebSocket 세션 종료
	            console.log("WebSocket 세션이 종료되었습니다.");
	            socket = null;
	            currentChatIdx = null;
	        }
	    });
	}


	// 프로필 모달 열기
	function openProfileModal(empIdx, empName) {
     openModal("header-profileModal", function () {
         // AJAX를 통해 데이터 가져오기
         $.ajax({
             url: "profile.ajax",
             type: "GET",
             data: { emp_idx: empIdx },
             success: function (profile) {
                 $("#header-profileModal .header-modal-body").html(
                		'<div class="profile-header">' +
                     	'<img src="/photo/' + profile.photo + '" alt="프로필 사진" class="custom-image">' +
                     	'<div>' +
                     		'<span>' + empName + '</span>' +
                     		'<span>' + (profile.state == 1 ? '<i class="fas fa-circle"></i> 근무 중' : '근무 종료') + '</span>' +
                     	'</div>' +
                     '</div>' +
                     '<ul>' +
                     	'<li><span>부서</span><span>'  + profile.depart_name + '</span></li>' +
                     	'<li><span>이메일</span><span>'  + profile.email + '</span></li>' +
                     	'<li><span>연락처</span><span>'  + profile.phone + '</span></li>' +
                     	'<li><span>핸드폰</span><span>'  + profile.mobile + '</span></li>' +
                     '</ul>'
                 );
                 $("#profileChat").off("click").on("click", function () {
                     openConfirmModal(profile.name + " 님과 대화를 시작하시겠습니까?", function () {
                         createChat("", [empIdx]); // 확인 후 방 생성
                     });
                 });
             },
             error: function () {
                 alert("프로필 정보를 가져오는 데 실패했습니다.");
             }
         });
     });
 }
	
	$(document).on("click", ".chat-item", function () {
	    const chatIdx = $(this).data("chat-idx"); // 클릭된 채팅방 ID
	    const chatTitle = $(this).find(".chat-title").text(); // 채팅방 제목

	    // 1. 모달 열기
	    openModal("chatModalTemplate", chatIdx);

	    // 2. 모달 제목 업데이트
	    $("#chatModalTemplate .modalHeaderTitle").text(chatTitle);

	    // 3. 메시지 로드
	    loadChatMessages(chatIdx);
	});
	
	function formatTimeToAmPm(timeString) {
        const options = { hour: 'numeric', minute: 'numeric', hour12: true };
        const formattedTime = new Date(timeString).toLocaleTimeString('ko-KR', options);
        return formattedTime.replace('AM', '오전').replace('PM', '오후');
    }
	
	
	function addMessageToUI(messageData, isMyMessage = false) {
        var messagesContainer = $("#messagesContainer");
        var messageElement = "";

        // 현재 메시지의 시간을 포맷팅
        var currentMessageTime = formatTimeToAmPm(messageData.time);

        if (messageData.message_type === "system") {
            // 시스템 메시지
            messageElement = '<div class="system-message" data-msg-idx="' + messageData.msg_idx + '" data-is-read="false">' + messageData.content + '</div>';
        } else if (isMyMessage) {
            // 내가 보낸 메시지
            messageElement =
                '<div class="send-messages" data-msg-idx="' + messageData.msg_idx + '" data-is-read="false">' +
                '<div class="time-and-number">' +
                '<div class="number">' + (messageData.unread_count > 0 ? messageData.unread_count : "") + '</div>' +
                '<div class="sent-time">' + currentMessageTime + '</div>' +
                '</div>' +
                '<div class="chat-bubble send-message">' + messageData.content + '</div>' +
                '</div>';
        } else {
            // 다른 사람이 보낸 메시지
            messageElement =
                '<div class="chat-message" data-msg-idx="' + messageData.msg_idx + '" data-is-read="false">' +
                '<div class="chat-profile">' +
                '<div class="profile-image">' +
                '<img src="/photo/' + messageData.photo + '" alt="프로필 사진" class="custom-image">' +
                '</div>' +
                '</div>' +
                '<div class="chat-bubble-container">' +
                '<div class="profile-name">' +
                '<span>' + messageData.name + ' / ' + messageData.rank_name + '</span>' +
                '</div>' +
                '<div class="content-div">' +
                '<div class="chat-bubble">' + messageData.content + '</div>' +
                '<div class="time-and-number2">' +
                '<div class="number">' + (messageData.unread_count > 0 ? messageData.unread_count : "") + '</div>' +
                '<div class="message-time">' + currentMessageTime + '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>';
        }

        // 동일한 시간이 이미 존재하면 제거
        messagesContainer.find(".sent-time:contains('" + currentMessageTime + "'), .message-time:contains('" + currentMessageTime + "')").remove();

        // 메시지를 UI에 추가
        messagesContainer.append(messageElement);

        // 메시지 컨테이너 스크롤을 아래로 이동
        messagesContainer.scrollTop(messagesContainer[0].scrollHeight);
    }

	var socket = null;
	var currentChatIdx = null;
	// 채팅방 메시지 로드
	function loadChatMessages(chatIdx) {
		
		currentChatIdx = chatIdx;
		
		if (chatIdx) {
			
			if (socket && socket.readyState === WebSocket.OPEN) {
	            socket.close();
	            console.log("이전 WebSocket 세션이 종료되었습니다.");
	        }
			
	        window.socket = new WebSocket("ws://localhost:8080/BEST/main/messenger?chat_idx=" + chatIdx);

	        socket.onopen = function() {
	            $.ajax({
	                type: "POST",
	                url: "updateConnectionTime",
	                contentType: "application/json",
	                data: JSON.stringify({
	                    chat_idx: chatIdx,
	                    action: "connect"
	                }),
	                success: function() {
	                    console.log("웹소켓 연결");
	                },
	                error: function() {
	                    console.error("Error recording connection time.");
	                }
	            });
	        };

	        var isFirstConnection = true; // 최초 WebSocket 연결 확인용

	        socket.onmessage = function(event) {
	            try {
	                var messageData = JSON.parse(event.data); // JSON 메시지 파싱
	                if (messageData.chat_idx !== parseInt(chatIdx)) {
	                    console.warn("다른 방 메시지 감지, 무시:", messageData.chat_idx, "내 방:", chatIdx);
	                    return;
	                }
	                
	                
	                if (messageData.type === "UPDATE_UNREAD_COUNT") {
	                    var msgIdx = messageData.msg_idx;
	                    var newCount = messageData.unread_count;
	                    var $msgDiv = $("[data-msg-idx='" + msgIdx + "']");
	                    $msgDiv.find(".number").text(newCount > 0 ? newCount : "");

	                } else if (messageData && messageData.content) {
	                    // WebSocket으로 수신된 새 메시지 처리
	                    var isMyMessage = messageData.msg_send_idx === loginId;
	                    addMessageToUI(messageData, isMyMessage);

	                } else {
	                    console.error("메시지 데이터에 content 필드가 없습니다:", messageData);
	                }
	            } catch (error) {
	                console.error("메시지 처리 중 오류 발생:", error);
	            }
	        };

	        socket.onclose = function() {
	            $.ajax({
	                type: "POST",
	                url: "updateConnectionTime",
	                contentType: "application/json",
	                data: JSON.stringify({
	                    chat_idx: chatIdx,
	                    action: "disconnect"
	                }),
	                success: function() {
	                    console.log("웹소켓 종료");
	                },
	                error: function() {
	                    console.error("Error recording connection time.");
	                }
	            });
	        };

	        socket.onerror = function(error) {
	            console.error("WebSocket 에러 발생:", error);
	        };
		}
		
		function updateChatNotice(noticeContent) {
            const chatNoticeDiv = $(".chat-notice");
            const messagesDiv = $(".messages"); // 메시지 영역

            if (noticeContent && noticeContent.trim() !== "") {
                const noticeHtml = '<i class="bi bi-megaphone-fill"></i>' + noticeContent;
                chatNoticeDiv.html(noticeHtml); // 아이콘 포함하여 HTML 업데이트
                chatNoticeDiv.show(); // 내용이 있으면 보이기
                messagesDiv.css("margin-top", chatNoticeDiv.outerHeight() + "px"); // 메시지 영역 여백 추가
            } else {
                chatNoticeDiv.hide(); // 내용이 없으면 숨기기
                messagesDiv.css("margin-top", "0"); // 여백 제거
            }
        }

        // 초기 공지사항 설정
        $.ajax({
            type: "GET",
            url: "getChatNotice.ajax",
            data: { chat_idx: currentChatIdx },
            success: function (response) {
                if (response.success) {
                    updateChatNotice(response.notice);
                }
            },
            error: function () {
                console.error("공지사항을 가져오는 데 실패했습니다.");
            },
        });

        // 공지사항 클릭 시 펼치기/접기
        $(document).on("click", ".chat-notice", function () {
            $(this).toggleClass("expanded"); // expanded 클래스 추가/제거
        });


	    $.ajax({
            type: "POST",
            url: "getMessages.ajax",
            contentType: "application/json",
            data: JSON.stringify({ chat_idx: chatIdx }),
            success: function(messages) {
                messages.forEach(function(message) {
                    if (message.message_type === "system") {
                        // 시스템 메시지 렌더링
                        addMessageToUI(message, false);
                    } else {
                        // 일반 메시지 렌더링
                        addMessageToUI(message, message.msg_send_idx === loginId);
                    }
                });

                // 메시지 컨테이너 스크롤 초기화
                $("#messagesContainer").scrollTop($("#messagesContainer")[0].scrollHeight);
            },
            error: function() {
                console.error("메시지 로드 중 오류 발생");
            }
        });
	    registerSendMessageHandler();
	}
	
	function sendMessage() {
	    const text = $("#messageInput").val().trim();

	    if (!text) {
	        alert("메시지를 작성해주세요.");
	        return;
	    }

	    const messageData = {
	        chat_idx: currentChatIdx,
	        content: text,
	        msg_send_idx: loginId,
	    };

	    // 메시지 저장 AJAX 호출
	    $.ajax({
	        type: "POST",
	        url: "message.ajax",
	        contentType: "application/json",
	        data: JSON.stringify(messageData),
	        success: function (response) {
	            messageData.msg_idx = response.msg_idx;
	            messageData.photo = response.photo;
	            messageData.name = response.name;

	            // 읽지 않은 사용자 수 조회
	            $.ajax({
	                type: "GET",
	                url: "unreadUserCount.ajax",
	                data: { msg_idx: response.msg_idx },
	                success: function (count) {
	                    messageData.unread_count = count;
	                    if (messageData.chat_idx === currentChatIdx) {
	                        socket.send(JSON.stringify(messageData));
	                    } else {
	                        console.warn("현재 활성 채팅방과 일치하지 않음, 메시지 전송 중단.");
	                    }
	                },
	                error: function () {
	                    console.error("읽지 않은 사용자 수 조회 실패");
	                },
	            });

	            // 입력창 초기화
	            $("#messageInput").val("");
	        },
	        error: function () {
	            console.error("메시지 저장 중 오류 발생");
	            alert("메시지 저장에 실패했습니다.");
	        },
	    });
	}

	// 이벤트 핸들러 등록 함수
	function registerSendMessageHandler() {
	    const sendButton = $("#sendButton");
	    const messageInput = $("#messageInput");

	    // 기존 이벤트 핸들러 제거
	    sendButton.off("click");
	    messageInput.off("keypress");

	    // 새로운 이벤트 핸들러 등록
	    sendButton.on("click", sendMessage);
	    messageInput.on("keypress", function (event) {
	        if (event.key === "Enter") {
	            sendMessage();
	        }
	    });
	}

	function openConfirmModal(message, onConfirm) {
        $("#confirmMessage").text(message); // 메시지 설정
        $("#confirmYes")
            .on("click", function () {
                onConfirm(); // 확인 작업 실행
                closeModal("confirmModal"); // 모달 닫기
            });
        openModal("confirmModal"); // 모달 열기
    }

	$("#createChatButton").off("click").on("click", function () {
        var chatSubject = $("#chatSubject").val().trim();
        var selectedMembers = [];

        // 체크된 체크박스의 emp_idx 값을 수집
        $("input[name='member']:checked").each(function () {
            selectedMembers.push(parseInt($(this).val())); // emp_idx를 숫자로 변환
        });

        if (!chatSubject && selectedMembers.length === 0) {
            return;
        }

        // 확인 모달 열기
        openConfirmModal("대화방을 생성하시겠습니까?", function () {
            createChat(chatSubject, selectedMembers); // 확인 후 대화방 생성
        });
    });
    // 대화방 생성 함수
    function createChat(chat_subject, emp_idx_list) {
    $.ajax({
        type: "POST",
        url: "createChat.do",
        contentType: "application/json; charset=UTF-8",
        data: JSON.stringify({
            chat_subject: chat_subject,
            emp_idx_list: emp_idx_list
        }),
        success: function (response) {
            if (response.success) {
            	if (response.existing) {
                    // 기존 대화방으로 모달 열기
                    openChatModal(response.chatIdx, chat_subject);
                } else {
                    // 새로 생성된 대화방으로 모달 열기
                    openChatModal(response.chatIdx, chat_subject);
                }
            } else {
                alert("대화방 생성에 실패했습니다. 다시 시도해주세요.");
            }
        },
        error: function () {
            alert("서버와 통신 중 문제가 발생했습니다.");
        }
    });
}

    function openMemberModal(actionType) {
        openModal("header-memberModal", function () {
            // actionType에 따라 멤버 리스트 로드
            if (actionType === "createChat") {
                loadMemberList(null); // 기본 멤버 리스트 로드
                $(".subject-div").show(); // 제목 입력 필드 보이기
            } else if (actionType === "addMembers") {
                loadPartyList(null); // 대화방 초대 멤버 리스트 로드
                $(".subject-div").hide(); // 제목 입력 필드 숨기기
            }

            // 확인 버튼 동작 설정
            const confirmButton = $("#createChatButton");
            confirmButton.off("click"); // 이전 이벤트 제거

            if (actionType === "createChat") {
                // 대화방 생성
                confirmButton.on("click", function () {
                    const chatSubject = $("#chatSubject").val().trim();
                    const selectedMembers = getSelectedMembers();

                    if (!chatSubject && selectedMembers.length === 0) {
                        alert("대화방 제목 또는 멤버를 선택하세요.");
                        return;
                    }

                    openConfirmModal("대화방을 생성하시겠습니까?", function () {
                        createChat(chatSubject, selectedMembers); // 대화방 생성 함수 호출
                    });
                });
            } else if (actionType === "addMembers") {
                // 대화방 초대
                confirmButton.on("click", function () {
                    addSelectedMembersToChat(); // 대화방 초대 함수 호출
                });
            }
        });
    }


    $(document).on('click', '.search-icon', function () {
        executeSearch();
    });

    $(document).on("keypress", "#memberSearchBar", function (e) {
        if (e.which === 13) {
            executeSearch();
        }
    });

    function executeSearch() {
        var keyword = $("#memberSearchBar").val().trim(); // 검색어 가져오기
        loadMemberList(keyword); // 검색 실행
    }

    function loadMemberList(keyword) {
        $.ajax({
            type: "GET",
            url: "memberList.ajax",
            data: { keyword: keyword || '' }, // 검색어 전달
            success: function (members) {
                var memberList = $("#memberList");
                memberList.empty(); // 기존 리스트 초기화

                if (members && members.length > 0) {
                    members.forEach(function (member) {
                        // 로그인한 사용자는 리스트에서 제외
                        if (Number(member.emp_idx) === Number(loginId)) {
                            return; // 해당 항목을 건너뜀
                        }

                        // 다른 멤버 정보 생성
                        var memberItem = 
                            '<div class="radio-container">' +
                                '<label>' +
                                    '<div>' +
                                        '<img src="/photo/' + member.photo + '" alt="프로필 사진" class="custom-image"> ' +
                                        '<span>' + member.name + ' / ' + member.rank_name + '</span>' +
                                    '</div>' +
                                    '<div>' +
                                        '<input type="checkbox" name="member" value="' + member.emp_idx + '">' +
                                    '</div>' +
                                '</label>' +
                            '</div>';
                        memberList.append(memberItem);
                    });
                } else {
                    memberList.html("<p>검색된 회원이 없습니다.</p>");
                }
            },
            error: function () {
                alert("회원 리스트를 불러오는 데 실패했습니다.");
            }
        });
    }



    $(document).ready(function () {
        // 체크박스 상태 변경 이벤트
        $(document).on("change", "input[name='member']", function () {
            var selectedMembersContainer = $("#selectedMembersContainer"); // 선택된 회원 표시 영역
            var memberName = $(this).closest("label").find("span").text(); // 체크박스 옆의 회원 이름
            var memberId = $(this).val(); // 체크박스의 값 (emp_idx)
            var memberPhoto = $(this).closest("label").find("img").attr("src"); // 회원 프로필 사진 경로

            if ($(this).is(":checked")) {
                // 체크박스 선택 시
                var memberElement = 
                	'<div class="selected-member-container" data-member-id="' + memberId + '">' +
                        '<span><img src="' + memberPhoto + '" class="custom-image">' +
                        '<i class="fas fa-times remove-member" data-member-id="' + memberId + '"></i></span>' +
                    	'<span class="selected-member" data-member-id="' + memberId + '">' + memberName +
                    	'</span>' +
                    '</div>';
                selectedMembersContainer.append(memberElement);
            } else {
                // 체크박스 선택 해제 시
            	selectedMembersContainer.find('.selected-member-container[data-member-id="' + memberId + '"]').remove();
            }
        });

        // 선택된 회원의 제거 아이콘 클릭 이벤트
        $(document).on("click", ".remove-member", function () {
            var memberId = $(this).data("member-id");
            // 체크박스 선택 해제
            $('input[name="member"][value="' + memberId + '"]').prop("checked", false).trigger("change");
            // 선택된 멤버 제거
            $(this).closest('.selected-member-container').remove();
        });
        $(document).on("click", ".close-modal", function () {
            $(".selected-member-container").empty(); // 선택된 멤버 표시 영역 초기화
            $("input[name='member']").prop("checked", false).trigger("change"); // 모든 체크박스 선택 해제
        });

        // 바깥 영역 클릭 시 모달 닫히는 경우 처리
        $(document).on("click", function (e) {
            if ($(e.target).is("#header-memberModal")) {
                $(".selected-member-container").empty(); // 선택된 멤버 표시 영역 초기화
                $("input[name='member']").prop("checked", false).trigger("change"); // 모든 체크박스 선택 해제
                $("#header-memberModal").fadeOut();
            }
        });
    });


    $(document).ready(function () {
        // 제목 글자 수 제한
        $(".chatSubject").on("input", function () {
            const maxLength = 50;
            const currentLength = $(this).val().length;

            if (currentLength > maxLength) {
                alert("제목은 최대 50글자까지 입력 가능합니다.");
                $(this).val($(this).val().substring(0, maxLength)); // 초과된 내용 제거
            }
        });
    });
    
    function openChatModal(chatIdx, chatSubject) {
        // 모달 내부 내용 업데이트
        $('#chatModalTemplate .modalHeaderTitle').text(chatSubject);  // 제목 업데이트
        $('#messagesContainer').empty(); // 기존 메시지 초기화
        loadChatMessages(chatIdx); // 채팅 메시지 로드

        // 모달 열기 (기존 openModal 함수 사용)
        openModal('chatModalTemplate');
    }
    
    function showParticipantsDropdown() {
        const dropdown = $("#participantsDropdown");

        // 드롭다운 토글
        if (dropdown.is(":visible")) {
            dropdown.hide();
            return;
        }

        const chatIdx = currentChatIdx; // 현재 활성 채팅방 ID
        if (!chatIdx) {
            console.error("현재 활성 채팅방 ID가 없습니다.");
            return;
        }

        // Ajax 요청으로 참여자 데이터 가져오기
        $.ajax({
            type: "GET",
            url: "chatParticipants.ajax",
            data: { chat_idx: chatIdx },
            success: function (participants) {
                const memberListContainer = $(".member-list");
                memberListContainer.empty(); // 기존 리스트 초기화

                if (participants && participants.length > 0) {
                    // 로그인한 사용자와 다른 사용자 분리
                    const myProfile = participants.find(function(p) { return Number(p.emp_idx) === Number(loginId); });
                    const otherParticipants = participants.filter(function(p) { return Number(p.emp_idx) !== Number(loginId); });

                    // 로그인한 사용자 표시
                    if (myProfile) {
                        const myProfileElement = 
                        	'<div class="image-header-wrapper my-profile" data-emp-idx="' + myProfile.emp_idx + '">' +
                            	'<img src="/photo/' + myProfile.photo + '" alt="프로필 사진" class="custom-image">' +
                           		'<span class="custom-label">' + myProfile.name + ' / </span>' +
                            	'<div class="mySelf"><span>나</span></div>' +
                        	'</div>';
                        memberListContainer.append(myProfileElement);
                    }

                    // 다른 사용자 표시
                    otherParticipants.forEach(function(participant) {
                        const participantElement = 
                        	'<div class="image-header-wrapper member-item" data-emp-idx="' + participant.emp_idx + '">' +
                        		'<img src="/photo/' + participant.photo + '" alt="프로필 사진" class="custom-image">' +
                        		'<span class="custom-label">' + participant.name + ' / ' + participant.rank_name + '</span>' +
                    		'</div>';
                        memberListContainer.append(participantElement);
                    });
                    
                    $(".member-item").on("click", function () {
	                    var empIdx = $(this).data("emp-idx");
	                    var empName = $(this).find(".custom-label").text();

	                    // 프로필 모달 열기
	                    openProfileModal(empIdx, empName);
	                });
                } else {
                    memberListContainer.html("<p>참여자가 없습니다.</p>");
                }
                
                const inviteElement =
                	'<div class="image-header-wrapper" onclick="openMemberModal(\'addMembers\')">' +
                    '<span class="custom-label"><i class="fas fa-plus-circle"></i> 대화 상대 초대</span>' +
                    '</div>';
                memberListContainer.append(inviteElement);

                // 드롭다운 표시
                dropdown.show();
            },
            error: function() {
                alert("참여자 리스트를 불러오는 데 실패했습니다.");
            }
        });
    }

    // 바깥 영역 클릭 시 드롭다운 닫기
    $(document).on("click", function (e) {
        const dropdown = $("#participantsDropdown");
        if (!$(e.target).closest(".messengerUser, #participantsDropdown").length) {
            dropdown.hide();
        }
    });

    

    
    function loadPartyList(keyword) {
    	    $.ajax({
    	        type: "GET",
    	        url: "chatParty.ajax",
    	        data: { keyword: keyword || '' , chat_idx: currentChatIdx}, // 검색어 전달
    	        success: function (members) {
    	            var memberList = $("#memberList");
    	            memberList.empty(); // 기존 리스트 초기화

    	            if (members && members.length > 0) {
    	                members.forEach(function (member) {
    	                    var memberItem = 
    	                        '<div class="radio-container">' +
    	                            '<label>' +
    	                                '<div>' +
    	                                    '<img src="/photo/' + member.photo + '" alt="프로필 사진" class="custom-image"> ' +
    	                                    '<span>' + member.name + ' / ' + member.rank_name + '</span>' +
    	                                '</div>' +
    	                                '<div>' +
    	                                    '<input type="checkbox" name="member" value="' + member.emp_idx + '">' +
    	                                '</div>' +
    	                            '</label>' +
    	                        '</div>';
    	                    memberList.append(memberItem);
    	                });
    	            } else {
    	                memberList.html("<p>검색된 회원이 없습니다.</p>");
    	            }
    	        },
    	        error: function () {
    	            alert("회원 리스트를 불러오는 데 실패했습니다.");
    	        }
    	    });
    	}
    
    
    function addSelectedMembersToChat() {
	    var selectedMembers = [];

	    // 체크된 체크박스의 emp_idx 값을 수집
	    $("input[name='member']:checked").each(function () {
	        selectedMembers.push(parseInt($(this).val())); // emp_idx를 숫자로 변환
	    });

	    if (selectedMembers.length === 0) {
	        alert("추가할 회원을 선택해주세요.");
	        return;
	    }

	    // 확인 모달 열기
	    openConfirmModal("대화방에 초대하시겠습니까?", function () {
	        // 확인 버튼 클릭 시 회원 추가 AJAX 요청
	        $.ajax({
	            type: "POST",
	            url: "addParty.ajax",
	            contentType: "application/json; charset=UTF-8", // Content-Type을 JSON으로 설정
	            data: JSON.stringify({ chat_idx: currentChatIdx, emp_idx_list: selectedMembers }),
	            success: function (response) {
	                if (response.success) {
	                	openChatModal(currentChatIdx);
	                	closeModal("header-memberModal");
	                } else {
	                    alert(response.message || "회원 추가에 실패했습니다.");
	                }
	            },
	            error: function () {
	                alert("회원 추가 중 오류가 발생했습니다.");
	            },
	        });
	    });
	}
    
    
    function toggleChatMenu() {
        const dropdown = $("#chatMenuDropdown");

        // 드롭다운 토글
        if (dropdown.is(":visible")) {
            dropdown.hide();
        } else {
            dropdown.show();

            // 바깥 영역 클릭 시 닫기
            $(document).off("click.chatMenu").on("click.chatMenu", function (e) {
                if (!$(e.target).closest(".messengerBar, #chatMenuDropdown").length) {
                    dropdown.hide();
                    $(document).off("click.chatMenu"); // 이벤트 제거
                }
            });
        }
    }

    function updateChatSubject() {
        var chatIdx = currentChatIdx;
        var newChatSubject = $("#newChatSubject").val().trim();

        if (!newChatSubject) {
            alert("제목을 입력해주세요.");
            return;
        }

        // 확인 모달 열기
        openConfirmModal("대화방 제목을 '" + newChatSubject + "'(으)로 변경하시겠습니까?", function () {
            // 확인 버튼 클릭 시 AJAX 요청
            $.ajax({
                type: "POST",
                url: "updateChatSubject.ajax",
                contentType: "application/json; charset=UTF-8",
                data: JSON.stringify({ chat_idx: String(chatIdx), chat_subject: newChatSubject }),
                success: function (response) {
                    if (response.success) {
                        $(".naviPath .purple").text(newChatSubject);
                        closeModal("editChatSubjectModal"); // 수정 모달 닫기
                        openChatModal(chatIdx);
                    } else {
                        alert(response.message || "대화방 제목 수정에 실패했습니다.");
                    }
                },
                error: function () {
                    alert("대화방 제목 수정 중 오류가 발생했습니다.");
                },
            });
        });
    }

    	function submitNotice() {
            const noticeContent = $("#noticeContent").val().trim();
            const chatIdx = currentChatIdx; // URL에서 chat_idx 가져오기

            if (!noticeContent) {
                alert("공지사항 내용을 입력해주세요.");
                return;
            }

            if (!chatIdx) {
                alert("채팅방 정보(chat_idx)가 없습니다.");
                return;
            }

            openConfirmModal("공지사항을 등록하시겠습니까?", function () {
                // 공지사항 등록 AJAX 요청
                $.ajax({
                    type: "POST",
                    url: "registerNotice.ajax",
                    contentType: "application/json",
                    data: JSON.stringify({ content: noticeContent, chat_idx: chatIdx }), // chat_idx 포함
                    success: function (response) {
                        if (response.success) {
                            closeModal("noticeModal");
                            openChatModal(chatIdx);
                        } else {
                            alert(response.message || "공지사항 등록에 실패했습니다.");
                        }
                    },
                    error: function () {
                        alert("공지사항 등록 중 오류가 발생했습니다.");
                    },
                });
            });
        };

    $(document).ready(function () {
        // 제목 글자 수 제한
        $(".chatSubject").on("input", function () {
            const maxLength = 20;
            const currentLength = $(this).val().length;

            if (currentLength > maxLength) {
                alert("제목은 최대 20글자까지 입력 가능합니다.");
                $(this).val($(this).val().substring(0, maxLength)); // 초과된 내용 제거
            }
        });

        // 공지사항 글자 수 제한
        $("#noticeContent").on("input", function () {
            const maxLength = 50;
            const currentLength = $(this).val().length;

            if (currentLength > maxLength) {
                alert("공지사항은 최대 50글자까지 입력 가능합니다.");
                $(this).val($(this).val().substring(0, maxLength)); // 초과된 내용 제거
            }
        });
        
        // 메시지 글자 수 제한
        $("#messageInput").on("input", function () {
            const maxLength = 50;
            const currentLength = $(this).val().length;

            if (currentLength > maxLength) {
                alert("메시지는 최대 50글자까지 입력 가능합니다.");
                $(this).val($(this).val().substring(0, maxLength)); // 초과된 내용 제거
            }
        });
    });
    
    function leaveChat() {
        var chatIdx = currentChatIdx;

        if (!chatIdx) {
            alert("방 정보를 찾을 수 없습니다.");
            return;
        }

        // 확인 모달 열기
        openConfirmModal("이 대화방에서 나가시겠습니까?", function () {
            // 확인 버튼 클릭 시 방 나가기 AJAX 요청
            $.ajax({
                type: "POST",
                url: "leaveChat.ajax",
                data: { chat_idx: chatIdx },
                success: function (response) {
                    if (response.success) {
                    	location.reload(); // 방 나가기 후 이동할 페이지
                    } else {
                        alert(response.message || "방 나가기에 실패했습니다.");
                    }
                },
                error: function () {
                    alert("방 나가기 요청 중 오류가 발생했습니다.");
                },
            });
        });
    }
    
    
    
    
    


	// 메시지 포맷팅
	function formatDateTime(timestamp) {
	    if (!timestamp) return "";

	    const now = new Date();
	    const date = new Date(timestamp);

	    const isToday =
	        now.getFullYear() === date.getFullYear() &&
	        now.getMonth() === date.getMonth() &&
	        now.getDate() === date.getDate();

	    const isThisYear = now.getFullYear() === date.getFullYear();

	    if (isToday) {
	        return date.toLocaleString("ko-KR", {
	            hour: "numeric",
	            minute: "numeric",
	            hour12: true,
	        }).replace("AM", "오전").replace("PM", "오후");
	    } else if (isThisYear) {
	        return (date.getMonth() + 1) + "월 " + date.getDate() + "일";
	    } else {
	        return date.getFullYear() + ". " + (date.getMonth() + 1) + ". " + date.getDate();
	    }
	}

</script>

<script type="module">
import { EmojiButton } from 'https://cdn.jsdelivr.net/npm/@joeattardi/emoji-button@4.6.4/dist/index.js';

// 이모지 피커 초기화
const picker = new EmojiButton({
  position: 'top-start', // 피커 위치
  zIndex: 9999, // 피커가 다른 요소 위에 표시되도록
});

// 버튼 및 입력창 참조
$(document).on('click', '.emoji-button', function () {
  const emojiButton = this; // 클릭된 이모지 버튼 참조
  const messageInput = $(emojiButton).siblings('input'); // 해당 버튼 옆의 입력창 참조

  picker.togglePicker(emojiButton); // 피커 열기/닫기

  // 이모지 선택 시 이벤트
  picker.on('emoji', (emoji) => {
    if (messageInput.length) {
      messageInput.val(messageInput.val() + emoji.emoji); // 입력창에 이모지 추가
    } else {
      console.error('입력창을 찾을 수 없습니다.');
    }
  });
});
</script>


</html>
