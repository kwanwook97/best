package com.best.emp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface EmployeeDAO {
	// 지정된 사원 목록조회
	List<Map<String, Object>> empList(Map<String, Object> condition);
     
	// 전체 페이지 수 계산
	int allCount(Map<String, Object> condition);
	
	// 사원정보 상세보기
	Map<String, Object> empDetail(int emp_idx);
	// 이번달 근태정보
	Map<String, Object> empAttend(int emp_idx);
	// 연차정보
	Map<String, Object> empLeave(int emp_idx);
	// 변경내역
	List<Map<String, Object>> empHistory(int emp_idx);
	// 첨부파일
	List<Map<String, Object>> empAttach(int emp_idx);

	// 사원정보 수정하기
	int empUpdate(Map<String, Object> condition);
	
	// 부서 및 직급 드롭다운 메뉴 가져오기
	List<Map<String, Object>> empDropdown(String table);
	// 사원정보 업데이트사항 History기록
	int historyUpdate(Map<String, Object> condition);
	
	// 삭제할 파일의 newFileName 가져오기
	String newFilename(Map<String, Object> condition);
	
	// 파일삭제
	int fileDel(Map<String, Object> condition);

	// 파일업로드
	int fileUpload(Map<String, Object> condition);
	
	// 기사정보 관리
	int driverUpsert(Map<String, String> params);
	

}
