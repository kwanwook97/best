package com.best.chat;

import java.util.Date;

public class MessageDTO {
	private int msg_idx; // 메시지 ID (Primary Key, AUTO_INCREMENT)
	private int chat_idx; // 채팅방 ID
	private Integer msg_send_idx; // 보낸 사람 ID (NULL 가능)
	private String content; // 메시지 내용
	private Date time; // 메시지 시간 (TIMESTAMP)
	private String message_type; // 메시지 유형 추가
	private int last_msg;

	public int getLast_msg() {
		return last_msg;
	}

	public void setLast_msg(int last_msg) {
		this.last_msg = last_msg;
	}

	public String getMessage_type() {
        return message_type;
    }

    public void setMessage_type(String message_type) {
        this.message_type = message_type;
    }
	
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}

}
