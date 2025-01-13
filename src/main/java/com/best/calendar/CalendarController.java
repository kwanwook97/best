package com.best.calendar;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.best.attendance.AttendanceService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
		
		// 홀리데이 가져오기
        Map<String, Object> specialDays = new HashMap<>();
        List<HolidayDTO> holidays = calendarService.getAllHolidays(); 

        for (HolidayDTO holiday : holidays) {
            specialDays.put(holiday.getHoliday_date().toString(), holiday.getHoliday_name());
        }
        
        ObjectMapper objectMapper = new ObjectMapper();
        try {
			String specialDaysJson = objectMapper.writeValueAsString(specialDays);
	        model.addAttribute("specialDaysJson", specialDaysJson);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    model.addAttribute("specialDays", specialDays);

		
		return "calendar/meetingRoomCalendar";
	}
	
	@RequestMapping(value="/calendar.go")
	public String calendarGo(Model model) {
		
	    
        List<HolidayDTO> holidays = calendarService.getAllHolidays(); 
        Map<String, Object> specialDays = new HashMap<>();

        for (HolidayDTO holiday : holidays) {
            specialDays.put(holiday.getHoliday_date().toString(), holiday.getHoliday_name());
        }
        
        ObjectMapper objectMapper = new ObjectMapper();
        try {
			String specialDaysJson = objectMapper.writeValueAsString(specialDays);
	        model.addAttribute("specialDaysJson", specialDaysJson);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	    model.addAttribute("specialDays", specialDays);
		
		return "calendar/calendar";
	}
	
	// 회의실 예약
	@PostMapping(value ="/saveCalendar.ajax")
	@ResponseBody
	public Map<String, Object> saveCalendar(
		    @RequestParam(value ="materialIdxList", required = false) List<Integer> materialIdxList,
		    @RequestParam(value = "quantityList", required = false) List<Integer> quantityList,
			@RequestParam Map<String, Object> params){
		 
	    materialIdxList = materialIdxList != null ? materialIdxList : new ArrayList<>();
	    quantityList = quantityList != null ? quantityList : new ArrayList<>();
//		 logger.info("params: " + params);
//		 logger.info("quantityList: " + quantityList);
//		 logger.info("materialIdxList: " + materialIdxList);
		return calendarService.saveCalendar(params,quantityList,materialIdxList);
	}
	
	// 회의실 정보 가져오기
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
		logger.info("params: 수정 {}",params);
		return calendarService.myReserveUpdate(params);
	}
	@PostMapping(value="/cancelReserve.ajax")
	@ResponseBody
	public Map<String, Object> cancelReserve(@RequestParam Map<String, Object> params) {
		logger.info("params: 삭제 {}",params);
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
            @RequestParam(value = "roomName", required = false) String roomName,
            @RequestParam(value = "photo", required = false) MultipartFile photo,
            @RequestParam(value = "maxCapacity", required = false, defaultValue = "0") int maxCapacity,
            @RequestParam(value = "materialIdx", required = false) List<Integer> materialIdxList,
            @RequestParam(value = "quantity", required = false) List<Integer> quantityList) {
		
		logger.info("roomName : " + roomName);
		logger.info("photo : " + photo);
		logger.info("maxCapacity : " + maxCapacity);
		logger.info("materialIdxList : " + materialIdxList);
		logger.info("quantityList : " + quantityList);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if (roomName.equals("") || roomName == null) {
			map.put("response", "회의실 이름을 입력해 주세요");
			return map;
		}
		if (photo == null || photo.isEmpty()) {
			map.put("response", "사진을 등록해 주세요");
			return map;
		}
		if (maxCapacity == 0) {
			map.put("response", "회의실 수용 인원을 입력해 주세요");
			return map;
		}
		if (materialIdxList == null || materialIdxList.isEmpty()) {
			map.put("response", "회의실 기본기자재를 입력해 주세요");
			return map;
		}
		if (quantityList == null || quantityList.isEmpty()) {
			map.put("response", "기자재 수량을 입력해 주세요");
			return map;
		}
		
		
		if (!roomName.isEmpty()) {
			map= calendarService.saveRoomInfo(roomName,photo,maxCapacity,materialIdxList,quantityList);
		}else {
			map.put("response", "회의실 이름이 없습니다.");
		}
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
	public Map<String, Object> getRoomMaterial(int roomIdx){
		return calendarService.getRoomMaterialList(roomIdx);
	}
	
	// 회의실 예약시 기자재 추가 버튼 클릭 정보 가져오기
	@PostMapping(value="/getMaterial.ajax")
	@ResponseBody
	public Map<String, Object> getMaterial(){
		return calendarService.getMaterial();
	}
	
	// 일정 등록
    @PostMapping("/addMyCalendar.ajax")
    @ResponseBody
    public Map<String, Object> addEvent(@RequestBody Map<String, Object> requestData) {
        // 요청 데이터 확인
        
        logger.info("requestData종원 테스트1:{}",requestData);
        // 사원 정보 조회 (사원 ID 기준)
        // 부서 정보 가져와 저장
        int loginId = Integer.parseInt(requestData.get("loginId").toString());
        Map<String, Object> employeeDepartmentIdx = calendarService.findById(loginId);
        if (employeeDepartmentIdx == null) {
            throw new RuntimeException("사원을 찾을 수 없습니다: " + loginId);
        }
        
        
        requestData.put("employeeDepartmentIdx", employeeDepartmentIdx);
        
        logger.info("requestData:{}종원 테스트2",requestData);
       
        // 이벤트 저장
        Object savedEventId = (Object) calendarService.saveEvent(requestData);

        // 응답 반환
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("eventId", savedEventId); // 저장된 이벤트 ID 반환
        return response;
    }
    
    // 일정 뽑기
    @RequestMapping(value="/events.ajax")
    @ResponseBody
    public List<Map<String, Object>> getMyEvents(){
    	
    	
    	
    	return calendarService.getMyEvents();
    }
    
    // 일정 수정
    @PostMapping(value="/updateEvent.ajax")
    @ResponseBody
    public Map<String, Object> updateMyEvent(@RequestBody Map<String, Object> params){
    	return calendarService.updateMyEvent(params);
    }
    
    
    
    @PostMapping(value="/delEvent.ajax")
    @ResponseBody
    public Map<String, Object> delEvent(@RequestBody Map<String, Object> params){
    	return calendarService.delEvent(params);
    }
    
    
	@PostMapping(value="/getDepartmentNmae.ajax")
	@ResponseBody
	public Map<String, Object> getDepartmentNmae(@RequestParam Map<String, Object> params){ 
		return calendarService.getDepartmentNmae(params);
	}
	
	
	
    	
	
}

























