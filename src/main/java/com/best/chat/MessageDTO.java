package com.best.chat;

import java.time.LocalDateTime;

public class MessageDTO {
	private int msg_idx; // 메시지 ID (Primary Key, AUTO_INCREMENT)
	private int chat_idx; // 채팅방 ID
	private Integer msg_send_idx; // 보낸 사람 ID (NULL 가능)
	private Integer msg_receive_idx; // 받은 사람 ID (NULL 가능)
	private String content; // 메시지 내용
	private LocalDateTime time; // 메시지 시간 (TIMESTAMP)
	public int getMsg_idx() {
		return msg_idx;
	}
	public void setMsg_idx(int msg_idx) {
		this.msg_idx = msg_idx;
	}
	public int getChat_idx() {
		return chat_idx;
	}
	public void setChat_idx(int chat_idx) {
		this.chat_idx = chat_idx;
	}
	public Integer getMsg_send_idx() {
		return msg_send_idx;
	}
	public void setMsg_send_idx(Integer msg_send_idx) {
		this.msg_send_idx = msg_send_idx;
	}
	public Integer getMsg_receive_idx() {
		return msg_receive_idx;
	}
	public void setMsg_receive_idx(Integer msg_receive_idx) {
		this.msg_receive_idx = msg_receive_idx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public LocalDateTime getTime() {
		return time;
	}
	public void setTime(LocalDateTime time) {
		this.time = time;
	}

}
