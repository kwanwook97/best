    loginId = parseInt(loginId);


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
                                '<div class="image-label-wrapper member-item" data-emp-idx="' + participant.emp_idx + '">' +
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
                },
                error: function() {
                    alert("참여자 리스트를 불러오는 데 실패했습니다.");
                }
            });
        } else {
            console.error("chat_idx가 URL에 없습니다.");
        }
        
        function openProfileModal(empIdx, empName) {
            openModal("profileModal", function () {
                // AJAX를 통해 데이터 가져오기
                $.ajax({
                    url: "profile.ajax",
                    type: "GET",
                    data: { emp_idx: empIdx },
                    success: function (profile) {
                        $("#profileModal .modal-body").html(
                       		'<div class="profile-header">' +
                            	'<img src="/photo/' + profile.photo + '" alt="프로필 사진" class="custom-image">' +
                            	'<div>' +
                            		'<span>' + empName + '</span>' +
                            		'<span>' + (profile.state == 1 ? '근무 중' : '근무 종료') + '</span>' +
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
        
        $(document).ready(function () {
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
                data: { chat_idx: new URLSearchParams(window.location.search).get("chat_idx") },
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

    
    $(".fa-door-open").off("click").on("click", function () {
        var chatIdx = new URLSearchParams(window.location.search).get("chat_idx");

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

    
    
});

function openConfirmModal(message, onConfirm) {
    // 확인 메시 설정과 콜백 정의를 contentUpdater로 전달
    openModal("confirmModal", function () {
        $("#confirmMessage").text(message); // 메시지 업데이트

        // 확인 버튼 클릭 이벤트 설정
        $("#confirmYes")
            .on("click", function () {
                onConfirm(); // 확인 작업 실행
                closeModal("confirmModal"); // 모달 닫기
            });

        // 취소 버튼 클릭 이벤트 설정
        $("#confirmModal .close-modal, #confirmModal .confirmBtn:last-child")
            .on("click", function () {
                closeModal("confirmModal"); // 모달 닫기
            });
    });
}

function openModal(modalId, contentUpdater) {
    // 필요한 데이터 업데이트 (contentUpdater는 콜백 함수)
    if (typeof contentUpdater === "function") {
        contentUpdater();
    }

    // 모달 열기
    $("#" + modalId).fadeIn(200, function () {
        centerModal(modalId); // 중앙 정렬
    });
}

function closeModal(modalId) {
    $("#" + modalId).fadeOut();
}

function centerModal(modalId) {
    var modal = $("#" + modalId + " .modal-content");
    var top = Math.max(($(window).height() - modal.outerHeight()) / 2, 0);
    var left = Math.max(($(window).width() - modal.outerWidth()) / 2, 0);
    modal.css({
        top: top + "px",
        left: left + "px",
    });
}

$(document).on("click", function (e) {
    $(".modal").each(function () {
        if ($(e.target).is(this)) {
            closeModal($(this).attr("id"));
        }
    });
});

$(window).on("resize", function () {
    $(".modal:visible").each(function () {
        centerModal($(this).attr("id"));
    });
});

// 기존 코드에서 openModal 및 closeModal 사용
$(document).ready(function () {
    $(".fa-user-plus").on("click", function () {
        openModal("memberModal", function () {
            loadMemberList(null); // 데이터 업데이트
        });
    });

    $(".close-modal").on("click", function () {
        var modalId = $(this).closest(".modal").attr("id");
        closeModal(modalId);
    });

    $(document).on("click", function (e) {
        $(".modal").each(function () {
            if ($(e.target).is(this)) {
                closeModal($(this).attr("id"));
            }
        });
    });
});

// 서치 아이콘 클릭 이벤트
$(document).on('click', '.search-icon', function() {
    executeSearch();
});

// 엔터키 이벤트
$(document).on("keypress", "#memberSearchBar", function (e) {
    if (e.which === 13) {
        executeSearch();
    }
});

//검색 실행 함수
function executeSearch() {
    var keyword = $("#memberSearchBar").val().trim(); // 검색어 가져오기
    loadMemberList(keyword); // 검색 실행
}

// 회원 리스트 불러오기
function loadMemberList(keyword) {
var chatIdx = new URLSearchParams(window.location.search).get("chat_idx"); // URL에서 chat_idx 가져오기
    $.ajax({
        type: "GET",
        url: "chatParty.ajax",
        data: { keyword: keyword || '' , chat_idx: chatIdx}, // 검색어 전달
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
        if ($(e.target).is("#memberModal")) {
            $(".selected-member-container").empty(); // 선택된 멤버 표시 영역 초기화
            $("input[name='member']").prop("checked", false).trigger("change"); // 모든 체크박스 선택 해제
            $("#memberModal").fadeOut();
        }
    });
});



// 대화방에 회원 추가
function addSelectedMembersToChat() {
    var chatIdx = new URLSearchParams(window.location.search).get("chat_idx");
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
            data: JSON.stringify({ chat_idx: chatIdx, emp_idx_list: selectedMembers }),
            success: function (response) {
                if (response.success) {
                    location.reload(); // 페이지 새로고침
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


$(document).on("click", ".fa-cog", function () {
    // 수정 모달 열기
    openModal("editChatSubjectModal", function () {
        var currentChatTitle = $(".naviPath .purple").text();
        $("#chatSubject").val(currentChatTitle); // 현재 제목을 입력 필드에 표시
    });
});

// 수정 버튼 클릭 이벤트
function updateChatSubject() {
    var chatIdx = new URLSearchParams(window.location.search).get("chat_idx");
    var newChatSubject = $("#chatSubject").val().trim();

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
            data: JSON.stringify({ chat_idx: chatIdx, chat_subject: newChatSubject }),
            success: function (response) {
                if (response.success) {
                    $(".naviPath .purple").text(newChatSubject);
                    closeModal("editChatSubjectModal"); // 수정 모달 닫기
                    location.reload();
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

$(document).ready(function () {
    // 공지사항 등록 버튼 클릭 이벤트
    $(".bi-megaphone-fill").on("click", function () {
        openModal("noticeModal");
    });

    // 공지사항 등록 함수
    window.submitNotice = function () {
        const noticeContent = $("#noticeContent").val().trim();
        const chatIdx = new URLSearchParams(window.location.search).get("chat_idx"); // URL에서 chat_idx 가져오기

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
                        location.reload();
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
});

$(document).ready(function () {
    // 제목 글자 수 제한
    $("#chatSubject").on("input", function () {
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