package com.best.attendance;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.best.calendar.CalendarDAO;
import com.best.calendar.HolidayDTO;

@Service
public class AttendanceService {
	
	@Autowired AttendanceDAO attendanceDAO;
	@Autowired CalendarDAO calendarDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	// 출근전 근태 테이블 늘리기용
	public void insertAttendance(LocalDate today) {
		int row = attendanceDAO.checkHistory(today);
		if (row == 0) {
			attendanceDAO.insertAttendance();
		}
	}

	public Map<String, Object> updateStartTime(Map<String, Object> params) {
		Map<String, Object> response = new HashMap<String, Object>();
		int row = attendanceDAO.updateStartTime(params);
		logger.info("종원테스트:{}",row);
		if (row >0) {
			response.put("msg", "성공");
			params.put("state",true);
			attendanceDAO.upEmpStatus(params);
		}else {
			response.put("msg", "실패");
		}
		
		return response;
	}

	public Map<String, Object> getWorkTime(Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
	    Map<String, Object> workTime = attendanceDAO.getWorkTime(params);

	    if (workTime != null) {
		    if (workTime.get("start_time") != null) {
				map.put("startTime", workTime.get("start_time"));
			}else {
				map.put("startTime", "");
			}
		    if (workTime.get("end_time") != null) {
		    	map.put("endTime", workTime.get("end_time"));
		    }else {
		    	map.put("endTime", "");
		    }
		}
//	    logger.info("workTime:{}",workTime);
//	    logger.info("startTime:{}",map.get("startTime"));
//	    logger.info("endTime:{}",map.get("endTime"));
//	    logger.info("endTime:{}",workTime.get("start_time"));
//	    logger.info("endTime:{}",workTime.get("end_time"));
	    
	    
	    
	    List<Map<String, Object>> list = attendanceDAO.getAttendanceList(params);
	    map.put("list", list);

	    LocalDate now = LocalDate.now();
	    int thisMonth = now.getMonthValue();
	    
	    logger.info("now:{}",now);
        logger.info("list:{}",list);
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
        logger.info("filteredList:{}",filteredList);
        
        
        double totalOverTime = filteredList.stream()
                .mapToDouble(item -> {
                    Object overTime = item.get("over_time"); // "over_time" 값 가져오기
                    return overTime != null ? Math.round(Double.parseDouble(overTime.toString()) * 10) / 10.0 : 0.0; 
                })
                .sum();
        
        logger.info("연장 근무시간: {}", totalOverTime);

        double totalWorkTime = filteredList.stream()
                .mapToDouble(item -> {
                    Object calculateTime = item.get("calculate_time");
                    return calculateTime != null ? Math.round(Double.parseDouble(calculateTime.toString()) * 10) / 10.0  : 0.0;
                })
                .sum(); 
        
//        Math.round(Double.parseDouble(totalWorkTime.toString()) * 10) / 10.0
        totalWorkTime = Math.round(totalWorkTime * 10) / 10.0; 
        totalOverTime = Math.round(totalOverTime * 10) / 10.0; 
        //logger.info("총 근무시간: {}", totalWorkTime);
        long lateCount = filteredList.stream()
            .filter(item -> "지각".equals(item.get("status")))
            .count();

        List<Map<String, Object>> filterListOne = list.stream()
        	    .filter(name -> {
        	        Date sqlDate = (Date) name.get("date");
        	        LocalDate date = sqlDate.toLocalDate();
        	        return date.getMonthValue() == LocalDate.now().getMonthValue();
        	    })
        	    .collect(Collectors.toList());
        
        long leaveCount = filterListOne.stream()
        	    .filter(item -> "연차".equals(item.get("status")))
        	    .count();

        long absentCount = filterListOne.stream()
        	    .filter(item -> "결근".equals(item.get("status")))
        	    .count();
        
        Integer remainLeave = attendanceDAO.getLeave(params);
        
//        logger.info("totalWorkTime:{}",totalWorkTime);
//        
//        logger.info("지각 횟수: {}", lateCount);
//        logger.info("연차 횟수: {}", leaveCount);
//        logger.info("결근 횟수: {}", absentCount);
        map.put("workdays", filteredList.size());
        map.put("totalOverTime", totalOverTime);
        map.put("totalWorkTime", totalWorkTime);
        map.put("lateCount", lateCount);
        map.put("leaveCount", leaveCount);
        map.put("absentCount", absentCount);
        map.put("remainLeave", remainLeave);
        
	    
		return map;
	}

	public Map<String, Object> checkButton(Map<String, Object> params) {
		Map<String, Object> map = attendanceDAO.checkButton(params);
			
//		int s = (int) map.get("startTime");
//		int a = (int) map.get("endTime");

//		logger.info("시작:{}",map.get("startTime"));
//		logger.info("끝:{}",map.get("endTime"));
//		logger.info("맵:{}",map);
	    if (map == null || map.isEmpty()) {
	    	map = new HashMap<>(); // 빈 Map을 생성
	    	map.put("msg", "출근 기록이 없습니다.");
	    	map.put("startTime", 0);
	    	map.put("endTime", 0);
	    }
		
		
		return map;
	}

	public Map<String, Object> updateEndTime(Map<String, Object> params) {
		Map<String, Object> response = new HashMap<String, Object>();
		int row = attendanceDAO.updateEndTime(params);
		/* logger.info("종원테스트퇴근:{}",row); */
		if (row >0) {
			response.put("msg", "성공");
			params.put("state", false);
			attendanceDAO.upEmpStatus(params);
		}else {
			response.put("msg", "실패");
		}
		
		
		
		return response;
	}

	public void updateAbsent(LocalDate today) {
		attendanceDAO.updateAbsent(today);
	}

	public Map<String, Object> updateAttendance(List<Map<String, Object>> list) {
		Map<String, Object> response = new HashMap<>();
		int row = 0 ;
		if (list == null) {
		    response.put("msg", "매개변수 빈필드 오류");
		}else {
			for (Map<String, Object> map : list) {
			Map<String, Object> prev = attendanceDAO.selectAttendance(map);
			
			logger.info("prev:{}",prev);
				map.put("prevStartTime", prev.get("prevStartTime"));
				map.put("prevEndTime", prev.get("prevEndTime"));
				//map.put("prevStatus", prev.get("prevStatus"));
				attendanceDAO.updateAttendance(map);
				row += attendanceDAO.insertAttendanceHistory(map);
			}
			
			if (row > 0) {
				response.put("msg", "성공");
			}else {
				response.put("msg", "실패");
			}
			
			
		}
		
		
		return response;
	}

	



}








































