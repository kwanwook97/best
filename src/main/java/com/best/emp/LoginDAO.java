package com.best.emp;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {

	EmployeeDTO login(String id, String pw);

	void updatePassword(Map<String, String> params);

}
