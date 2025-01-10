package com.best.leave;

import java.sql.Date;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.best.attendance.AttendanceDAO;
import com.best.calendar.CalendarDAO;

@Service
public class LeaveService {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired LeaveDAO leaveDAO;
	@Autowired AttendanceDAO attendanceDAO;
	@Autowired CalendarDAO calendarDAO;

	//연차 부여 로직
	public void updateLeave() {
		List<Map<String, Object>> list  = leaveDAO.getEmpList();
		LocalDate today = LocalDate.now();
		List<LocalDate> isHolidays = calendarDAO.getHolidayCalculate();
		String text = "";
		
		// 소멸일시 업데이트
		List<Map<String, Object>> annualLeaveList = leaveDAO.getAnnualLeave();
		for (Map<String, Object> map : annualLeaveList) {
			leaveDAO.updateLeaveDel(map);
		}
		
		
		
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
		                if (workDays <= row) {
		                	leaveDAO.updateLeave(empIdx,1);
		                	text = "1년미만 사원 1개월 근로 연차 지급 내역";
		                	leaveDAO.insertAnnualLeave(empIdx,1,text);
						}else {
							leaveDAO.updateLeave(empIdx,0);
		                	text = "1년미만 사원 1개월 근로 연차 지급 내역";
		                	leaveDAO.insertAnnualLeave(empIdx,1,text);
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
		        	text = "1년 만근한 사원 지급 내역";
		        	leaveDAO.insertAnnualLeave(empIdx, 15,text);
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
			                	text = "한달만근 연차 부여";
			                	leaveDAO.insertAnnualLeave(empIdx, 1, text);
							}else {
								leaveDAO.updateLeave(empIdx,0);
			                	text = "한달만근 연차 부여";
			                	leaveDAO.insertAnnualLeave(empIdx, 0, text);
							}
			                
						}
			        }
		        }

		        if (yearsOfService >= 3) {
		            int extraLeave = (yearsOfService - 1) / 2; 
		            leaveDAO.updateLeave(empIdx, extraLeave);
		            text = "근속별 추가부여";
                	leaveDAO.insertAnnualLeave(empIdx,extraLeave, text);
		        }
			}
		}
	}

	private boolean isWorkingDay(LocalDate date, List<LocalDate> isHolidays) {
	    return !(date.getDayOfWeek() == DayOfWeek.SATURDAY || 
	             date.getDayOfWeek() == DayOfWeek.SUNDAY || 
	             isHolidays.contains(date));
	}

	@Transactional
	public Map<String, Object> updateLeaveHistory(List<Map<String, Object>> list) {
		Map<String, Object> response = new HashMap<>();
		int row = 0 ;
		if (list == null) {
		    response.put("msg", "매개변수 빈필드 오류");
		}else {
			for (Map<String, Object> map : list) {
			Map<String, Object> prev = leaveDAO.selectLeaveHistory(map);
			logger.info("prev:{}",prev);
			if (prev != null && !prev.isEmpty()) {
				map.put("prevStartDate", prev.get("prevStartDate"));
				map.put("prevEndDate", prev.get("prevEndDate"));
				
				
			}else {
				return (Map<String, Object>) response.put("msg","변경할 이전 연차가 없습니다?");
			}
				leaveDAO.updateLeaveHistory(map);
				row += leaveDAO.insertLeaveHistoryLog(map);
			}
			if (row > 0) {
				response.put("msg", "성공");
			}else {
				response.put("msg", "실패");
			}
		}
		return response;
	}

	// 연차 로직
	@Transactional
	public void addLeaveHistory(String doc_idx) {
	    // 연차 소진 로직
	    String formSubject = leaveDAO.documentName(doc_idx);
	    if (formSubject.equals("연차신청서")) {
	    	Map<String, Object> result = leaveDAO.getDocContent(doc_idx);
	    	String docContent = (String) result.get("doc_content");
	    	int empIdx = (int) result.get("emp_idx");
	    	
	        Document htmlDoc = Jsoup.parse(docContent);
	        Element startDateElement = htmlDoc.selectFirst("input[name=start_date]");
	        Element endDateElement = htmlDoc.selectFirst("input[name=end_date]");
	        Element textareaElement = htmlDoc.selectFirst("textarea");
	        String textareaValue = textareaElement != null ? textareaElement.text() : null;
	        String startDate = startDateElement != null ? startDateElement.attr("value") : null;
	        String endDate = endDateElement != null ? endDateElement.attr("value") : null;
	        
	        
	        LocalDate start = LocalDate.parse(startDate); // 예: "2025-01-01"
	        LocalDate end = LocalDate.parse(endDate);     // 예:
	        long days = ChronoUnit.DAYS.between(start, end) + 1;
	        
	        Map<String, Object> map = new HashMap<String, Object>();
	        map.put("startDate", startDate);
	        map.put("endDate", endDate);
	        map.put("reason", textareaValue);
	        map.put("empIdx", empIdx);
	        map.put("days", days);
	        
	        logger.info("map테스트:{}",map);
	        
	        leaveDAO.insertLeaveHistory(map);
	        leaveDAO.updateRemainLeave(map);
		}		
	}

}
