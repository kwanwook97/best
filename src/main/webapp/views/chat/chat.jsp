<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- <script src="resources/js/chat.js"></script> -->
  <link href="resources/css/chat2.css" rel="stylesheet"/>

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
					    <i class="fas fa-star"></i> <!-- 별표 -->
					    <i class="fas fa-cog"></i> <!-- 설정 -->
					</div>
				</div>
				
		    </div>
		  </div>
	</div>
</body>



<div id="memberModal" class="modal" style="display: none;">
  <div class="modal-content">
    <span class="close-modal" onclick="closeModal();">&times;</span>
    <h3>메신져 초대</h3>
    <div class="member-list-container">
      <ul id="memberList">
        <!-- 회원 리스트가 여기에 추가됩니다 -->
      </ul>
    </div>
  </div>
</div>



<script>

window.updateChatList = function(messageDataList) {
    const sidebar = $(".sidebar");

    for (const messageData of messageDataList) {
        const chatIdx = messageData.chat_idx;
        const chatTitle = messageData.chat_subject ? messageData.chat_subject : messageData.participants;

        // chat_idx에 해당하는 대화방 항목 찾기
        const chatItem = sidebar.find('.chat-item[data-chat-idx="' + chatIdx + '"]');

        if (chatItem.length > 0) {
            // 기존 항목 업데이트
            chatItem.find(".chat-preview").text(messageData.latest_message);
            chatItem.find(".chat-time").text(formatTime(messageData.latest_time));

            // 읽지 않은 메시지 숫자 업데이트
            const unreadCountContainer = chatItem.find(".unread-message-count");
            if (messageData.unread_count && messageData.unread_count > 0) {
                if (unreadCountContainer.length > 0) {
                    unreadCountContainer.text(messageData.unread_count); // 기존 엘리먼트가 있으면 업데이트
                } else {
                    const unreadCountText = '<div class="unread-count-list"><span class="unread-message-count" id="unread-count-' + chatIdx + '">' 
                                            + messageData.unread_count + '</span></div>';
                    chatItem.find(".chat-preview").append(unreadCountText); // 없으면 새로 추가
                }
            } else {
                unreadCountContainer.remove(); // 읽지 않은 메시지가 없으면 제거
            }

            // 항목을 리스트 맨 위로 이동
            chatItem.prependTo(sidebar);

            // 새로운 항목 추가
            const newChatItem =
                '<div class="chat-item" data-chat-idx="' + chatIdx + '">' +
                    '<div class="chat-avatar">' +
                        '<img src="/photo/' + messageData.photo + '" alt="Avatar">' +
                    '</div>' +
                    '<div class="chat-details">' +
                        '<div class="chat-header">' +
                            '<span class="chat-title">' + chatTitle + '</span>' +
                            '<span class="chat-time">' + formatTime(messageData.latest_time) + '</span>' +
                        '</div>' +
                        '<div class="chat-preview">' + messageData.latest_message + '</div>' +
                        unreadCountText +
                    '</div>' +
                '</div>';
            sidebar.prepend(newChatItem);
        }
    }
};



// 시간 포맷팅 함수
function formatTime(timestamp) {
    var options = { hour: "numeric", minute: "numeric", hour12: true };
    var formattedTime = new Date(timestamp).toLocaleTimeString("ko-KR", options);
    return formattedTime.replace("AM", "오전").replace("PM", "오후");
}




window.socket = null;

function switchPage(){
	if (window.socket && window.socket.readyState === WebSocket.OPEN) {
		 console.log("Closing old WebSocket before moving to new chat room...");
		 window.socket.close(1000, "Switching chat room");
		}
	location.href = "chatList.go";
}
//전역 함수
function switchChatRoom(newChatIdx) {
if (window.socket && window.socket.readyState === WebSocket.OPEN) {
 console.log("Closing old WebSocket before moving to new chat room...");
 window.socket.close(1000, "Switching chat room");
}
location.href = "chat.go?chat_idx=" + newChatIdx;
}


