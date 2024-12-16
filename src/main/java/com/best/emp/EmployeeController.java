package com.best.emp;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class EmployeeController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired EmployeeService empService;
	
	// 사원목록 페이지이동
	// 페이지 접속권한 : 인사부서
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
		
		
		return "empManage/empDetail";
	}
	
	
	// 사원등록
	@RequestMapping(value="/empCreate.go")
	public String empCreate() {
		return "empManage/empCreate";
	}
	
}
