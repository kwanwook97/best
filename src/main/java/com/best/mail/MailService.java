package com.best.mail;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MailService {
	
	@Autowired MailDAO mailDao;
	Logger logger = LoggerFactory.getLogger(getClass());

	
	// 메일목록 불러오기
	public Map<String, Object> mailList(Map<String, String> map) {
		
		int state = Integer.parseInt(map.get("state"));
		int page = Integer.parseInt(map.get("page"));
		int cnt = Integer.parseInt(map.get("cnt"));
		int emp_idx = Integer.parseInt(map.get("emp_idx"));
		
		String searchFilter = map.get("searchFilter");
		String searchKeyword = "";
		
		// 검색 값이 있다면, 검색
		if(!map.get("searchKeyword").equals("")) {
			searchKeyword = map.get("searchKeyword");
		}
		
		logger.info("현재페이지 : "+page);
		logger.info("한페이지에 보여줄 갯수 : "+cnt);		
		int limit = cnt;
		int offset = (page-1) * cnt;
		
		// 검색 조건들을 담을 Map변수
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("state", state);
		condition.put("page", page);
		condition.put("cnt", cnt);
		condition.put("limit", limit);
		condition.put("offset", offset);
		condition.put("searchFilter", searchFilter);
		condition.put("searchKeyword", searchKeyword);
		condition.put("emp_idx", emp_idx);
		
		int totalPages = mailDao.allCount(condition);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("totalPages", totalPages);
		result.put("currPage", page);
		result.put("list", mailDao.mailList(condition));		
		
		return result;
	}

}
