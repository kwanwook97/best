package com.best.chat;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.best.emp.EmployeeDTO;
import com.best.websocket.GlobalWebsocketHandler;

@Controller
public class ChatController {
	@Autowired
	ChatService chatService;
	@Autowired
	GlobalWebsocketHandler globalWs;

	/*
	 * 메신져 기능 장희재
	 */

	/* 메신저 이동 */
	@RequestMapping(value = "/chat.go")
	public String chatGo() {
		return "chat/chat";
	}

	/*
	 * 대화방 초대 대화방 생성하기 눌렀을 때, 상대 방 지정 & 초대하기로 상대방 지정 & 초대, 입장, 퇴장 시스템 메시지 저장 & 웹소켓으로
	 * 뿌려주기
	 */
	@PostMapping(value = "/addParty.ajax")
	@ResponseBody
	public Map<String, Object> addParty(@RequestBody Map<String, Object> requestData, HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		try {
			// JSON 데이터 파싱
			int chatIdx = Integer.parseInt(requestData.get("chat_idx").toString());
			List<?> empIdxRawList = (List<?>) requestData.get("emp_idx_list");

			// emp_idx를 Integer 리스트로 변환
			List<Integer> empIdxList = empIdxRawList.stream().map(emp -> Integer.parseInt(emp.toString()))
					.collect(Collectors.toList());

			// 세션에서 로그인 사용자 이름 가져오기
			String loginName = (String) session.getAttribute("loginName");
			if (loginName == null) {
				throw new RuntimeException("로그인 이름을 찾을 수 없습니다.");
			}

			// 각 사용자에 대해 초대 처리
			for (int empIdx : empIdxList) {
				String invitedEmpName = chatService.getEmployeeName(empIdx);
				chatService.addPartyWithInviteMessage(chatIdx, empIdx, loginName, invitedEmpName);
			}

			result.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			result.put("success", false);
			result.put("message", "오류 발생");
		}
		return result;
	}

	/* 대화방 참여자 리스트 */
	@GetMapping(value = "/chatParticipants.ajax")
	@ResponseBody
	public List<Map<String, Object>> getChatParticipants(@RequestParam int chat_idx) {
		return chatService.getChatParticipants(chat_idx);
	}

	/* 메시지 내용 가져오기 */
	@PostMapping(value = "/getMessages.ajax")
	@ResponseBody
	public List<Map<String, Object>> getMessages(@RequestBody Map<String, Object> payload) {
		int chatIdx = Integer.parseInt(payload.get("chat_idx").toString());
		return chatService.getMessagesByChatIdx(chatIdx);
	}

	/* 메시지 저장 */
	@PostMapping(value = "/message.ajax")
	@ResponseBody
	public ResponseEntity<?> message(@RequestBody Map<String, Object> payload, HttpSession session) {
		try {
			int chatIdx = Integer.parseInt(payload.get("chat_idx").toString());
			String content = payload.get("content").toString();
			int senderIdx = Integer.parseInt((String) session.getAttribute("loginId"));

			MessageDTO message = new MessageDTO();
			message.setChat_idx(chatIdx);
			message.setMsg_send_idx(senderIdx);
			message.setContent(content);

			// 메시지 저장 후 msg_idx 반환
			int msgIdx = chatService.message(message);

			// msg_idx 반환
			Map<String, Object> response = new HashMap<>();
			response.put("msg_idx", msgIdx);
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error saving message");
		}
	}

	/* 메신져 리스트 이동 */
	@RequestMapping(value = "/chatList.go")
	public String chatListGo() {
		return "chat/chatList";
	}

