package com.best.mail;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
	
	// 메일작성 페이지
	@RequestMapping(value = "/mailWrite.go")
	public String mailWrite() {
		return "mail/mailWrite";
	}
	
	// 메일전송
	@RequestMapping(value = "/mailWrite.do")
	public String mailWrite(MultipartFile[] files, @RequestParam Map<String, Object> map, Model model) {
		String page = "mail/mailWrite";
		
		int row = mailService.mailWrite(files, map);
		
		// 메일전송 성공시
		if(row > 0) {
			page = "redirect:/mail.go";
		}else {
			model.addAttribute("msg", "메일전송에 실패했습니다.");
		}
		
		return page;
	}
	
	// 메일상세보기
	@RequestMapping(value = "/mailDetail.go")
	public String mailDetail(String idx, Model model) {
		String page = "mail/mailDetail";
		
		mailService.mailDetail(idx, model);
		
		return page;
	}
	
	
	// 사원정보 가져오기(메일, 이름, idx) 
	@RequestMapping(value="/empInfo.ajax")
	@ResponseBody
	public List<Map<String, Object>> empInfo(@RequestParam Map<String, Object> map) {
		
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
	
	// 메일읽음여부 변경
	@RequestMapping(value="/updateReadStatus.ajax")
	@ResponseBody
	public int updateReadStatus(@RequestParam Map<String, Object> map) {
	    // 메일 읽음여부 변경 후 결과값 반환
	    return mailService.updateReadStatus(map);
	}
	
	// 중요여부 변경
	@RequestMapping(value="/updateSpecialStatus.ajax")
	@ResponseBody
	public int updateSpecialStatus(@RequestParam Map<String, Object> map) {
		return mailService.updateSpecialStatus(map);
	}
	
	// 메일 휴지통이동, 복구, 완전삭제 
	@RequestMapping(value="/updateDeleteStatus.ajax")
	@ResponseBody
	public int updateDeleteStatus(@RequestParam Map<String, Object> map) {
		return mailService.updateDeleteStatus(map);
	}

	
}
