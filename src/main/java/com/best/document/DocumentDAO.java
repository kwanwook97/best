package com.best.document;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DocumentDAO {

	/* 보낸 문서 */
	// 대기, 진행중, 완료, 반려, 임시저장 토탈 페이지 / 리스트
	int sentCount(String emp_idx, int cnt, String status);
	List<Map<String, Object>> sentList(String emp_idx, int limit, int offset, String status);
	// 검색
	int searchCount(String emp_idx, int cnt, String status, String searchType, String query);
	List<Map<String, Object>> searchList(String emp_idx, int limit, int offset, String status, String searchType, String query);

	
	/* 받은 문서 */
	// 전자결재 @대기@ 토탈 페이지 / 리스트
	int pendingCount(String emp_idx, int cnt, String readStatus);
	List<Map<String, Object>> pendingList(String emp_idx, int limit, int offset, String readStatus);
	// 검색
	int searchPending(String emp_idx, int cnt, String searchType, String query);
	List<Map<String, Object>> searchPendingList(String emp_idx, int limit, int offset, String searchType, String query);
	
	
	// 전자결재 @진행중@ 토탈 페이지 / 리스트
	int inProgressCount(String emp_idx, int cnt, String readStatus);
	List<Map<String, Object>> inProgressList(String emp_idx, int limit, int offset, String readStatus);
	// 검색
	int searchInProgress(String emp_idx, int cnt, String searchType, String query);
	List<Map<String, Object>> searchInProgressList(String emp_idx, int limit, int offset, String searchType, String query);
	
	// 전자결재 @완료@ 토탈 페이지 / 리스트
	int approvedCount(String emp_idx, int cnt, String readStatus);
	List<Map<String, Object>> approvedList(String emp_idx, int limit, int offset, String readStatus);
	// 검색
	int searchApproved(String emp_idx, int cnt, String searchType, String query);
	List<Map<String, Object>> searchApprovedList(String emp_idx, int limit, int offset, String searchType, String query);
	
	// 전자결재 @반려@ 토탈 페이지 / 리스트
	int rejectCount(String emp_idx, int cnt, String readStatus);
	List<Map<String, Object>> rejectList(String emp_idx, int limit, int offset, String readStatus);
	// 검색
	int searchReject(String emp_idx, int cnt, String searchType, String query);
	List<Map<String, Object>> searchRejectList(String emp_idx, int limit, int offset, String searchType, String query);
	
	// 전자결재 @참조@ 토탈 페이지 / 리스트
	int referenceCount(String emp_idx, int cnt, String readStatus);
	List<Map<String, Object>> referenceList(String emp_idx, int limit, int offset, String readStatus);
	// 검색
	int searchReference(String emp_idx, int cnt, String searchType, String query);
	List<Map<String, Object>> searchReferenceList(String emp_idx, int limit, int offset, String searchType, String query);

	
	// 읽음, 읽지않음 처리
	boolean updateReference(int doc_read, int ref_idx);
	boolean updateapprov(int doc_read, int approv_num);
	
	
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
	
	// 임시저장한거 기안
	int formUpdateSent(String doc_idx, String doc_content, String doc_subject);

	
	// 결재 양식 리스트
	List<FormDTO> getDocList();
	// 전자결재 양식 불러오기
	String getForm(String form_idx);
	// 전자결재 양식 검색
	List<Map<String, String>> searchForm(String query);
	
	// 전자결재 문서번호 만들기
	Integer getLastSequenceForDate(String today);

	// 전자결재 기안자 정보
	Map<String, Object> getEmpDetails(String emp_idx);
	
	// 팀장 idx
	Map<String, Integer> managerIdx(int emp_idx, String managerName);
	
	// 상신
	int formsent(int doc_idx, int parentManager, int order1, int manager, int order2, String status);
	
	
	
	
	
	
	// 서명
	int saveSign(Map<String, Object> result);
	// 서명하기
	String getSign(String emp_idx);
	
	
	// 결재 승인
	int approveStatus(String doc_idx, String approv_order, String approv_date);
	int documentStatus(String doc_idx, String doc_content);
	int documentStatusT(String doc_idx, String doc_content);
	// 결재 반려
	int rejectStatus(String doc_idx, String emp_idx, String approv_date);
	int documentStatusReject(String doc_idx, String doc_content, String remark);
	
	// 참조
	int referenceEmpOne(int doc_idx, String firstRef);
	int referenceEmpTwo(int doc_idx, String firstRef, String secondRef);
	int referenceEmpThree(int doc_idx, String firstRef, String secondRef, String thirdRef);


	
	Map<String, Object> getApproverDetails(int docIdx);
	List<Integer> getReferenceEmpIds(int doc_idx);
	


















	
	




}
