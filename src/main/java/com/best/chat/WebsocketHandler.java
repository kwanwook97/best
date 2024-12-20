package com.best.chat;

import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class WebsocketHandler extends TextWebSocketHandler {
	Logger log = LoggerFactory.getLogger(getClass());

    private final List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String chatIdx = (String) session.getAttributes().get("chat_idx");
        log.info("WebSocket 연결 - chat_idx: " + chatIdx);
        log.info("WebSocket 연결 시도 - chat_idx: " + chatIdx);
        sessions.add(session); // 세션 추가
        log.info("현재 연결된 세션 수: " + sessions.size());
    }

    // 메시지 수신 및 브로드캐스팅 처리
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        log.info("수신 메시지: " + payload);

        // 모든 클라이언트에 메시지 브로드캐스팅
        for (WebSocketSession s : sessions) {
            if (s.isOpen()) {
                s.sendMessage(new TextMessage("From " + session.getId() + ": " + payload));
            }
        }
    }

    // 클라이언트 연결 종료 처리
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        log.info("클라이언트 연결 종료: " + session.getId());
        
    }
}
