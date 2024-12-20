package com.best.bus;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BusController {
	@Autowired BusService busService;
	Logger log = LoggerFactory.getLogger(getClass());
	/*
	 *  버스정보
	 *  장희재
	 */
	
	/* 버스 운행현황 */
	@RequestMapping(value="/driveInfo.go")
	public ModelAndView driveInfo(Model model) {
		busService.driveInfo(model);
		return new ModelAndView("bus/driveInfo");
	}
	/* 버스 운행현황 api 불러오기 */
	@GetMapping(value="/bus.ajax") 
	@ResponseBody
	public Map<String, Object> apiCall(@RequestParam Map<String, String>params){
		return busService.apiCall(params); 
	}
	
	
	/* 버스 상세 정보 */
	
	@RequestMapping(value = "/busDetail.go")
    public String busDetailGo() {
        return "bus/busDetail"; // busDetail.jsp로 이동
    }
	
	@GetMapping(value = "/busDetail.ajax")
	@ResponseBody
	public Map<String, Object> busDetail(
	        @RequestParam(value = "route_name", required = false, defaultValue = "") String routeName,
	        @RequestParam(value = "filterType", required = false, defaultValue = "") String filterType,
	        @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {

	    Map<String, Object> result = new HashMap<>();

	    // route_name, filterType, keyword 값 확인
	    System.out.println("route_name: " + routeName);
	    System.out.println("filterType: " + filterType);
	    System.out.println("keyword: " + keyword);

	    List<Map<String, Object>> busData = busService.busDetail(routeName, filterType, keyword);
	    List<Map<String, Object>> busSum = busService.busSum(routeName);

	    result.put("busData", busData);
	    result.put("busSum", busSum);

	    return result;
	}
	
	/* 버스 등록*/
	@RequestMapping(value="/busInsert.go")
	public ModelAndView busInsert() {
		ModelAndView mav = new ModelAndView("bus/busInsert");
		return mav;
	}
	@RequestMapping(value="/busInsert.do")
	public String busInsert(@RequestParam Map<String, String> param) {
		busService.busInsert(param); 
		log.info("contrl param:{}",param);
	    return "redirect:/busDetail";
	}
	

	@RequestMapping(value="/busUpdate.go")
	public String busUpdate(@RequestParam("bus_idx") String busIdx, Model model) {
		int bus_idx = Integer.parseInt(busIdx);
		busService.busUpdate(bus_idx, model);
		return "bus/busUpdate";
	}
	
	@RequestMapping(value="/busUpdate.do")
	public String busUpdate(@RequestParam Map<String, String> param) {
		busService.busUpdateDo(param); 
		log.info("contrl param:{}",param);
	    return "redirect:/busUpdate.go?bus_idx="+Integer.parseInt(param.get("bus_idx"));
	}
	
	
	@RequestMapping(value="/dispatchList.go")
	public String dispatchList() {
		return "bus/dispatchList";
	}
	
	@RequestMapping(value="/busDispatch.go")
	public String busDispatchGo() {
		return "bus/busDispatch";
	}
	
	@GetMapping(value="/busDispatch.ajax")
    @ResponseBody
    public List<String> busDispatch() {
        return busService.busDispatch();
    }
	
	@GetMapping("/shift.ajax")
	@ResponseBody
	public List<Map<String, Object>> shift() {
	    return busService.shift();
	}
	
	@GetMapping("/license.ajax")
	@ResponseBody
	public List<Map<String, Object>> license(@RequestParam("route_name") String routeName) {
	    return busService.license(routeName);
	}
	
	@GetMapping("/driver.ajax")
	@ResponseBody
	public List<Map<String, Object>> driver(@RequestParam("route_name") String routeName) {
	    return busService.driver(routeName);
	}
	
	
	@GetMapping("/dispatchList.ajax")
	@ResponseBody
	public Map<String, Object> dispatchList(@RequestParam(required = false) String date) {
		Map<String, Object> result = new HashMap<>();
	    try {
	        // 날짜를 기준으로 필터링 (date가 null이면 전체 데이터를 가져옴)
	        List<Map<String, Object>> dispatchList = busService.dispatchList(date);

	        // route_name 목록 추출
	        Set<String> routeNames = dispatchList.stream()
	            .map(data -> (String) data.get("route_name")) // route_name 필드 추출
	            .collect(Collectors.toSet()); // 중복 제거

	        result.put("success", true);
	        result.put("result", dispatchList);
	        result.put("routes", new ArrayList<>(routeNames)); // routes 키에 route_name 목록 추가
	    } catch (Exception e) {
	        result.put("success", false);
	        e.printStackTrace();
	    }
	    log.info("result{}",result);
	    return result;
	}
	
	@PostMapping("/dispatchInsert.ajax")
	@ResponseBody
	public Map<String, Object> dispatchInsert(@RequestBody DispatchDTO dispatch) {
	    Map<String, Object> result = new HashMap<>();

	    try {
	        // DriveDTO 생성 및 초기화
	        DriveDTO drive = new DriveDTO();
	        drive.setStart_time(new Date()); // 현재 시간 설정
	        drive.setStatus("운행 대기");

	        boolean isInserted = busService.dispatchInsert(dispatch, drive);

	        if (isInserted) {
	            result.put("success", true);
	        } else {
	            result.put("success", false);
	            result.put("message", "중복된 데이터가 존재합니다.");
	        }
	    } catch (Exception e) {
	        result.put("success", false);
	        result.put("message", "서버 오류가 발생했습니다.");
	        e.printStackTrace();
	    }

	    return result;
	}
	
	@PostMapping(value = "/dispatchUpdate.ajax")
    @ResponseBody
    public Map<String, Object> dispatchUpdate(@RequestBody Map<String, Object> updateData) {
        int result = busService.dispatchUpdate(updateData); // DAO 호출
        Map<String, Object> response = new HashMap<>();
        response.put("success", result > 0);
        return response;
    }
	
	@GetMapping(value = "/getDispatchByIdx.ajax")
	@ResponseBody
	public Map<String, Object> getDispatchByIdx(@RequestParam("dispatch_idx") int dispatchIdx) {
	    Map<String, Object> dispatchData = busService.getDispatchByIdx(dispatchIdx);
	    Map<String, Object> response = new HashMap<>();
	    response.put("success", dispatchData != null);
	    response.put("data", dispatchData);
	    return response;
	}
	
	@GetMapping("/getDriverIdx.ajax")
	@ResponseBody
	public Map<String, Object> getDriverIdx(@RequestParam("emp_idx") int empIdx) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        int driverIdx = busService.getDriverIdx(empIdx);
	        response.put("success", true);
	        response.put("driver_idx", driverIdx);
	    } catch (Exception e) {
	        response.put("success", false);
	    }
	    return response;
	}
	
	@GetMapping("/getDispatchIdx.ajax")
	@ResponseBody
	public Map<String, Object> getDispatchIdx(@RequestParam("driver_idx") int driverIdx,
	                                          @RequestParam("date") String date) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        int dispatchIdx = busService.getDispatchIdx(driverIdx, date);
	        response.put("success", true);
	        response.put("dispatch_idx", dispatchIdx);
	    } catch (Exception e) {
	        response.put("success", false);
	    }
	    return response;
	}
	
	@PostMapping("/insertDrive.ajax")
	@ResponseBody
	public Map<String, Object> insertDrive(@RequestParam("dispatch_idx") int dispatchIdx,
	                                       @RequestParam("start_time") String startTime,
	                                       @RequestParam("status") String status) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	    	busService.insertDrive(dispatchIdx, startTime, status);
	        response.put("success", true);
	    } catch (Exception e) {
	        response.put("success", false);
	    }
	    return response;
	}

	@PostMapping("/updateDriveStatus.ajax")
	@ResponseBody
	public Map<String, Object> updateDriveStatus(@RequestBody Map<String, Object> requestData) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        Integer empIdx = (Integer) requestData.get("emp_idx");
	        String date = (String) requestData.get("date");

	        Integer updatedDispatchIdx = busService.updateDriveStatus(empIdx, date); // dispatch_idx 반환
	        if (updatedDispatchIdx != null) {
	            response.put("success", true);
	            response.put("dispatchIdx", updatedDispatchIdx); // dispatch_idx 추가
	        } else {
	            response.put("success", false);
	            response.put("message", "업데이트할 데이터가 없습니다.");
	        }
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "서버 오류가 발생했습니다.");
	        e.printStackTrace();
	    }
	    return response;
	}
	
	@PostMapping("/stopDriveStatus.ajax")
	@ResponseBody
	public Map<String, Object> stopDriveStatus(@RequestBody Map<String, Object> requestData) {
	    Map<String, Object> response = new HashMap<>();
	    try {
	        Integer empIdx = (Integer) requestData.get("emp_idx");
	        String date = (String) requestData.get("date");

	        Integer updatedDispatchIdx = busService.stopDriveStatus(empIdx, date); // stopDriveStatus 호출
	        if (updatedDispatchIdx != null) {
	            response.put("success", true);
	            response.put("dispatchIdx", updatedDispatchIdx); // dispatch_idx 반환
	        } else {
	            response.put("success", false);
	            response.put("message", "업데이트할 데이터가 없습니다.");
	        }
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "서버 오류가 발생했습니다.");
	        e.printStackTrace();
	    }
	    return response;
	}

	
	
	
	@RequestMapping(value="/busManage.go")
	public String busManage() {
		return "bus/busManage";
	}
	
	@RequestMapping(value="/dispatchInsert.go")
	public String dispatchInsert() {
		return "bus/dispatchInsert";
	}

}
