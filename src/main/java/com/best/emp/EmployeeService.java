package com.best.emp;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


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
		List<Map<String, Object>> empAttach = empDAO.empAttach(emp_idx);
		if(empAttach != null)
		empDetail.put("fileList", empAttach);
		
		return empDetail;
	}

	// 사원정보 업데이트
	@Transactional
	public int empUpdate(Map<String, String> params) {
		// 성공여부 체크
		int row = 0;
		
		int emp_idx = Integer.parseInt(params.get("emp_idx"));       /* 사번 */
		String col = params.get("col");                              /* 컬럼 */
		String currentVal = params.get("currentVal");                /* 현재 값 */
		String newVal = params.get("newVal");                        /* 변경할 값 */
		String newText = params.get("newText");
		
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("emp_idx", emp_idx);
		condition.put("currentVal", currentVal);
		condition.put("col", col);            
		
		
		// 날짜형 컬럼인경우 Date타입으로 형변환후 condition에 put
		if (col.equals("end_date") || col.equals("license_period")) {
			Date sqlDate = java.sql.Date.valueOf(newVal); 
		    condition.put("newVal", sqlDate);
		    
		    // 퇴사일이 현재날짜보다 큰 경우 enable과 state = false처리.
		    if(col.equals("end_date")) {
		    	LocalDate today = LocalDate.now(); // 현재 날짜 가져오기
		    	LocalDate endDate = sqlDate.toLocalDate(); // java.sql.Date -> LocalDate 변환
		    	if (endDate.isBefore(today)) { // 퇴사일이 현재 날짜를 지난 경우
		    		condition.put("state", false);
		    		condition.put("enable", false);
		    	}else {
		    		condition.put("state", true);
		    		condition.put("enable", true);
		    	}
		    }
		    
		// 부서나 직책정보 업데이트인 경우 int형으로 형변환후 condition에 put
		} else if(col.equals("depart_idx") || col.equals("rank_idx")) {
			int numCol = Integer.parseInt(newVal); 
			condition.put("newVal", numCol);
		}else {
			condition.put("newVal", newVal);
		}
		
		
		// 사원정보 업데이트인 경우
		row = empDAO.empUpdate(condition);
		
		
		// 성공시 History기록
		if(row > 0) {
			// 부서,직급은 newVal값이 idx값이므로 history관리를 위해 newText도 저장.
			if(col.equals("depart_idx") || col.equals("rank_idx")) {
				condition.put("newVal", newText);
			}
			row = empDAO.historyUpdate(condition);
		}
		
		return row;
	}

	// 파일삭제
	@Transactional
	public int fileDel(Map<String, String> params) {
		
		int idx_num = Integer.parseInt(params.get("idx_num"));
		String file_name = params.get("file_name");
		
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("idx_num", idx_num);
		condition.put("file_name", file_name);
		
		// 1. newFileName 가져오기
		String newFileName = empDAO.newFilename(condition);
		
		// 2. DB의 파일정보 삭제
		int row = empDAO.fileDel(condition);
		
		// 3. 파일삭제 성공시 서버에 있는 파일도 삭제
		if(row > 0) {
			File file = new File("C:/upload/" + newFileName);
			if(file.exists()) {
				boolean success = file.delete();
				logger.info("파일삭제 여부 : " + success);
			}
		}
		
		return row;
	}

	
	// 부서 및 직급 드롭다운 메뉴 가져오기
	public List<Map<String, Object>> empDropdown(String table) {
		return empDAO.empDropdown(table);
	}


	public int fileUpload(String emp_idx_, MultipartFile[] files) {

		int row = 0;
		
		int emp_idx = Integer.parseInt(emp_idx_);
		
		for(MultipartFile file : files) {
			try {
				/* 파일이름 변경 */
				// 1. 기존 파일명
				String fileName = file.getOriginalFilename();
				// 2. 확장자 분리
				String ext = fileName.substring(fileName.lastIndexOf("."));
				// 3. 새 파일명 생성(UUID)
				String newFileName = UUID.randomUUID().toString() + ext;
				
				/* 파일저장 */
				// 1. 바이트 추출
				byte[] arr = file.getBytes();
				// 2. 저장경로 지정
				Path path = Paths.get("C:/upload/" + newFileName);
				// 3. 파일쓰기
				Files.write(path, arr);
				
				Map<String, Object> condition = new HashMap<String, Object>();
				condition.put("emp_idx", emp_idx);
				condition.put("fileName", fileName);
				condition.put("newFileName", newFileName);
				
				// 4. 파일저장정보 DB에 INSERT
				row = empDAO.fileUpload(condition);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return row;
	}

	// 파일 다운로드
	public ResponseEntity<Resource> fileDownload(String file_name) {
		// TODO Auto-generated method stub
		return null;
	}

	// 기사정보 관리
	public int driverUpsert(Map<String, String> params) {
		return empDAO.driverUpsert(params);
	}



}



