loginId = parseInt(loginId);

// 글로벌 WebSocket 연결
window.globalSocket = new WebSocket("ws://localhost:8080/BEST/ws");

// WebSocket 연결 성공 시
globalSocket.onopen = function () {
    console.log("Global WebSocket 연결 성공");
};

globalSocket.onmessage = function (event) {
    const messageData = JSON.parse(event.data);

    console.log("수신된 데이터:", messageData);

    if (
        messageData.type === "CHAT_LIST_UPDATE" &&
        Array.isArray(messageData.chatList) &&
        messageData.emp_idx === loginId // 자신의 emp_idx에 해당하는 데이터만 처리
    ) {
        updateChatList(messageData.chatList); // UI 업데이트
    } else {
        console.warn("유효하지 않은 메시지 또는 다른 사용자 데이터:", messageData);
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