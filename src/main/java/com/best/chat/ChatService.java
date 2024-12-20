package com.best.chat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ChatService {
	
	@Autowired ChatDAO chatDAO;
	
	public List<ChatDTO> chatList(Integer emp_idx) {
        return chatDAO.chatList(emp_idx);
    }
	
	@Transactional
    public int createChat(String chat_subject, Integer emp_idx) {
        // 1. chat 테이블에 대화방 생성
        ChatDTO chatDTO = new ChatDTO();
        chatDTO.setChat_subject(chat_subject);
        chatDAO.insertChat(chatDTO); // chatIdx는 자동 생성됨

        // 2. 방금 생성된 chatIdx를 가져옴
        int chat_idx = chatDTO.getChat_idx();

        // 3. party 테이블에 참여자 정보 추가
        PartyDTO partyDTO = new PartyDTO();
        partyDTO.setChat_idx(chat_idx);
        partyDTO.setEmp_idx(emp_idx);
        chatDAO.insertParty(partyDTO);

        return chat_idx;
    }
	
	public void message(MessageDTO message) {
		chatDAO.message(message);
    }
	
	
}
