package com.best.chat;

import java.util.Collections;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class ChatWebSocketHandler extends TextWebSocketHandler {

    // Map<chat_idx, Set<user_id>> 형태로 연결된 사용자 관리
    private final static Map<Integer, Set<Integer>> connectedUsers = new ConcurrentHashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 연결 시
        int chatIdx = Integer.parseInt(session.getUri().getQuery().split("=")[1]); // chat_idx 가져오기
        int userId = (int) session.getAttributes().get("loginId"); // 로그인 ID 가져오기

        connectedUsers.putIfAbsent(chatIdx, new HashSet<>());
        connectedUsers.get(chatIdx).add(userId); // 사용자 추가
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        // 연결 해제 시
        int chatIdx = Integer.parseInt(session.getUri().getQuery().split("=")[1]);
        int userId = (int) session.getAttributes().get("loginId");

        if (connectedUsers.containsKey(chatIdx)) {
            connectedUsers.get(chatIdx).remove(userId);
            if (connectedUsers.get(chatIdx).isEmpty()) {
                connectedUsers.remove(chatIdx); // 비어 있으면 삭제
            }
        }
    }

    public static int getActiveUserCount(int chatIdx) {
        return connectedUsers.getOrDefault(chatIdx, Collections.emptySet()).size();
    }
}

