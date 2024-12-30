package com.best.calendar;

import java.io.File; 
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.DefaultUriBuilderFactory;
import org.springframework.web.util.DefaultUriBuilderFactory.EncodingMode;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import reactor.core.publisher.Mono;

@Service
public class CalendarService {
	@Autowired private CalendarDAO calendarDAO;
	@Value("${upload.path}") private String bpath;
	Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired private RestTemplate restTemplate;

	private final String key = "TCuRmWq%2FaFsNLdJwyz%2BHkWCAMRVUPiYN0ucu6JUybxixygOPOMtXjAyPJPuYzVPPuUBUVtd9mDibVPXIy1xjpg%3D%3D";
	private final String url = "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService";


	
	@Transactional
	public Map<String, Object> saveCalendar(Map<String, Object> params, List<Integer> quantityList, List<Integer> materialIdxList) {
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
		map.put("msg","실패");
		if (row >0) {
			map.put("msg", "회의가 성공적으로 저장되었습니다!");
		}else {
			map.put("msg","이미 예약된 시간대 입니다 회의실 예약 현황 확인후 다시 입력해 주세요.");
			return map;
		}
		Object reserveIdx = params.get("reserveIdx");
		Object empIdx = params.get("emp_idx");
		if (materialIdxList.size() != 0) {
			saveBorrow(reserveIdx,quantityList,materialIdxList,empIdx,startDatetime,endDatetime);
			
		}
		return map;
	}

	private void saveBorrow(Object reserveIdx, List<Integer> quantityList, List<Integer> materialIdxList, Object empIdx, String startDatetime, String endDatetime) {
        for (int i = 0; i < materialIdxList.size(); i++) {
            Map<String, Object> params = new HashMap<>();
            params.put("reserveIdx", reserveIdx);
            params.put("materialIdx", materialIdxList.get(i));
            params.put("quantity", quantityList.get(i));
            params.put("empIdx", empIdx);
            params.put("startDatetime", startDatetime);
            params.put("endDatetime", endDatetime);
            
            int row = calendarDAO.insertBorrow(params);
            int dow = calendarDAO.updateMaterial(params);
            if (row == 0) {
                throw new IllegalArgumentException("재고 부족: materialIdx = " + materialIdxList.get(i));
            }
        }
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
//	    List<Map<String, Object>> completedList = new ArrayList<>();
//
//	    for (Map<String, Object> item : list) {
//	        String status = (String) item.get("status");
//	        if ("이용 완료".equals(status)) { // status 값이 '이용 완료'인지 확인
//	            completedList.add(item);
//	        }
//	    }
//	    logger.info("completedList:{}",completedList);
//	    logger.info("completedList.size:{}",completedList.size());
	    
	    
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
	    
	    Map<String, Object> map = new HashMap<String, Object>();
	    int row = calendarDAO.myReserveUpdate(params);
	    if (row>0) {
	    	map.put("msg", "업데이트 성공");
		}else {
			map.put("msg", "이미 예약된 내역이 있습니다. 가능한 시간대 확인후 다시 해주세요.");
		}
		return map;
	}
	
	public Map<String, Object> cancelReserve(Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
	    int row = calendarDAO.cancelReserve(params);
	    int dow = calendarDAO.cancelMaterial(params);
	    int sow =0;
	    if (dow>0) {
	    	sow = calendarDAO.delBorrow(params);
	    	map.put("msg", "삭제 성공");
		}
		return map;
	}

	public List<Map<String, Object>> getAllMaterials() {
		return calendarDAO.getAllMaterials();
	}


	public List<Map<String, Object>> allRoomList() {
		return calendarDAO.allRoomList();
	}

	// 회의실 저장
    @Transactional
	public Map<String, Object> saveRoomInfo(String roomName, MultipartFile photo, int maxCapacity, List<Integer> materialIdxList, List<Integer> quantityList) {
        String savedFileName = savePhoto(photo);
        Map<String, Object> params = new HashMap<>();
        params.put("name", roomName);
        params.put("photo", savedFileName);
        params.put("maxCapacity", maxCapacity);

        int row =0;
        if (!photo.isEmpty()) {
			params.put("response", "사진이 없습니다.");
			row = calendarDAO.insertRoomInfo(params);
		}
		if (row > 0) {
	        int roomIdx = ((BigInteger) params.get("roomIdx")).intValue();
	        saveRoomMaterials(roomIdx,materialIdxList,quantityList);
			params.put("response", "저장완료");
		}
		
		return params;
	}


