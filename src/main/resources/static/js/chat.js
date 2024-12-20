$(document).ready(function() {
    var chatIdx = new URLSearchParams(window.location.search).get("chat_idx"); // URL에서 chat_idx 가져오기

    if (chatIdx) {
        console.log("선택된 chat_idx:", chatIdx);

        // WebSocket 연결
        var socket = new WebSocket("ws://localhost:8080/BEST/chat/chat?chat_idx=" + chatIdx);

        socket.onopen = function() {
            console.log("WebSocket 연결 성공 - chat_idx:", chatIdx);
        };

        socket.onmessage = function(event) {
            console.log("WebSocket 메시지 수신:", event.data);

            try {
                // 메시지 데이터 파싱
                var messageData = JSON.parse(event.data); // 서버에서 JSON으로 메시지를 보내준다고 가정
                var isSender = messageData.sender === "me"; // sender가 "me"이면 내가 보낸 메시지로 간주

                var messages = $("#messages");

                if (!isSender) {
                    // 남이 보낸 메시지: chat-message
                    var lastMessage = messages.find(".chat-message").last();
                    var newMessage = lastMessage.clone();

                    newMessage.find(".profile-image").text("A"); // 상대방 프로필 이미지
                    newMessage.find(".profile-name").text(messageData.sender || "사용자");
                    newMessage.find(".chat-bubble").text(messageData.content);
                    newMessage.find(".message-time").text(new Date().toLocaleTimeString());

                    messages.append(newMessage);
                }
                messages.scrollTop(messages[0].scrollHeight); // 스크롤 맨 아래로 이동
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

        // 메시지 전송 처리
        var sendButton = $("#sendButton");
        var messageInput = $("#messageInput");

        sendButton.on("click", function () {
    var text = messageInput.val().trim();

    if (text) {
        var messageData = {
            chat_idx: chatIdx,
            content: text
        };

        // 메시지 DB 저장 요청
        $.ajax({
            type: "POST",
            url: "message.ajax",
            contentType: "application/json",
            data: JSON.stringify(messageData),
            success: function () {
                console.log("메시지가 DB에 저장되었습니다.");

                // WebSocket 메시지 전송
                var messageToSend = JSON.stringify({
                    content: text
                });
                socket.send(messageToSend);

                // 내가 보낸 메시지 UI 업데이트
                var messages = $("#messages");
                var lastSentMessage = messages.find(".send-messages").last();
                var newSentMessage = lastSentMessage.clone();

                newSentMessage.find(".sent-time").text(new Date().toLocaleTimeString());
                newSentMessage.find(".chat-bubble").text(text);

                messages.append(newSentMessage);
                messages.scrollTop(messages[0].scrollHeight);

                messageInput.val(""); // 입력창 초기화
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
});