$(document).ready(function() {
    var chatIdx = new URLSearchParams(window.location.search).get("chat_idx"); // URL에서 chat_idx 가져오기
    var loginId = ${sessionScope.loginId};
    loginId = parseInt(loginId);


    var isFirstConnection = true; // 최초 WebSocket 연결 확인용

    function formatTimeToAmPm(timeString) {
        const options = { hour: 'numeric', minute: 'numeric', hour12: true };
        const formattedTime = new Date(timeString).toLocaleTimeString('ko-KR', options);
        return formattedTime.replace('AM', '오전').replace('PM', '오후');
    }

    function addMessageToUI(messageData, isMyMessage = false) {
        var messagesContainer = $("#messages");
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
                '<span>' + messageData.name + '</span>' +
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



    if (chatIdx) {
        console.log("선택된 chat_idx:", chatIdx);

        window.socket = new WebSocket("ws://localhost:8080/BEST/chat/chat?chat_idx=" + chatIdx);

        socket.onopen = function() {
            console.log("WebSocket 연결 성공 - chat_idx:", chatIdx);
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
                console.log("수신 메시지 데이터:", messageData);
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

                    // 최신 메시지 갱신
                    /* updateChatListWithLatestMessage(messageData); */
                } else {
                    console.error("메시지 데이터에 content 필드가 없습니다:", messageData);
                }
            } catch (error) {
                console.error("메시지 처리 중 오류 발생:", error);
            }
        };

        socket.onclose = function() {
            console.log("WebSocket 연결 종료");
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
        

            $.ajax({
                type: "GET",
                url: "chatList.ajax",
                data: {emp_idx : loginId},
                success: function (response) {
                    var sidebar = $(".sidebar");

                    // 날짜 및 시간 포맷팅 함수
                    function formatDateTime(latestTime) {
                        if (!latestTime) return "";
                        const now = new Date();
                        const messageDate = new Date(latestTime);
                        const isToday =
                            now.getFullYear() === messageDate.getFullYear() &&
                            now.getMonth() === messageDate.getMonth() &&
                            now.getDate() === messageDate.getDate();
                        const isThisYear = now.getFullYear() === messageDate.getFullYear();

                        if (isToday) {
                            return messageDate.toLocaleString("ko-KR", {
                                hour: "numeric",
                                minute: "numeric",
                                hour12: true,
                            });
                        } else if (isThisYear) {
                            return (messageDate.getMonth() + 1) + "월 " + messageDate.getDate() + "일";
                        } else {
                            return messageDate.getFullYear() + ". " + (messageDate.getMonth() + 1) + ". " + messageDate.getDate();
                        }
                    }

                    // 대화방 리스트가 있을 때
                    if (response.chatList && response.chatList.length > 0) {
                        sidebar.empty();
                        response.chatList.forEach(function (chat) {
                            var latestMessage = chat.latest_message || "메시지가 없습니다.";
                            var latestTime = chat.latest_time ? formatDateTime(chat.latest_time) : "";

                            // 제목이 null인지 확인하여 제목 또는 참여자 표시
                            var chatTitle;
                            if (chat.chat_subject === null || chat.chat_subject === "") {
                                chatTitle = chat.participants;
                            } else {
                                chatTitle = chat.chat_subject;
                            }

                            // 현재 페이지의 chatIdx
                            // (만약 전역 변수로 chatIdx가 있다면 그대로 사용)
                            var currentChatIdx = new URLSearchParams(window.location.search).get("chat_idx");

                            if (chat.chat_idx.toString() === currentChatIdx) {
                                // 상단 .purple 표시 갱신
                                $(".naviPath .purple").text(chatTitle);
                            }

                            // "읽지 않은 메시지 수"를 표시할 수 있는 필드
                            var unreadCountText = "";
                            if (chat.unread_count && chat.unread_count > 0) {
                                unreadCountText = '<div class="unread-count-list"><span class="unread-message-count" id="unread-count-' + chat.chat_idx + '">' 
                                                  + chat.unread_count + '</span></div>';
                            } else {
                                unreadCountText = '<span class="unread-message-count" id="unread-count-' + chat.chat_idx + '"></span>';
                            }

                            var chatItem =
                                '<div class="chat-item" data-chat-idx="' + chat.chat_idx + '" onclick="switchChatRoom(' + chat.chat_idx + ')">' +
                                  '<div class="chat-avatar">' +
                                    '<img src="/photo/' + chat.photo + '" alt="프로필 사진" class="custom-image">' +
                                  '</div>' +
                                  '<div class="chat-details">' +
                                    '<div class="chat-header">' +
                                      '<span class="chat-title">' + chatTitle + '</span>' +
                                      '<span class="chat-time">' + latestTime + '</span>' +
                                    '</div>' +
                                    '<div class="chat-preview">' +
                                      '<span id="latest-message-' + chat.chat_idx + '">' + latestMessage + '</span>' +
                                       unreadCountText +
                                    '</div>' +
                                  '</div>' +
                                '</div>';
                            sidebar.append(chatItem);
                        });
                    } else {
                        sidebar.html("<p>참여 중인 대화방이 없습니다.</p>");
                    }
                },
                error: function () {
                    console.warn("대화방 리스트를 불러오는 데 실패했습니다.");
                }
            });


        
        /* $.ajax({
            type: "GET",
            url: "chatList.ajax",
            success: function (response) {
                var sidebar = $(".sidebar");

                // 날짜 및 시간 포맷팅 함수
                function formatDateTime(latestTime) {
                    if (!latestTime) return "";

                    const now = new Date();
                    const messageDate = new Date(latestTime);

                    const isToday =
                        now.getFullYear() === messageDate.getFullYear() &&
                        now.getMonth() === messageDate.getMonth() &&
                        now.getDate() === messageDate.getDate();

                    const isThisYear = now.getFullYear() === messageDate.getFullYear();

                    if (isToday) {
                        return messageDate.toLocaleString("ko-KR", {
                            hour: "numeric",
                            minute: "numeric",
                            hour12: true,
                        });
                    } else if (isThisYear) {
                        return (messageDate.getMonth() + 1) + "월 " + messageDate.getDate() + "일";
                    } else {
                        return messageDate.getFullYear() + ". " + (messageDate.getMonth() + 1) + ". " + messageDate.getDate();
                    }
                }

             // 대화방 리스트 렌더링
                if (response.chatList && response.chatList.length > 0) {
                    sidebar.empty();
                    response.chatList.forEach(function (chat) {
                        var latestMessage = chat.latest_message || "메시지가 없습니다.";
                        var latestTime = chat.latest_time ? formatDateTime(chat.latest_time) : "";

                        // 제목이 null인지 확인하여 제목 또는 참여자 표시
                        var chatTitle;
                        if (chat.chat_subject === null || chat.chat_subject === "") {
                            chatTitle = chat.participants;
                        } else {
                            chatTitle = chat.chat_subject;
                        }
                        if (chat.chat_idx.toString() === chatIdx) {
                            $(".naviPath .purple").text(chatTitle);
                        }

                        var chatItem =
                            '<div class="chat-item" data-chat-idx="' + chat.chat_idx + '" onclick="switchChatRoom(' + chat.chat_idx + ')">' +
                            '<div class="chat-avatar">' +
                            '<img src="/photo/' + chat.photo + '" alt="프로필 사진" class="custom-image">' +
                            '</div>' +
                            '<div class="chat-details">' +
                            '<div class="chat-header">' +
                            '<span class="chat-title">' + chatTitle + '</span>' +
                            '<span class="chat-time">' + latestTime + '</span>' +
                            '</div>' +
                            '<div class="chat-preview">' +
                            '<span id="latest-message-' + chat.chat_idx + '">' + latestMessage + '</span>' +
                            '<span class="unread-message-count" id="unread-count-' + chat.chat_idx + '"></span>' +
                            '</div>' +
                            '</div>' +
                            '</div>';
                        sidebar.append(chatItem);

                    });
                    
                } else {
                    sidebar.html("<p>참여 중인 대화방이 없습니다.</p>");
                }
            },
            error: function () {
                alert("대화방 리스트를 불러오는 데 실패했습니다.");
            }
        }); */
        
        
        
        /* function updateChatListWithLatestMessage(messageData) {
            var chatIdx = messageData.chat_idx;
            var latestMessage = messageData.content;
            var sidebar = $(".sidebar");

            // 대화방 리스트에서 해당 chat_idx를 가진 항목 찾기
            var chatItem = sidebar.find(".chat-item[data-chat-idx='" + chatIdx + "']");
            if (chatItem.length > 0) {
                // 최신 메시지 갱신
                chatItem.find(".chat-preview").text(latestMessage);

                // 최신 메시지 시간 갱신
                var formattedTime = formatTimeToAmPm(messageData.time);
                chatItem.find(".chat-time").text(formattedTime);

                // 대화방을 맨 위로 이동 (선택 사항)
                chatItem.prependTo(sidebar);
            } else {
                console.warn("chat_idx " + chatIdx + "에 해당하는 대화방을 찾을 수 없습니다.");
            }
        } */


        if (chatIdx) {
            // 참여자 리스트 가져오기
            $.ajax({
                type: "GET",
                url: "chatParticipants.ajax",
                data: { chat_idx: chatIdx },
                success: function(participants) {
                    var memberListContainer = $(".member-list");
                    memberListContainer.empty(); // 기존 리스트 초기화

                    if (participants && participants.length > 0) {
                        participants.forEach(function(participant) {
                            var participantElement =
                                '<div class="image-label-wrapper">' +
                                '<img src="/photo/' + participant.photo + '" alt="프로필 사진" class="custom-image">' +
                                '<span class="custom-label">' + participant.name + '</span>' +
                                '</div>';
                            memberListContainer.append(participantElement);
                        });
                    } else {
                        memberListContainer.html("<p>참여자가 없습니다.</p>");
                    }
                },
                error: function() {
                    alert("참여자 리스트를 불러오는 데 실패했습니다.");
                }
            });
        } else {
            console.error("chat_idx가 URL에 없습니다.");
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


        var sendButton = $("#sendButton");
        var messageInput = $("#messageInput");

        sendButton.on("click", function () {
            var text = messageInput.val().trim();

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
                        console.log("저장된 메시지 데이터:", response);
                        
                     // 메시지 ID 추가
                        messageData.msg_idx = response.msg_idx;
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
                console.log("빈 메시지는 전송되지 않습니다.");
            }
        });




        messageInput.on("keypress", function(event) {
            if (event.key === "Enter") {
                sendButton.click();
            }
        });
    } else {
        console.error("chat_idx가 URL에 없습니다.");
    }

    
    $(".fa-door-open").on("click", function () {
        var chatIdx = new URLSearchParams(window.location.search).get("chat_idx");

        if (!chatIdx) {
            alert("방 정보를 찾을 수 없습니다.");
            return;
        }

        $.ajax({
            type: "POST",
            url: "leaveChat.ajax",
            data: { chat_idx: chatIdx },
            success: function (response) {
                if (response.success) {
                    alert("방에서 나갔습니다.");
                    location.href = "chatList.go"; // 방 나가기 후 이동할 페이지
                } else {
                    alert(response.message || "방 나가기에 실패했습니다.");
                }
            },
            error: function () {
                alert("방 나가기 요청 중 오류가 발생했습니다.");
            },
        });
    });
    
    
    
});



