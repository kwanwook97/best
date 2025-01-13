loginId = parseInt(loginId);

// 글로벌 WebSocket 연결
window.globalSocket = new WebSocket("ws://localhost:8080/BEST/ws");

// WebSocket 연결 성공 시
globalSocket.onopen = function () {
    console.log("Global WebSocket 연결");
};

globalSocket.onmessage = function (event) {
    const messageData = JSON.parse(event.data);

    // 읽지않은 알림
    if (messageData.type === "UPDATE_UNREAD_ALARM") {
        window.updateUnreadAlarmCount(messageData.unread_alarm_count);
        // 읽지않은 메시지 총합
    } else if (messageData.type === "UPDATE_UNREAD_TOTAL") {
        window.updateUnreadMessageCount(messageData.unread_total);
        // 채팅방 리스트 브로드캐스트
    } else if (messageData.type === "CHAT_LIST_UPDATE") {
        if (Array.isArray(messageData.chatList) && messageData.emp_idx === loginId) {
            updateChatList(messageData.chatList); // UI 업데이트
        }
    } else if (messageData.msg_send_idx && messageData.msg_send_idx !== loginId) {
        // 알림 로직: 본인이 보낸 메시지는 제외한 참여자들 토스트, 드롭다운
        if (messageData.content && messageData.photo) {
            showNotification(messageData.photo, messageData.name, messageData.content, messageData.chat_idx, messageData.rank_name);
            updateMessageDropdown(messageData.photo, messageData.name, messageData.content, messageData.chat_idx, messageData.rank_name);
        }
    }
    
    if (messageData.type === "mail" || messageData.type === "document" || messageData.type === "calendar" || messageData.type === "reserve" || messageData.type === "borrow" || messageData.type === "comment") {
        // 알림 표시 및 드롭다운 업데이트
        showMailNotification(messageData.content, messageData.type);
        updateMailDropdown(messageData.content, messageData.type);
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