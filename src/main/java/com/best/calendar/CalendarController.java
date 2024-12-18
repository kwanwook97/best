package com.best.calendar;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
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
import org.springframework.web.multipart.MultipartFile;

import com.best.attendance.AttendanceService;

@Controller
public class CalendarController {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired CalendarService calendarService;
	@Autowired AttendanceService attendanceService;
	
	// 회의실 예약 페이지 가기
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
	        @RequestParam("start") String start,
	        @RequestParam("end") String end) {

	    logger.info("캘린더: 시작시간 테스트 " + start);
	    logger.info("캘린더: 종료 테스트 " + end);

	    // UTC 시간 -> KST 변환
	    DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE_TIME;
	    LocalDateTime startDateTime = LocalDateTime.parse(start, formatter).plusHours(9);
	    LocalDateTime endDateTime = LocalDateTime.parse(end, formatter).plusHours(9);

	    logger.info("KST 시작시간: " + startDateTime);
	    logger.info("KST 종료시간: " + endDateTime);

	    LocalDate startDate = startDateTime.toLocalDate();
	    LocalDate endDate = endDateTime.toLocalDate().plusDays(1);
	    logger.info("startDate:테스트 {}:" ,startDate);
	    logger.info("endDate:테스트 {}:" ,endDate);
	   

	    List<Map<String, Object>> events = calendarService.getEvents(startDate, endDate);
	    logger.info("events:테스트 {}:" ,events);
	    return events;
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
	

	@GetMapping(value="/roomList.ajax")
	@ResponseBody
    public List<Map<String, Object>> roomList() {
		
		
        return calendarService.allRoomList();
    }
	
	// 회의실 등록 할때 하는 컨트롤러
	// 기자재 테이블 에서 기자재 가져오는 역할도 있음
	
	@GetMapping(value="/roomInfo.go")
	public String roomInfoGo(Model model) {
		
        List<Map<String, Object>> materialList = calendarService.getAllMaterials(); // 기자재 리스트 가져오기
        model.addAttribute("materialList", materialList);
        
		return "calendar/roomInfo" ;
	}
	
	//회의실 정보 저장
	@PostMapping(value="/saveRoomInfo.ajax")
	@ResponseBody
    public Map<String, Object> saveRoomInfo(
            @RequestParam("roomName") String roomName,
            @RequestParam("photo") MultipartFile photo,
            @RequestParam("maxCapacity") int maxCapacity,
            @RequestParam("materialIdx") List<Integer> materialIdxList,
            @RequestParam("quantity") List<Integer> quantityList) {
		
		logger.info("roomName : " + roomName);
		logger.info("photo : " + photo);
		logger.info("maxCapacity : " + maxCapacity);
		logger.info("materialIdxList : " + materialIdxList);
		logger.info("quantityList : " + quantityList);
		
		Map<String, Object> map = new HashMap<String, Object>();
		if (!roomName.isEmpty()) {
			map= calendarService.saveRoomInfo(roomName,photo,maxCapacity,materialIdxList,quantityList);
		}
		map.put("response", "대화방 이름이 없습니다.");
        return map;
    }
	
	//회의실 정보 저장
	@PostMapping(value = "/delRoomInfo.ajax")
	@ResponseBody
	public Map<String, Object> delRoomInfo(@RequestParam(value = "roomIdx", required = false) Integer roomIdx) {
	    if (roomIdx == null) {
	        throw new IllegalArgumentException("roomIdx 값이 비어 있습니다.");
	    }
	    return calendarService.delRoomInfo(roomIdx);
	}
	
	@PostMapping(value = "/getRoomMaterial.ajax")
	@ResponseBody
	public List<Map<String, Object>> getRoomMaterial(){
		
		return null;
	}
    	
	
}

























