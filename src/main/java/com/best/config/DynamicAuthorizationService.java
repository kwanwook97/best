package com.best.config;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.best.emp.EmployeeDTO;
import com.best.emp.LoginDAO;

@Service
public class DynamicAuthorizationService {

    private final LoginDAO loginDAO;

    @Autowired
    public DynamicAuthorizationService(LoginDAO loginDAO) {
        this.loginDAO = loginDAO;
    }

    
    
    
    /**
     * 특정 사용자에게 접근 불가능한 URL 목록 가져오기
     * 
     * @param employee 사용자 정보(EmployeeDTO)
     * @return 접근 불가능한 URL 목록
     */
    public List<String> getInaccessibleUrlsForUser(EmployeeDTO employee) {
        if (employee == null) {
            throw new IllegalArgumentException("EmployeeDTO is required.");
        }

        // 사용자 부서 ID와 직급 ID를 기반으로 접근 가능한 URL 목록 가져오기
        int departIdx = employee.getDepart_idx();
        int rankIdx = employee.getRank_idx();

        // 로그인 DAO에서 DB 조회하여 접근 가능한 URL 목록 가져오기
        List<String> accessibleUrls = loginDAO.findAccessibleUrls(departIdx, rankIdx);

        // DB에서 모든 등록된 URL 가져오기
        List<String> allUrls = loginDAO.findAllUrls();

        // 접근 가능한 URL을 제외하여 접근 불가능한 URL 목록 생성
        allUrls.removeAll(accessibleUrls);

        System.out.println("Inaccessible URLs for user: " + allUrls);
        return allUrls;
    }

    
    
    
    /**
     * 요청된 URL에 대해 동적으로 접근 권한 확인
     * @param url 요청 URL
     * @return 접근 가능 여부
     */
    // SecurityConfig의 메서드 호출부에 의해 호출됨.
    public boolean hasAccess(String url) {
        System.out.println("Checking access for URL: " + url);

        // 요청 URL에서 "/" 이전 값제거
        if (url.lastIndexOf("/") != -1) {
            url = url.substring(url.lastIndexOf("/")+1);
        }
        System.out.println("Processed URL for database validation: " + url);

        // 1. Authentication 정보 확인
        // SecurityContext에서 접근가능한 url목록 불러오기
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        
        // 2. 로그인에 성공하지 못한경우... 유효성체크
        if (authentication == null || authentication.getPrincipal() == null) {
            System.out.println("Access denied: No authentication found");
            return false; // 인증되지 않은 사용자
        }
        
        // 관리자 권한 확인
        if (authentication.getAuthorities().stream()
                .anyMatch(grantedAuthority -> grantedAuthority.getAuthority().equals("ADMIN"))) {
            return true; // 관리자는 모든 URL 접근 허용
        }

        // 3. Principal에서 EmployeeDTO 가져오기.
        Object principal = authentication.getPrincipal();
        System.out.println("Principal: " + principal);

        EmployeeDTO employee = null;

        if (principal instanceof EmployeeDTO) {
            employee = (EmployeeDTO) principal;
        } 

        // 4. principal에 사용자 정보(employeeDTO)가 없는경우 유효성체크
        if (employee == null) {
            System.out.println("Access denied: Employee not found");
            return false; // 사용자 정보가 없는 경우
        }

        
        // 5. access 테이블에 URL이 등록되어 있지않은경우 페이지 접근 허용처리. *******
        Integer urlCount = loginDAO.countUrl(url);
        if (urlCount == null || urlCount == 0) {
            System.out.println("Access allowed: URL not registered in access table");
            return true; // URL이 등록되지 않은 경우 접근 허용
        }

        
        // 6. access 테이블에 URL이 등록되어 있는경우 URL 접근 권한체크
        int departIdx = employee.getDepart_idx();
        int rankIdx = employee.getRank_idx();

        boolean accessGranted = loginDAO.hasAccessToUrl(url, departIdx, rankIdx) > 0;
        System.out.println("Access granted: " + accessGranted);

        // URL권한에 따른 접근제어값 반환 true 또는 false
        return accessGranted;
    }
}
