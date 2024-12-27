package com.best.attendance;

import java.sql.Timestamp;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		logger.info("종원테스트:{}",row);
		if (row >0) {
			response.put("msg", "성공");
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
	    
	    List<HolidayDTO> holidays = calendarDAO.getAllHolidays();
	    ZoneId zoneId = ZoneId.of("Asia/Seoul");
        LocalDate startDate = LocalDate.now().withDayOfMonth(1);
        LocalDate endDate = startDate.withDayOfMonth(startDate.lengthOfMonth());
        int workDays = 0;
        for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
            final LocalDate currentDate = date;

            if (date.getDayOfWeek() == DayOfWeek.SATURDAY || date.getDayOfWeek() == DayOfWeek.SUNDAY) {
                continue;
            }
          

            boolean isHoliday = holidays.stream()
            	    .anyMatch(holiday -> holiday.getHoliday_date().toLocalDate().equals(currentDate));
            if (isHoliday) {
                continue;
            }

            workDays++;
        }
        logger.info("workDays:"+workDays);
        
        logger.info("list:{}",list);
        
        
	    
	    
		return map;
	}

	public Map<String, Object> checkButton(Map<String, Object> params) {
		Map<String, Object> map = attendanceDAO.checkButton(params);
			
//		int s = (int) map.get("startTime");
//		int a = (int) map.get("endTime");
		
		logger.info("시작:{}",map.get("startTime"));
		logger.info("끝:{}",map.get("endTime"));
		logger.info("맵:{}",map);
		
		return map;
	}

	public Map<String, Object> updateEndTime(Map<String, Object> params) {
		Map<String, Object> response = new HashMap<String, Object>();
		int row = attendanceDAO.updateEndTime(params);
		logger.info("종원테스트퇴근:{}",row);
		if (row >0) {
			response.put("msg", "성공");
		}else {
			response.put("msg", "실패");
		}
		
		return response;
	}

}
