package com.best.sales;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SalesController {

	@Autowired SalesService salesService;
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping(value="monthlyChart.go")
	public String monthlyChartGo() {
		return "sales/monthlyChart";
	}
	@RequestMapping(value="yearlyChart.go")
	public String yearlyChartGo() {
		return "sales/yearlyChart";
	}
	
	@PostMapping(value="/saveSettlement.ajax")
	@ResponseBody
	public Map<String, Object> saveSettlement(@RequestParam Map<String, Object> params){
		
		return salesService.saveSettlement(params);
	}
	
	@PostMapping(value="/filterSettlement.ajax")
	@ResponseBody
	public Map<String, Object> filterSettlement(@RequestParam Map<String, Object> params){
		return salesService.filterSettlement(params);
	}
	@PostMapping(value="/fetchChart.ajax")
	@ResponseBody
	public Map<String, Object> fetchChart(@RequestParam Map<String, Object> params){
		return salesService.fetchChart(params);
	}
	@PostMapping(value="/fetchYearChart.ajax")
	@ResponseBody
	public Map<String, Object> fetchYearChart(@RequestParam Map<String, Object> params){
		return salesService.fetchYearChart(params);
	}
	@PostMapping(value="/getChartData.ajax")
	@ResponseBody
	public Map<String, Object> getChartData(@RequestParam Map<String, Object> params){
		return salesService.getChartData(params);
	}
	@PostMapping(value="/updateSattlement.ajax")
	@ResponseBody
	public Map<String, Object> updateSattlement(@RequestParam Map<String, Object> params){
		return salesService.updateSattlement(params);
	}
	@PostMapping(value="/delSattlement.ajax")
	@ResponseBody
	public Map<String, Object> delSattlement(@RequestParam Map<String, Object> params){
		return salesService.delSattlement(params);
	}
}

























