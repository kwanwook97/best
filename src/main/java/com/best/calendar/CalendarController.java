package com.best.calendar;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CalendarController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CalendarService calendarService;
	
	
	@RequestMapping(value="/meetingRoomCalendar.do")
	public String meetingRoomCalendarDo(Model model) {
		//List<String> departName = calendarService.meetingRoomCalendarDo();
		List<RoomDTO> roomList = calendarService.getRoomList();
		model.addAttribute("roomList",roomList);
		return "calendar/meetingRoomCalendar";
	}
	@RequestMapping(value="/calendar.go")
	public String calendarGo() {
		return "calendar/calendar";
	}
	
	
	@PostMapping(value ="/saveCalendar.ajax")
	@ResponseBody
	public Map<String, Object> saveCalendar(@RequestParam Map<String, Object> params){
		 logger.info("params: " + params);
		return calendarService.saveCalendar(params);
	}
	
	@GetMapping(value ="/getCalendarEvents.ajax")
	@ResponseBody
    public List<Map<String, Object>> getCalendarEvents(
            @RequestParam("start") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime start,
            @RequestParam("end") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime end) {
        // 데이터베이스에서 데이터를 가져옵니다.
		 logger.info("캘린더: 시작시간 테스트" + start);
		 logger.info("캘린더: 종료 테스트" + end);
		    LocalDate startDate = start.toLocalDate();
		    LocalDate endDate = end.toLocalDate().plusDays(1);
		 
        List<Map<String, Object>> events = calendarService.getEvents(startDate, endDate);

        return events; // FullCalendar가 처리할 수 있도록 JSON 데이터 반환
    }
	
	@GetMapping("/myReserve.go")
	public String myReserveGo(Model model) {
		return "calendar/myReserve";
	}
	
	@PostMapping(value="/myReserve.ajax")
	@ResponseBody
    public Map<String, Object> myReserveList(int cnt, @RequestParam(value = "page", defaultValue = "1") int page,int loginId) {
        return calendarService.myReserveList(page,cnt,loginId);
    }
	@PostMapping(value="/myReserveUpdate.ajax")
	@ResponseBody
	public Map<String, Object> myReserveUpdate(@RequestParam Map<String, Object> params) {
		logger.info("params: 수정 ",params);
		return calendarService.myReserveUpdate(params);
	}
	@PostMapping(value="/cancelReserve.ajax")
	@ResponseBody
	public Map<String, Object> cancelReserve(@RequestParam Map<String, Object> params) {
		return calendarService.cancelReserve(params);
	}
	
	@GetMapping(value="/roomInfo.go")
	public String roomInfoGo() {
		return "calendar/roomInfo" ;
	}
//	@GetMapping(value="/roomList.ajax")
//	@ResponseBody
//    public Map<String, Object> roomList() {
//        return calendarService.roomList();
//    }
	
}


























