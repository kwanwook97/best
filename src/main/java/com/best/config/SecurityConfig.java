package com.best.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

	// 1. 각 URL에 따른 접근제어 처리.
    private final DynamicAuthorizationService dynamicAuthorizationService;
    // 2. 권한이 없는경우(403에러) 대신 alert창 처리.
    private final CustomAccessDeniedHandler accessDeniedHandler;

    @Autowired
    public SecurityConfig(DynamicAuthorizationService dynamicAuthorizationService, CustomAccessDeniedHandler accessDeniedHandler) {
        this.dynamicAuthorizationService = dynamicAuthorizationService;
        this.accessDeniedHandler = accessDeniedHandler;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .headers().frameOptions().disable() // X-Frame-Options 비활성화
            .and()
            // 현재 있는 페이지에 있는 경로정보들에 대해서만 처리.
            .authorizeRequests(authorize -> authorize
                .antMatchers("/css/**", "/js/**", "/images/**", "/webjars/**", "/resources/**").permitAll()
                .antMatchers("/", "/login.go", "/login.do", "/adminLogin.go", "/adminLogin.do").permitAll()
                .antMatchers("/*.go", "/*.do").access("@dynamicAuthorizationService.hasAccess(request.requestURI)")
                .anyRequest().authenticated() // 로그인된 사용자만 접근가능.
            )
            .exceptionHandling()
            	.accessDeniedHandler(accessDeniedHandler) // 커스텀 AccessDeniedHandler 등록
            .and()
            .logout()
                .logoutUrl("/logout.do")
                .logoutSuccessUrl("/login.go?logout=success")
                .invalidateHttpSession(true)
                .permitAll();

        return http.build();
    }

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        return http.getSharedObject(AuthenticationManagerBuilder.class).build();
    }
}


