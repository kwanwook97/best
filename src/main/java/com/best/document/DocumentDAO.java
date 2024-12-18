package com.best.document;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DocumentDAO {

	// 전자결재 양식 불러오기
	String getForm(String form_subject);

	// 결재 기안, 임시저장
	int formSave(DocumentDTO docDTO);

	
	// 임시저장 토탈 페이지
	int allCount(int limit);
	// 임시저장 리스트
	List<DocumentDTO> saveList(int limit, int offset);

}
