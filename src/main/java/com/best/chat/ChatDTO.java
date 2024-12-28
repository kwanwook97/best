package com.best.chat;

import java.util.Date;

public class ChatDTO {
	private int chat_idx; // 채팅방 ID (Primary Key, AUTO_INCREMENT)
	private String chat_subject; // 채팅방 제목
	private Date created_at; // 생성 시간 (TIMESTAMP)
	private String chat_notice;
	
	
	
	public String getChat_notice() {
		return chat_notice;
	}
	public void setChat_notice(String chat_notice) {
		this.chat_notice = chat_notice;
	}
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
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}


}
