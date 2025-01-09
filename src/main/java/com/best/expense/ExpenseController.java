package com.best.expense;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	@GetMapping(value = "/dailyList.ajax")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> dailyList(@RequestParam String pageName, @RequestParam String startDate, @RequestParam String endDate) {

//	    LocalDate start = LocalDate.parse(startDate);
//	    LocalDate end = LocalDate.parse(endDate);
//
//	    // 현재 월 검증
//	    LocalDate now = LocalDate.now();
//	    if (start.getMonth() != now.getMonth() || end.getMonth() != now.getMonth()) {
//	        // 에러 응답 생성
//	        Map<String, Object> errorResponse = new HashMap<>();
//	        errorResponse.put("error", "이번 달에 포함되지 않은 날짜입니다.");
//	        return ResponseEntity.badRequest().body(errorResponse);
//	    }

	    // 데이터 조회
	    List<ExpenseDTO> dailyExpenses = expenseService.dailyList(pageName, startDate, endDate);

	    // 정상 응답 생성
	    Map<String, Object> response = new HashMap<String, Object>();
	    response.put("dailyExpenses", dailyExpenses);

	    return ResponseEntity.ok(response);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	// 연별 지출 차트
	@RequestMapping(value="/expenseYearly.go")
	public String expenseYearly() {
		return "expense/expenseYearly";
	}
	
	
	
}
