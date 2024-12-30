package com.best.leave;

import java.sql.Date;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.best.calendar.CalendarDAO;

@Service
public class LeaveService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired LeaveDAO leaveDAO;
	@Autowired CalendarDAO calendarDAO;

	//연차 부여 로직
	public void updateLeave() {
		List<Map<String, Object>> list  = leaveDAO.getEmpList();
		LocalDate today = LocalDate.now();
		List<LocalDate> isHolidays = calendarDAO.getHolidayCalculate(); 
		
		for (Map<String, Object> emp : list) {
			int yearsOfService = ((Long) emp.get("years_of_service")).intValue();
		    LocalDate startDate = ((Date) emp.get("start_date")).toLocalDate();
		    int empIdx = (int) emp.get("emp_idx");
		    
			if (yearsOfService < 1) {
		        LocalDate currentDate = startDate;
		        List<LocalDate> dates = new ArrayList<>();
		        dates.add(startDate);
		        for (int i = 0; i < 11; i++) {
		            YearMonth nextMonth = YearMonth.from(currentDate).plusMonths(1);
		            if (startDate.getDayOfMonth() > nextMonth.lengthOfMonth()) {
		                currentDate = nextMonth.atEndOfMonth();
		            } else {
		                currentDate = nextMonth.atDay(startDate.getDayOfMonth());
		            }
		            dates.add(currentDate);
		            
		            if (currentDate.equals(today)) {
		            	int todayIndex = dates.indexOf(today);
		            	LocalDate previousDate = dates.get(todayIndex - 1);
		            	
		            	logger.info("previousDate :{}",previousDate);
		                int row = leaveDAO.getAttendanceRecords(empIdx, previousDate, today);
		            	
		                int workDays = 0;
		                //previousDate , today 사이에 업무일수 구해야되는데?
	                    for (LocalDate date = previousDate; !date.isAfter(today); date = date.plusDays(1)) {
	                        if (isWorkingDay(date, isHolidays)) {
	                            workDays++;
	                        }
	                    }
		                if (workDays == row) {
		                	leaveDAO.updateLeave(empIdx,1);
						}else {
							leaveDAO.updateLeave(empIdx,0);
						}
		                
					}
		        }

		        
		        
			} else if (startDate.plusYears(yearsOfService).equals(today)) {
				int totalWorkDays = 0;
				
				LocalDate previousDate = startDate.plusYears(yearsOfService).minusYears(1);
			    for (LocalDate date = previousDate; !date.isAfter(today); date = date.plusDays(1)) {
			        if (isWorkingDay(date, isHolidays)) {
			            totalWorkDays++;
			        }
			    }

		        int row = leaveDAO.getAttendanceRecords(empIdx,previousDate, today);
		        double attendanceCount = (double) row / totalWorkDays;

		        if (attendanceCount >= 0.8) {
		        	leaveDAO.updateLeave(empIdx, 15);
		        }else {
			        LocalDate currentDate = previousDate;
			        List<LocalDate> dates = new ArrayList<>();
			        dates.add(startDate);
			        for (int i = 0; i < 11; i++) {
			            YearMonth nextMonth = YearMonth.from(currentDate).plusMonths(1);
			            if (startDate.getDayOfMonth() > nextMonth.lengthOfMonth()) {
			                currentDate = nextMonth.atEndOfMonth();
			            } else {
			                currentDate = nextMonth.atDay(startDate.getDayOfMonth());
			            }
			            dates.add(currentDate);
			            
			            if (currentDate.equals(today)) {
			            	int todayIndex = dates.indexOf(today);
			            	LocalDate previous = dates.get(todayIndex - 1);
			            	
			            	logger.info("previous 80프로안된사람 :{}",previous);
			                int dow = leaveDAO.getAttendanceRecords(empIdx, previous, today);
			            	
			                int workDays = 0;
			                //previousDate , today 사이에 업무일수 구해야되는데?
		                    for (LocalDate date = previous; !date.isAfter(today); date = date.plusDays(1)) {
		                        if (isWorkingDay(date, isHolidays)) {
		                            workDays++;
		                        }
		                    }
			                if (workDays == dow) {
			                	leaveDAO.updateLeave(empIdx,1);
							}else {
								leaveDAO.updateLeave(empIdx,0);
							}
			                
						}
			        }
		        }

		        if (yearsOfService >= 3) {
		            int extraLeave = (yearsOfService - 1) / 2; 
		            leaveDAO.updateLeave(empIdx, extraLeave); 
		        }
			}
		}
	}

	private boolean isWorkingDay(LocalDate date, List<LocalDate> isHolidays) {
	    return !(date.getDayOfWeek() == DayOfWeek.SATURDAY || 
	             date.getDayOfWeek() == DayOfWeek.SUNDAY || 
	             isHolidays.contains(date));
	}

}
