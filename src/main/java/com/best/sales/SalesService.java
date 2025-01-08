package com.best.sales;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SalesService {
	
	@Autowired SalesDAO salesDAO;
	Logger logger = LoggerFactory.getLogger(getClass());
	public Map<String, Object> saveSettlement(Map<String, Object> params) {
		
		int row = salesDAO.saveSettlement(params);
		
		params = new HashMap<String, Object>();
		if (row >0) {
			params.put("msg", "성공");
		}else {
			params.put("msg", "실패");
		}
		
		
		
		return params;
	}
	
	public Map<String, Object> filterSettlement(Map<String, Object> params) {
		int page = Integer.parseInt((String) params.get("page")) ; 
		int cnt = Integer.parseInt((String)params.get("cnt")); 
		
		params.put("offset", (page - 1) * cnt);
		params.put("limit", cnt);
		List<Map<String, Object>> list = salesDAO.filterSettlement(params);
		Map<String, Object> response = new HashMap<>();
		if (list.size() != 0 && !list.isEmpty()) {
			int  totalPages = salesDAO.getTotalPages(params);
			response.put("msg", "성공");
		    response.put("totalPages", totalPages);
		    response.put("currentPage", params.get("page"));
		    response.put("list", list);
		}else {
			response.put("msg", "실패");
		}
		return response;
	}

	public Map<String, Object> fetchChart(Map<String, Object> params) {
			List<Map<String, Object>> list = salesDAO.fetchChart(params);
			params = new HashMap<String, Object>();
			if (!list.isEmpty() && list.size() != 0) {
				params.put("msg", "성공");
				params.put("list", list);
			}else {
				params.put("msg", "실패");
			}
			
		return params;
	}

	public Map<String, Object> fetchYearChart(Map<String, Object> params) {
		List<Map<String, Object>> list = salesDAO.fetchYearChart(params);
		List<String> companyList = salesDAO.fetchYearCompanyList(params);
		params = new HashMap<String, Object>();
		if (!list.isEmpty() && list.size() != 0) {
			params.put("msg", "성공");
			params.put("list", list);
		}else {
			params.put("msg", "실패");
		}
		if (!companyList.isEmpty() && companyList.size() != 0) {
			params.put("msgList", "성공");
			params.put("companyList", companyList);
		}else {
			params.put("msgList", "실패");
		}
		return params;
	}

	public Map<String, Object> getChartData(Map<String, Object> params) {
		List<Map<String, Object>> list = salesDAO.getChartData(params);
		params = new HashMap<String, Object>();
		if (!list.isEmpty() && list.size() != 0) {
			params.put("msg", "성공");
			params.put("list", list);
		}else {
			params.put("msg", "실패");
		}
		
		return params;
	}

	public Map<String, Object> updateSattlement(Map<String, Object> params) {
		int row = salesDAO.updateSattlement(params);
		params = new HashMap<String, Object>();
		if (row>0) {
			params.put("msg", "성공");
		}else {
			params.put("msg", "실패");
		}
		return params;
	}

	public Map<String, Object> delSattlement(Map<String, Object> params) {
		int row = salesDAO.delSattlement(params);
		params = new HashMap<String, Object>();
		if (row>0) {
			params.put("msg", "성공");
		}else {
			params.put("msg", "실패");
		}
		return params;
	}

}











