	/* 내가 참여중인 메신져 리스트 보여주기 */
	@GetMapping(value = "/chatList.ajax")
	@ResponseBody
	public Map<String, Object> chatList(int emp_idx,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {
		List<Map<String, Object>> chatList = chatService.chatList(emp_idx, keyword);
		List<Map<String, Object>> employeeList = chatService.getEmployeeList(keyword); // 사원 목록 조회 서비스 호출

		Map<String, Object> response = new HashMap<>();
		response.put("chatList", chatList);
		response.put("employeeList", employeeList);

		return response;
	}

	/* 회원 리스트 보여주기 */
	@GetMapping(value="/memberList.ajax")
	@ResponseBody
	public List<Map<String, Object>> getMemberList(@RequestParam(value = "keyword", required = false) String keyword) {
		return chatService.getEmployeeList(keyword); // 회원 리스트를 반환하는 서비스 호출
	}
	
	/* 대화방에 참여중인 인원 제외하고 보여주기 */
	@GetMapping(value = "/chatParty.ajax")
	@ResponseBody
	public List<Map<String, Object>> chatParty(
	        @RequestParam(value = "keyword", required = false) String keyword,
	        @RequestParam(value = "chat_idx") int chatIdx) {
	    return chatService.chatParty(keyword, chatIdx);
	}

	
	/* 회원 프로필 가져오기 */
	@GetMapping(value="/profile.ajax")
	@ResponseBody
	public Map<String, Object> profile(@RequestParam(value = "emp_idx", required = false) String emp_idx){
		int empIdx = Integer.parseInt(emp_idx);
		Map<String, Object> profileData = chatService.profile(empIdx);

	    return profileData;
	}
	
	
	/* 대화방 생성 */
	@PostMapping(value = "/createChat.do")
	@ResponseBody
	public Map<String, Object> createChat(@RequestBody Map<String, Object> requestData, HttpSession session) {
	    Map<String, Object> result = new HashMap<>();
	    try {
	        String chat_subject = (String) requestData.get("chat_subject");
	        List<Integer> emp_idx_list = (List<Integer>) requestData.get("emp_idx_list");

	        Integer login_emp_idx = Integer.parseInt((String) session.getAttribute("loginId"));

	        // 단둘만 있는 대화방 확인
	        if (emp_idx_list.size() == 1) { // 상대방이 1명일 때만 체크
	            Integer existingChatIdx = chatService.findSingleChatRoom(login_emp_idx, emp_idx_list.get(0));
	            if (existingChatIdx != null) {
	                // 단둘만 있는 대화방으로 이동
	                result.put("success", true);
	                result.put("chatIdx", existingChatIdx);
	                result.put("existing", true);
	                return result;
	            }
	        }

	        // 대화방 생성
	        int chat_idx = chatService.createChat(chat_subject, login_emp_idx, emp_idx_list);

	        result.put("success", true);
	        result.put("chatIdx", chat_idx);
	        result.put("existing", false);
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("success", false);
	    }
	    return result;
	}

//	@PostMapping(value = "/createChat.do")
//	@ResponseBody
//	public Map<String, Object> createChat(@RequestBody Map<String, Object> requestData, HttpSession session) {
//		Map<String, Object> result = new HashMap<>();
//		try {
//			String chat_subject = (String) requestData.get("chat_subject");
//			List<Integer> emp_idx_list = (List<Integer>) requestData.get("emp_idx_list");
//
//			Integer login_emp_idx = Integer.parseInt((String) session.getAttribute("loginId"));
//
//			// 대화방 생성
//			int chat_idx = chatService.createChat(chat_subject, login_emp_idx, emp_idx_list);
//
//			result.put("success", true);
//			result.put("chatIdx", chat_idx);
//		} catch (Exception e) {
//			e.printStackTrace();
//			result.put("success", false);
//		}
//		return result;
//	}

	/* 방 나가기 */
	@PostMapping(value="/leaveChat.ajax")
	@ResponseBody
	public Map<String, Object> leaveChat(HttpSession session, @RequestParam int chat_idx) {
		Integer emp_idx = Integer.parseInt((String) session.getAttribute("loginId"));
		String loginName = (String) session.getAttribute("loginName"); // 로그인한 사용자 이름

		boolean success = chatService.leaveChat(chat_idx, emp_idx);

		// 시스템 메시지 저장 및 WebSocket 전송
		if (success) {
			String systemMessage = loginName + " 님이 나갔습니다.";
			chatService.saveAndBroadcastSystemMessage(chat_idx, systemMessage);
		}

		Map<String, Object> response = new HashMap<>();
		response.put("success", success);
		if (!success) {
			response.put("message", "방 나가기에 실패했습니다.");
		}
		return response;
	}
	
	/* 웹소켓 연결 & 종료 시간 업데이트 */
	@PostMapping(value="/updateConnectionTime")
	@ResponseBody
	public ResponseEntity<?> updateConnectionTime(@RequestBody Map<String, Object> payload, HttpSession session) {
		int chat_idx = Integer.parseInt(payload.get("chat_idx").toString());
		String action = payload.get("action").toString();
		int emp_idx = Integer.parseInt((String) session.getAttribute("loginId"));
		LocalDateTime currentTime = LocalDateTime.now();

		if ("connect".equals(action)) {
			chatService.updateConnectionStart(chat_idx, emp_idx, currentTime);
		} else if ("disconnect".equals(action)) {
			chatService.updateConnectionEnd(chat_idx, emp_idx, currentTime);
		}
		return ResponseEntity.ok("Connection time updated");
	}

	/* 읽지않은 유저 수 */
	@GetMapping(value="/unreadUserCount.ajax")
	@ResponseBody
	public int getUnreadUserCount(@RequestParam int msg_idx) {
		return chatService.getUnreadUserCount(msg_idx);
	}
	
	/* 대화방 제목 변경 */
	@PostMapping(value="/updateChatSubject.ajax")
	@ResponseBody
	public Map<String, Object> updateChatSubject(@RequestBody Map<String, Object> requestBody, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();
	    String chatIdxStr = (String) requestBody.get("chat_idx");
	    String chatSubject = (String) requestBody.get("chat_subject");
	    String empName = (String) session.getAttribute("loginName"); // 세션에서 emp_name 가져오기

	    try {
	        Integer chatIdx = Integer.valueOf(chatIdxStr); // String을 Integer로 변환

	        ChatDTO chatDTO = new ChatDTO();
	        chatDTO.setChat_idx(chatIdx);
	        chatDTO.setChat_subject(chatSubject);

	        boolean isUpdated = chatService.updateChatSubject(chatDTO, empName);

	        if (isUpdated) {
	            response.put("success", true);
	        } else {
	            response.put("success", false);
	            response.put("message", "대화방 제목 수정에 실패했습니다.");
	        }
	    } catch (NumberFormatException e) {
	        response.put("success", false);
	        response.put("message", "chat_idx가 올바르지 않습니다.");
	    }

	    return response;
	}
	
	/* 대화방 공지사항 등록 */
	@PostMapping("/registerNotice.ajax")
	@ResponseBody
	public Map<String, Object> registerNotice(@RequestBody Map<String, Object> requestBody, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        String noticeContent = (String) requestBody.get("content");
	        String empName = (String) session.getAttribute("loginName");
	        Integer chatIdx = Integer.valueOf(requestBody.get("chat_idx").toString());

	        chatService.addNotice(chatIdx, noticeContent, empName);

	        response.put("success", true);
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "공지사항 등록 중 오류 발생: " + e.getMessage());
	    }
	    return response;
	}
	
	/* 공지사항 가져오기 */
	@GetMapping(value = "/getChatNotice.ajax")
	@ResponseBody
	public Map<String, Object> getChatNotice(@RequestParam int chat_idx) {
	    String chatNotice = chatService.getChatNotice(chat_idx);

	    Map<String, Object> response = new HashMap<>();
	    response.put("success", true);
	    response.put("chat_idx", chat_idx);
	    response.put("notice", chatNotice);

	    return response;
	}
	
	/* 안읽은 메시지 총 갯수 */
	@GetMapping(value = "/unreadTotal.ajax")
	@ResponseBody
	public int unreadTotal(HttpSession session) {
	    // 세션에서 로그인 ID 가져오기
	    Integer emp_idx = Integer.parseInt((String) session.getAttribute("loginId"));

	    // 서비스 호출하여 읽지 않은 메시지 수 계산
	    return chatService.unreadTotal(emp_idx);
	}
	
	/* 메시지 알림 */
	@GetMapping(value="/msgAlarm.ajax")
	@ResponseBody
    public List<Map<String, Object>> msgAlarm(@RequestParam("emp_idx") Integer empIdx) {
        return chatService.msgAlarm(empIdx);
    }
}
