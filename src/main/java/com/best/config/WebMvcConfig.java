package com.best.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    private final DynamicAuthorizationService authorizationService;

    public WebMvcConfig(DynamicAuthorizationService authorizationService) {
        this.authorizationService = authorizationService;
    }

    // 구현한 인터셉터를 InterceptorRegistry에 등록. 
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
    	// 구현한 AuthorizationInterceptor를 생성하면서 DynamicAuthorizationService 주입..
        registry.addInterceptor(new AuthorizationInterceptor(authorizationService))
                .addPathPatterns("/*.go", "/*.do"); // .go, .do인 모든 경로에 대해 인터셉터 적용
    }
}
