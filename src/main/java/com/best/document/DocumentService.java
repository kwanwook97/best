package com.best.document;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.best.emp.EmployeeDAO;
import com.best.emp.EmployeeDTO;

@Service
public class DocumentService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired DocumentDAO documentDao;
	@Autowired EmployeeDAO employeeDao;
	
	// 전자결재 대기 리스트
	public Map<String, Object> pendingList(int page, int cnt) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1;
		
		int receivedTotalPages = documentDao.receivedCount(emp_idx, cnt);
		int sentTotalPages = documentDao.sentCount(emp_idx, cnt);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("receivedTotalPages", receivedTotalPages);
		result.put("sentTotalPages", sentTotalPages);
		
		List<Map<String, Object>> receivedList = documentDao.receivedList(emp_idx, limit, offset);
		List<Map<String, Object>> sentList = documentDao.sentList(emp_idx, limit, offset);
	    result.put("receivedList", receivedList);
	    result.put("sentList", sentList);
		return result;
	}
	
	
	// 전자결재 진행중 리스트
	// 전자결재 완료 리스트
	// 전자결재 반려 리스트
	// 전자결재 참조 리스트
	// 임시저장 리스트
	public Map<String, Object> saveList(int page, int cnt) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		int emp_idx = 1;
		
		int totalPages = documentDao.allCount(cnt);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		
		List<Map<String, Object>> saveList = documentDao.saveList(emp_idx, limit, offset);
	    result.put("saveList", saveList);
		
		return result;
	}

	// 임시저장 상세보기
	public String draftDetail(String doc_idx) {
		return documentDao.draftDetail(doc_idx);
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
        Map<String, Object> employeeDetails = employeeDao.getEmpDetails(emp_idx);
        logger.info("기안자 정보: {}",employeeDetails);
        // HTML 내용에 데이터를 삽입 (replace를 사용하여 치환)
        return htmlContent
                .replace("${todayDate}", todayDateString)
                .replace("${name}", (String) employeeDetails.get("name"))
                .replace("${sign}", (String) employeeDetails.get("sign"))
                .replace("${managerName}", (String) employeeDetails.get("managerName"))
                .replace("${depart_name}", (String) employeeDetails.get("depart_name"))
                .replace("${rank_name}", (String) employeeDetails.get("rank_name"))
        		.replace("${doc_number}", "");
    }


	// 결재 기안, 임시저장
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

	




}
