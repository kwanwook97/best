package com.best.mail;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MailDAO {
	
	// 지정된 사원 목록조회
	List<Map<String, Object>> mailList(Map<String, Object> condition);

	// 전체 페이지 수 계산
	int allCount(Map<String, Object> condition);

	// 사원정보 가져오기(메일, 이름, idx) 
	Map<String, Object> empInfo(Map<String, String> map);
	
	
}
