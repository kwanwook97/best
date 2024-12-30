package com.best.scheduler;

import java.time.LocalDate;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.best.attendance.AttendanceService;
import com.best.calendar.CalendarService;
import com.best.leave.LeaveService;

@EnableScheduling
@Component
public class Scheduler {
	
	Logger logger = LoggerFactory.getLogger(getClass());
    private final CalendarService calendarService;
    private final AttendanceService attendanceService;
    private final LeaveService leaveService;

    public Scheduler(CalendarService calendarService,AttendanceService attendanceService,LeaveService leaveService) {
        this.calendarService = calendarService;
    	this.attendanceService = attendanceService;
    	this.leaveService = leaveService;
    }
	
	@Scheduled(cron = "0 0 0 1 1 *")//매년 1월 1일 00:00:00 에 실행
	public void insertHolidays() {
		calendarService.insertHolidays();
	}
	
	 
	@Scheduled(cron = "0 0 6 ? * MON-FRI")
	public void executeExcludingHolidays() {
	    LocalDate today = LocalDate.now();
	    List<LocalDate> holidays = calendarService.getHolidayCalculate();
	    
	    // 출근 행 늘리기
	    if (!holidays.contains(today)) {
	    	attendanceService.insertAttendance(today);
	    }
	    
	}
	
    //@Scheduled(cron = "*/10 * * * * *")
	// 연차 체크
    @Scheduled(cron = "0 0 0 * * ?")  
    public void leaveCheck() {
    	leaveService.updateLeave();
    }
    //@Scheduled(cron = "*/10 * * * * *")
	@Scheduled(cron = "0 0 13 ? * MON-FRI")
	public void checkAttendance() {
	    LocalDate today = LocalDate.now();
	    List<LocalDate> holidays = calendarService.getHolidayCalculate();
	    if (!holidays.contains(today)) {
	    	attendanceService.updateAbsent(today);
	    }
	}
	
	

}
