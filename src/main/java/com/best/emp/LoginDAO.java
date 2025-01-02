package com.best.emp;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.best.role.RoleDTO;

@Mapper
public interface LoginDAO {

	// 회원정보 ㅏ져오기
	EmployeeDTO login(String id);

	void updatePassword(Map<String, String> params);
	
	// 부서 권한 정보를 Map으로 가져오기
    Map<String, Object> departRoleAsMap(String id);

    // 직급 권한 정보를 Map으로 가져오기
    Map<String, Object> rankRoleAsMap(String id);

}
