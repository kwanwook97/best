package com.best.calendar;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CalendarService {
	@Autowired CalendarDAO calendarDAO;
	Logger logger = LoggerFactory.getLogger(getClass());

	public Map<String, Object> saveCalendar(Map<String, Object> params) {
	    String date = (String) params.get("date");
	    String startTime = (String) params.get("startTime");
	    String endTime = (String) params.get("endTime");

	    // 날짜와 시간을 조합
	    String startDatetime = date + " " + startTime;
	    String endDatetime = date + " " + endTime;
	    params.put("startDateTime",startDatetime);
	    params.put("endDateTime",endDatetime);
	    
		int row = calendarDAO.saveCalendar(params);
		Map<String, Object> map = new HashMap<String, Object>();
		if (row >0) {
			map.put("msg", "회의가 성공적으로 저장되었습니다!");
		}
		
		
		
		return map;
	}

	public List<Map<String, Object>> getEvents(LocalDate startDate, LocalDate endDate) {
        // DAO를 통해 데이터베이스에서 이벤트를 가져옵니다.
        return calendarDAO.getEvents(startDate, endDate);
	}

	public List<RoomDTO> getRoomList() {
		return calendarDAO.getRoomList() ;
	}

	public Map<String, Object> myReserveList(int page, int cnt, int loginId) {
		int limit = cnt;
		int offset = (page - 1) * cnt;
		
	    List<Map<String, Object>> list = calendarDAO.myReserveList(limit, offset,loginId);
	    // 총 페이지 수 계산
	    int totalPages = calendarDAO.getTotalPages(limit, loginId);

	    // 결과 반환
	    Map<String, Object> response = new HashMap<>();
	    response.put("totalPages", totalPages);
	    response.put("currentPage", page);
	    response.put("list", list);
		 
		return response;
	}

	public Map<String, Object> myReserveUpdate(Map<String, Object> params) {
	    String date = (String) params.get("date");
	    String startTime = (String) params.get("startTime");
	    String endTime = (String) params.get("endTime");

	    // 날짜와 시간을 조합
	    String startDatetime = date + " " + startTime;
	    String endDatetime = date + " " + endTime;
	    params.put("startDateTime",startDatetime);
	    params.put("endDateTime",endDatetime);
	    
	    int row = calendarDAO.myReserveUpdate(params);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msg", "업데이트 성공");
		return map;
	}

	public Map<String, Object> cancelReserve(Map<String, Object> params) {
	    int row = calendarDAO.cancelReserve(params);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msg", "삭제 성공");
		return map;
	}

//	public Map<String, Object> roomList() {
//	    int row = calendarDAO.cancelReserve();
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("msg", "삭제 성공");
//		return map;
//	}



}
