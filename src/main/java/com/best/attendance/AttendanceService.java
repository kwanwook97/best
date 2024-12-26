package com.best.attendance;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AttendanceService {
	
	@Autowired AttendanceDAO attendanceDAO;

	// 출근전 근태 테이블 늘리기용
	public void insertAttendance() {
	    LocalDate today = LocalDate.now();
		int row = attendanceDAO.checkHistory(today);
		if (row == 0) {
			attendanceDAO.insertAttendance();
		}
	}

	public Map<String, Object> updateStartTime(Map<String, Object> params) {
		Map<String, Object> response = new HashMap<String, Object>();
		int row = attendanceDAO.updateStartTime(params);
		if (row >0) {
			response.put("msg", "출근 성공");
		}
		response.put("msg", "실패");
		
		return response;
	}

	public Map<String, Object> getWorkTime(Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
	    Map<String, Object> workTime = attendanceDAO.getWorkTime(params);

	    Timestamp startTime_ = (Timestamp) workTime.get("start_time");
	    Timestamp endTime_ = (Timestamp) workTime.get("end_time");
	    String startTime="";
	    String endTime="";


	    ZoneId koreaZone = ZoneId.of("Asia/Seoul");
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	    if (startTime_!= null ) {
	    	ZonedDateTime startTimeKST = startTime_.toInstant().atZone(koreaZone);
	    	startTime = startTimeKST.format(formatter);
			
		}
	    
	    if (endTime_!= null) {
	    	ZonedDateTime endTimeKST = endTime_.toInstant().atZone(koreaZone);
	    	endTime = endTimeKST.format(formatter);
			
		}


	    
	    System.out.println("출근 시간 (KST): " + startTime);
	    System.out.println("퇴근 시간 (KST): " + endTime);
	    
	    map.put("startTime", startTime);
	    map.put("endTime", endTime);
		return map;
	}

}
