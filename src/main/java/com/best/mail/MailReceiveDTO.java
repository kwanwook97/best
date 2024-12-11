package com.best.mail;

public class MailReceiveDTO {
	private int mail_receive_idx; // 메일 수신 ID (Primary Key, AUTO_INCREMENT)
	private int mail_send_idx; // 발신된 메일 ID
	private String emp_idx; // 직원 ID
	private String email; // 수신 이메일 주소
	private String category; // 메일 카테고리
	private Boolean flag; // 상태 플래그
	public int getMail_receive_idx() {
		return mail_receive_idx;
	}
	public void setMail_receive_idx(int mail_receive_idx) {
		this.mail_receive_idx = mail_receive_idx;
	}
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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Boolean getFlag() {
		return flag;
	}
	public void setFlag(Boolean flag) {
		this.flag = flag;
	}
	
}
