package com.best.emp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmployeeService {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired EmployeeDAO empDAO;
	
	// 사원목록 가져오기
	public Map<String, Object> empList(Map<String, String> map) {
		
		int state = Integer.parseInt(map.get("state"));
		int page = Integer.parseInt(map.get("page"));
		int cnt = Integer.parseInt(map.get("cnt"));
		
		String searchFilter = map.get("searchFilter");
		String searchKeyword = "";
		
		// 검색 값이 있다면, 검색
		if(!map.get("searchKeyword").equals("")) {
			searchKeyword = map.get("searchKeyword");
		}
		
		logger.info("현재페이지 : "+page);
		logger.info("한페이지에 보여줄 갯수 : "+cnt);		
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		// 검색 조건들을 담을 Map변수
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("state", state);
		condition.put("page", page);
		condition.put("cnt", cnt);
		condition.put("limit", limit);
		condition.put("offset", offset);
		condition.put("searchFilter", searchFilter);
		condition.put("searchKeyword", searchKeyword);
		
		int totalPages = empDAO.allCount(condition);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		result.put("list", empDAO.empList(condition));		
		
		return result;
	}

	
	// 사원 상세보기
	public Map<String, Object> empDetail(String emp_idx_) {
		
		int emp_idx = Integer.parseInt(emp_idx_); 
		
		Map<String, Object> empDetail = new HashMap<String, Object>(); 
		
		
		// 1. 개인정보
		empDetail = empDAO.empDetail(emp_idx);
		// 2. 근무상태
		Map<String, Object> empAttend = empDAO.empAttend(emp_idx);
		if(empAttend != null)
		empDetail.putAll(empAttend);
		// 3. 연차정보
		Map<String, Object> empLeave = empDAO.empLeave(emp_idx);
		if(empLeave != null)
		empDetail.putAll(empLeave);
		// 4. 변경내역
		List<Map<String, Object>> empHistory = empDAO.empHistory(emp_idx);
		if(empHistory != null)
		empDetail.put("list", empHistory);
		// 5. 첨부파일
		Map<String, Object> empAttach = empDAO.empAttach(emp_idx);
		if(empAttach != null)
		empDetail.putAll(empAttach);
		
		return empDetail;
	}

}



