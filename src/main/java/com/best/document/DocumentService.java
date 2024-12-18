package com.best.document;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

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
		
		DocumentDTO docDTO = new DocumentDTO();
		docDTO.setForm_idx(Integer.parseInt(form_idx));
		docDTO.setDoc_subject(doc_subject);
		docDTO.setDoc_content(doc_content);
		docDTO.setEmp_idx(emp_idx);
		docDTO.setStatus(status);
		
		documentDao.formSave(docDTO);
	}

	// 임시저장 리스트
	public Map<String, Object> saveList(int page, int cnt) {
		int limit = cnt;
		int offset = (page-1) * limit;
		
		int totalPages = documentDao.allCount(limit);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("saveList", documentDao.saveList(limit, offset));
		
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
