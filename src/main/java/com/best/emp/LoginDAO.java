package com.best.emp;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {

	// 회원정보 ㅏ져오기
	EmployeeDTO login(String id);

	void updatePassword(Map<String, String> params);
	
	// URL이 테이블에 등록되어 있는경우 URL 접근권한 체크 
    int hasAccessToUrl(String url, int departIdx, int rankIdx);

    // URL이 access 테이블에 등록되어 있는지 체크
	int countUrl(String url);

	// 메뉴URL 권한체크 (메뉴바에서 감추기위함)
	List<String> findAccessibleUrls(int departIdx, int rankIdx);

	// 접근제어가 등록되어있는 모든 URL체크
	List<String> findAllUrls();

	
	// 관리자 로그인
	AdminDTO getAdminById(String id);

	EmployeeDTO findByIdAndEmail(int empIdx, String email);

	int chagePassword(int empIdx, String newPassword);


}
