package com.best.expense;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ExpenseDAO {

	int addExpense(Map<String, Object> params);

}
