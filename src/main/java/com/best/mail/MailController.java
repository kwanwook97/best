package com.best.mail;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MailController {

	@Autowired MailService mailService;
	
	@RequestMapping(value = "/mail.go")
	public String mail() {
		return "mail/mail";
	}
	
	@RequestMapping(value = "/test.go")
	public String Test() {
		return "mail/test";
	}
	
	@RequestMapping(value = "/mailWrite.go")
	public String mailWrite() {
		return "mail/mailWrite";
	}
	
	
	// 사원정보 가져오기(메일, 이름, idx) 
	@RequestMapping(value="/empInfo.ajax")
	@ResponseBody
	public Map<String, Object> empInfo(@RequestParam Map<String, String> map) {
		
		// 사원 DTO에 담기.
		return mailService.empInfo(map);
	}
	
	// 메일목록 가져오기
	@RequestMapping(value="/mailList.ajax")
	@ResponseBody
	public Map<String, Object> mailList(@RequestParam Map<String, String> map) {
		
		// 사원목록 DTO에 담기.
		return mailService.mailList(map);
	}
	
}
