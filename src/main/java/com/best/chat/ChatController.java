package com.best.chat;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

@Controller
public class ChatController {
	@Autowired ChatService chatService;
	
	/*
	 * 메신져 기능
	 * 장희재 
	 */
	
	/* 메신저 이동 */
	@RequestMapping(value="/chat.go")
	public String chatGo() {
		return "chat/chat";
	}
	
	/* 대화방 초대 
	 * 대화방 생성하기 눌렀을 때, 상대 방 지정
	 * &
	 * 초대하기로 상대방 지정
	 * &
	 * 초대, 입장, 퇴장 시스템 메시지 저장 & 웹소켓으로 뿌려주기
	 */
	@PostMapping(value = "/addParty.ajax")
	@ResponseBody
	public Map<String, Object> addParty(@RequestParam String chat_idx, @RequestParam String emp_idx, HttpSession session) {
	    Map<String, Object> result = new HashMap<>();
	    try {
	        int chatIdx = Integer.parseInt(chat_idx);
	        int empIdx = Integer.parseInt(emp_idx);

	        // 세션에서 로그인 사용자 이름 가져오기
	        String loginName = (String) session.getAttribute("loginName");
	        if (loginName == null) {
	            throw new RuntimeException("로그인 이름을 찾을 수 없습니다.");
	        }

	        // 초대받은 사용자의 이름 가져오기
	        String invitedEmpName = chatService.getEmployeeName(empIdx);

	        // 초대 메시지 처리
	        chatService.addPartyWithInviteMessage(chatIdx, empIdx, loginName, invitedEmpName);

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
	@PostMapping(value="/getMessages.ajax")
	@ResponseBody
	public List<Map<String, Object>> getMessages(@RequestBody Map<String, Object> payload) {
	    int chatIdx = Integer.parseInt(payload.get("chat_idx").toString());
	    return chatService.getMessagesByChatIdx(chatIdx);
    }
	
	/* 메시지 저장 */
	 @PostMapping(value="/message.ajax")
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
	            message.setTime(new Date()); // 현재 시간

	            chatService.message(message);

	            return ResponseEntity.ok("Message saved successfully");
	        } catch (Exception e) {
	            e.printStackTrace();
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error saving message");
	        }
	 }
	 
	 


	 /* 읽지 않은 메시지 수 */
	 @GetMapping("/unreadCount.ajax")
	 @ResponseBody
	 public ResponseEntity<?> unreadCount(@RequestParam int chat_idx, HttpSession session) {
	     int emp_idx = Integer.parseInt((String) session.getAttribute("loginId"));
	     int unreadCount = chatService.getUnreadMessageCount(chat_idx, emp_idx);
	     return ResponseEntity.ok(unreadCount);
	 }
	 
	 @PostMapping("/updateLastMsg.ajax")
	 @ResponseBody
	 public ResponseEntity<?> updateLastMsg(@RequestBody Map<String, Object> payload, HttpSession session) {
	     try {
	         int chatIdx = Integer.parseInt(payload.get("chat_idx").toString());
	         int lastMsgIdx = Integer.parseInt(payload.get("msg_idx").toString());
	         int empIdx = Integer.parseInt((String) session.getAttribute("loginId")); // 현재 사용자 ID 가져오기

	         chatService.updateLastMsg(chatIdx, empIdx, lastMsgIdx); // Service 호출

	         return ResponseEntity.ok("Last message updated successfully");
	     } catch (Exception e) {
	         e.printStackTrace();
	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating last message");
	     }
	 }
	 
	 @GetMapping("/messageUnreadCount.ajax")
	 @ResponseBody
	 public ResponseEntity<?> getMessageUnreadCount(@RequestParam int chat_idx, @RequestParam int msg_idx) {
	     try {
	         int unreadCount = chatService.getUnreadCountForMessage(chat_idx, msg_idx);
	         return ResponseEntity.ok(unreadCount);
	     } catch (Exception e) {
	         e.printStackTrace();
	         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("오류 발생");
	     }
	 }


	
	
	/* 메신져 리스트 이동*/
	@RequestMapping(value="/chatList.go")
	public String chatList() {
		return "chat/chatList";
	}
	
	/* 내가 참여중인 메신져 리스트 보여주기 */
	@GetMapping(value = "/chatList.ajax")
	@ResponseBody
	public Map<String, Object> chatList(HttpSession session) {
	    Integer emp_idx = Integer.parseInt((String) session.getAttribute("loginId"));
	    List<Map<String, Object>> chatList = chatService.chatList(emp_idx);
	    List<EmployeeDTO> employeeList = chatService.getEmployeeList(); // 사원 목록 조회 서비스 호출

	    Map<String, Object> response = new HashMap<>();
	    response.put("chatList", chatList);
	    response.put("employeeList", employeeList);

	    return response;
	}
	
	/* 회원 리스트 보여주기 */
	@GetMapping("/memberList.ajax")
	@ResponseBody
	public List<EmployeeDTO> getMemberList() {
	    return chatService.getEmployeeList(); // 회원 리스트를 반환하는 서비스 호출
	}

	/* 대화방 생성 */
	@PostMapping(value = "/createChat.do")
	@ResponseBody
	public Map<String, Object> createChat(
	    @RequestParam(required = false) String chat_subject,
	    @RequestParam(required = false) Integer emp_idx,
	    HttpSession session
	) {
	    Map<String, Object> result = new HashMap<>();
	    try {
	        Integer login_emp_idx = Integer.parseInt((String) session.getAttribute("loginId"));

	        // 대화방 생성
	        int chat_idx = chatService.createChat(chat_subject, login_emp_idx, emp_idx);

	        result.put("success", true);
	        result.put("chatIdx", chat_idx);
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("success", false);
	    }
	    return result;
	}
	
	/* 방 나가기 */
	@PostMapping("/leaveChat.ajax")
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

}
