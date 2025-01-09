package com.best.expense;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ExpenseDAO {

	// 지출 내역
	int addExpense(Map<String, Object> params);
	
	// 월별 카테고리 지출
	List<Map<String, Object>> categoryList(int form_idx);

	// 일별 지출
	List<ExpenseDTO> dailyList(int form_idx, String startDate, String endDate);

}
