package com.best.emp;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.best.attendance.AttendanceDAO;


@Service
public class EmployeeService {
	
	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired EmployeeDAO empDAO;
	@Autowired AttendanceDAO attendanceDAO;
	

	private final PasswordEncoder passwordEncoder;

    @Autowired
    public EmployeeService(EmployeeDAO empDAO, PasswordEncoder passwordEncoder) {
        this.empDAO = empDAO;
        this.passwordEncoder = passwordEncoder;
    }

	
	
	
	// 사원목록 가져오기
	public Map<String, Object> empList(Map<String, String> map) {
		
		int enable = Integer.parseInt(map.get("enable"));
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
		condition.put("enable", enable);
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
		
		// 사원정보를 변경하기 위한 조건
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("emp_idx", emp_idx);
		condition.put("currentVal", currentVal);
		condition.put("col", col);            
		
		// 상급자정보를 변경하기 위한 조건
		Map<String, Object> parentCondition = new HashMap<String, Object>();
		parentCondition.put("emp_idx", emp_idx);
		
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
		    
		// 부서나 직급정보 업데이트인 경우 int형으로 형변환후 condition에 put
		} else if(col.equals("depart_idx") || col.equals("rank_idx")) {
			int parentFind = Integer.parseInt(params.get("parentFind"));
			int depart_idx = 0;
			int rank_idx = 0;
			
			int numCol = Integer.parseInt(newVal); 
			condition.put("newVal", numCol);
			
			if(col.equals("depart_idx")) {         // 부서변경인 경우
				depart_idx = numCol;
				rank_idx = parentFind;
			}else if(col.equals("rank_idx")) {     // 직급변경인 경우
				depart_idx = parentFind;
				rank_idx = numCol;
			}
			
			
			/* 상급자 정보수정 */
			if (3 < rank_idx) {                         // 팀원이라면, 상급자 => 같은 부서의 팀장
				// 같은부서 팀장의 정보를 가져와서 put
				parentCondition.put("rank_idx", 3);	
				parentCondition.put("depart_idx", depart_idx);	
			} else if (rank_idx == 3) {                 // 팀장이라면, 상급자 => 같은부서 상무
			    // 같은부서 상무의 정보를 가져와서 put
				parentCondition.put("rank_idx", 2);	
				parentCondition.put("depart_idx", depart_idx);
			} else if (rank_idx < 3) {                   // 상무, 대표라면, 상급자 => 대표
			    // 대표의 정보를 가져와서 put
				parentCondition.put("rank_idx", 1);	
			}                     
			
			
			// 미발령이라면, 상급자 => 대표
			if(depart_idx == 1) {
				// 대표의 정보를 가져와서 put
				parentCondition.put("rank_idx", 1);
				parentCondition.remove("depart_idx");
			}
			
			
			// 같은부서에 상급자가 있는지 체크
			Integer parent_idx = empDAO.parentCheck(condition);
			// 같은부서에 상급자가 없다면, 상급자 => 대표
			if(parent_idx != null) {
				parentCondition.put("rank_idx", 1);
				parentCondition.remove("depart_idx");
			}
			
			
				
			condition.put("newVal", numCol);
		}else {
			condition.put("newVal", newVal);
		}
		
		
		// 사원정보 업데이트
		row = empDAO.empUpdate(condition);
		
