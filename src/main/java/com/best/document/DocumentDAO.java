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
	// 검색
	int searchCount(int emp_idx, int cnt, String status, String searchType, String query);
	List<Map<String, Object>> searchList(int emp_idx, int limit, int offset, 
			String status, String searchType, String query);
	
	/* 받은 문서 */
	// 전자결재 대기 토탈 페이지 / 리스트
	int pendingCount(int emp_idx, int cnt);
	List<Map<String, Object>> pendingList(int emp_idx, int limit, int offset);
	// 검색
	int searchPending(int emp_idx, int cnt, String searchType, String query);
	List<Map<String, Object>> searchPendingList(int emp_idx, int limit, int offset, String searchType, String query);
	
	// 전자결재 진행중 토탈 페이지 / 리스트
	int inProgressCount(int emp_idx, int cnt);
	List<Map<String, Object>> inProgressList(int emp_idx, int limit, int offset);
	// 검색
	int searchInProgress(int emp_idx, int cnt, String searchType, String query);
	List<Map<String, Object>> searchInProgressList(int emp_idx, int limit, int offset, String searchType, String query);
	
	// 전자결재 완료 토탈 페이지 / 리스트
	int approvedCount(int emp_idx, int cnt);
	List<Map<String, Object>> approvedList(int emp_idx, int limit, int offset);
	// 검색
	int searchApproved(int emp_idx, int cnt, String searchType, String query);
	List<Map<String, Object>> searchApprovedList(int emp_idx, int limit, int offset, String searchType, String query);
	
	// 전자결재 반려 토탈 페이지 / 리스트
	int rejectCount(int emp_idx, int cnt);
	List<Map<String, Object>> rejectList(int emp_idx, int limit, int offset);
	// 검색
	int searchReject(int emp_idx, int cnt, String searchType, String query);
	List<Map<String, Object>> searchRejectList(int emp_idx, int limit, int offset, String searchType, String query);
	
	// 전자결재 참조 토탈 페이지 / 리스트
	int referenceCount(int emp_idx, int cnt);
	List<Map<String, Object>> referenceList(int emp_idx, int limit, int offset);
	// 검색
	int searchReference(int emp_idx, int cnt, String searchType, String query);
	List<Map<String, Object>> searchReferenceList(int emp_idx, int limit, int offset, String searchType, String query);
	
	// 읽음, 읽지않음 처리
	boolean updateRead(int doc_idx, int doc_read, int approv_num);
	
	
	// 전자결재 임시저장
	int formSave(DocumentDTO docDTO);
	// 전자결재 임시저장 상세보기
	String getDocument(String doc_idx);
	// 전자결재 문서 번호
	String getDocNumer(String doc_idx);
	// 전자결재 임시저장 삭제
	int draftDelete(String doc_idx);
	// 전재결재 임시저장 수정
	int formUpdate(String doc_idx, String doc_content, String doc_subject);
	
	// 전자결재 양식 불러오기
	String getForm(String form_subject);
	// 전자결재 양식 검색
	List<Map<String, String>> searchForm(String query);
	
	// 전자결재 문서번호 만들기
	Integer getLastSequenceForDate(String today);

	// 전자결재 기안자 정보
	Map<String, Object> getEmpDetails(int emp_idx);



















	
	




}
