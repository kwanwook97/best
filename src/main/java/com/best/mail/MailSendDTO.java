package com.best.mail;

import java.time.LocalDateTime;

public class MailSendDTO {
	private int mail_send_idx; // 메일 발송 ID (Primary Key, AUTO_INCREMENT)
	private String sender_name; // 작성자이름
	private int sender_idx; // 작성자 ID
	private String sender_email; // 이메일 주소
	private String subject; // 메일 제목
	private String content; // 메일 내용
	private LocalDateTime date; // 메일 전송 시간 (TIMESTAMP)
	private int status; // 상태 (0:임시저장, 1:발송)
	private int special_flag; // 중요여부 (0: 일반, 1: 중요)
	private int delete_flag;  // 삭제여부 (0: 정상, 1: 휴지통, 2: 완전삭제)
	
	
	
	
	public int getSender_idx() {
		return sender_idx;
	}
	public void setSender_idx(int sender_idx) {
		this.sender_idx = sender_idx;
	}
	public String getSender_name() {
		return sender_name;
	}
	public void setSender_name(String sender_name) {
		this.sender_name = sender_name;
	}
	public int getMail_send_idx() {
		return mail_send_idx;
	}
	public void setMail_send_idx(int mail_send_idx) {
		this.mail_send_idx = mail_send_idx;
	}
	public String getSender_email() {
		return sender_email;
	}
	public void setSender_email(String sender_email) {
		this.sender_email = sender_email;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public LocalDateTime getDate() {
		return date;
	}
	public void setDate(LocalDateTime date) {
		this.date = date;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getSpecial_flag() {
		return special_flag;
	}
	public void setSpecial_flag(int special_flag) {
		this.special_flag = special_flag;
	}
	public int getDelete_flag() {
		return delete_flag;
	}
	public void setDelete_flag(int delete_flag) {
		this.delete_flag = delete_flag;
	}
	
	

}