$(document).ready(function () {
    $(".fa-user-plus").on("click", function () {
        openModal();
    });
});

//모달 열기
function openModal() {
    $("#memberModal").fadeIn();
    loadMemberList(); // 회원 리스트 불러오기
    centerModal(); // 모달 중앙 정렬
}

// 모달 닫기
function closeModal() {
    $("#memberModal").fadeOut();
}

// 바깥 영역 클릭 시 모달 닫기
$(document).on("click", function (e) {
    if ($(e.target).is("#memberModal")) {
        closeModal();
    }
});

// 윈도우 리사이즈 시 중앙 정렬 유지
$(window).on("resize", function () {
    centerModal();
});

// 모달 중앙 정렬 함수
function centerModal() {
    var modal = $("#memberModal .modal-content");
    var top = ($(window).height() - modal.outerHeight()) / 2;
    var left = ($(window).width() - modal.outerWidth()) / 2;
    modal.css({
        top: top > 0 ? top + "px" : "0px",
        left: left > 0 ? left + "px" : "0px",
    });
}

// 회원 리스트 불러오기
function loadMemberList() {
    $.ajax({
        type: "GET",
        url: "memberList.ajax", // 회원 리스트를 반환하는 URL
        success: function (members) {
            var memberList = $("#memberList");
            memberList.empty(); // 기존 리스트 초기화

            if (members && members.length > 0) {
                members.forEach(function (member) {
                    var memberItem = 
                        '<li>' +
                        	'<div onclick="addMemberToChat(' + member.emp_idx + ');">' +
                            '<img src="/photo/' + member.photo + '" alt="프로필 사진" class="custom-image">' +
                            '<span>' + member.name + '</span>' +
                            '</div>' +
                        '</li>';
                    memberList.append(memberItem);
                });
            } else {
                memberList.html("<p>회원이 없습니다.</p>");
            }
        }, // success 끝
        error: function () {
            alert("회원 리스트를 불러오는 데 실패했습니다.");
        }
    });
}


// 대화방에 회원 추가
function addMemberToChat(empIdx) {
    var chatIdx = new URLSearchParams(window.location.search).get("chat_idx");

    $.ajax({
        type: "POST",
        url: "addParty.ajax",
        data: { chat_idx: chatIdx, emp_idx: empIdx },
        success: function (response) {
            if (response.success) {
                closeModal();
                location.reload(); // 페이지 새로고침
            } else {
                alert(response.message || "회원 추가에 실패했습니다.");
            }
        },
        error: function () {
            alert("회원 추가 중 오류가 발생했습니다.");
        },
    });
}

</script>
</html>
