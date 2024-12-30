package com.best.document;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class DocumentController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired DocumentService documentService;

	// 전자결재 대기 리스트
	@RequestMapping(value="/documentPending.go")
	public String documentPending() {
		return "document/documentPending";
	}
	// 전자결재 진행중 리스트
	@RequestMapping(value="/documentBoard.go")
	public String documentBoard() {
		return "document/documentBoard";
	}
	// 전자결재 완료 리스트
	@RequestMapping(value="/documentApproved.go")
	public String documentApproved() {
		return "document/documentApproved";
	}
	// 전자결재 반려 리스트
	@RequestMapping(value="/documentReject.go")
	public String documentReject() {
		return "document/documentReject";
	}		
	// 전자결재 참조 리스트
	@RequestMapping(value="/documentReference.go")
	public String documentReference() {
		return "document/documentReference";
	}		
	// 전자결재 임시저장 리스트
	@RequestMapping(value="/documentDraft.go")
	public String documentDraft() {
		return "document/documentDraft";
	}
	
	
	// 전자결재 리스트
	@GetMapping(value="/documentList.ajax")
	@ResponseBody
	public Map<String, Object> documentList(String text, String page, String cnt, HttpSession session) {
	    int page_ = Integer.parseInt(page);
	    int cnt_ = Integer.parseInt(cnt);
	    String status = "";
	    String emp_idx = (String) session.getAttribute("loginId");
	    switch (text) {
	        case "대기":
	            status = "상신";
	            return documentService.pendingList(page_, cnt_, status, emp_idx);
	        case "진행중":
	            status = "진행중";
	            return documentService.inProgressList(page_, cnt_, status, emp_idx);
	        case "완료":
	        	status = "완료";
	        	return documentService.approvedList(page_, cnt_, status, emp_idx);
	        case "반려":
	        	status = "반려";
	        	return documentService.rejectList(page_, cnt_, status, emp_idx);
	        case "참조":
	        	status = "참조";
	        	return documentService.referenceList(page_, cnt_, status, emp_idx);
	        case "임시저장":
	        	status = "임시저장";
	        	return documentService.draftList(page_, cnt_, status, emp_idx);
	        default:
	            logger.warn("알 수 없는 상태", text);
	            return new HashMap<String, Object>();
	    }
	}
	
	
	// 전자결재 리스트 검색
	@PostMapping(value="/searchList.ajax")
	@ResponseBody
    public Map<String, Object> searchForm(String page, String cnt, String text, String listType, String searchType, String query, HttpSession session) {
	    int page_ = Integer.parseInt(page);
	    int cnt_ = Integer.parseInt(cnt);
	    String emp_idx = (String) session.getAttribute("loginId");
		String status = "";
		switch (text) {
        case "대기":
            status = "상신";
            return documentService.searchPending(page_, cnt_, status, listType, searchType, query, emp_idx);
		case "진행중":
            status = "진행중";
            return documentService.searchInProgress(page_, cnt_, status, listType, searchType, query, emp_idx);
        case "완료":
        	status = "완료";
        	return documentService.searchApproved(page_, cnt_, status, listType, searchType, query, emp_idx);
        case "반려":
        	status = "반려";
        	return documentService.searchReject(page_, cnt_, status, listType, searchType, query, emp_idx);
        case "참조":
        	status = "참조";
        	return documentService.searchReference(page_, cnt_, status, listType, searchType, query, emp_idx);
        case "임시저장":
        	status = "임시저장";
        	return documentService.searchDraft(page_, cnt_, status, listType, searchType, query, emp_idx);
        default:
            logger.warn("알 수 없는 상태", text);
            return new HashMap<String, Object>();
		}
	}    
	
	// 읽음, 읽지않음 처리
	@PostMapping(value="/updateRead.ajax")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateRead(String text, int doc_idx, int doc_read, int approv_num) {
		Map<String, Object> response = new HashMap<>();
		
		boolean success = documentService.updateRead(text, doc_idx, doc_read, approv_num);
	
        if (success) {
            response.put("success", 1);
        } else {
            response.put("success", 0);
            response.put("message", "문서 상태 업데이트 실패");
        }
		return ResponseEntity.ok(response);
	}
	
	
	// 임시저장 상세보기
	@GetMapping(value={"/draftDetail.ajax", "/pendingDetail.ajax"})
	@ResponseBody
	public String draftDetail(@RequestParam("doc_idx") String doc_idx) {
		String Detail = documentService.draftDetail(doc_idx);
		logger.info("바꾸고 난거: "+Detail);
		return Detail;		
	}
	// 임시저장 삭제
	@PostMapping(value="/documentDelete.ajax")
	@ResponseBody
	public Map<String, Object> draftDelete(String doc_idx) {
		Map<String, Object> response = new HashMap<>();

		int row = documentService.draftDelete(doc_idx);
		if(row>0) {			
			response.put("success", true);
		}
	    return response;
	}

	
	// 전자결재 양식 불러오기
	@GetMapping(value="/getForm.ajax")
	@ResponseBody
	public String getForm(String form_subject,  HttpSession session) throws IOException {
		String emp_idx = (String) session.getAttribute("loginId");
	    String responseContent = documentService.getForm(form_subject, emp_idx);
	    
	    return responseContent;
	}
	// 전재결재 양식 검색
	@PostMapping(value="/searchForm.ajax")
	@ResponseBody
    public List<Map<String, String>> searchForm(String query) {
        return documentService.searchForm(query);
    }
    
    
	// 결재 기안, 임시저장, 수정
	@GetMapping(value="/formType.ajax")
	@ResponseBody
	public ResponseEntity<Map<String, String>> formType(String form_idx,
			String action, String doc_subject, String doc_content,
			@RequestParam(required = false) String doc_idx,
	        @RequestParam(required = false) String start_date,
	        @RequestParam(required = false) String end_date,
	        @RequestParam(required = false) String managerName1,
	        HttpSession session) {
		Map<String, String> response = new HashMap<String, String>();
		
		String empIdx = (String) session.getAttribute("loginId");
		int emp_idx = Integer.parseInt(empIdx);
		// 요청에 따른 처리 로직
		if ("기안".equals(action)) {
			
			Map<String, Integer> result = documentService.managerIdx(emp_idx, managerName1);
			int parentManager = result.get("parentManager");
		    int manager = result.get("manager");
		    
	    	logger.info("팀장, 그위에 팀장 : "+parentManager +" / "+manager);
	    	int docIdx = documentService.formSave(form_idx, doc_subject, doc_content, emp_idx, "상신");
	    	if(docIdx > 0) {				
	    		documentService.formsent(docIdx, parentManager, 1, manager, 2, "상신");
	    		response.put("message", "기안 완료");
	    	}
	    	
		} else if ("임시저장".equals(action)) {
			
			logger.info("doc cont : {}", doc_content);
			documentService.formSave(form_idx, doc_subject, doc_content, emp_idx, "임시저장");
			response.put("message", "임시저장 완료");
			
		} else if("수정".equals(action)) {
			
			documentService.formUpdate(doc_idx, doc_content, doc_subject);
			response.put("message", "수정 완료");
			
		}  else if("수정기안".equals(action)) {
			
			Map<String, Integer> result = documentService.managerIdx(emp_idx, managerName1);
			int parentManager = result.get("parentManager");
		    int manager = result.get("manager");
		    
			int row = documentService.formUpdateSent(doc_idx, doc_content, doc_subject);
			if(row > 0) {				
				int docIdx = Integer.parseInt(doc_idx);
	    		documentService.formsent(docIdx, parentManager, 1, manager, 2, "상신");
	    		response.put("message", "기안 완료");	
			}
			
		}
		
		return ResponseEntity.ok(response);
	}	

	
	
	
	// 서명
	@RequestMapping(value="/sign.go")
	public String signGo() {
		return "document/sign";
	}
	
	@PostMapping(value="/saveSignature.ajax")
	@ResponseBody
	public ResponseEntity<Map<String, String>> saveSign(String sign, HttpSession session){
		Map<String, String> response = new HashMap<String, String>();
		String loginName = (String) session.getAttribute("loginName");
		String emp_idx = (String) session.getAttribute("loginId");
		logger.info("로그인 : "+loginName);
		logger.info("로그인 : "+emp_idx);
		logger.info("사인 : "+sign);
		
		int row = documentService.saveSign(sign, emp_idx);
		if(row>0) {
	        response.put("status", "success");
	        response.put("message", "서명 등록 완료.");
		}else {
	        response.put("status", "error");
	        response.put("message", "서명 등록 실패.");
		}
		return ResponseEntity.ok(response);
	}
	
	
	// 서명하기
	@GetMapping(value="/getSign.ajax")
	@ResponseBody
	public ResponseEntity<Map<String, String>> getSign(String emp_idx) throws IOException{
		Map<String, String> response = new HashMap<String, String>();
		String sign = documentService.getSign(emp_idx);
		if(sign != null) {
			response.put("message", "서명등록 됨");
			response.put("sign", sign);
		}else {
	        response.put("message", "서명등록하세요"); // 서명등록해라
		}
		
		return ResponseEntity.ok(response);
	}
		

	// 결재 승인, 반려
	@PostMapping(value="/approveDoc.ajax")
	@ResponseBody
	public ResponseEntity<Map<String, String>> approveDoc(String doc_idx, String approv_order, String actionType, String doc_content){
		Map<String, String> response = new HashMap<String, String>();
		
		if ("승인".equals(actionType)) {
			if(approv_order.equals("1")) {				
				documentService.approveStatus(doc_idx, approv_order, doc_content);
			}else if(approv_order.equals("2")) {
				documentService.approveStatusT(doc_idx, approv_order, doc_content);
			}
			
		}else if("반려".equals(actionType)) {
			
		}
			
			
		return ResponseEntity.ok(response);
	}
	
	
}
