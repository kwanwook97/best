package com.best.chat;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
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
	                    String query = request.getURI().getQuery();
	                    if (query != null && query.contains("chat_idx")) {
	                        String chatIdx = query.split("=")[1];
	                        attributes.put("chat_idx", chatIdx);
	                    }
	                    return super.beforeHandshake(request, response, wsHandler, attributes);
	                }
	            });
	}

	@Bean
	public WebSocketHandler webSocketHandler() {
		return new WebsocketHandler();
	}
}
