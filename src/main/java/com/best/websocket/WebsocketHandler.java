package com.best.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.best.chat.ChatService;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class WebsocketHandler extends TextWebSocketHandler {
    Logger log = LoggerFactory.getLogger(getClass());
    @Autowired ChatService chatService;
    @Autowired GlobalWebsocketHandler globalWebsocketHandler;
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
        String messageType = (String) messagePayload.get("type");

        sessions.stream()
            .filter(WebSocketSession::isOpen)
            .forEach(session -> {
                try {
                    // 메시지를 JSON 형식으로 변환
                    String jsonMessage = objectMapper.writeValueAsString(messagePayload);

                    // "UPDATE_UNREAD_TOTAL" 메시지는 모든 세션에 전송
                    if ("UPDATE_UNREAD_TOTAL".equals(messageType)) {
                        session.sendMessage(new TextMessage(jsonMessage));
                    } 
                    // 다른 메시지에 대해 chat_idx 필터링
                    else {
                        Integer sessionChatIdx = (Integer) session.getAttributes().get("chat_idx");
                        Object payloadChatIdxObj = messagePayload.get("chat_idx");

                        if (sessionChatIdx != null 
                            && payloadChatIdxObj instanceof Integer
                            && sessionChatIdx.equals(payloadChatIdxObj)) {
                            
                            session.sendMessage(new TextMessage(jsonMessage));
                        }
                    }
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

            Integer chatIdx = (Integer) session.getAttributes().get("chat_idx");
            Integer empIdx = (Integer) session.getAttributes().get("emp_idx");
            String empName = (String) session.getAttributes().get("emp_name");

            if (chatIdx == null || empIdx == null) {
                log.error("세션 데이터 누락: {}", session.getAttributes());
                return;
            }

            messagePayload.put("chat_idx", chatIdx);
            messagePayload.put("msg_send_idx", empIdx);
            messagePayload.put("name", empName);
            messagePayload.put("time", System.currentTimeMillis());
            
            Map<String, Object> senderDetails = chatService.senderInfo(empIdx);
            if (senderDetails != null) {
                messagePayload.put("photo", senderDetails.get("photo"));
                messagePayload.put("rank_name", senderDetails.get("rank_name"));
            }

            // 개별 방 브로드캐스트
            broadcast(messagePayload);
           
            chatService.broadcastUnreadCount(chatIdx);
            
            for (WebSocketSession activeSession : GlobalWebsocketHandler.getSessions()) {
                if (activeSession.isOpen()) {
                    Integer targetEmpIdx = (Integer) activeSession.getAttributes().get("emp_idx");
                    if (targetEmpIdx != null) {
                        chatService.broadcastUnreadTotal(targetEmpIdx);
                        log.info("웹소켓 핸들러 broadcastUnreadTotal 호출: empIdx = {}", empIdx);
                    }
                }
            }

            if (!"CHAT_LIST_UPDATE".equals(messagePayload.get("type"))) {
                globalWebsocketHandler.broadcastAll(messagePayload, session);
            }
            

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
