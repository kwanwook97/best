package com.best.chat;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.best.emp.EmployeeDTO;

@Service
public class ChatService {

	@Autowired
	ChatDAO chatDAO;
	@Autowired
	GlobalWebsocketHandler globalWs;

	Logger log = LoggerFactory.getLogger(getClass());

	/* 내가 참여중인 메신져 리스트 */
	public List<Map<String, Object>> chatList(Integer emp_idx, String keyword) {
		// 메신저 리스트 가져오기 (unread_count 포함)
		List<Map<String, Object>> chatList = chatDAO.chatListWithUnread(emp_idx, keyword);

		// 사원 전체 목록 가져오기
		List<Map<String, Object>> employeeList = chatDAO.getEmployeeList(keyword);

		// 사원 이름과 사진 경로 매핑
		Map<String, String> employeePhotoMap = new HashMap<>();
		for (Map<String, Object> employee : employeeList) {
			String name = (String) employee.get("name");
			String photo = (String) employee.get("photo");
			employeePhotoMap.put(name, photo);
		}

		// 각 메신저 리스트의 참여자 이름 및 사진 추가
		for (Map<String, Object> chat : chatList) {
			// 참여자 이름 가져오기 (이미 나를 제외한 참여자 정보)
			List<String> participantNames = chatDAO.getParticipantNames((Integer) chat.get("chat_idx"), emp_idx);
			chat.put("participants", String.join(", ", participantNames)); // 참여자 이름 추가

			// 첫 번째 참여자의 이름을 기준으로 사진 매핑
			String photo = null;
			if (!participantNames.isEmpty()) {
				String firstParticipantName = participantNames.get(0); // 첫 번째 참여자 이름
				photo = employeePhotoMap.get(firstParticipantName); // 이름으로 사진 경로 매핑
			}

			// 사진을 chat에 추가
			chat.put("photo", photo);
		}

		log.info("아작스 chatList {}", chatList);
		return chatList;
	}
	
	/* 읽지않은 메시지 수 브로드캐스트 */
	public void broadcastUnreadCount(int chatIdx) {
		// 참여자 목록 가져오기
		List<Map<String, Object>> participants = getChatParticipants(chatIdx);
		if (participants == null || participants.isEmpty()) {
			log.warn("참여자가 없습니다. chatIdx: {}", chatIdx);
			return;
		}

		log.info("참여자 목록: {}", participants);

		// 각 참여자 emp_idx로 chatList 생성 및 브로드캐스트
		for (Map<String, Object> participant : participants) {
			Integer empIdx = (Integer) participant.get("emp_idx");
			if (empIdx == null) {
				log.warn("참여자 정보에 emp_idx가 없습니다: {}", participant);
				continue;
			}

			try {
				// emp_idx를 기준으로 chatList 가져오기
				List<Map<String, Object>> chatList = chatList(empIdx, null);
				log.info("emp_idx={}의 chatList: {}", empIdx, chatList);

				// 브로드캐스트 데이터 구성
				Map<String, Object> broadcastPayload = new HashMap<>();
				broadcastPayload.put("type", "CHAT_LIST_UPDATE");
				broadcastPayload.put("emp_idx", empIdx); // 해당 emp_idx 추가
				broadcastPayload.put("chatList", chatList);

				log.info("브로드캐스트 페이로드: {}", broadcastPayload);

				// 브로드캐스트
				globalWs.broadcastUpdate(broadcastPayload);

			} catch (Exception e) {
				log.error("chatList 가져오기 및 브로드캐스트 중 오류 발생: chat_idx={}, emp_idx={}", chatIdx, empIdx, e);
			}
		}
	}
	
	/* 모든 사원 목록 */
	public List<Map<String, Object>> getEmployeeList(String keyword) {
		return chatDAO.getEmployeeList(keyword);
	}

