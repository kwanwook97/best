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
	Map<String, Object> empAttach(int emp_idx);

}
