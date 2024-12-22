package com.best.chat;

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
public class WebsocketHandler extends TextWebSocketHandler {
    Logger log = LoggerFactory.getLogger(getClass());
    private static final List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
    private static final ObjectMapper objectMapper = new ObjectMapper(); // JSON 변환기

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // chat_idx와 emp_idx 가져오기
        Integer chatIdx = (Integer) session.getAttributes().get("chat_idx");
        Integer empIdx = (Integer) session.getAttributes().get("emp_idx");
        String empName = (String) session.getAttributes().get("emp_name");

        if (chatIdx == null || empIdx == null) {
            log.error("세션 데이터 누락: chat_idx={}, emp_idx={}", chatIdx, empIdx);
            session.close(CloseStatus.BAD_DATA);
            return;
        }

        log.info("WebSocket 연결 - chat_idx: {}, emp_idx: {}, emp_name: {}", chatIdx, empIdx, empName);
        sessions.add(session);
        log.info("현재 연결된 세션 수: {}", sessions.size());
    }

    public static void broadcast(Map<String, Object> messagePayload) {
        sessions.stream()
            .filter(WebSocketSession::isOpen)
            .forEach(session -> {
                try {
                    String jsonMessage = objectMapper.writeValueAsString(messagePayload);
                    session.sendMessage(new TextMessage(jsonMessage));
                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
    }


    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        log.info("수신 메시지: {}", payload);

        try {
            Map<String, Object> messagePayload = objectMapper.readValue(payload, Map.class);

            // 세션에서 사용자 정보 가져오기
            Integer chatIdx = (Integer) session.getAttributes().get("chat_idx");
            Integer empIdx = (Integer) session.getAttributes().get("emp_idx");
            String empName = (String) session.getAttributes().get("emp_name");

            if (chatIdx == null || empIdx == null) {
                log.error("세션 데이터 누락: {}", session.getAttributes());
                return;
            }

            // 메시지에 데이터 추가
            messagePayload.put("chat_idx", chatIdx);
            messagePayload.put("msg_send_idx", empIdx); // 보낸 사람 ID
            messagePayload.put("name", empName);
            messagePayload.put("time", System.currentTimeMillis());

            // 브로드캐스트
            broadcast(messagePayload);
        } catch (Exception e) {
            log.error("메시지 처리 중 오류 발생: {}", e.getMessage(), e);
        }
    }


    
    

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        sessions.remove(session);
        log.info("클라이언트 연결 종료: " + session.getId());
    }
}