	private String savePhoto(MultipartFile photo) {
		String newPhoto = "";
        if (photo != null && !photo.isEmpty()) {
            try {
                String ori = photo.getOriginalFilename();
                int ext = ori.lastIndexOf(".");
                if (ext >0) {
					String extt = ori.substring(ext);
					newPhoto = UUID.randomUUID()+extt;
					Path path = Paths.get(bpath,newPhoto);
					byte[] arr = photo.getBytes();
					Files.write(path, arr);
				}
            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException("파일 저장 실패");
            }
        }
        return newPhoto; // 파일이 없으면 null 반환
	}
	
	private void saveRoomMaterials(int roomIdx, List<Integer> materialIdxList, List<Integer> quantityList) {
        for (int i = 0; i < materialIdxList.size(); i++) {
            Map<String, Object> params = new HashMap<>();
            params.put("roomIdx", roomIdx);
            params.put("materialIdx", materialIdxList.get(i));
            params.put("quantity", quantityList.get(i));

            calendarDAO.insertRoomMaterial(params);
            int updatedRows = calendarDAO.updateMaterial(params);
            if (updatedRows == 0) {
                throw new IllegalArgumentException("재고 부족: materialIdx = " + materialIdxList.get(i));
            }
        }		
	}

    @Transactional
	public Map<String, Object> delRoomInfo(int roomIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ReserveDTO> reserve = calendarDAO.selectReserveData(roomIdx);
		int row = 0;
		int dow = 0;
		int sow = 0;
		if (reserve.isEmpty()) {
			row = calendarDAO.delRoomInfo(roomIdx);
			dow = calendarDAO.updateMaterialBecauseRoomInfo(roomIdx);
			sow = calendarDAO.delRoomMaterial(roomIdx);
			map.put("response", "해당하는 회의실을 삭제 완료 되었습니다.");
				
		}else {
			map.put("response","해당 회의실 에는 예약 일정이 있습니다 예약 일정이 없는 회의실에만 삭제할 수 있습니다." );
		}
		return map;
	}

	public Map<String, Object> getRoomMaterialList(int roomIdx) {
		
		List<Map<String, Object>> materialList = calendarDAO.getRoomMaterialList(roomIdx);
		List<Map<String, Object>> reserveList = calendarDAO.getReserves(roomIdx);
		Map<String, Object> materialAndReserve = new HashMap<String, Object>();
		if (!materialList.isEmpty()) {
			materialAndReserve.put("materialList",materialList);
			materialAndReserve.put("reserveList",reserveList);
		}else {
			materialAndReserve.put("msg", "회의실 정보 불러오기 실패!");
		}
		
		logger.info("테스트1:{}" ,materialList);
		logger.info("테스트2:{}" ,materialAndReserve);
		return materialAndReserve;
	}

	public Map<String, Object> getMaterial() {
		List<Map<String, Object>> list = calendarDAO.getAllMaterials();
		Map<String, Object> map = new HashMap<String, Object>();
		if (!list.isEmpty()) {
			map.put("materials", list);
		}else {
			map.put("msg", "기자재가 없습니다.");
		}
		return map;
	}

	
	public Map<String, Object> findById(int loginId) {
		return calendarDAO.findById(loginId);
	}

	public int saveEvent(Map<String, Object> requestData) {
		
		int row = calendarDAO.saveEvent(requestData);
		if (row >0 ) {
	        return ((BigInteger) requestData.get("eventId")).intValue(); 
		}
		return 0;
	}

	public List<Map<String, Object>> getMyEvents() {
		return calendarDAO.getMyEvents();
	}

	public Map<String, Object> updateMyEvent(Map<String, Object> params) {
		logger.info("params:{}",params);
		int row = calendarDAO.updateMyEvent(params);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("response", row);
		return map;
	}

	public Map<String, Object> delEvent(Map<String, Object> params) {
		logger.info("params:{}삭제 아이디 확인",params);
		int row = calendarDAO.delEvent(params);
		Map<String, Object> map = new HashMap<String, Object>();
		if (row>0) {
			map.put("success", row);
		}
		map.put("msg","삭제 실패");
		return map;
	}

