package com.best.attendance;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.best.attachment.AttachmentService;

@Controller
public class AttendanceController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired AttendanceService attendanceService;
	
	@GetMapping(value="/attendance.go")
	public String attendanceGo(
		    @RequestParam(value = "emp_idx", required = false) Integer empIdx,
		    @RequestParam(value = "name", required = false) String name,
		    @RequestParam(value = "depart_name", required = false) String departName,
		    @RequestParam(value = "rank_name", required = false) String rankName,
		    Model model) {
	    if (empIdx != null) {
	        model.addAttribute("empIdx", empIdx);
	    }
	    if (name != null) {
	        model.addAttribute("name", name);
	    }
	    if (departName != null) {
	    	model.addAttribute("departName", departName);
	    }
	    if (rankName != null) {
	    	model.addAttribute("rankName", rankName);
	    }
	    
	    return "emp/attendance";
	}
	
	@PostMapping(value="/updateStartTime.ajax")
	@ResponseBody
	public Map<String, Object> updateStartTime(@RequestBody Map<String, Object> params) {
		
		return attendanceService.updateStartTime(params);
	}
	
	@GetMapping(value="/updateTime.ajax")
	@ResponseBody
	public Map<String, Object> getWorkTime (@RequestParam Map<String, Object> params){
		return attendanceService.getWorkTime(params);
	}
	
	@PostMapping(value="/checkButton.ajax")
	@ResponseBody
	public Map<String, Object> checkButton (@RequestBody Map<String, Object> params){
		return attendanceService.checkButton(params);
	}
	
	// 퇴근 버튼 로직
	@PostMapping(value="/updateEndTime.ajax")
	@ResponseBody
	public Map<String, Object> updateEndTime (@RequestBody Map<String, Object> params){
		return attendanceService.updateEndTime(params);
	}
	
	@GetMapping(value="/attendanceEmpList.go")
	public String attendanceEmpListGo(){
		return "emp/attendanceEmpList";
	}
	
}
