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

@Controller
public class ChatController {
	@Autowired ChatService chatService;
	
	@RequestMapping(value="/chat.go")
	public String chatGo() {
		return "chat/chat";
	}
	@RequestMapping(value="/chatList.go")
	public String chatList() {
		return "chat/chatList";
	}
	
	@GetMapping(value="/chatList.ajax")
	@ResponseBody
    public List<Map<String, Object>> chatList(HttpSession session) {
		Integer emp_idx = Integer.parseInt((String) session.getAttribute("loginId"));
        List<ChatDTO> chatList = chatService.chatList(emp_idx);

        List<Map<String, Object>> responseList = new ArrayList<>();

        for (ChatDTO chat : chatList) {
            Map<String, Object> chatMap = new HashMap<>();
            
            chatMap.put("chat_subject", chat.getChat_subject());
            chatMap.put("chat_idx", chat.getChat_idx());
            responseList.add(chatMap);
        }
        return responseList;

    }
	
	@PostMapping(value="/createChat.do")
    @ResponseBody
    public Map<String, Object> createChat(@RequestParam String chat_subject, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 로그인한 사용자 ID 가져오기
            Integer emp_idx = Integer.parseInt((String) session.getAttribute("loginId"));

            // 대화방 생성
            int chat_idx = chatService.createChat(chat_subject, emp_idx);

            result.put("success", true);
            result.put("chatIdx", chat_idx);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        return result;
    }
	
	
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
}
