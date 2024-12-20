package com.best.document;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DocumentDAO {

	// 전자결재 대기 토탈 페이지
	int receivedCount(int emp_idx, int cnt);
	int sentCount(int emp_idx, int cnt);
	// 전자결재 대기 리스트
	List<Map<String, Object>> receivedList(int emp_idx, int limit, int offset);
	List<Map<String, Object>> sentList(int emp_idx, int limit, int offset);
	
	
	// 전자결재 진행중 토탈 페이지
	// 전자결재 진행중 리스트
	// 전자결재 완료 토탈 페이지
	// 전자결재 완료 리스트
	// 전자결재 반려 토탈 페이지
	// 전자결재 반려 리스트
	// 전자결재 참조 토탈 페이지
	// 전자결재 참조 리스트
	
	
	// 전자결재 임시저장 토탈 페이지
	int allCount(int cnt);
	// 전자결재 임시저장 리스트
	List<Map<String, Object>> saveList(int emp_idx, int limit, int offset);
	// 전자결재 임시저장 상세보기
	String draftDetail(String doc_idx);
	// 전자결재 임시저장 삭제
	int draftDelete(String doc_idx);
	
	
	// 전자결재 양식 불러오기
	String getForm(String form_subject);

	// 전자결재 기안, 임시저장
	int formSave(DocumentDTO docDTO);
	
	// 전자결재 문서번호 만들기
	Integer getLastSequenceForDate(String today);

	
	




}
