package com.best.document;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DocumentController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired DocumentService documentService;
	
	// 전자결재 메인 리스트
	@RequestMapping(value="/documentBoard.go")
	public String documentBoard() {
		return "document/documentBoard";
	}
	
	
	// 전자결재 완료 리스트
	@RequestMapping(value="/documentApproved.go")
	public String documentApproved() {
		return "document/documentApproved";
	}
	
	
	
	
	
	
	// 전자결재 임시저장 리스트
	@RequestMapping(value="/documentDraft.go")
	public String documentDraft() {
		return "document/documentDraft";
	}
	
	
	
	
	
	// 전자결재 메인 리스트
	@RequestMapping(value="/documentReject.go")
	public String documentReject() {
		return "document/documentReject";
	}
}
