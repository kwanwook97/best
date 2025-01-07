package com.best.config;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException {
        // AJAX 요청인지 확인
        String requestedWith = request.getHeader("X-Requested-With");

        if ("XMLHttpRequest".equals(requestedWith)) {
            // AJAX 요청일 경우 JSON으로 메시지 전송
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"error\": \"권한이 부족합니다.\"}");
        } else {
            // 일반 요청일 경우 alert 스크립트를 포함한 HTML 반환
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write("<script>alert('권한이 부족합니다.'); history.back();</script>");
        }
    }
}
