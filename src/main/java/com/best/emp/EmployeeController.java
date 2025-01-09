package com.best.emp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class EmployeeController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired EmployeeService empService;
	
	// 사원목록 페이지이동
	@RequestMapping(value="/empList.go")
	public String empListGo() {
		return "empManage/empList";
	}
	
	// 사원목록 가져오기
	@RequestMapping(value="/empList.ajax")
	@ResponseBody
	public Map<String, Object> empList(@RequestParam Map<String, String> map) {
		
		// 사원목록 DTO에 담기.
		return empService.empList(map);
	}
	
	
	
	// 사원상세조회
	@GetMapping(value="/empDetail.go")
	public String empDetail(String emp_idx, Model model) {
		
		model.addAttribute("detail", empService.empDetail(emp_idx));
		model.addAttribute("attendance",empService.empOverTime(emp_idx));
		
		return "empManage/empDetail";
	}
	
	
	// 사원정보 업데이트
	@PostMapping(value = "/empUpdate.ajax")
	@ResponseBody
	public Map<String, Object> empUpdate(@RequestParam Map<String, String> params){
		logger.info("params:{}",params);
		
		int row = empService.empUpdate(params);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 성공했다면
		if(row > 0) {
			map.put("success", "성공");
		}
		
		return map; 
	}
	
	// 파일업로드
	@PostMapping("/fileUpload.do")
	public String fileUpload(MultipartFile[] files, String emp_idx) {
		
		int row = empService.fileUpload(emp_idx, files);
		
	    return "redirect:/empDetail.go?emp_idx=" + emp_idx; 
	}
	
	// 파일삭제
	@PostMapping(value = "/fileDel.ajax")
	@ResponseBody
	public Map<String, Object> fileDel(@RequestParam Map<String, String> params){
		
		int row = empService.fileDel(params);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 성공했다면
		if(row > 0) {
			map.put("success", "성공");
		}
		
		return map; 
	}
	
	// 파일 다운로드
	@GetMapping(value = "/fileDownload.do")
	@ResponseBody
	public ResponseEntity<Resource> fileDownload(String file_name) {
		
		return empService.fileDownload(file_name);
	}
	
	// 부서 및 직급 드롭다운 메뉴 가져오기
	@PostMapping(value = {"/empDrop.ajax", "/orgStruct.ajax"})
	@ResponseBody
	public List<Map<String, Object>> empDropdown(String table){
		
		List<Map<String, Object>> dropdown = empService.empDropdown(table);
		
		return dropdown; 
	}
	
	
	// 사원등록 페이지로 이동
	@RequestMapping(value="/empCreate.go")
	public String empCreate() {
		return "empManage/empCreate";
	}
	
	// 사원등록 
	@RequestMapping(value="/empCreate.do")
	public String empCreate(
	        @RequestParam(value = "photoFile", required = false) MultipartFile photo,
	        @RequestParam(value = "files", required = false) MultipartFile[] files,            
	        EmployeeDTO employeeDTO) {                  
		
		String page = "redirect:/empList.go";
		
		// 사원등록에 성공하면, 사번 받아오기.
		
		 int emp_idx = empService.empCreate(photo, files, employeeDTO);
		 
		 // 사원등록에 성공했다면 
		 if(emp_idx > 0) { 
			 page = "redirect:/empDetail.go?emp_idx=" + emp_idx;
		 }
		
		return page; 
	}
	
	
	// 기사정보 관리
	@PostMapping(value = "/driverUpsert.ajax")
	@ResponseBody
	public Map<String, Object> driverUpsert(@RequestParam Map<String, String> params){
		
		int row = empService.driverUpsert(params);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 성공했다면
		if(row > 0) {
			map.put("success", "성공");
		}
		
		return map; 
	}
	
	
	// 조직도 페이지로 이동
	@RequestMapping(value="/orgChart.go")
	public String orgChart() {
		/* return "emp/orgChart"; */
		return "emp/orgChart";
	}
	
	
	
	// 조직도 정보 가져오기
	@PostMapping(value = "/orgChart.ajax")
	@ResponseBody
	public List<Map<String, Object>> orgList(@RequestParam Map<String, String> parmas){
		
		// 조직도정보 DTO에 담기.
		return empService.orgList(parmas); 
	}
	
	
	//내 정보 관리
	@GetMapping(value="/myDetail.go")
	public String myDetail(String emp_idx, Model model) {
		//logger.info("디테일:{}",empService.empDetail(emp_idx));
		model.addAttribute("detail", empService.empDetail(emp_idx));
		model.addAttribute("attendance",empService.empOverTime(emp_idx));
		return "emp/myDetail";
	}
	
	@PostMapping(value="/updateMyDetail.ajax")
	@ResponseBody
	public Map<String, Object> updateMyDetail(@RequestParam Map<String, Object> params){
		
		logger.info("이종원테스트1:{}",params);

		return empService.updateMyDetail(params);
	}
	
	// 내정보 사인 체크 로직
	@GetMapping(value="checkSign.ajax")
	@ResponseBody
	public Map<String, Object> checkSign(@RequestParam Map<String, Object> params){
		
		return empService.checkSign(params);
	}
	
	// 사인 삭제시 삭제 로직 
	@GetMapping(value="delSign.ajax")
	@ResponseBody
	public Map<String, Object> delSign(@RequestParam Map<String, Object> params){
		
		return empService.delSign(params);
	}
	
	@PostMapping(value="/infoHistoryCheck.ajax")
	@ResponseBody
	public Map<String, Object> infoHistoryCheck(@RequestParam Map<String, Object> params){
		int emp_idx = Integer.parseInt((String)params.get("emp_idx")); 
		
		return empService.infoHistoryCheck(emp_idx);
	}
	
	
	// 프로필사진 수정
	@PostMapping(value = "/profilePhotoUpload.do")
	@ResponseBody
	public Map<String, Object> profilePhotoUpload(
	        @RequestParam("emp_idx") String empIdx,
	        @RequestParam("photoFile") MultipartFile photoFile) {

	    // 서비스 호출
	    int row = empService.updateProfilePhoto(empIdx, photoFile);

	    // 응답 데이터 생성
	    Map<String, Object> response = new HashMap<>();
	    if (row > 0) {
	        response.put("success", "성공");
	    } else {
	        response.put("success", "실패");
	    }

	    return response;
	}
	
	
	
	
}
