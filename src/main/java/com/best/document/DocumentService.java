package com.best.document;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.best.alarm.AlarmDTO;
import com.best.alarm.AlarmService;
import com.best.emp.EmployeeDAO;
import com.best.emp.EmployeeDTO;
import com.best.leave.LeaveDAO;

@Service
public class DocumentService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired DocumentDAO documentDao;
    @Value("${upload.path}") private String signPath;
    @Autowired LeaveDAO leaveDAO;
	// 전자결재 대기 리스트
	public Map<String, Object> pendingList(int page, int cnt, String status, String emp_idx, String readStatus) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(readStatus.equals("all")) {
			
			int receivedTotalPages = documentDao.pendingCount(emp_idx, cnt, readStatus);
			int sentTotalPages = documentDao.sentCount(emp_idx, cnt, status);
			
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("sentTotalPages", sentTotalPages);
			
			List<Map<String, Object>> receivedList = documentDao.pendingList(emp_idx, limit, offset, readStatus);
			List<Map<String, Object>> sentList = documentDao.sentList(emp_idx, limit, offset, status);
			
		    result.put("receivedList", receivedList);
		    result.put("sentList", sentList);
		    
		}else if	(readStatus.equals("read")) {
			
			readStatus = "1";
			
			int receivedTotalPages = documentDao.pendingCount(emp_idx, cnt, readStatus);
			List<Map<String, Object>> receivedList = documentDao.pendingList(emp_idx, limit, offset, readStatus);
			
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("receivedList", receivedList);
			
		}else if(readStatus.equals("unread")) {
			
			readStatus = "0";
			
			int receivedTotalPages = documentDao.pendingCount(emp_idx, cnt, readStatus);
			List<Map<String, Object>> receivedList = documentDao.pendingList(emp_idx, limit, offset, readStatus);
			
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("receivedList", receivedList);
			
		}
		return result;
	}
	// 전자결재 대기 리스트 검색
	public Map<String, Object> searchPending(int page, int cnt, String status, String listType,
			String searchType, String query, String emp_idx) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
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
	public Map<String, Object> inProgressList(int page, int cnt, String status, String emp_idx, String readStatus) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(readStatus.equals("all")) {
			
			int receivedTotalPages = documentDao.inProgressCount(emp_idx, cnt, readStatus);
			int sentTotalPages = documentDao.sentCount(emp_idx, cnt, status);
			
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("sentTotalPages", sentTotalPages);
			
			List<Map<String, Object>> receivedList = documentDao.inProgressList(emp_idx, limit, offset, readStatus);
			List<Map<String, Object>> sentList = documentDao.sentList(emp_idx, limit, offset, status);
			
		    result.put("receivedList", receivedList);
		    result.put("sentList", sentList);
		    
		}else if(readStatus.equals("read")) {	
			
			readStatus = "1";
			
			int receivedTotalPages = documentDao.inProgressCount(emp_idx, cnt, readStatus);
			List<Map<String, Object>> receivedList = documentDao.inProgressList(emp_idx, limit, offset, readStatus);
			
			result.put("receivedTotalPages", receivedTotalPages);			
			result.put("receivedList", receivedList);
			
		}else if(readStatus.equals("unread")) {
			
			readStatus = "0";
			
			int receivedTotalPages = documentDao.inProgressCount(emp_idx, cnt, readStatus);
			List<Map<String, Object>> receivedList = documentDao.inProgressList(emp_idx, limit, offset, readStatus);
			
			result.put("receivedTotalPages", receivedTotalPages);			
			result.put("receivedList", receivedList);
			
		}
		return result;
	}
	// 전자결재 진행중 리스트 검색
	public Map<String, Object> searchInProgress(int page, int cnt, String status, String listType, String searchType,
			String query, String emp_idx) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
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
	public Map<String, Object> approvedList(int page, int cnt, String status, String emp_idx, String readStatus) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		Map<String, Object> result = new HashMap<String, Object>();

		if(readStatus.equals("all")) {
			
			int receivedTotalPages = documentDao.approvedCount(emp_idx, cnt, readStatus);
			int sentTotalPages = documentDao.sentCount(emp_idx, cnt, status);
			
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("sentTotalPages", sentTotalPages);
			
			List<Map<String, Object>> receivedList = documentDao.approvedList(emp_idx, limit, offset, readStatus);
			List<Map<String, Object>> sentList = documentDao.sentList(emp_idx, limit, offset, status);
			
			result.put("receivedList", receivedList);
			result.put("sentList", sentList);
			
		}else if(readStatus.equals("read")) {
			
			readStatus = "1";
			
			int receivedTotalPages = documentDao.approvedCount(emp_idx, cnt, readStatus);
			List<Map<String, Object>> receivedList = documentDao.approvedList(emp_idx, limit, offset, readStatus);
			
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("receivedList", receivedList);
			
		}else if(readStatus.equals("unread")) {
			
			readStatus = "0";
			
			int receivedTotalPages = documentDao.approvedCount(emp_idx, cnt, readStatus);
			List<Map<String, Object>> receivedList = documentDao.approvedList(emp_idx, limit, offset, readStatus);
			
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("receivedList", receivedList);
			
		}
		return result;
	}
	// 전자결재 완료 리스트 검색
	public Map<String, Object> searchApproved(int page, int cnt, String status, String listType, String searchType,
			String query, String emp_idx) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
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
	public Map<String, Object> rejectList(int page, int cnt, String status, String emp_idx, String readStatus) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		Map<String, Object> result = new HashMap<String, Object>();

		if(readStatus.equals("all")) {
			
			int receivedTotalPages = documentDao.rejectCount(emp_idx, cnt, readStatus);
			int sentTotalPages = documentDao.sentCount(emp_idx, cnt, status);
			
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("sentTotalPages", sentTotalPages);
			
			List<Map<String, Object>> receivedList = documentDao.rejectList(emp_idx, limit, offset, readStatus);
			List<Map<String, Object>> sentList = documentDao.sentList(emp_idx, limit, offset, status);
			
			result.put("receivedList", receivedList);
			result.put("sentList", sentList);
			
		}else if(readStatus.equals("read")) {
			
			readStatus = "1";
			
			int receivedTotalPages = documentDao.rejectCount(emp_idx, cnt, readStatus);
			List<Map<String, Object>> receivedList = documentDao.rejectList(emp_idx, limit, offset, readStatus);
			
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("receivedList", receivedList);
			
		}else if(readStatus.equals("unread")) {
			
			readStatus = "0";
			
			int receivedTotalPages = documentDao.rejectCount(emp_idx, cnt, readStatus);
			List<Map<String, Object>> receivedList = documentDao.rejectList(emp_idx, limit, offset, readStatus);
			
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("receivedList", receivedList);
			
		}
		return result;
	}
	// 전자결재 반려 리스트 검색
	public Map<String, Object> searchReject(int page, int cnt, String status, String listType, String searchType,
			String query, String emp_idx) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
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
	public Map<String, Object> referenceList(int page, int cnt, String status, String emp_idx, String readStatus) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		Map<String, Object> result = new HashMap<String, Object>();

		if(readStatus.equals("all")) {
			
			int receivedTotalPages = documentDao.referenceCount(emp_idx, cnt, readStatus);
			List<Map<String, Object>> receivedList = documentDao.referenceList(emp_idx, limit, offset, readStatus);
			
			result.put("receivedTotalPages", receivedTotalPages);
			result.put("receivedList", receivedList);
			
		}else if(readStatus.equals("read")) {
			
			readStatus = "1";
			
			int receivedTotalPages = documentDao.referenceCount(emp_idx, cnt, readStatus);
			List<Map<String, Object>> receivedList = documentDao.referenceList(emp_idx, limit, offset, readStatus);
			
			result.put("receivedTotalPages", receivedTotalPages);
		    result.put("receivedList", receivedList);
		    
		}else if(readStatus.equals("unread")) {
			
			readStatus = "0";
			
			int receivedTotalPages = documentDao.referenceCount(emp_idx, cnt, readStatus);
			List<Map<String, Object>> receivedList = documentDao.referenceList(emp_idx, limit, offset, readStatus);
			
			result.put("receivedTotalPages", receivedTotalPages);
		    result.put("receivedList", receivedList);
		    
		}
		return result;
	}
	// 전자결재 참조 리스트 검색
	public Map<String, Object> searchReference(int page, int cnt, String status, String listType, String searchType,
			String query, String emp_idx) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		int receivedTotalPages = documentDao.searchReference(emp_idx, cnt, searchType, query);
		List<Map<String, Object>> receivedList = documentDao.searchReferenceList(emp_idx, limit, offset, searchType, query);
		
		result.put("receivedTotalPages", receivedTotalPages);
	    result.put("receivedList", receivedList);
	    
		return result;
	}

	// 임시저장 리스트
	public Map<String, Object> draftList(int page, int cnt, String status, String emp_idx) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		int totalPages = documentDao.sentCount(emp_idx, cnt, status);
		List<Map<String, Object>> saveList = documentDao.sentList(emp_idx, limit, offset, status);
		
		result.put("totalPages", totalPages);
	    result.put("saveList", saveList);
		
		return result;
	}
	// 임시저장 리스트 검색
	public Map<String, Object> searchDraft(int page, int cnt, String status, String listType, String searchType,
			String query, String emp_idx) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		Map<String, Object> result = new HashMap<String, Object>();

		int totalPages = documentDao.searchCount(emp_idx, cnt, status, searchType, query);
		List<Map<String, Object>> saveList = documentDao.searchList(emp_idx, limit, offset, status, searchType, query);
		
		result.put("totalPages", totalPages);
	    result.put("saveList", saveList);
		
		return result;
	}

	// 읽음, 읽지않음 처리
	public boolean updateRead(String text, int doc_read, int approv_num) {
		
		boolean success = false;
		
		if(text.equals("참조")) {
			success = documentDao.updateReference(doc_read, approv_num);
		}else {			
			success = documentDao.updateapprov(doc_read, approv_num);
		}
		return success;
	}

	// 임시저장 상세보기
	public String draftDetail(String doc_idx) {
		String htmlContent = documentDao.getDocument(doc_idx);
		String doc_number = documentDao.getDocNumer(doc_idx);
		
		logger.info("idx : "+doc_idx);
		logger.info("번호 : "+ doc_number);
		logger.info("idx : "+htmlContent);
		
		return htmlContent
				.replace("${doc_idx}", doc_idx)
				.replaceFirst(
			        "(<span\\s+class=\"comp_item\\s+doc_number\"[^>]*>)(</span>)",
			        "$1" + doc_number + "$2"
			    );
	}
	
	// 임시저장 삭제
	public int draftDelete(String doc_idx) {
		return documentDao.draftDelete(doc_idx);
	}
	
	// 결재 양식 리스트
	public List<FormDTO> getDocList() {
		return documentDao.getDocList();
	}
	
	// 전자결재 양식 불러오기
    public String getForm(String form_idx, String emp_idx) throws IOException {
        // 양식 내용 가져오기
        String htmlContent = documentDao.getForm(form_idx);
        logger.info("시발아 :"+htmlContent);
        // 오늘 날짜
        LocalDate todayDate = LocalDate.now();
        String todayDateString = todayDate.toString();

        // 직원 정보 가져오기
        Map<String, Object> employeeDetails = documentDao.getEmpDetails(emp_idx);
        logger.info("기안자 정보: {}",employeeDetails);
        
        // 이미지 파일을 Base64로 변환
        String sign = (String) employeeDetails.get("sign");
        Path filePath = Paths.get(signPath + sign);
        byte[] imageBytes = Files.readAllBytes(filePath);
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);

        // HTML에 Base64 인코딩된 이미지 삽입
        String signImageUrl = "data:image/png;base64," + base64Image;
        
        return htmlContent
                .replace("${todayDate}", todayDateString)
                .replace("${name}", (String) employeeDetails.get("name"))
                .replace("${managerName}", (String) employeeDetails.get("managerName"))
                .replace("${depart_name}", (String) employeeDetails.get("depart_name"))
                .replace("${rank_name}", (String) employeeDetails.get("rank_name"))
        		.replace("${doc_number}", "")
        		.replace("${remain_leave}", Integer.toString((Integer) employeeDetails.get("remain_leave")))
				.replace("${sign}", "<img src='" + signImageUrl + "' alt='서명' style='max-width: 90px; max-height: 70px;'/>");

    }

    // 전자결재 양식 검색
	public List<Map<String, String>> searchForm(String query) {
        return documentDao.searchForm(query);
	}

	// 결재 임시저장
	@Transactional
	public int formSave(String form_idx, String doc_subject, 
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
    	
    	return docDTO.getDoc_idx();
	}
	// 상신
	public void formsent(int doc_idx, int parentManager, int order1, int manager, int order2, String status) {
		documentDao.formsent(doc_idx,  parentManager, order1, manager, order2, status);
		
		notifyApproval(doc_idx, 0, "상신");
	}
		
	// 결재 임시저장 문서 수정
	public void formUpdate(String doc_idx, String doc_content, String doc_subject) {
		documentDao.formUpdate(doc_idx, doc_content, doc_subject);
	}
	
	// 임시저장한거 기안
	public int formUpdateSent(String doc_idx, String doc_content, String doc_subject) {
		return documentDao.formUpdateSent(doc_idx, doc_content, doc_subject);
	}
	
	// 결재자 emp_idx
	public Map<String, Integer> managerIdx(int emp_idx, String managerName) {
		return documentDao.managerIdx(emp_idx, managerName);
	}
	
	
	
	
	
	
	// 서명
	public int saveSign(String sign, String emp_idx) {

		try {
			// Base64로 받은 데이터에서 "data:image/png;base64," 부분 제거
			String imageDataBytes = sign.split(",")[1];
		
			// Base64 문자열을 바이트 배열로 디코딩
			byte[] imageBytes = Base64.getDecoder().decode(imageDataBytes);
		
			// 파일명을 생성 (예: emp_1.png)
	        String empSign = "emp_" + emp_idx +".png";

			// 파일 저장 경로
			Path path = Paths.get("C:/upload/" + empSign);
			
			Files.write(path, imageBytes);
			
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("emp_idx", emp_idx);
			result.put("sign", empSign);
			
			return documentDao.saveSign(result);
			
		} catch (IOException e) {
			e.printStackTrace();
			return 0;
		}
		
		
	}
	
	// 서명하기
	public String getSign(String emp_idx) throws IOException {
		
        String sign = documentDao.getSign(emp_idx);
        Path filePath = Paths.get(signPath + sign);
        byte[] imageBytes = Files.readAllBytes(filePath);
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
        String signImageUrl = "data:image/png;base64," + base64Image;
        
		return signImageUrl;
	}
	
	// 결재 승인
	@Transactional
	public void approveStatus(String doc_idx, String approv_order, String doc_content) {

		String approv_date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		String approvDate= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

		documentDao.approveStatus(doc_idx, approv_order, approv_date);
		
		doc_content = doc_content.replaceFirst(
		        "(<td\\s+class=\"todayDate1\"[^>]*>)(</td>)",
		        "$1" + approvDate + "$2"
		    );
		logger.info("뭔데 : "+ doc_content);
		
		documentDao.documentStatus(doc_idx, doc_content);
		
		// 결재 알림 처리
	    notifyApproval(
	        Integer.parseInt(doc_idx),
	        Integer.parseInt(approv_order),
	        "승인"
	    );
	}
	@Transactional
	public void approveStatusT(String doc_idx, String approv_order, String doc_content) {
		String approv_date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		String approvDate= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		documentDao.approveStatus(doc_idx, approv_order, approv_date);
		
		doc_content = doc_content.replaceFirst(
			"(<td\\s+class=\"todayDate3\"[^>]*>)(</td>)",
				"$1" + approvDate + "$2"
			);
		logger.info("뭔데 : "+ doc_content);
		
		documentDao.documentStatusT(doc_idx, doc_content);
	    
		notifyApproval(
		        Integer.parseInt(doc_idx),
		        Integer.parseInt(approv_order),
		        "승인"
		    );
	}
	// 결재 반려
	@Transactional
	public void rejectStatus(String doc_idx, String emp_idx, String remark, String doc_content) {
		String approv_date = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		String approvDate= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		documentDao.rejectStatus(doc_idx, emp_idx, approv_date);
		
		doc_content = doc_content.replaceFirst(
			"(<td\\s+class=\"todayDate4\"[^>]*>)(</td>)",
				"$1" + approvDate + "$2"
			);
		documentDao.documentStatusReject(doc_idx, doc_content, remark);
		
		 // 반려 알림 처리
	    notifyApproval(
	        Integer.parseInt(doc_idx),
	        0, // 반려는 approvOrder가 필요 없음
	        "반려"
	    );
	}
	
	
	// 참조
	public void referenceEmp(int doc_idx, List<String> managerIds) {
		
		if (managerIds.size() == 1) {
	        documentDao.referenceEmpOne(doc_idx, managerIds.get(0));
	    } else if (managerIds.size() == 2) {
	        documentDao.referenceEmpTwo(doc_idx, managerIds.get(0), managerIds.get(1));
	    } else if (managerIds.size() == 3) {
	        documentDao.referenceEmpThree(doc_idx, managerIds.get(0), managerIds.get(1), managerIds.get(2));
	    }
	}
	














	@Autowired
	private AlarmService alarmService;

	private void notifyApproval(
	        int docIdx,
	        int approvOrder,
	        String status
	    ) {
	    // 결재자 정보를 DAO에서 조회
	    Map<String, Object> approverData = documentDao.getApproverDetails(docIdx);
	    if (approverData == null) {
	        throw new IllegalStateException("결재자 정보를 찾을 수 없습니다.");
	    }

	    int writerEmpIdx = (int) approverData.get("writerEmpIdx");
	    String writerName = (String) approverData.get("writerName");
	    int firstApproverEmpIdx = (int) approverData.getOrDefault("firstApproverEmpIdx", 0);
	    String firstApproverName = (String) approverData.getOrDefault("firstApproverName", ""); // 1차 결재자 이름
	    int secondApproverEmpIdx = (int) approverData.getOrDefault("secondApproverEmpIdx", 0);
	    String secondApproverName = (String) approverData.getOrDefault("secondApproverName", ""); // 2차 결재자 이름
	    String formName = (String) approverData.get("formName"); // 양식 이름

	    // 참조자 ID 가져오기
	    List<Integer> referenceEmpIds = documentDao.getReferenceEmpIds(docIdx);
	    if (referenceEmpIds == null) {
	        referenceEmpIds = new ArrayList<>();
	    }

	    List<AlarmDTO> alarms = new ArrayList<>();
	    String message = "";

	    switch (status) {
        case "상신":
            message = writerName+ "님의 " + formName + " 문서가 도착했습니다.";
            if (firstApproverEmpIdx > 0) {
                alarms.add(createAlarm(firstApproverEmpIdx, message));
            }
            // 참조자 알림 추가
            for (int referenceEmpIdx : referenceEmpIds) {
                alarms.add(createAlarm(referenceEmpIdx, writerName+ "님의 " + formName + " 문서가 도착했습니다."));
            }
            break;

        case "반려":
            message = firstApproverName + " 님이 기안하신 " + formName + "(을)를 반려하였습니다.";
            alarms.add(createAlarm(writerEmpIdx, message)); // 기안자

            if (firstApproverEmpIdx > 0) {
                alarms.add(createAlarm(firstApproverEmpIdx, secondApproverName + "님이 승인하신 " + formName + "(을)를 반려하였습니다.")); // 1차 결재자
            }
            // 참조자 알림 추가
            for (int referenceEmpIdx : referenceEmpIds) {
                alarms.add(createAlarm(referenceEmpIdx, writerName+ "님의 " + formName + " 문서가 반려되었습니다."));
            }
            break;

        case "승인":
            if (approvOrder == 1) {
                message = firstApproverName + "님이 기안하신 " + formName + "(을)를 승인하셨습니다.";
                alarms.add(createAlarm(writerEmpIdx, message)); // 기안자
                if (secondApproverEmpIdx > 0) {
                    alarms.add(createAlarm(secondApproverEmpIdx, writerName + "님의 " + formName + " 문서가 도착했습니다.")); // 2차 결재자
                }
            } else if (approvOrder == 2) {
                message = secondApproverName + "님이 기안하신 " + formName + "(을)를 최종 승인하셨습니다.";
                alarms.add(createAlarm(writerEmpIdx, message)); // 기안자
                if (firstApproverEmpIdx > 0) {
                    alarms.add(createAlarm(firstApproverEmpIdx, secondApproverName + "님이 승인하신 " + formName + "(을)를 최종 승인하셨습니다.")); // 1차 결재자
                }
                for (int referenceEmpIdx : referenceEmpIds) {
                    alarms.add(createAlarm(referenceEmpIdx, writerName+ "님의 " + formName + " 문서가 승인되었습니다."));
                }
            }
            break;
    }

	    // 알림 전송
	    alarmService.sendAlarms(alarms);
	}


	private AlarmDTO createAlarm(int empIdx, String content) {
	    AlarmDTO alarm = new AlarmDTO();
	    alarm.setEmp_idx(empIdx);
	    alarm.setType("document");
	    alarm.setContent(content);
	    alarm.setDate(new Date());
	    return alarm;
	}






	




}
