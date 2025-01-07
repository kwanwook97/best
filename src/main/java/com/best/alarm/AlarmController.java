package com.best.alarm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	public Map<String, Object> alarmList(
	    @RequestParam int emp_idx,
	    @RequestParam(required = false) String type,
	    @RequestParam(required = false) Boolean flag,
	    @RequestParam(defaultValue = "1") int page,
	    @RequestParam(defaultValue = "15") int limit
	) {
	    int offset = (page - 1) * limit; // 시작 인덱스 계산
	    List<AlarmDTO> alarms = alarmService.alarmList(emp_idx, type, flag, offset, limit);
	    int totalCount = alarmService.getTotalAlarmCount(emp_idx, type, flag); // 전체 알림 수 가져오기

	    Map<String, Object> response = new HashMap<>();
	    response.put("alarms", alarms);
	    response.put("totalCount", totalCount);
	    response.put("currentPage", page);
	    response.put("pageSize", limit);

	    return response;
	}
	
	@GetMapping(value = "/unreadAlarm.ajax")
	@ResponseBody
	public Map<String, Object> unreadAlarm(@RequestParam int emp_idx) {
	    Map<String, Object> response = new HashMap<>();
	    List<Map<String, Object>> alarms = alarmService.unreadAlarm(emp_idx);
	    response.put("alarms", alarms);
	    return response;
	}

	
	
	
	@PostMapping("/updateAlarmFlag.ajax")
	@ResponseBody
	public String updateAlarmFlag(@RequestParam int alarm_idx, @RequestParam int flag) {
	    try {
	        // 서비스 호출
	        alarmService.updateAlarmFlag(alarm_idx, flag);
	        return "success";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "fail";
	    }
	}
	
	@GetMapping("/unreadAlarmCount.ajax")
	@ResponseBody
	public Map<String, Object> getUnreadAlarmCount(@RequestParam("emp_idx") int empIdx) {
	    int unreadAlarmCount = alarmService.getUnreadAlarmCount(empIdx);
	    Map<String, Object> response = new HashMap<>();
	    response.put("unreadAlarmCount", unreadAlarmCount);
	    return response;
	}

}
