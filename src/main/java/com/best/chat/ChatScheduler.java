package com.best.chat;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ChatScheduler {

    @Autowired
    private ChatService chatService;

    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");

    // 매일 자정(00:00:00)에 실행
    @Scheduled(cron = "0 0 0 * * ?")
    public void saveAndBroadcastDateMessage() {
        String currentDate = dateFormat.format(new Date());
        String messageContent = currentDate;

        // 모든 채팅방에 시스템 메시지를 저장하고 브로드캐스트
        chatService.saveAndBroadcastSystemMessageToAllChats(messageContent);
    }
}