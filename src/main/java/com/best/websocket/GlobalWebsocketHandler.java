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
    private static final ObjectMapper objectMapper = new ObjectMapper();
    
    public static List<WebSocketSession> getSessions() {
        return sessions;
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
        log.info("글로벌 WebSocket 연결 성공: {}", session.getId());
        Integer empIdx = (Integer) session.getAttributes().get("emp_idx");
        log.info("세션 empIdx 설정: {}", empIdx);
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
    
    /* 안읽은 메시지 총 갯수 카운트 브로드캐스트 */
    public static void broadcastUnreadTotal(int empIdx, int unreadTotal) {
    	log.info("글로벌 웹소켓 broadcastUnreadTotal 호출: empIdx = {}", empIdx);
        sessions.stream()
            .filter(WebSocketSession::isOpen)
            .forEach(session -> {
                try {
                    Integer sessionEmpIdx = (Integer) session.getAttributes().get("emp_idx");
                    if (sessionEmpIdx != null && sessionEmpIdx.equals(empIdx)) {
                        Map<String, Object> payload = new HashMap<>();
                        payload.put("type", "UPDATE_UNREAD_TOTAL");
                        payload.put("emp_idx", empIdx);
                        payload.put("unread_total", unreadTotal);

                        String jsonMessage = objectMapper.writeValueAsString(payload);
                        session.sendMessage(new TextMessage(jsonMessage));

                        log.info("브로드캐스트 전송 성공: empIdx={}, unreadTotal={}", empIdx, unreadTotal);
                    }
                } catch (IOException e) {
                    log.error("글로벌 WebSocket 메시지 전송 실패 - 세션 ID: {}", session.getId(), e);
                }
            });
    }
    
    /* 메일 알림 브로드캐스트 */
    public static void broadcastNewMail(int empIdx, String senderName, String content) {
        log.info("글로벌 웹소켓 broadcastNewMail 호출: empIdx = {}, senderName = {}, content = {}", empIdx, senderName, content);
        sessions.stream()
            .filter(WebSocketSession::isOpen)
            .forEach(session -> {
                try {
                    Integer sessionEmpIdx = (Integer) session.getAttributes().get("emp_idx");
                    if (sessionEmpIdx != null && sessionEmpIdx.equals(empIdx)) {
                        Map<String, Object> payload = new HashMap<>();
                        payload.put("type", "NEW_MAIL");
                        payload.put("emp_idx", empIdx);
                        payload.put("sender_name", senderName);
                        payload.put("content", content);

                        String jsonMessage = objectMapper.writeValueAsString(payload);
                        session.sendMessage(new TextMessage(jsonMessage));

                        log.info("새 메일 알림 전송 성공: empIdx={}, senderName={}, content={}", empIdx, senderName, content);
                    }
                } catch (IOException e) {
                    log.error("새 메일 알림 전송 실패 - 세션 ID: {}", session.getId(), e);
                }
            });
    }


}
