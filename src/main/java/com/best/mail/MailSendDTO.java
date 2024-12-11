package com.best.mail;

import java.time.LocalDateTime;

public class MailSendDTO {
	private int mail_send_idx; // 메일 발송 ID (Primary Key, AUTO_INCREMENT)
	private String emp_idx; // 직원 ID
	private String email; // 이메일 주소
	private String subject; // 메일 제목
	private String content; // 메일 내용
	private LocalDateTime date; // 메일 전송 시간 (TIMESTAMP)
	private String status; // 상태 (발송 완료, 실패 등)
	public int getMail_send_idx() {
		return mail_send_idx;
	}
	public void setMail_send_idx(int mail_send_idx) {
		this.mail_send_idx = mail_send_idx;
	}
	public String getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(String emp_idx) {
		this.emp_idx = emp_idx;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}


}
