package com.best.alarm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AlarmController {
	@Autowired AlarmService alarmService;

	@RequestMapping(value="alarm.go")
	public String alarmGo() {
		return "alarm/alarm";
	}
	
	@GetMapping(value="/alarmList.ajax")
	@ResponseBody
	public List<AlarmDTO> alarmList(int emp_idx, @RequestParam(required = false) String type, @RequestParam(required = false) Integer flag) {
		return alarmService.alarmList(emp_idx, type, flag);
	}
}
