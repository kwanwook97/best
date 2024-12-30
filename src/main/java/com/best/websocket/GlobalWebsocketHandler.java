package com.best.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;


@Component
public class GlobalWebsocketHandler extends TextWebSocketHandler {
    private static final List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
    private static final Logger log = LoggerFactory.getLogger(GlobalWebsocketHandler.class);

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
        log.info("글로벌 WebSocket 연결 성공: {}", session.getId());
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        log.info("글로벌 WebSocket 연결 종료: {}", session.getId());
    }

    public void broadcastUpdate(Map<String, Object> payload) {
        sessions.stream()
            .filter(WebSocketSession::isOpen)
            .forEach(session -> {
                try {
                    String jsonMessage = new ObjectMapper().writeValueAsString(payload);
                    session.sendMessage(new TextMessage(jsonMessage));
                } catch (IOException e) {
                    log.error("글로벌 WebSocket 메시지 전송 실패", e);
                }
            });
    }
    
    
    public void broadcastAll(Map<String, Object> payload, WebSocketSession senderSession) {
        sessions.stream()
            .filter(s -> s.isOpen() && s != senderSession) // 전송자 제외
            .forEach(session -> {
                try {
                    String jsonMessage = new ObjectMapper().writeValueAsString(payload);
                    session.sendMessage(new TextMessage(jsonMessage));
                } catch (IOException e) {
                    log.error("글로벌 WebSocket 메시지 전송 실패", e);
                }
            });
    }

}
