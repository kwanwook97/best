package com.best.leave;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LeaveController {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired LeaveService leaveService;
	
	@PostMapping(value="/updateLeaveHistory.ajax")
	@ResponseBody
	public Map<String, Object> updateLeaveHistory(@RequestBody(required = false) Map<String, Object> params){
		List<Map<String, Object>> list = (List<Map<String, Object>>) params.get("updatedList");
		logger.info("params:{}",params);
		logger.info("list:{}",list);
		return leaveService.updateLeaveHistory(list);
	}
}
