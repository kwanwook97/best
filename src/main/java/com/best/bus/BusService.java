package com.best.bus;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.DefaultUriBuilderFactory;
import org.springframework.web.util.DefaultUriBuilderFactory.EncodingMode;

import reactor.core.publisher.Mono;

@Service
public class BusService {
    @Autowired
    BusDAO busDao;
    Logger log = LoggerFactory.getLogger(getClass());

    private final String key = "KmQX1X%2BNdSuQB70ankwO2m0b2Hj5ZxRqTnwlH7uQH8w";
    private final String detailUrl = "https://api.odsay.com/v1/api/busLaneDetail";
    private final String realtimeUrl = "https://api.odsay.com/v1/api/realtimeRoute";
    private final String loadLaneUrl = "https://api.odsay.com/v1/api/loadLane"; // 보간점 API URL

    /* 노선 상세 정보 API 호출 */
    public Map<String, Object> getBusDetails(Map<String, String> params) {
        params.put("apiKey", key);
        return callApi(detailUrl, params);
    }

    /* 실시간 버스 위치 정보 API 호출 */
    public Map<String, Object> getRealtimeRoute(Map<String, String> params) {
        params.put("apiKey", key);
        return callApi(realtimeUrl, params);
    }

    /* 보간점 정보 API 호출 */
    public Map<String, Object> getLaneData(Map<String, String> params) {
        String busID = params.get("busID");
        if (busID == null || busID.isEmpty()) {
            throw new IllegalArgumentException("busID가 제공되지 않았습니다.");
        }

        Map<String, String> laneParams = new HashMap<>();
        laneParams.put("apiKey", key);
        laneParams.put("mapObject", "0:0@" + busID + ":1:-1:-1");

        return callApi(loadLaneUrl, laneParams);
    }

    // 공통 API 호출 메서드
    private Map<String, Object> callApi(String url, Map<String, String> params) {
        DefaultUriBuilderFactory factory = new DefaultUriBuilderFactory(url);
        factory.setEncodingMode(EncodingMode.VALUES_ONLY);

        WebClient client = WebClient.builder().uriBuilderFactory(factory).baseUrl(url).build();

        String param = buildQueryParams(params);
        Mono<Map> mono = client.get().uri(param).retrieve().bodyToMono(Map.class);
        return mono.flux().toStream().findFirst().orElse(new HashMap<>());
    }

    // 쿼리 파라미터 생성 메서드
    private String buildQueryParams(Map<String, String> params) {
        StringBuilder paramBuilder = new StringBuilder("?");
        for (Map.Entry<String, String> entry : params.entrySet()) {
            paramBuilder.append(entry.getKey()).append("=").append(entry.getValue()).append("&");
        }
        return paramBuilder.substring(0, paramBuilder.length() - 1);
    }

    // 기존 API 호출과 보간점 데이터 병합
    public Map<String, Object> apiCall(Map<String, String> params) {
        // 노선 상세 정보
        Map<String, Object> busDetails = getBusDetails(params);
        // 실시간 버스 위치
        Map<String, Object> realtimeRoute = getRealtimeRoute(params);
        // 보간점 데이터
        Map<String, Object> laneData = getLaneData(params);
        // 데이터 병합
        Map<String, Object> combinedData = new HashMap<>();
        combinedData.put("busDetails", busDetails);
        combinedData.put("realtimeRoute", realtimeRoute);
        combinedData.put("laneData", laneData); // 보간점 데이터 추가

        return combinedData;
    }

    /* 운행현황 기본 정보 */
    public void driveInfo(Model model) {
        List<RouteDTO> info = busDao.driveInfo();
        model.addAttribute("info", info); // 기존 정보 리스트
    }
    
    /* 버스 상세 정보 */
	public List<Map<String, Object>> busDetail(String routeName, String filterType, String keyword) {
		return busDao.busDetail(routeName, filterType, keyword);
	}
	public List<Map<String, Object>> busSum(String routeName) {
		return busDao.busSum(routeName);
	}

	/* 버스 등록 */
	public void busInsert(Map<String, String> param) {
		log.info("ser param:{}",param);
		BusDTO bus = new BusDTO();	
		String buyDateStr = param.get("bus_buy_date");
	    bus.setRoute_name(param.get("bus_route_name"));
	    bus.setLicense_plate(param.get("bus_license_plate"));
	    bus.setFuel_efficiency(Double.parseDouble(param.get("bus_fuel_efficiency")));
	    bus.setBuy_date(parseLocalDate(buyDateStr));
	    bus.setBus_conpany(param.get("bus_bus_company"));
	    bus.setSeat_number(Integer.parseInt(param.get("bus_seat_number")));
	    bus.setBus_type(param.get("bus_bus_type"));
	    busDao.busInsert(bus);
	}
	public void busManage(Map<String, String> param) {
		BusManageDTO busMan = new BusManageDTO();   
		String inspectDateStr = param.get("bus_manage_inspect_date");
		String nextInspectDateStr = param.get("bus_manage_next_inspect_date");
		busMan.setBus_idx(Integer.parseInt(param.get("bus_idx")));
		busMan.setStatus(param.get("bus_manage_status"));
		busMan.setDistance(Double.parseDouble(param.get("bus_manage_distance")));
		busMan.setInspect_date(parseLocalDate(inspectDateStr));
		busMan.setNext_inspect_date(parseLocalDate(nextInspectDateStr));
		busMan.setEmp_idx(Integer.parseInt(param.get("bus_manage_emp_idx")));
		busMan.setContent(param.get("bus_manage_content"));
		busMan.setAmount(Integer.parseInt(param.get("bus_manage_amount")));
		busDao.busManInsert(busMan);
	}
	/* 데이트 타입 형변환 공통 메서드 */
	private LocalDate parseLocalDate(String dateStr) {
	    if (dateStr != null && !dateStr.isEmpty()) {
	        try {
	            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	            return LocalDate.parse(dateStr, formatter);
	        } catch (DateTimeParseException e) {
	            System.out.println("Invalid date format: " + dateStr);
	        }
	    }
	    return null;
	}

