package com.best.websocket;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

@Configuration
@EnableWebSocket
public class WebsocketController implements WebSocketConfigurer {
	Logger log = LoggerFactory.getLogger(getClass());
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
	    registry.addHandler(webSocketHandler(), "/chat/chat")
	        .setAllowedOrigins("*")
	        .addInterceptors(new HttpSessionHandshakeInterceptor() {
	        	
	        	@Override
	        	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
	        	                               WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
	        	    if (request instanceof ServletServerHttpRequest) {
	        	        ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
	        	        HttpSession httpSession = servletRequest.getServletRequest().getSession(false);

	        	        if (httpSession != null) {
	        	            // 로그인 정보 가져오기
	        	            String loginName = (String) httpSession.getAttribute("loginName");
	        	            String empIdxString = (String) httpSession.getAttribute("loginId"); // loginId는 emp_idx에 해당

	        	            // emp_idx 변환
	        	            Integer empIdx = null;
	        	            if (empIdxString != null) {
	        	                try {
	        	                    empIdx = Integer.valueOf(empIdxString);
	        	                } catch (NumberFormatException e) {
	        	                    log.error("emp_idx 변환 실패: {}", empIdxString, e);
	        	                }
	        	            }

	        	            // chat_idx URL에서 가져오기
	        	            String chatIdxString = servletRequest.getServletRequest().getParameter("chat_idx");
	        	            Integer chatIdx = null;
	        	            if (chatIdxString != null) {
	        	                try {
	        	                    chatIdx = Integer.valueOf(chatIdxString);
	        	                } catch (NumberFormatException e) {
	        	                    log.error("chat_idx 변환 실패: {}", chatIdxString, e);
	        	                }
	        	            }

	        	            // WebSocket attributes에 저장
	        	            attributes.put("emp_name", loginName != null ? loginName : "Unknown User");
	        	            attributes.put("emp_idx", empIdx); // 여기서 emp_idx로 저장
	        	            attributes.put("chat_idx", chatIdx); // 여기서 chat_idx로 저장

	        	            // 세션 속성 로그 추가
	        	            log.info("Handshake - emp_idx: {}, chat_idx: {}", empIdx, chatIdx);
	        	        }
	        	    }
	        	    return super.beforeHandshake(request, response, wsHandler, attributes);
	        	}
	        });
	    
	    registry.addHandler(globalWebSocketHandler(), "/ws")
	    .setAllowedOrigins("*")
	    .addInterceptors(new HttpSessionHandshakeInterceptor() {
	        @Override
	        public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
	                                       WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
	            if (request instanceof ServletServerHttpRequest) {
	                ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
	                HttpSession httpSession = servletRequest.getServletRequest().getSession(false);

	                if (httpSession != null) {
	                    // 로그인 정보 가져오기
	                    String loginName = (String) httpSession.getAttribute("loginName");
	                    String empIdxString = (String) httpSession.getAttribute("loginId");

	                    // emp_idx 변환
	                    Integer empIdx = null;
	                    if (empIdxString != null) {
	                        try {
	                            empIdx = Integer.valueOf(empIdxString);
	                        } catch (NumberFormatException e) {
	                            log.error("emp_idx 변환 실패: {}", empIdxString, e);
	                        }
	                    }

	                    // WebSocket attributes에 저장
	                    attributes.put("emp_name", loginName != null ? loginName : "Unknown User");
	                    attributes.put("emp_idx", empIdx);
	                    log.info("Global Handshake - emp_idx: {}", empIdx);
	                }
	            }
	            return super.beforeHandshake(request, response, wsHandler, attributes);
	        }
	    });
	}
	
    @Bean
    public WebSocketHandler webSocketHandler() {
        return new WebsocketHandler();
    }
    
 // 글로벌 WebSocketHandler 추가
    @Bean
    public WebSocketHandler globalWebSocketHandler() {
        return new GlobalWebsocketHandler();
    }
}
