package com.best.expense;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ExpenseService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired ExpenseDAO expenseDao;
	
	// 지출 내역
	public void addExpense(List<String> one, List<String> two, List<String> three, List<String> four,
			List<String> five, String doc_idx, String form_idx) {
	
        List<List<String>> expenseList = Arrays.asList(one, two, three, four, five);

        // 비어 있지 않은 리스트를 필터링
        List<List<String>> emptyList = new ArrayList<List<String>>();
        
        for (List<String> list : expenseList) {
            // 빈 리스트나 null 값이 포함된 리스트를 제외 (마지막 배열이 null일 경우 허용)
            if (list != null && !list.isEmpty()) {
                boolean isValid = true;
                for (int i = 0; i < list.size(); i++) {
                    String item = list.get(i);
                    // 마지막 요소는 null을 허용, 나머지 요소는 null이나 빈 문자열을 허용하지 않음
                    if (i < list.size() - 1 && (item == null || item.isEmpty())) {
                        isValid = false;
                        break;
                    }
                }
                if (isValid) {
                    emptyList.add(list);
                }
            }
        }
        
        for (List<String> exList : emptyList) {
            if (exList.size() < 4) {
                throw new IllegalArgumentException("Invalid row: " + exList); // 최소 4개 값이 없는 경우 예외
            }
            
            String ex_date = exList.get(0).replaceAll("[\\[\\]\"]", "");
            try {
                LocalDate.parse(ex_date);
            } catch (DateTimeParseException e) {
                throw new IllegalArgumentException("Invalid date format: " + ex_date);
            }
            
            String ex_item = exList.get(1).replaceAll("[\\[\\]\"]", "");
            String description = exList.get(2).replaceAll("[\\[\\]\"]", "");
            String exAmountStr = exList.get(3).replaceAll("[^\\d]", "");
            long ex_amount = Long.parseLong(exAmountStr);
            String remark = exList.size() > 4 ? exList.get(4).replaceAll("[\\[\\]\"]", "") : null;
            
            Map<String, Object> params = new HashMap<String, Object>();
            
            params.put("form_idx", form_idx);
            params.put("doc_idx", doc_idx);
            params.put("ex_date", ex_date);
            params.put("ex_item", ex_item);
            params.put("description", description);
            params.put("ex_amount", ex_amount);
            params.put("remark", remark);

            expenseDao.addExpense(params);
        }
	}

	
	// 월별 카테고리 지출
	public List<Map<String, Object>> categoryList(String ex_date, String pageName) {
		
		int form_idx = 0;
		
		if(pageName.equals("일반")) {
			form_idx = 3;
			return expenseDao.categoryList(form_idx,ex_date);
		}else if(pageName.equals("버스관리")) {
			form_idx = 4;
			return expenseDao.categoryList(form_idx,ex_date);
		}else if(pageName.equals("급여")) {
			form_idx = 5;
			return expenseDao.categoryList(form_idx,ex_date);
		}else {
			return expenseDao.categoryList(form_idx,ex_date);
		}
		
	}


	// 일별 지출
	public Map<String, Object> dailyList(String pageName, String ex_date, int page, int cnt) {
		int offset = (page-1) * cnt;
		int form_idx = 0;
		
		Map<String, Object> result = new HashMap<>();
		
		if(pageName.equals("일반")) {
			
			form_idx = 3;
			int totalPages = expenseDao.allCount(ex_date, cnt, form_idx);		
			
			result.put("totalPages", totalPages);
			result.put("dailyList", expenseDao.dailyList(ex_date, cnt, offset, form_idx));
	        
		}else if(pageName.equals("버스관리")) {
			
			form_idx = 4;
			int totalPages = expenseDao.allCount(ex_date, cnt, form_idx);	
			
			result.put("totalPages", totalPages);
			result.put("dailyList", expenseDao.dailyList(ex_date, cnt, offset, form_idx));
	        
		}else if(pageName.equals("급여")) {
			
			form_idx = 5;
			int totalPages = expenseDao.allCount(ex_date, cnt, form_idx);	
			
			result.put("totalPages", totalPages);
			result.put("dailyList", expenseDao.dailyList(ex_date, cnt, offset, form_idx));
	        
		}
		return result;
	}
	


	// 연별 지출 차트
	public Map<String, long[]> yearlyList(int year) {
		List<Map<String, Object>> groupedData = expenseDao.yearlyList(year);

	    // 결과 초기화 (12개월, 각 카테고리)
	    Map<String, long[]> categorizedData = new HashMap<>();
	    categorizedData.put("basic", new long[12]);
	    categorizedData.put("bus", new long[12]);
	    categorizedData.put("emp", new long[12]);

	    // 데이터를 월별로 분류
	    for (Map<String, Object> row : groupedData) {
	        int month = (int) row.get("month") - 1; // 0-based index
	        int formIdx = (int) row.get("form_idx");
	        long totalAmount = ((Number) row.get("total_amount")).longValue();

	        if (formIdx == 3) {
	            categorizedData.get("basic")[month] += totalAmount;
	        } else if (formIdx == 4) {
	            categorizedData.get("bus")[month] += totalAmount;
	        } else if (formIdx == 5) {
	            categorizedData.get("emp")[month] += totalAmount;
	        }
	    }

	    return categorizedData;
	}


}
