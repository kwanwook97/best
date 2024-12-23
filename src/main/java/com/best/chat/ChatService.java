package com.best.chat;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.best.emp.EmployeeDTO;

@Service
public class ChatService {
	
	@Autowired ChatDAO chatDAO;
	
	/* 내가 참여중인 메신져 리스트 */
	public List<Map<String, Object>> chatList(Integer emp_idx) {
	    List<Map<String, Object>> chatList = chatDAO.chatList(emp_idx);

	    for (Map<String, Object> chat : chatList) {
	        // 참여자 이름 가져오기
	        List<String> participantNames = chatDAO.getParticipantNames(
	            (Integer) chat.get("chat_idx"), emp_idx
	        );
	        chat.put("participants", String.join(", ", participantNames)); // 참여자 이름 추가
	    }
	    return chatList;
	}
	
	public List<EmployeeDTO> getEmployeeList() {
        return chatDAO.getEmployeeList();
    }
	
	/* 대화방 생성 */
	@Transactional
	public int createChat(String chat_subject, Integer login_emp_idx, Integer emp_idx) {
	    // 1. chat 테이블에 대화방 생성
	    ChatDTO chatDTO = new ChatDTO();
	    chatDTO.setChat_subject(chat_subject);
	    chatDAO.insertChat(chatDTO); // chatIdx는 자동 생성됨

	    // 2. 방금 생성된 chatIdx를 가져옴
	    int chat_idx = chatDTO.getChat_idx();

	    // 3. party 테이블에 로그인한 사용자 추가
	    PartyDTO loginPartyDTO = new PartyDTO();
	    loginPartyDTO.setChat_idx(chat_idx);
	    loginPartyDTO.setEmp_idx(login_emp_idx);
	    chatDAO.insertParty(loginPartyDTO);

	    // 4. emp_idx가 있을 경우 추가로 참여자 추가
	    if (emp_idx != null) {
	        PartyDTO partyDTO = new PartyDTO();
	        partyDTO.setChat_idx(chat_idx);
	        partyDTO.setEmp_idx(emp_idx);
	        chatDAO.insertParty(partyDTO);
	    }

	    // 5. 현재 날짜를 시스템 메시지로 저장
	    String currentDate = new SimpleDateFormat("yyyy년 MM월 dd일").format(new Date());
	    String messageContent = currentDate;

	    MessageDTO messageDTO = new MessageDTO();
	    messageDTO.setChat_idx(chat_idx);
	    messageDTO.setContent(messageContent);
	    messageDTO.setMessage_type("system");
	    chatDAO.insertEnterMessage(messageDTO); // DB에 저장

	    // 6. WebSocket 브로드캐스트
	    broadcastEnterMessage(chat_idx, messageContent);

	    return chat_idx;
	}
	

	/* 대화방 초대,생성 & 시스템 메시지 */
	@Transactional
	public void addPartyWithInviteMessage(int chat_idx, int emp_idx, String inviterName, String invitedEmpName) {
	    // 중복 여부 확인
	    int partyExists = chatDAO.checkPartyExists(chat_idx, emp_idx);
	    if (partyExists == 0) {
	        // 참여자 추가
	        PartyDTO partyDTO = new PartyDTO();
	        partyDTO.setChat_idx(chat_idx);
	        partyDTO.setEmp_idx(emp_idx);
	        chatDAO.insertParty(partyDTO);
	    } else {
	        System.out.println("이미 참여자로 등록된 사용자입니다: chat_idx=" + chat_idx + ", emp_idx=" + emp_idx);
	    }

	    // 초대 메시지 저장 전에 중복 여부 확인
	    String inviteMessage = inviterName + "님이 " + invitedEmpName + "님을 초대하셨습니다.";
	    int messageExists = chatDAO.checkEnterMessageExists(chat_idx, inviteMessage);
	    if (messageExists == 0) {
	        MessageDTO messageDTO = new MessageDTO();
	        messageDTO.setChat_idx(chat_idx);
	        messageDTO.setContent(inviteMessage);
	        messageDTO.setMessage_type("system");
	        chatDAO.insertEnterMessage(messageDTO);

	        // WebSocket 브로드캐스트
	        broadcastEnterMessage(chat_idx, inviteMessage);
	    }
	}
	
	/* 매일 자정 날짜 시스템 메시지 저장 & 뿌려주기 */
	@Transactional
	public void saveAndBroadcastSystemMessageToAllChats(String messageContent) {
	    // 모든 채팅방 조회
	    List<Integer> chatIdxList = chatDAO.getAllChatIdx(); // 모든 chat_idx 가져오기

	    for (Integer chatIdx : chatIdxList) {
	        // 시스템 메시지 저장
	        MessageDTO messageDTO = new MessageDTO();
	        messageDTO.setChat_idx(chatIdx);
	        messageDTO.setContent(messageContent);
	        messageDTO.setMessage_type("system");
	        chatDAO.insertEnterMessage(messageDTO); // DB에 저장

	        // WebSocket 브로드캐스트
	        broadcastEnterMessage(chatIdx, messageContent);
	    }
	}

	/* 시스템 메시지 웹소켓 전달 */
	public void broadcastEnterMessage(int chatIdx, String content) {
	    Map<String, Object> messagePayload = new HashMap<>();
	    messagePayload.put("chat_idx", chatIdx);
	    messagePayload.put("message_type", "system");
	    messagePayload.put("content", content);
	    messagePayload.put("time", System.currentTimeMillis());

	    WebsocketHandler.broadcast(messagePayload);
	}
	
	
	/* 메시지 저장 */
	public void message(MessageDTO message) {
		chatDAO.message(message);
    }
	
	/* 메시지 가져오기 */
	public List<Map<String, Object>> getMessagesByChatIdx(int chatIdx) {
        return chatDAO.getMessagesByChatIdx(chatIdx);
    }
	
	/* 사원 이름 가져오기 */
	public String getEmployeeName(int emp_idx) {
		return chatDAO.getEmployeeName(emp_idx);
	}
	
	/* 대화방 참여자 리스트 가져오기 */
	public List<Map<String, Object>> getChatParticipants(int chat_idx) {
        return chatDAO.getChatParticipants(chat_idx);
    }

	
}
