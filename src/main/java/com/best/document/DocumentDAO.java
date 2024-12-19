package com.best.document;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DocumentDAO {

	// 전자결재 양식 불러오기
	String getForm(String form_subject);

	// 결재 기안, 임시저장
	int formSave(DocumentDTO docDTO);
	// 문서번호 만들기
	Integer getLastSequenceForDate(String today);
	
	// 임시저장 토탈 페이지
	int allCount(int cnt);
	// 임시저장 리스트
	List<Map<String, Object>> saveList(int limit, int offset);

	// 임시저장 상세보기
	String draftDetail(String doc_idx);

	// 임시저장 삭제
	int draftDelete(String doc_idx);



}
