package com.best.expense;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ExpenseController {
	
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ExpenseService expenseService;
	
	// 월별 지출 차트
	@RequestMapping(value="/expenseMonthly.go")
	public String expenseMonthly() {
		return "expense/expenseMonthly";
	}
	
	// 월별 카테고리 지출
	@GetMapping(value="/categoryList.ajax")
	@ResponseBody
	public ResponseEntity<List<Map<String, Object>>> categoryList(String pageName) {
		
	    List<Map<String, Object>> categoryTotals = expenseService.categoryList(pageName);

	    return ResponseEntity.ok(categoryTotals);
	    
	}
	
	// 일별 지출
	@GetMapping(value="/dailyList.ajax")
	@ResponseBody
	public Map<String, Object> dailyList(@RequestParam String pageName, @RequestParam String ex_date, @RequestParam String page, @RequestParam String cnt) {
		int page_ = Integer.parseInt(page);
	    int cnt_ = Integer.parseInt(cnt);

	    return expenseService.dailyList(pageName, ex_date, page_, cnt_);
	}

	
	
	
	// 연별 지출 차트
	@RequestMapping(value="/expenseYearly.go")
	public String expenseYearly() {
		return "expense/expenseYearly";
	}
	@GetMapping(value="/yearlyList.ajax")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> yearlyList(@RequestParam("year") int year) {
	
        Map<String, long[]> categorizedData = expenseService.yearlyList(year);

        Map<String, Object> response = new HashMap<>();
        response.put("year", year);
        response.put("data", categorizedData);

        return ResponseEntity.ok(response);
    }

}
