package com.best.document;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.best.emp.EmployeeDAO;
import com.best.emp.EmployeeDTO;

@Service
public class DocumentService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired DocumentDAO documentDao;
	
	// 전자결재 대기 리스트
	public Map<String, Object> pendingList(int page, int cnt, String status) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1; // 사원 번호
		
		int receivedTotalPages = documentDao.pendingCount(emp_idx, cnt);
		int sentTotalPages = documentDao.sentCount(emp_idx, cnt, status);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("receivedTotalPages", receivedTotalPages);
		result.put("sentTotalPages", sentTotalPages);
		
		List<Map<String, Object>> receivedList = documentDao.pendingList(emp_idx, limit, offset);
		List<Map<String, Object>> sentList = documentDao.sentList(emp_idx, limit, offset, status);
	    result.put("receivedList", receivedList);
	    result.put("sentList", sentList);
		return result;
	}
	// 전자결재 대기 리스트 검색
	public Map<String, Object> searchPending(int page, int cnt, String status, String listType,
			String searchType, String query) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1; // 사원 번호
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(listType.equals("received")) {
			
			int receivedTotalPages = documentDao.searchPending(emp_idx, cnt, searchType, query);
			List<Map<String, Object>> receivedList = documentDao.searchPendingList(emp_idx, limit, offset, searchType, query);
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("receivedList", receivedList);
			
		}else if(listType.equals("sent")) {
			int sentTotalPages = documentDao.searchCount(emp_idx, cnt, status, searchType, query);
			List<Map<String, Object>> sentList = documentDao.searchList(emp_idx, limit, offset, status, searchType, query);
			result.put("sentTotalPages", sentTotalPages);			
			result.put("sentList", sentList);
		}
		return result;
	}
	
	
	// 전자결재 진행중 리스트
	public Map<String, Object> inProgressList(int page, int cnt, String status) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1;
		
		int receivedTotalPages = documentDao.inProgressCount(emp_idx, cnt);
		int sentTotalPages = documentDao.sentCount(emp_idx, cnt, status);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("receivedTotalPages", receivedTotalPages);
		result.put("sentTotalPages", sentTotalPages);
		
		List<Map<String, Object>> receivedList = documentDao.inProgressList(emp_idx, limit, offset);
		List<Map<String, Object>> sentList = documentDao.sentList(emp_idx, limit, offset, status);
	    result.put("receivedList", receivedList);
	    result.put("sentList", sentList);
		return result;
	}
	// 전자결재 진행중 리스트 검색
	public Map<String, Object> searchInProgress(int page, int cnt, String status, String listType, String searchType,
			String query) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1; // 사원 번호
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(listType.equals("received")) {
			
			int receivedTotalPages = documentDao.searchInProgress(emp_idx, cnt, searchType, query);
			List<Map<String, Object>> receivedList = documentDao.searchInProgressList(emp_idx, limit, offset, searchType, query);
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("receivedList", receivedList);
			
		}else if(listType.equals("sent")) {
			int sentTotalPages = documentDao.searchCount(emp_idx, cnt, status, searchType, query);
			List<Map<String, Object>> sentList = documentDao.searchList(emp_idx, limit, offset, status, searchType, query);
			result.put("sentTotalPages", sentTotalPages);			
			result.put("sentList", sentList);
		}
		return result;
	}
	
	
	// 전자결재 완료 리스트
	public Map<String, Object> approvedList(int page, int cnt, String status) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1;
		
		int receivedTotalPages = documentDao.approvedCount(emp_idx, cnt);
		int sentTotalPages = documentDao.sentCount(emp_idx, cnt, status);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("receivedTotalPages", receivedTotalPages);
		result.put("sentTotalPages", sentTotalPages);
		
		List<Map<String, Object>> receivedList = documentDao.approvedList(emp_idx, limit, offset);
		List<Map<String, Object>> sentList = documentDao.sentList(emp_idx, limit, offset, status);
	    result.put("receivedList", receivedList);
	    result.put("sentList", sentList);
		return result;
	}
	// 전자결재 완료 리스트 검색
	public Map<String, Object> searchApproved(int page, int cnt, String status, String listType, String searchType,
			String query) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1; // 사원 번호
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(listType.equals("received")) {
			
			int receivedTotalPages = documentDao.searchApproved(emp_idx, cnt, searchType, query);
			List<Map<String, Object>> receivedList = documentDao.searchApprovedList(emp_idx, limit, offset, searchType, query);
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("receivedList", receivedList);
			
		}else if(listType.equals("sent")) {
			int sentTotalPages = documentDao.searchCount(emp_idx, cnt, status, searchType, query);
			List<Map<String, Object>> sentList = documentDao.searchList(emp_idx, limit, offset, status, searchType, query);
			result.put("sentTotalPages", sentTotalPages);			
			result.put("sentList", sentList);
		}
		return result;
	}

	
	// 전자결재 반려 리스트
	public Map<String, Object> rejectList(int page, int cnt, String status) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1;
		
		int receivedTotalPages = documentDao.rejectCount(emp_idx, cnt);
		int sentTotalPages = documentDao.sentCount(emp_idx, cnt, status);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("receivedTotalPages", receivedTotalPages);
		result.put("sentTotalPages", sentTotalPages);
		
		List<Map<String, Object>> receivedList = documentDao.rejectList(emp_idx, limit, offset);
		List<Map<String, Object>> sentList = documentDao.sentList(emp_idx, limit, offset, status);
	    result.put("receivedList", receivedList);
	    result.put("sentList", sentList);
		return result;
	}
	// 전자결재 반려 리스트 검색
	public Map<String, Object> searchReject(int page, int cnt, String status, String listType, String searchType,
			String query) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1; // 사원 번호
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(listType.equals("received")) {
			
			int receivedTotalPages = documentDao.searchReject(emp_idx, cnt, searchType, query);
			List<Map<String, Object>> receivedList = documentDao.searchRejectList(emp_idx, limit, offset, searchType, query);
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("receivedList", receivedList);
			
		}else if(listType.equals("sent")) {
			int sentTotalPages = documentDao.searchCount(emp_idx, cnt, status, searchType, query);
			List<Map<String, Object>> sentList = documentDao.searchList(emp_idx, limit, offset, status, searchType, query);
			result.put("sentTotalPages", sentTotalPages);			
			result.put("sentList", sentList);
		}
		return result;
	}
	
	
	// 전자결재 참조 리스트
	public Map<String, Object> referenceList(int page, int cnt, String status) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1;
		
		int receivedTotalPages = documentDao.referenceCount(emp_idx, cnt);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("receivedTotalPages", receivedTotalPages);
		
		List<Map<String, Object>> receivedList = documentDao.referenceList(emp_idx, limit, offset);
	    result.put("receivedList", receivedList);
		return result;
	}
	// 전자결재 참조 리스트 검색
	public Map<String, Object> searchReference(int page, int cnt, String status, String listType, String searchType,
			String query) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1;
		
		int receivedTotalPages = documentDao.referenceCount(emp_idx, cnt);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("receivedTotalPages", receivedTotalPages);
		
		List<Map<String, Object>> receivedList = documentDao.referenceList(emp_idx, limit, offset);
	    result.put("receivedList", receivedList);
		return result;
	}

	// 임시저장 리스트
	public Map<String, Object> draftList(int page, int cnt, String status) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1;
		
		int totalPages = documentDao.sentCount(emp_idx, cnt, status);
		logger.info("토탈페이지:", totalPages);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		
		List<Map<String, Object>> saveList = documentDao.sentList(emp_idx, limit, offset, status);
	    result.put("saveList", saveList);
		
		return result;
	}
	// 임시저장 리스트 검색
	public Map<String, Object> searchDraft(int page, int cnt, String status, String listType, String searchType,
			String query) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1;
		
		int totalPages = documentDao.sentCount(emp_idx, cnt, status);
		logger.info("토탈페이지:", totalPages);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		
		List<Map<String, Object>> saveList = documentDao.sentList(emp_idx, limit, offset, status);
	    result.put("saveList", saveList);
		
		return result;
	}

	// 읽음, 읽지않음 처리
	public boolean updateRead(int doc_idx, int doc_read) {
		return documentDao.updateRead(doc_idx, doc_read);
	}

	// 임시저장 상세보기
	public String draftDetail(String doc_idx) {
		String htmlContent = documentDao.draftDetail(doc_idx);
		return htmlContent
				.replace("${doc_idx}", doc_idx);
	}
	
	// 임시저장 삭제
	public int draftDelete(String doc_idx) {
		return documentDao.draftDelete(doc_idx);
	}
	
	
	
	// 전자결재 양식 불러오기
    public String getForm(String form_subject) {
        // 양식 내용 가져오기
        String htmlContent = documentDao.getForm(form_subject);

        // 오늘 날짜
        LocalDate todayDate = LocalDate.now();
        String todayDateString = todayDate.toString();  // 날짜를 문자열로 변환

        // 직원 정보 가져오기 (예시로 emp_idx가 1인 직원 정보)
        int emp_idx = 1;  // 예시로 1번 직원 정보를 가져옴
        Map<String, Object> employeeDetails = documentDao.getEmpDetails(emp_idx);
        logger.info("기안자 정보: {}",employeeDetails);
        // HTML 내용에 데이터를 삽입 (replace를 사용하여 치환)
        return htmlContent
                .replace("${todayDate}", todayDateString)
                .replace("${name}", (String) employeeDetails.get("name"))
                .replace("${sign}", (String) employeeDetails.get("sign"))
                .replace("${managerName}", (String) employeeDetails.get("managerName"))
                .replace("${depart_name}", (String) employeeDetails.get("depart_name"))
                .replace("${rank_name}", (String) employeeDetails.get("rank_name"))
        		.replace("${doc_number}", "")
        		.replace("${remain_leave}", Integer.toString((Integer) employeeDetails.get("remain_leave")));

    }

    // 전자결재 양식 검색
	public List<Map<String, String>> searchForm(String query) {
        return documentDao.searchForm(query);
	}

	// 결재 임시저장
	@Transactional
	public void formSave(String form_idx, String doc_subject, 
	                     String doc_content, int emp_idx, String status) {

	    // Step 1: 오늘 날짜 포맷팅
	    String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"));
	    logger.info("오늘 날짜: " + today);

	    // Step 2: 오늘 날짜의 마지막 시퀀스 가져오기 (트랜잭션 내에서 FOR UPDATE로 락)
	    Integer lastSeq = documentDao.getLastSequenceForDate(today);

	    // Step 3: 새로운 시퀀스 번호 계산
	    int newSeq = (lastSeq == null) ? 1 : lastSeq + 1;

	    // Step 4: 문서 번호 생성
	    String docNumber = today + "-" + String.format("%04d", newSeq);
	    logger.info("생성된 문서번호: " + docNumber);

    	// Step 5: DocumentDTO 생성 및 값 설정
    	DocumentDTO docDTO = new DocumentDTO();
    	docDTO.setForm_idx(Integer.parseInt(form_idx));
    	docDTO.setDoc_subject(doc_subject);
    	docDTO.setDoc_content(doc_content);
    	docDTO.setEmp_idx(emp_idx);
    	docDTO.setStatus(status);
    	docDTO.setDoc_number(docNumber);
    	
    	// Step 6: 데이터베이스에 저장
    	documentDao.formSave(docDTO);
	}


	// 결재 임시저장 문서 수정
	public void formUpdate(String doc_idx, String doc_subject, String doc_content) {
		documentDao.formUpdate(doc_subject,doc_content,doc_idx);
	}

















	




}
