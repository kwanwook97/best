package com.best.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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
     * 요청된 URL에 대해 동적으로 접근 권한 확인
     * @param url 요청 URL
     * @return 접근 가능 여부
     */
    public boolean hasAccess(String url) {
        System.out.println("Checking access for URL: " + url);

        System.out.println("Processed URL for validation: " + url);

        // 1. Authentication 정보 확인
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || authentication.getPrincipal() == null) {
            System.out.println("Access denied: No authentication found");
            return false; // 인증되지 않은 사용자
        }

        Object principal = authentication.getPrincipal();
        System.out.println("Principal: " + principal);

        EmployeeDTO employee = null;

        if (principal instanceof EmployeeDTO) {
            employee = (EmployeeDTO) principal;
        } else if (principal instanceof UserDetails) {
            String username = ((UserDetails) principal).getUsername();
            employee = loginDAO.login(username); // 사용자 정보 로드
        } else if (principal instanceof String) {
            String username = (String) principal;
            employee = loginDAO.login(username); // 사용자 정보 로드
        }

        if (employee == null) {
            System.out.println("Access denied: Employee not found");
            return false; // 사용자 정보가 없는 경우
        }

        // 2. access 테이블에서 URL 확인
        Integer urlCount = loginDAO.countUrl(url);
        if (urlCount == null || urlCount == 0) {
            System.out.println("Access allowed: URL not registered in access table");
            return true; // URL이 등록되지 않은 경우 접근 허용
        }

        // 3. URL 접근 권한 확인
        int departIdx = employee.getDepart_idx();
        int rankIdx = employee.getRank_idx();

        boolean accessGranted = loginDAO.hasAccessToUrl(url, departIdx, rankIdx) > 0;
        System.out.println("Access granted: " + accessGranted);
        return accessGranted;
    }
}
