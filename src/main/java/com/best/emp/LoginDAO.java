package com.best.emp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {

	// 회원정보 ㅏ져오기
	EmployeeDTO login(String id);

	void updatePassword(Map<String, String> params);
	
	
	List<String> findAllUrls();
    int hasAccessToUrl(String url, int departIdx, int rankIdx);

    // URL이 access 테이블에 등록되어 있는지 확인
	int countUrl(String url);


}
