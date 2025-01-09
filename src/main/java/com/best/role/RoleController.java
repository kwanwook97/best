package com.best.role;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RoleController {

    @Autowired
    private RoleService roleService;

    
    // 권한관리 페이지로 이동
    @RequestMapping(value = "/accessManage.go")
    public String accessManage(HttpSession session) {
    	
    	return "main/accessManage";
    }
    
    
    // 접근제어 페이지 목록 가져오기.
    @GetMapping("/getPageList.ajax")
    @ResponseBody
    public Map<String, Object> getPageList(@RequestParam(value = "query", required = false) String query) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<PageDTO> pages = roleService.getPageList(query);
            response.put("success", true);
            response.put("pages", pages);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }
    
    /**
     * 페이지 등록 처리
     * @param url 페이지 URL
     * @param name 페이지 이름
     * @return 등록 결과(success: true/false, message: 오류 메시지)
     */
    @PostMapping("/addPage.ajax")
    @ResponseBody
    public Map<String, Object> addPage(@RequestParam String url, @RequestParam String name) {
    	int row = 0;
    	
        Map<String, Object> response = new HashMap<>();
        
        
        if (roleService.isPageDuplicate(url, name)) {
            response.put("success", false);
            response.put("message", "이미 등록된 URL 또는 페이지 이름입니다.");
        } else {
            PageDTO page = new PageDTO();
            page.setUrl(url);
            page.setPage_name(name);
            row = roleService.insertPage(page);
        }
        
        if(row > 0) {
        	response.put("success", true);
        }else {
        	response.put("success", false);
        }
        
        
        
        return response;
    }

    
    // 페이지 삭제
    @PostMapping("/deletePage.ajax")
    @ResponseBody
    public Map<String, Object> deletePage(@RequestParam int pageIdx) {
    	int row = 0;
        Map<String, Object> response = new HashMap<>();
        
        row = roleService.deletePage(pageIdx);
        
        if(row > 0) {
        	response.put("success", true);
        }else {
        	response.put("success", false);
        }
        
        return response;
    }
    

    /**
     * 페이지 검색 처리
     * @param query 검색어
     * @return 검색 결과(success: true/false, pages: 페이지 목록)
     */
    @GetMapping("/searchPages.ajax")
    @ResponseBody
    public Map<String, Object> searchPages(
        @RequestParam("searchFilter") String searchFilter,
        @RequestParam("searchKeyword") String searchKeyword) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<PageDTO> pages = roleService.searchPages(searchFilter, searchKeyword);
            response.put("success", true);
            response.put("pages", pages);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }


    /**
     * 부서별 권한 조회
     * @param departmentId 부서 ID
     * @return 권한 목록(success: true/false, roles: 권한 리스트)
     */
    @GetMapping("/filterDepartmentRoles.ajax")
    @ResponseBody
    public Map<String, Object> filterDepartmentRoles(@RequestParam int departmentId) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<PageDTO> roles = roleService.filterDepartmentRoles(departmentId);
            result.put("success", true);
            result.put("roles", roles);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }



    /**
     * 직급별 권한 조회
     * @param rankId 직급 ID
     * @return 권한 목록(success: true/false, roles: 권한 리스트)
     */
    @GetMapping("/filterRankRoles.ajax")
    @ResponseBody
    public Map<String, Object> filterRankRoles(@RequestParam int rankId) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<PageDTO> roles = roleService.filterRankRoles(rankId);
            result.put("success", true);
            result.put("roles", roles);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    /**
     * 페이지별 권한 조회
     * @param url 페이지 URL
     * @return 권한 정보(success: true/false, roles: 권한 리스트)
     */
    @GetMapping("/getPermissions.ajax")
    @ResponseBody
    public Map<String, Object> getPermissions(@RequestParam String url) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Map<String, Object>> roles = roleService.getPermissions(url);
            result.put("success", true);
            result.put("roles", roles);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }


    // 권한없는 부서목록가져오기
    @GetMapping("/getUnassignedDepartments.ajax")
    @ResponseBody
    public Map<String, Object> getUnassignedDepartments(@RequestParam int pageIdx) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Map<String, Object>> departments = roleService.getUnassignedDepartments(pageIdx);
            response.put("success", true);
            response.put("departments", departments);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // 권한없는 직급목록가져오기
    @GetMapping("/getUnassignedRanks.ajax")
    @ResponseBody
    public Map<String, Object> getUnassignedRanks(@RequestParam int pageIdx) {
        Map<String, Object> response = new HashMap<>();
        try {
        	List<Map<String, Object>> ranks = roleService.getUnassignedRanks(pageIdx);
            response.put("success", true);
            response.put("ranks", ranks);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // 부서 또는 직급권한 삭제
    @PostMapping("/deleteRole.ajax")
    @ResponseBody
    public Map<String, Object> deleteRole(@RequestParam int roleIdx) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = roleService.deleteRole(roleIdx);
            response.put("success", result > 0);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    

    // 부서에 권한부여
    @PostMapping("/assignDepartmentRole.ajax")
    @ResponseBody
    public Map<String, Object> assignDepartmentRole(@RequestParam int pageIdx, @RequestParam int departIdx) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = roleService.assignDepartmentRole(pageIdx, departIdx);
            response.put("success", result > 0);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // 직급에 권한부여
    @PostMapping("/assignRankRole.ajax")
    @ResponseBody
    public Map<String, Object> assignRankRole(@RequestParam int pageIdx, @RequestParam int rankIdx) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = roleService.assignRankRole(pageIdx, rankIdx);
            response.put("success", result > 0);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    
    
    // 모든 부서 목록 가져오기
    @GetMapping("/getAllDepartments.ajax")
    @ResponseBody
    public Map<String, Object> getAllDepartments() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Map<String, Object>> departments = roleService.getAllDepartments(); // 부서 목록 가져오기
            response.put("success", true);
            response.put("departments", departments);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // 모든 직급 목록 가져오기
    @GetMapping("/getAllRanks.ajax")
    @ResponseBody
    public Map<String, Object> getAllRanks() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Map<String, Object>> ranks = roleService.getAllRanks(); // 직급 목록 가져오기
            response.put("success", true);
            response.put("ranks", ranks);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }
    
    // 모든 직책 목록 가져오기
    @GetMapping("/getAllPositions.ajax")
    @ResponseBody
    public Map<String, Object> getAllPositions() {
    	Map<String, Object> response = new HashMap<>();
    	try {
    		List<Map<String, Object>> positions = roleService.getAllPositions(); // 직책 목록 가져오기
    		response.put("success", true);
    		response.put("positions", positions);
    	} catch (Exception e) {
    		response.put("success", false);
    		response.put("message", e.getMessage());
    	}
    	return response;
    }

    
    // 직급관리 페이지로 이동
    @RequestMapping(value = "/rankManage.go")
    public String rankManage(HttpSession session) {
    	
    	return "main/rankManage";
    }
    
    // 부서관리 페이지로 이동
    @RequestMapping(value = "/departManage.go")
    public String departManage(HttpSession session) {
    	
    	return "main/departManage";
    }
    
    // 직급 추가
    @PostMapping("/addRank.ajax")
    @ResponseBody
    public Map<String, Object> addRank(@RequestParam String rankName) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = roleService.addRank(rankName);
            response.put("success", result > 0);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }
    
    // 직급 변경
    @PostMapping("/updateRank.ajax")
    @ResponseBody
    public Map<String, Object> updateRank(@RequestParam int rankIdx, @RequestParam String rankName) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = roleService.updateRank(rankIdx, rankName);
            response.put("success", result > 0);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // 직급 삭제
    @PostMapping("/deleteRank.ajax")
    @ResponseBody
    public Map<String, Object> deleteRank(@RequestParam int rankIdx) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = roleService.deleteRank(rankIdx);
            response.put("success", result > 0);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }
    
    // 부서 추가
    @PostMapping("/addDepartment.ajax")
    @ResponseBody
    public Map<String, Object> addDepartment(@RequestParam String departName) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = roleService.addDepartment(departName);
            response.put("success", result > 0);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // 부서 수정
    @PostMapping("/updateDepartment.ajax")
    @ResponseBody
    public Map<String, Object> updateDepartment(@RequestParam int departIdx, @RequestParam String departName) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = roleService.updateDepartment(departIdx, departName);
            response.put("success", result > 0);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // 부서 삭제
    @PostMapping("/deleteDepartment.ajax")
    @ResponseBody
    public Map<String, Object> deleteDepartment(@RequestParam int departIdx) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = roleService.deleteDepartment(departIdx);
            response.put("success", result > 0);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

    // 직급체계 변경
    @PostMapping("/updateRankPosition.ajax")
    @ResponseBody
    public Map<String, Object> updateRankPosition(@RequestBody Map<String, Object> requestData) {
        Map<String, Object> response = new HashMap<>();
        try {
            int rankIdx = Integer.parseInt(requestData.get("rankIdx").toString()); // String을 Integer로 변환
            int positionIdx = Integer.parseInt(requestData.get("positionIdx").toString());
            int result = roleService.updateRankPosition(rankIdx, positionIdx);

            response.put("success", result > 0);
            if (result <= 0) {
                response.put("message", "데이터베이스 업데이트 실패");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

}
