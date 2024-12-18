package com.best.bus;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	
	@RequestMapping(value="/busDispatch.go")
	public String busDispatch() {
		return "bus/busDispatch";
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