	public void insertHolidays() {
	    int currentYear = LocalDate.now().getYear();

	    for (int month = 1; month <= 12; month++) {
	        try {
	            List<Map<String, Object>> holidays = getHolidaysForMonth(2021, month);

	            holidays.forEach(holiday -> {
	                String date = holiday.get("locdate").toString(); // 타입 안전하게 처리
	                String name = holiday.get("dateName").toString();
	                calendarDAO.saveHoliday(date, name);
	            });
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	}

	private List<Map<String, Object>> getHolidaysForMonth(int year, int month) throws Exception {
	    String response = fetchHolidaysFromAPI(year, month);
	    return parseHolidays(response);
	}

	private String fetchHolidaysFromAPI(int year, int month) {
	    String baseUrl = url;

	    DefaultUriBuilderFactory factory = new DefaultUriBuilderFactory(baseUrl);
	    factory.setEncodingMode(DefaultUriBuilderFactory.EncodingMode.VALUES_ONLY);

	    WebClient webClient = WebClient.builder()
	            .uriBuilderFactory(factory)
	            .build();

	    String response = webClient.get()
	            .uri(uriBuilder -> uriBuilder
	                    .path("/getRestDeInfo")
	                    .queryParam("serviceKey", key) // 실제 API 키
	                    .queryParam("solYear", year)
	                    .queryParam("solMonth", String.format("%02d", month))
	                    .queryParam("_type", "json")
	                    .build())
	            .retrieve()
	            .bodyToMono(String.class)
	            .block();


	    return response;
	}


	private List<Map<String, Object>> parseHolidays(String response) throws Exception {
	    ObjectMapper objectMapper = new ObjectMapper();

	    // JSON 문자열을 Map으로 변환
	    Map<String, Object> responseMap = objectMapper.readValue(response, new TypeReference<Map<String, Object>>() {});

	    // "response" -> "body" -> "items" 탐색
	    Map<String, Object> responseNode = (Map<String, Object>) responseMap.get("response");
	    Map<String, Object> bodyNode = (Map<String, Object>) responseNode.get("body");
	    Object itemsNode = bodyNode.get("items");

	    List<Map<String, Object>> holidays = new ArrayList<>();

	    if (itemsNode == null || (itemsNode instanceof String && ((String) itemsNode).isEmpty())) {
	        // "items"가 null이거나 빈 문자열인 경우 빈 리스트 반환
	        return holidays;
	    }

	    if (itemsNode instanceof Map) {
	        // "items"가 단일 객체인 경우
	        Map<String, Object> itemMap = (Map<String, Object>) itemsNode;
	        Object item = itemMap.get("item");
	        if (item instanceof Map) {
	            holidays.add((Map<String, Object>) item);
	        } else if (item instanceof List) {
	            holidays.addAll((List<Map<String, Object>>) item);
	        }
	    } else if (itemsNode instanceof List) {
	        // "items" 자체가 리스트인 경우
	        holidays.addAll((List<Map<String, Object>>) itemsNode);
	    } else {
	        throw new IllegalArgumentException("Unexpected items type: " + itemsNode.getClass().getName());
	    }


	    return holidays;
	}

	public List<HolidayDTO> getAllHolidays() {
		return calendarDAO.getAllHolidays();
	}

	public List<LocalDate> getHolidayCalculate() {
		return calendarDAO.getHolidayCalculate();
	}



















	
	
	//개인 캘린더 공휴일 api 사용
	

//        public void fetchAndStoreHolidays(String baseUrl, int startYear, int endYear) {
//            for (int year = startYear; year <= endYear; year++) {
//                for (int month = 1; month <= 12; month++) {
//                    String apiUrl = baseUrl + "?year=" + year + "&month=" + String.format("%02d", month);
//                    try {
//                        // API 호출
//                        ResponseEntity<Map> response = restTemplate.getForEntity(apiUrl, Map.class);
//                        List<Map<String, Object>> holidays = (List<Map<String, Object>>) response.getBody().get("holidays");
//
//                        // 데이터 저장
//                        for (Map<String, Object> holiday : holidays) {
//                            LocalDate date = LocalDate.parse((String) holiday.get("date"));
//                            String name = (String) holiday.get("name");
//
//                            // 중복 확인 및 삽입
//                            if (!calendarDAO.existsByDate(date)) {
//                                calendarDAO.insertHoliday(date, name);
//                            }
//                        }
//                    } catch (Exception e) {
//                        System.err.println("Error fetching data for year " + year + ", month " + month);
//                        e.printStackTrace();
//                    }
//                }
//            }
//        }

	

//	https://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/
//	getRestDeInfo?
//	serviceKey=TCuRmWq%2FaFsNLdJwyz%2BHkWCAMRVUPiYN0ucu6JUybxixygOPOMtXjAyPJPuYzVPPuUBUVtd9mDibVPXIy1xjpg%3D%3D
//	&solYear=2018
//	&solMonth=01
// 	http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService
	
	
	
	
	

}