	/* 대화방 생성 */
	@Transactional
	public int createChat(String chat_subject, Integer login_emp_idx, List<Integer> emp_idx_list) {
		// 1. chat 테이블에 대화방 생성
		ChatDTO chatDTO = new ChatDTO();
		chatDTO.setChat_subject(chat_subject);
		chatDAO.insertChat(chatDTO);

		// 2. 방금 생성된 chatIdx 가져오기
		int chat_idx = chatDTO.getChat_idx();

		// 3. 로그인 사용자 추가
		PartyDTO loginPartyDTO = new PartyDTO();
		loginPartyDTO.setChat_idx(chat_idx);
		loginPartyDTO.setEmp_idx(login_emp_idx);
		chatDAO.insertParty(loginPartyDTO);

		// 4. emp_idx_list가 비어있지 않다면 추가
		if (emp_idx_list != null && !emp_idx_list.isEmpty()) {
			for (Integer emp_idx : emp_idx_list) {
				PartyDTO partyDTO = new PartyDTO();
				partyDTO.setChat_idx(chat_idx);
				partyDTO.setEmp_idx(emp_idx);
				chatDAO.insertParty(partyDTO);
			}
		}

		// 5. 현재 날짜 시스템 메시지 저장
		String currentDate = new SimpleDateFormat("yyyy년 MM월 dd일").format(new Date());
		MessageDTO messageDTO = new MessageDTO();
		messageDTO.setChat_idx(chat_idx);
		messageDTO.setContent(currentDate);
		messageDTO.setMessage_type("system");
		chatDAO.insertEnterMessage(messageDTO);

		broadcastEnterMessage(chat_idx, currentDate);

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

		// 초대 메시지 생성
		String inviteMessage = inviterName + "님이 " + invitedEmpName + "님을 초대하셨습니다.";

		// 시스템 메시지 저장
		MessageDTO messageDTO = new MessageDTO();
		messageDTO.setChat_idx(chat_idx);
		messageDTO.setContent(inviteMessage);
		messageDTO.setMessage_type("system");
		chatDAO.insertEnterMessage(messageDTO);

		// WebSocket 브로드캐스트
		broadcastEnterMessage(chat_idx, inviteMessage);
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

	/* 메시지 저장 & 날짜 확인 */
	public int message(MessageDTO message) {
		// 오늘 날짜 포맷
		String today = new SimpleDateFormat("yyyy년 MM월 dd일").format(new Date());

		// 오늘 날짜에 메시지가 있는지 확인
		int messageExists = chatDAO.checkMessageExistsForToday(message.getChat_idx(), today);

		// 메시지가 없으면 시스템 메시지 추가
		if (messageExists == 0) {
			MessageDTO systemMessage = new MessageDTO();
			systemMessage.setChat_idx(message.getChat_idx());
			systemMessage.setContent(today); // 날짜를 시스템 메시지로 설정
			systemMessage.setMessage_type("system");
			chatDAO.insertEnterMessage(systemMessage); // 시스템 메시지 저장

			// WebSocket으로 날짜 시스템 메시지 전송
			broadcastEnterMessage(message.getChat_idx(), today);
		}

		// 메시지 저장
		chatDAO.message(message);
		int msgIdx = message.getMsg_idx(); // 저장된 msg_idx 가져오기

		// msg_read에 기본값 삽입
		Map<String, Object> params = new HashMap<>();
		params.put("msg_idx", msgIdx);
		params.put("chat_idx", message.getChat_idx());
		params.put("sender_idx", message.getMsg_send_idx());
		chatDAO.insertDefaultMsgRead(params);

		return msgIdx;
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

	/* 방 나가기 */
	public boolean leaveChat(int chat_idx, int emp_idx) {
		// DAO를 호출하여 참여자 테이블에서 삭제
		int result = chatDAO.removeParticipant(chat_idx, emp_idx);
		return result > 0; // 성공 여부 반환
	}

	/* 방 나간후 시스템 메시지 뿌려주기 */
	public void saveAndBroadcastSystemMessage(int chat_idx, String content) {
		// 시스템 메시지 저장
		MessageDTO messageDTO = new MessageDTO();
		messageDTO.setChat_idx(chat_idx);
		messageDTO.setContent(content);
		messageDTO.setMessage_type("system");
		chatDAO.insertEnterMessage(messageDTO); // 기존 insertEnterMessage 메서드 사용

		// WebSocket으로 메시지 전송
		broadcastEnterMessage(chat_idx, content);
	}

	@Transactional
	public void updateConnectionStart(int chatIdx, int empIdx, LocalDateTime startTime) {
		int exists = chatDAO.checkConnectionStatusExists(chatIdx, empIdx);
		if (exists == 0) {
			chatDAO.insertConnectionStatus(chatIdx, empIdx, startTime); // endTime 기본값: 2038-01-19
		} else {
			chatDAO.updateConnectionTime(chatIdx, empIdx, startTime, "start");
		}

		// 읽음 상태 업데이트
		chatDAO.markMessagesAsRead(chatIdx, empIdx, LocalDateTime.now()); // 현재 시간 전달

		// broadcastUnreadCount(chatIdx);
		broadcastUpdatedUnreadCounts(chatIdx);
	}

	public void broadcastUpdatedUnreadCounts(int chatIdx) {
		List<Integer> msgIdxList = chatDAO.getMsgIdxListByChatIdx(chatIdx);

		for (Integer msgIdx : msgIdxList) {
			int unreadCount = chatDAO.getUnreadUserCount(msgIdx);

			Map<String, Object> payload = new HashMap<>();
			payload.put("type", "UPDATE_UNREAD_COUNT");
			payload.put("chat_idx", chatIdx); // 필수!!!
			payload.put("msg_idx", msgIdx);
			payload.put("unread_count", unreadCount);

			WebsocketHandler.broadcast(payload);
		}
	}

	@Transactional
	public void updateConnectionEnd(int chatIdx, int empIdx, LocalDateTime endTime) {
		// 데이터가 있으면 endTime만 업데이트
		chatDAO.updateConnectionTime(chatIdx, empIdx, endTime, "end");
	}

	// 메시지 읽지 않음 씨빨!!!!
	public int getUnreadUserCount(int msgIdx) {
		return chatDAO.getUnreadUserCount(msgIdx);
	}

}