	public void busUpdate(int bus_idx, Model model) {
	    BusDTO bus = busDao.busUpdate(bus_idx);
	    List<Map<String, Object>> busManList = busDao.busManUpdate(bus_idx); // 여러 행 처리

	    model.addAttribute("bus", bus);
	    model.addAttribute("busManList", busManList); // List로 전달
	}

	public List<String> busDispatch() {
		return busDao.busDispatch();
	}

	public List<Map<String, Object>> license(String routeName) {
		return busDao.license(routeName);
	}

	public List<Map<String, Object>> driver(String routeName) {
		return busDao.driver(routeName);
	}

	public List<Map<String, Object>> shift() {
		return busDao.shift();
	}
	
	public boolean dispatchInsert(DispatchDTO dispatch, DriveDTO drive) {
        // 중복 확인
		DispatchDTO existingDispatch = busDao.checkDuplicateDispatch(dispatch);
        if (existingDispatch != null) {
            return false; // 중복된 데이터가 있어 삽입하지 않음
        }
        
        int duplicateCount = busDao.checkDriverDispatch(dispatch);

        if (duplicateCount > 0) {
            return false;
        }

        // dispatch 삽입
        busDao.dispatchInsert(dispatch);

        // drive 삽입
        drive.setDispatch_idx(dispatch.getDispatch_idx()); // dispatch의 자동 생성된 PK를 설정
        busDao.driveInsert(drive);
        return true; // 성공적으로 삽입됨
    }
	public boolean driveInsert(DriveDTO drive) {
	    return busDao.driveInsert(drive) > 0;
	}

	public List<Map<String, Object>> dispatchList(String date) {
	    return busDao.dispatchList(date);
	}

	public int dispatchUpdate(Map<String, Object> updateData) {
		return busDao.dispatchUpdate(updateData);
	}

	public Map<String, Object> getDispatchByIdx(int dispatchIdx) {
		return busDao.getDispatchByIdx(dispatchIdx);
	}
	
	public int getDriverIdx(int empIdx) {
	    return busDao.getDriverIdx(empIdx);
	}
	
	public int getDispatchIdx(int driverIdx, String date) {
	    return busDao.getDispatchIdx(driverIdx, date);
	}
	
	public void insertDrive(int dispatchIdx, String startTime, String status) {
		busDao.insertDrive(dispatchIdx, startTime, status);
	}
	
	public Integer updateDriveStatus(int empIdx, String date) {
	    // 1. driver 테이블에서 driver_idx 조회
	    Integer driverIdx = busDao.findDriverIdxByEmpIdx(empIdx);
	    if (driverIdx == null) {
	        return null; // 실패 시 null 반환
	    }

	    // 2. dispatch 테이블에서 driver_idx와 date로 dispatch_idx와 bus_idx 조회
	    Map<String, Object> dispatchData = busDao.findDispatchIdxByDriverIdxAndDate(driverIdx, date);
	    if (dispatchData == null || dispatchData.isEmpty()) {
	        return null; // 실패 시 null 반환
	    }

	    Integer dispatchIdx = (Integer) dispatchData.get("dispatch_idx");
	    Integer busIdx = (Integer) dispatchData.get("bus_idx");

	    // 3. drive 테이블의 status와 start_time 업데이트
	    int updatedDriveRows = busDao.updateDriveStatus(dispatchIdx, new Date(), "운행 중 <i class=\"bi bi-bus-front-fill\"></i>");

	    if (updatedDriveRows > 0 && busIdx != null) {
	        // 4. bus 테이블의 drive_status 업데이트
	        busDao.updateBusDriveStatus(busIdx, "운행 중");
	    }

	    return updatedDriveRows > 0 ? dispatchIdx : null; // 업데이트 성공 시 dispatchIdx 반환
	}
	
	public Integer stopDriveStatus(int empIdx, String date) {
	    // 1. driver 테이블에서 driver_idx 조회
	    Integer driverIdx = busDao.findDriverIdxByEmpIdx(empIdx);
	    if (driverIdx == null) {
	        return null; // 실패 시 null 반환
	    }

	    // 2. dispatch 테이블에서 driver_idx와 date로 dispatch_idx와 bus_idx 조회
	    Map<String, Object> dispatchData = busDao.findDispatchIdxByDriverIdxAndDate(driverIdx, date);
	    if (dispatchData == null || dispatchData.isEmpty()) {
	        return null; // 실패 시 null 반환
	    }

	    Integer dispatchIdx = (Integer) dispatchData.get("dispatch_idx");
	    Integer busIdx = (Integer) dispatchData.get("bus_idx");

	    // 3. drive 테이블의 status와 end_time 업데이트
	    int updatedDriveRows = busDao.updateDriveEndStatus(dispatchIdx, new Date(), "운행 종료");

	    if (updatedDriveRows > 0 && busIdx != null) {
	        // 4. bus 테이블의 drive_status 업데이트
	        busDao.updateBusDriveStatus(busIdx, "운행 종료");
	    }

	    return updatedDriveRows > 0 ? dispatchIdx : null; // 업데이트 성공 시 dispatchIdx 반환
	}


	
	

}

