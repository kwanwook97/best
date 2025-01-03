package com.best.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

    private final DynamicAuthorizationService dynamicAuthorizationService;

    @Autowired
    public SecurityConfig(DynamicAuthorizationService dynamicAuthorizationService) {
        this.dynamicAuthorizationService = dynamicAuthorizationService;
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
            .authorizeRequests(authorize -> authorize
                .antMatchers("/css/**", "/js/**", "/images/**", "/webjars/**", "/resources/**").permitAll()
                .antMatchers("/", "/login.go", "/login.do").permitAll()
                .antMatchers("/**").access("@dynamicAuthorizationService.hasAccess(request.requestURI)")
                .anyRequest().authenticated()
            )
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


