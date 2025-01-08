package com.best.expense;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ExpenseController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ExpenseService expenseService;
	
	// 월별 지출 차트
	@RequestMapping(value="/expenseMonthly.go")
	public String expenseMonthly() {
		return "expense/expenseMonthly";
	}
	
	// 연별 지출 차트
	@RequestMapping(value="/expenseYearly.go")
	public String expenseYearly() {
		return "expense/expenseYearly";
	}
	
	
	
}
