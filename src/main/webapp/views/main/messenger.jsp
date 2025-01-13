<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">
  <title>BEST</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link href="resources/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="resources/css/app-style.css" rel="stylesheet"/>
  <script src="resources/js/bootstrap.min.js"></script>
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
	height: 100%;
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
    overflow-y: auto; /* 세로 스크롤 활성화 */
    box-sizing: border-box;
    height: 90%;
}
.message-modal-body::-webkit-scrollbar {
	display: none;
}
.message-modal-content {
    position: fixed;
    background-color: #30005A;
    padding: 10px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    width: 400px;
    max-width: 90%;
    text-align: center;
    height: 500px;
    right: 0; /* 오른쪽 끝으로 위치 지정 */
    top: 50px; /* 헤더와 약간의 간격을 줌 */
}
.message-modal {
    background-color: #30005A;
    position: fixed;
    top: 0;
    right: 0; /* 오른쪽 끝으로 위치 지정 */
    z-index: 1050;
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
.header-modal-content {
    position: fixed;
    background-color: #30005A;
    padding: 10px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    width: 400px;
    max-width: 90%;
    text-align: center;
    height: 500px;
    overflow-y: auto;
    right: 0; /* 오른쪽 끝으로 위치 지정 */
    top: 50px; /* 헤더와 약간의 간격을 줌 */
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
	max-width: 440px;
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
}
.messenger-header{
	display: flex;
    align-items: center !important;
    justify-content: space-between;
}
.modalHeaderTitle{
	color: #FFFBF2;
}
.modal-icon{
    width: 200px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    gap: 20px;
    margin-left: -104px;
}
.modal-icon div{
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
.member-list {
	width: 100%;
	background-color: #30005A;
	padding: 10px;
	display: flex;
	flex-direction: column;
	gap: 10px;
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
  </style>
</head>

<body>
	<div class="messenger-body">
        <div class="messenger-header">
            <h4 id="modalHeaderTitle" class="modalHeaderTitle"></h4>
            <div class="modal-icon">
    			<div data-title="사원">
        			<i class="fa-solid fa-user"></i>
    			</div>
    			<div data-title="채팅">
        			<i class="fa-solid fa-comment"></i>
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
            <h4 class="modalHeaderTitle"></h4>
            <span class="close-modal" style="color: #FFFBF2;" onclick="closeModal('chatModalTemplate');">&times;</span>
        </div>
        <div class="message-modal-body">
            <div class="messages" id="messagesContainer"></div>
            <div class="message-input">
                <button id="emojiButton" class="emoji-button"><i class="fa fa-smile-o"></i></button>
                <input type="text" id="messageInput" placeholder="메시지를 입력하세요">
                <button id="sendMessageButton">전송</button>
            </div>
        </div>
    </div>
</div>


<script>
var loginId = ${sessionScope.loginId};
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
	                response.chatList.forEach(function (chat) {
	                    const chatTitle = chat.chat_subject || chat.participants;
	                    const latestMessage = chat.latest_message || "메시지가 없습니다.";

	                    const chatItem =
	                    	'<div class="chat-item" data-chat-idx="' + chat.chat_idx + '">' +
	                            '<div class="chat-avatar">' +
	                                '<img src="/photo/' + chat.photo + '" alt="프로필 사진" class="custom-image">' +
	                            '</div>' +
	                            '<div class="chat-details">' +
	                                '<div class="chat-header">' +
	                                    '<span class="chat-title">' + chatTitle + '</span>' +
	                                    '<span class="chat-time">' + formatDateTime(chat.latest_time) + '</span>' +
	                                '</div>' +
	                                '<div class="chat-preview">' + latestMessage + '</div>' +
	                            '</div>' +
	                        '</div>';
	                    chatContainer.append(chatItem);
	                });
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
	    $("#" + modalId).fadeOut();
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


	// 채팅방 메시지 로드
	function loadChatMessages(chatIdx) {
		
		
		if (chatIdx) {
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
	                    console.log("Connection time recorded successfully.");
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
	                    console.log("Connection time recorded successfully.");
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
                $("#messages").scrollTop($("#messages")[0].scrollHeight);
            },
            error: function() {
                console.error("메시지 로드 중 오류 발생");
            }
        });
	}

	// 메시지 전송
	function sendMessage(chatIdx) {
	    const messageInput = $("#messageInput-" + chatIdx);
	    const text = messageInput.val().trim();

	    if (text) {
         var messageData = {
             chat_idx: chatIdx,
             content: text,
             msg_send_idx: loginId
         };

         // 메시지 저장 AJAX 호출
         $.ajax({
             type: "POST",
             url: "message.ajax",
             contentType: "application/json",
             data: JSON.stringify(messageData),
             success: function (response) {
              	// 메시지 ID 추가
                 // 저장된 메시지 데이터 업데이트
         		messageData.msg_idx = response.msg_idx;
         		messageData.photo = response.photo;
         		messageData.name = response.name;
                 // 읽지 않은 사용자 수 조회
                 $.ajax({
                     type: "GET",
                     url: "unreadUserCount.ajax",
                     data: { msg_idx: response.msg_idx },
                     success: function(count) {
                         // 읽지 않은 사용자 수 추가
                         messageData.unread_count = count;
							
                      // WebSocket으로 메시지와 count 전송
                         socket.send(JSON.stringify(messageData));
                     },
                     error: function() {
                         console.error("읽지 않은 사용자 수 조회 실패");
                     }
                 });

                 // 입력창 초기화
                 messageInput.val("");
             },
             error: function () {
                 console.error("메시지 저장 중 오류 발생");
                 alert("메시지 저장에 실패했습니다.");
             }
         });
     } else {
         alert("메시지를 작성해주세요.");
     }
 }
	$(document).on("keypress", "input[id^='messageInput-']", function (event) {
	    if (event.key === "Enter") {
	        const chatIdx = $(this).attr("id").split("-")[1]; // input의 ID에서 chatIdx 추출
	        sendMessage(chatIdx);
	    }
	});



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
