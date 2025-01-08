package com.best.config;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import com.best.emp.EmployeeDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

public class AuthorizationInterceptor implements HandlerInterceptor {

    private final DynamicAuthorizationService authorizationService;

    // Constructor를 통해 DynamicAuthorizationService 주입
    public AuthorizationInterceptor(DynamicAuthorizationService authorizationService) {
        this.authorizationService = authorizationService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        // 요청 처리 전에 필요한 로직 추가 가능 (현재는 통과)
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) {
    	
    	// 요청 처리 후, ModelAndView가 존재하는 경우 실행
    	if (modelAndView != null) {
    		// Spring Security에서 현재 사용자 정보(Authentication) 가져오기
    		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    		if (auth != null && auth.getPrincipal() instanceof EmployeeDTO) {
    			// 현재 사용자 정보(EmployeeDTO)를 가져옴
    			EmployeeDTO employee = (EmployeeDTO) auth.getPrincipal();
    			
    			// 접근 불가능한 URL 목록을 서비스에서 가져오기
    			List<String> inaccessibleUrls = authorizationService.getInaccessibleUrlsForUser(employee);
    			
    			try {
    				// 접근 불가능한 URL 목록을 JSON 문자열로 변환
    				ObjectMapper mapper = new ObjectMapper();
    				String inaccessibleUrlsJson = mapper.writeValueAsString(inaccessibleUrls);
    				
    				// ModelAndView에 추가하여 JSP로 전달
    				modelAndView.addObject("inaccessibleUrls", inaccessibleUrlsJson);
    			} catch (Exception e) {
    				// JSON 변환 중 예외 발생 시 스택 트레이스 출력
    				e.printStackTrace();
    			}
    		}
    	}
        	
        
    }
}
