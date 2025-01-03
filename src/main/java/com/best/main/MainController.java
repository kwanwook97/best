package com.best.main;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; 
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.best.emp.EmployeeService;

@Controller
public class MainController {
	@Autowired EmployeeService empService;
	
	@GetMapping(value="/main.go")
	public String main() {
		return "main/main";
	}
	
	@GetMapping(value = "/empDetail.ajax")
	@ResponseBody
	public Map<String, Object> getEmpDetail(@RequestParam("emp_idx") String empIdx) {
	    return empService.empDetail(empIdx);
	}

}
