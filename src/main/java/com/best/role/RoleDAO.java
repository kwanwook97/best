package com.best.role;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RoleDAO {
    
    // 부서별, 직급별 권한목록 가져오기
    List<PageDTO> filterDepartmentRoles(int departmentId);
    List<PageDTO> filterRankRoles(int rankId);
    
    // 페이지 접근권한을 가진 부서, 직급목록 가져오기
    List<Map<String, Object>> getPermissions(String url);
    
    // 접근제어 페이지목록 가져오기
	List<PageDTO> getPageList(String query);
	
	// 검색된 접근제어 페이지목록 가져오기 
	List<PageDTO> searchPages(String searchFilter, String searchKeyword);

	// 권한없는 부서목록가져오기
	List<Map<String, Object>> getUnassignedDepartments(int pageIdx);

	// 권한없는 직급목록가져오기
	List<Map<String, Object>> getUnassignedRanks(int pageIdx);

	// 접근제어페이지 추가
	int insertPage(PageDTO page);
	
	// 접근제어페이지 추가시 중복체크
	int checkDuplicatePage(String url, String page_name);
	
	// 접근제어 페이지 삭제
	int deletePage(int pageIdx);

	// 페이지에 등록된 권한 모두 삭제
	int deletePageRole(int pageIdx);
	
    // 부서또는 직급 권한 삭제
    int deleteRole(int roleIdx);

    // 부서에 권한부여
	int assignDepartmentRole(int pageIdx, int departIdx);
	
	// 직급에 권한부여
	int assignRankRole(int pageIdx, int rankIdx);
	
    // 모든 부서 목록 가져오기
    List<Map<String, Object>> getAllDepartments();

    // 모든 직급 목록 가져오기
    List<Map<String, Object>> getAllRanks();
    
    // 직급 추가
    int addRank(String rankName);

    // 직급 변경
    int updateRank(int rankIdx, String rankName);

    // 직급 삭제
    int deleteRank(int rankIdx);
    
    // 부서 추가
    int addDepartment(String departName);

    // 부서 수정
    int updateDepartment(int departIdx, String departName);

    // 부서 삭제
    int deleteDepartment(int departIdx);
    
    // 모든 직책 목록 가져오기
	List<Map<String, Object>> getAllPositions();
	
	// 직책 변경
    int updateRankPosition(int rankIdx, int positionIdx);
}
