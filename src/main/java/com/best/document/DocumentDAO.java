package com.best.document;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DocumentDAO {

	/* 보낸 문서 */
	// 대기, 진행중, 완료, 반려, 임시저장 토탈 페이지 / 리스트
	int sentCount(int emp_idx, int cnt, String status);
	List<Map<String, Object>> sentList(int emp_idx, int limit, int offset, String status);
	
	
	/* 받은 문서 */
	// 전자결재 대기 토탈 페이지 / 리스트
	int pendingCount(int emp_idx, int cnt);
	List<Map<String, Object>> pendingList(int emp_idx, int limit, int offset);
	
	// 전자결재 진행중 토탈 페이지 / 리스트
	int inProgressCount(int emp_idx, int cnt);
	List<Map<String, Object>> inProgressList(int emp_idx, int limit, int offset);
	
	// 전자결재 완료 토탈 페이지 / 리스트
	int approvedCount(int emp_idx, int cnt);
	List<Map<String, Object>> approvedList(int emp_idx, int limit, int offset);
	
	// 전자결재 반려 토탈 페이지 / 리스트
	int rejectCount(int emp_idx, int cnt);
	List<Map<String, Object>> rejectList(int emp_idx, int limit, int offset);
	
	// 전자결재 참조 토탈 페이지 / 리스트
	int referenceCount(int emp_idx, int cnt);
	List<Map<String, Object>> referenceList(int emp_idx, int limit, int offset);
	
	
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

	// 전자결재 기안자 정보
	Map<String, Object> getEmpDetails(int emp_idx);







	
	




}
