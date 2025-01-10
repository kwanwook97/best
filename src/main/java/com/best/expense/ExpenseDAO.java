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
	int allCount(String ex_date, int cnt, int form_idx);
	List<Map<String, Object>>  dailyList(String ex_date, int cnt, int offset, int form_idx);

	// 연별 지출 차트
	List<Map<String, Object>> yearlyList(int year);



}
