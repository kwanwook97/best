package com.best.role;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class RoleService {

    @Autowired
    private RoleDAO roleDao;
    
   
    // 부서별 권한목록 가져오기
    public List<PageDTO> filterDepartmentRoles(int departmentId) {
        return roleDao.filterDepartmentRoles(departmentId);
    }

    // 직급별 권한목록 가져오기
    public List<PageDTO> filterRankRoles(int rankId) {
        return roleDao.filterRankRoles(rankId);
    }

    
    // 접근제어 페이지에 대한 권한을 가진 부서목록, 직급목록 가져오기.
    public List<Map<String, Object>> getPermissions(String url) {
        return roleDao.getPermissions(url);
    }

    // 접근제어 페이지 목록 가져오기
    public List<PageDTO> getPageList(String query) {
        return roleDao.getPageList(query);
    }
    
    // 접근제어 페이지 목록 검색리스트 가져오기
    public List<PageDTO> searchPages(String searchFilter, String searchKeyword) {
        return roleDao.searchPages(searchFilter, searchKeyword);
    }

    // 접근제어페이지 추가
    public int insertPage(PageDTO page) {
    	return roleDao.insertPage(page);
    }

    // 접근제어 페이지 삭제
    @Transactional
 	public int deletePage(int pageIdx) {
    	int row = 0;
    	// 페이지삭제
    	row = roleDao.deletePage(pageIdx);
    	
    	// 페이지에 등록된 권한목록 삭제 
    	if(row > 0) {
    		roleDao.deletePageRole(pageIdx);
    	}
    	
 		return row;
 	}
    
	// 접근제어페이지 추가시 중복체크
    public boolean isPageDuplicate(String url, String page_name) {
        return roleDao.checkDuplicatePage(url, page_name) > 0;
    }

    

    // 권한없는 부서목록가져오기
	public List<Map<String, Object>> getUnassignedDepartments(int pageIdx) {
		return roleDao.getUnassignedDepartments(pageIdx);
	}

	// 권한없는 직급목록가져오기
	public List<Map<String, Object>> getUnassignedRanks(int pageIdx) {
		return roleDao.getUnassignedRanks(pageIdx);
	}

    // 부서 또는 직급 권한 삭제
    public int deleteRole(int roleIdx) {
        return roleDao.deleteRole(roleIdx);
    }

    
    // 부서에 권한부여
    public int assignDepartmentRole(int pageIdx, int departIdx) {
        return roleDao.assignDepartmentRole(pageIdx, departIdx);
    }

    // 직급에 권한부여
    public int assignRankRole(int pageIdx, int rankIdx) {
        return roleDao.assignRankRole(pageIdx, rankIdx);
    }

	
    // 모든 부서 목록 가져오기
    public List<Map<String, Object>> getAllDepartments() {
        return roleDao.getAllDepartments();
    }

    // 모든 직급 목록 가져오기
    public List<Map<String, Object>> getAllRanks() {
        return roleDao.getAllRanks();
    }

    // 직급 추가
    public int addRank(String rankName) {
        return roleDao.addRank(rankName);
    }

    // 직급 변경
    public int updateRank(int rankIdx, String rankName) {
        return roleDao.updateRank(rankIdx, rankName);
    }

    // 직급 삭제
    public int deleteRank(int rankIdx) {
        return roleDao.deleteRank(rankIdx);
    }

    // 부서 추가
    public int addDepartment(String departName) {
        return roleDao.addDepartment(departName);
    }

    // 부서 수정
    public int updateDepartment(int departIdx, String departName) {
        return roleDao.updateDepartment(departIdx, departName);
    }

    // 부서 삭제
    public int deleteDepartment(int departIdx) {
        return roleDao.deleteDepartment(departIdx);
    }

    // 모든 직급체계 목록 가져오기
	public List<Map<String, Object>> getAllPositions() {
		return roleDao.getAllPositions();
	}
	
	// 직급체계 변경
	public int updateRankPosition(int rankIdx, int positionIdx) {
        return roleDao.updateRankPosition(rankIdx, positionIdx);
    }
}