		// 성공시 상급자정보 업데이트
		if(row > 0) {
			row = empDAO.parentUpdate(parentCondition);
		}
		
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
			if(file == null || file.isEmpty()) {
		        logger.info("업로드할 파일이 없습니다.");
		        continue; // 반복문 건너뛰기
		    }
			
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
	public ResponseEntity<Resource> fileDownload(String fileName) {
		
		// 새 파일명 가져오기
		String new_filename = empDAO.getNewFileName(fileName);
		
		//body
		Resource res = new FileSystemResource("C:/upload/"+new_filename);
		
		//header
		HttpHeaders header = new HttpHeaders();		
		header.add("content-type", "application/octet-stream");
		try {
			String filename = URLEncoder.encode(fileName, "UTF-8");
			header.add("content-Disposition", "attechment;filename=\""+filename+"\"");
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		//body, header, status
		return new ResponseEntity<Resource>(res, header, HttpStatus.OK);
	}


	// 기사정보 관리
	public int driverUpsert(Map<String, String> params) {
		return empDAO.driverUpsert(params);
	}

	// 사원등록
	@Transactional
	public int empCreate(MultipartFile photo, MultipartFile[] files, EmployeeDTO empDTO) {
		// 성공여부 체크
		int row = 0;
		
		
		
		
		
		
		
	// 비밀번호 암호화
	    if (empDTO.getPassword() != null && !empDTO.getPassword().isEmpty()) {
	        String encryptedPassword = passwordEncoder.encode(empDTO.getPassword()); // 비밀번호 암호화
	        empDTO.setPassword(encryptedPassword);
	    } else {
	        logger.info("유효한 비밀번호가 없습니다.");
	        throw new IllegalArgumentException("비밀번호는 필수 입력 항목입니다.");
	    }
		
		
		
		
		
		
		
		
		// 프로필사진 파일명 가져오기
		String photoName = photo.getOriginalFilename();
		if (photoName == null || photoName.isEmpty()) {
			logger.info("유효하지 않은 파일 이름입니다.");
	    }
		empDTO.setPhoto(photoName);
		
		row = empDAO.empCreate(empDTO);
		int idx = empDTO.getEmp_idx();
		
		// 1. 사원등록
		if(row > 0) {
			// emp_idx값 가져오기
			String emp_idx = Integer.toString(idx);
			
			// 2. 프로필사진 저장.
			if(photo != null && !photo.isEmpty() && photo.getSize() > 0) {
			    try {
			        /* 파일저장 */
			        byte[] arr = photo.getBytes();
			        Path path = Paths.get("C:/upload/" + photoName);
			        Files.write(path, arr);
			    } catch (IOException e) {
			        e.printStackTrace();
			    }
			} else {
			    logger.info("유효한 프로필 사진이 없습니다.");
			}
			
			// 3. 첨부파일 저장.
			fileUpload(emp_idx, files);
			
		}
		
		// 모든 처리가 성공했으면 emp_idx값 반환
		return row > 0 ? idx : 0;
		
	}

	// 조직도정보 가져오기
	public List<Map<String, Object>> orgList(Map<String, String> parmas) {
		
		List<Map<String, Object>> orgList = empDAO.orgList(parmas);
		
		return orgList;
	}


	// 이번달 연장근로 시간
	public Map<String, Object> empOverTime(String emp_idx) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("loginId", emp_idx);
	    List<Map<String, Object>> list = attendanceDAO.getAttendanceList(params);

        List<Map<String, Object>> filteredList = list.stream()
        	    .filter(name -> {
        	        Date sqlDate = (Date) name.get("date");
        	        LocalDate date = sqlDate.toLocalDate();
        	        return date.getMonthValue() == LocalDate.now().getMonthValue(); 
        	    })
                .filter(name -> {
                    String status = (String) name.get("status"); 
                    return !("결근".equals(status) || "연차".equals(status));
                })
        	    .collect(Collectors.toList());
		
        double totalOverTime = filteredList.stream()
                .mapToDouble(item -> {
                    Object overTime = item.get("over_time"); // "over_time" 값 가져오기
                    return overTime != null ? Math.round(Double.parseDouble(overTime.toString()) * 10) / 10.0 : 0.0; 
                })
                .sum();
        
        totalOverTime = Math.round(totalOverTime * 10) / 10.0; 
        
        params.put("totalOverTime", totalOverTime);
        params.put("workDays", filteredList.size());
		
		return params;
	}


	public Map<String, Object> updateMyDetail(Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		int row = empDAO.updateMyDetail(params);
		// 성공했다면
		if(row > 0) {
			map.put("success", "성공");
		}
		
		return map;
	}




	public Map<String, Object> checkSign(Map<String, Object> params) {
		
		Map<String, Object> sign = empDAO.checkSign(params);

	    if (sign != null && !sign.isEmpty()) {
	        sign.put("msg", "성공");
	    } else {
	        sign = new HashMap<>();
	        sign.put("msg", "실패");
	    }

	    return sign;
	}




	public Map<String, Object> delSign(Map<String, Object> params) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		int row = empDAO.delSign(params);
		if (row>0) {
			map.put("msg", "성공");
		}else {
			map = new HashMap<>();
			map.put("msg", "실패");
		}
		return map;
	}



	// 프로필 사진 업데이트
	@Transactional
	public int updateProfilePhoto(String empIdx, MultipartFile photoFile) {
	    int row = 0;

	    // 기존 파일명 가져오기
	    String oldFileName = empDAO.getPhotoFileName(empIdx);

	    try {
	        // 새 파일 저장
	        String newFileName = UUID.randomUUID().toString() + photoFile.getOriginalFilename();
	        Path newFilePath = Paths.get("C:/upload/" + newFileName);
	        Files.write(newFilePath, photoFile.getBytes());

	        // DB 업데이트
	        row = empDAO.updatePhotoFile(empIdx, newFileName);

	        // 기존 파일 삭제
	        if (oldFileName != null && !oldFileName.isEmpty()) {
	            File oldFile = new File("C:/upload/" + oldFileName);
	            if (oldFile.exists()) {
	                oldFile.delete();
	            }
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    return row;
	}

}



