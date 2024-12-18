package com.best.document;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DocumentController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired DocumentService documentService;

	// 전자결재 메인 리스트
	@RequestMapping(value = "/documentBoard.go")
	public String documentBoard() {
		return "document/documentBoard";
	}

	// 전자결재 완료 리스트
	@RequestMapping(value = "/documentApproved.go")
	public String documentApproved() {
		return "document/documentApproved";
	}

	// 전자결재 임시저장 리스트
	@RequestMapping(value = "/documentDraft.go")
	public String documentDraft() {
		return "document/documentDraft";
	}

	// 전자결재 메인 리스트
	@RequestMapping(value = "/documentReject.go")
	public String documentReject() {
		return "document/documentReject";
	}

	// 전자결재 양식 불러오기
	@GetMapping("/getForm.ajax")
	@ResponseBody
	 public String getForm(String form_subject, Model model) {
		// 오늘 날짜
	    LocalDate todayDate = LocalDate.now();
	    String todayDateString = todayDate.toString();  // 날짜를 문자열로 변환
	    logger.info("날짜: "+todayDateString);
	    
	    // 양식 가져오기
	    String htmlContent = documentService.getForm(form_subject);
	    String responseContent = htmlContent.replace("${todayDate}", todayDateString);

	    return responseContent;
    }
	
	// 결재 기안, 임시저장
	@PostMapping("/formType.ajax")
	@ResponseBody
	public ResponseEntity<Map<String, String>> formType(String action, String doc_subject, String doc_content) {
		Map<String, String> response = new HashMap<String, String>();
		
		// 요청에 따른 처리 로직
		if ("기안".equals(action)) {
			// 기안 처리 로직
			response.put("message", "기안 완료");
		} else if ("임시저장".equals(action)) {
			logger.info("doc cont : {}", doc_content);
			int form_idx = 1; // 양식번호
			int emp_idx = 1; // 사원번호
			documentService.formSave(form_idx, doc_subject, doc_content, emp_idx, "임시저장");
			response.put("message", "임시저장 완료");
		} else {
			response.put("message", "알 수 없는 요청");
		}
		
		return ResponseEntity.ok(response);
		}

	
	
	
	// 임시저장 리스트
	@GetMapping (value="/saveList.ajax")
	@ResponseBody
	public Map<String, Object> saveList(String page, String cnt) {
		int page_ = Integer.parseInt(page);
		int cnt_ = Integer.parseInt(cnt);
		
		return documentService.saveList(page_, cnt_);
	}
}
