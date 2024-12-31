//loginId = parseInt(loginId);

// 글로벌 WebSocket 연결
window.globalSocket = new WebSocket("ws://localhost:8080/BEST/ws");

// WebSocket 연결 성공 시
globalSocket.onopen = function () {
    console.log("Global WebSocket 연결 성공");
};

globalSocket.onmessage = function (event) {
    const messageData = JSON.parse(event.data);

    // 읽지 않은 메시지 수 처리
    if (messageData.type === "UPDATE_UNREAD_TOTAL") {
    console.log("UPDATE_UNREAD_TOTAL 메시지 수신:", messageData);
        window.updateUnreadMessageCount(messageData.unread_total);
        console.log("읽지 않은 메시지 수", messageData.unread_total);
    } else if (messageData.type === "CHAT_LIST_UPDATE") {
        // 챗 리스트 업데이트
        if (Array.isArray(messageData.chatList) && messageData.emp_idx === loginId) {
            updateChatList(messageData.chatList); // UI 업데이트
        }
    } else if (messageData.msg_send_idx && messageData.msg_send_idx !== loginId) {
        // 알림 로직: 본인이 보낸 메시지는 제외
        if (messageData.content && messageData.photo) {
            showNotification(messageData.photo, messageData.name, messageData.content, messageData.chat_idx, messageData.rank_name);
            updateMessageDropdown(messageData.photo, messageData.name, messageData.content, messageData.chat_idx, messageData.rank_name);
        }
    } else {
        console.warn("유효하지 않은 데이터:", messageData);
    }
};

// WebSocket 에러 처리
globalSocket.onerror = function (error) {
    console.error("Global WebSocket 에러:", error);
};

// WebSocket 연결 종료 시
globalSocket.onclose = function () {
    console.log("WebSocket 연결 종료");
};