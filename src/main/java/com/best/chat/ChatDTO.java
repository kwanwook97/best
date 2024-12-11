package com.best.chat;

import java.time.LocalDateTime;

public class ChatDTO {
	private int chat_idx; // 채팅방 ID (Primary Key, AUTO_INCREMENT)
	private String chat_subject; // 채팅방 제목
	private LocalDateTime created_at; // 생성 시간 (TIMESTAMP)
	public int getChat_idx() {
		return chat_idx;
	}
	public void setChat_idx(int chat_idx) {
		this.chat_idx = chat_idx;
	}
	public String getChat_subject() {
		return chat_subject;
	}
	public void setChat_subject(String chat_subject) {
		this.chat_subject = chat_subject;
	}
	public LocalDateTime getCreated_at() {
		return created_at;
	}
	public void setCreated_at(LocalDateTime created_at) {
		this.created_at = created_at;
	}


}
