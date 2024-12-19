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

@Service
public class DocumentService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired DocumentDAO documentDao;
	
	// 전자결재 양식 불러오기
	public String getForm(String form_subject) {
		return documentDao.getForm(form_subject);
	}

	// 결재 기안, 임시저장
	public void formSave(String form_idx, String doc_subject, 
			String doc_content, int emp_idx, String status) {
		
        // 오늘 날짜 가져오기
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("yyMMdd"));
        logger.info("오늘 날짜" + today);
        // 오늘 날짜의 마지막 시퀀스 가져오기
        Integer lastSeq = documentDao.getLastSequenceForDate(today);

        // 새로운 시퀀스 번호 계산
        int newSeq = (lastSeq == null) ? 1 : lastSeq + 1;

        // 문서번호 생성
        String docNumber = today + "-" + String.format("%04d", newSeq);
        logger.info("문서번호 "+docNumber);
		DocumentDTO docDTO = new DocumentDTO();
		docDTO.setForm_idx(Integer.parseInt(form_idx));
		docDTO.setDoc_subject(doc_subject);
		docDTO.setDoc_content(doc_content);
		docDTO.setEmp_idx(emp_idx);
		docDTO.setStatus(status);
		docDTO.setDoc_number(docNumber);
		
		documentDao.formSave(docDTO);
	}

	// 임시저장 리스트
	public Map<String, Object> saveList(int page, int cnt) {
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		int totalPages = documentDao.allCount(cnt);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		
		List<Map<String, Object>> saveList = documentDao.saveList(limit, offset);
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




}
