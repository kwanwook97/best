package com.best.mail;

public class MailReceiveDTO {
	private int mail_receive_idx; // 메일 수신 ID (Primary Key, AUTO_INCREMENT)
	private int mail_send_idx; // 발신된 메일 ID
	private String receiver_name; // 직원 이름
	private int receiver_idx; // 직원 ID
	private String receiver_email; // 수신 이메일 주소
	private int read_flag; // 읽음여부
	private int special_flag; // 중요여부 (0: 일반, 1: 중요)
	private int receiver_type; // 0: 일반수신자, 1: 참조자
	private int delete_flag;  // 삭제여부 (0: 정상, 1: 휴지통, 2: 완전삭제)
	
	
	
	public String getReceiver_name() {
		return receiver_name;
	}
	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}
	public int getRead_flag() {
		return read_flag;
	}
	public void setRead_flag(int read_flag) {
		this.read_flag = read_flag;
	}
	public int getReceiver_idx() {
		return receiver_idx;
	}
	public void setReceiver_idx(int receiver_idx) {
		this.receiver_idx = receiver_idx;
	}
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
	public String getReceiver_email() {
		return receiver_email;
	}
	public void setReceiver_email(String receiver_email) {
		this.receiver_email = receiver_email;
	}
	public int getSpecial_flag() {
		return special_flag;
	}
	public void setSpecial_flag(int special_flag) {
		this.special_flag = special_flag;
	}
	public int getReceiver_type() {
		return receiver_type;
	}
	public void setReceiver_type(int receiver_type) {
		this.receiver_type = receiver_type;
	}
	public int getDelete_flag() {
		return delete_flag;
	}
	public void setDelete_flag(int delete_flag) {
		this.delete_flag = delete_flag;
	}
	
	
	
}
