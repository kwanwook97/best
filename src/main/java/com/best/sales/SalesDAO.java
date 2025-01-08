package com.best.sales;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SalesDAO {

	int saveSettlement(Map<String, Object> params);

	List<Map<String, Object>> filterSettlement(Map<String, Object> params);

	int getTotalPages(Map<String, Object> params);

	List<Map<String, Object>> fetchChart(Map<String, Object> params);

	List<Map<String, Object>> fetchYearChart(Map<String, Object> params);

	List<String> fetchYearCompanyList(Map<String, Object> params);

	List<Map<String, Object>> getChartData(Map<String, Object> params);

	int updateSattlement(Map<String, Object> params);

	int delSattlement(Map<String, Object> params);

}
