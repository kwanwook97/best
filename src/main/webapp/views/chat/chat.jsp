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
			<span class="lPurple">메신져</span> <i class="fa-solid fa-angle-right"
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
            messageElement = '<div class="system-message">' + messageData.content + '</div>';
        } else if (isMyMessage) {
            // 내가 보낸 메시지
            messageElement =
                '<div class="send-messages">' +
                '<input type="hidden" class="msg-idx" value="' + messageData.msg_idx + '">' +
                '<div class="time-and-number">' +
                '<div class="number" id="unread-user-count-' + messageData.msg_idx + '"></div>' +
                '<div class="sent-time">' + currentMessageTime + '</div>' +
                '</div>' +
                '<div class="chat-bubble send-message">' + messageData.content + '</div>' +
                '</div>';
        } else {
            // 다른 사람이 보낸 메시지
            messageElement =
                '<div class="chat-message">' +
                '<input type="hidden" class="msg-idx" value="' + messageData.msg_idx + '">' +
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
                '<div class="number" id="unread-user-count-' + messageData.msg_idx + '"></div>' +
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

        // 읽지 않은 사용자 수 가져오기
        fetchUnreadUserCount(messageData.msg_idx, "#unread-user-count-" + messageData.msg_idx);

        // 메시지 컨테이너 스크롤을 아래로 이동
        messagesContainer.scrollTop(messagesContainer[0].scrollHeight);
    }


    function markMessageAsRead(msgIdx) {
        $.ajax({
            type: "POST",
            url: "markAsRead",
            data: { msg_idx: msgIdx },
            success: function() {
                console.log("메시지 " + msgIdx + "를 읽음으로 표시했습니다.");
            },
            error: function() {
                console.error("메시지 " + msgIdx + " 읽음 표시 중 오류 발생.");
            }
        });
    }

    $(window).on("scroll", function() {
        $(".message").each(function() {
            var msgIdx = $(this).data("msg-idx");
            var isRead = $(this).data("is-read");

            if ($(this).isInViewport() && !isRead) {
                markMessageAsRead(msgIdx);
                $(this).data("is-read", true);
            }
        });
    });

    // jQuery 헬퍼 함수: 요소가 뷰포트에 있는지 확인
    $.fn.isInViewport = function() {
        var elementTop = $(this).offset().top;
        var elementBottom = elementTop + $(this).outerHeight();
        var viewportTop = $(window).scrollTop();
        var viewportBottom = viewportTop + $(window).height();
        return elementBottom > viewportTop && elementTop < viewportBottom;
    };

    
    
    function fetchUnreadUserCount(msgIdx, targetDiv) {
    $.ajax({
        type: "GET",
        url: "unreadUserCount.ajax", // 읽지 않은 사용자 수를 반환하는 API
        data: { msg_idx: msgIdx },
        success: function(count) {
            // 타겟 div에 읽지 않은 사용자 수를 표시
            $(targetDiv).text(count > 0 ? count : "");
        },
        error: function() {
            console.error("오류발생");
        }
    });
}


function fetchUnreadMessageCountByChat(chatIdx) {
    $.ajax({
        type: "GET",
        url: "unreadMessageCountByChat.ajax",
        data: { chat_idx: chatIdx },
        success: function(count) {
            $("#unread-count-" + chatIdx).text(count > 0 ? `(${count})` : "");
        },
        error: function() {
            console.error(`대화방 ${chatIdx}의 읽지 않은 메시지 수를 가져오는 중 오류 발생.`);
        }
    });
}




    
    
    
    
    






    if (chatIdx) {
        console.log("선택된 chat_idx:", chatIdx);

        var socket = new WebSocket("ws://localhost:8080/BEST/chat/chat?chat_idx=" + chatIdx);

        socket.onopen = function() {
            console.log("WebSocket 연결 성공 - chat_idx:", chatIdx);
        };

        var isFirstConnection = true; // 최초 WebSocket 연결 확인용

        socket.onmessage = function (event) {
            try {
                var messageData = JSON.parse(event.data); // JSON 메시지 파싱
                console.log("수신 메시지 데이터:", messageData);

                if (messageData && messageData.content) {
                    // 메시지를 메시지 창에 추가
                    var isMyMessage = messageData.msg_send_idx === loginId; 
                    addMessageToUI(messageData, isMyMessage);
                    
                	// 메시지별 읽지 않은 사용자 수 업데이트
                	console.log("msgIdx:", messageData.msg_idx);
                    fetchUnreadUserCount(messageData.msg_idx);

                    // 대화방별 읽지 않은 메시지 수 업데이트
                    fetchUnreadMessageCountByChat(chatIdx);

                } else {
                    console.error("메시지 데이터에 content 필드가 없습니다:", messageData);
                }
            } catch (error) {
                console.error("메시지 처리 중 오류 발생:", error);
            }
        };

        socket.onclose = function() {
            console.log("WebSocket 연결 종료");
        };

        socket.onerror = function(error) {
            console.error("WebSocket 에러 발생:", error);
        };

        
        $.ajax({
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
                    response.chatList.forEach(function(chat) {
                        var latestMessage = chat.latest_message || "메시지가 없습니다.";
                        var latestTime = chat.latest_time ? formatDateTime(chat.latest_time) : "";

                        var chatTitle = chat.chat_subject || chat.participants;

                        var chatItem =
                            '<div class="chat-item" data-chat-idx="' + chat.chat_idx + '" onclick="location.href=\'chat.go?chat_idx=' + chat.chat_idx + '\'">' +
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

                        // 읽지 않은 메시지 수 가져오기
                        fetchUnreadMessageCountByChat(chat.chat_idx);
                    });
                    
                } else {
                    sidebar.html("<p>참여 중인 대화방이 없습니다.</p>");
                }
            },
            error: function () {
                alert("대화방 리스트를 불러오는 데 실패했습니다.");
            }
        });

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

                $.ajax({
                    type: "POST",
                    url: "message.ajax",
                    contentType: "application/json",
                    data: JSON.stringify(messageData),
                    success: function (response) {
                        console.log("저장된 메시지 데이터:", response);

                        // 새로 저장된 메시지를 UI에 추가
                        addMessageToUI({
                            msg_idx: response.msg_idx,
                            chat_idx: response.chat_idx,
                            content: response.content,
                            time: response.time
                        }, true);

                        // WebSocket 메시지 전송
                        socket.send(JSON.stringify(response));

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
