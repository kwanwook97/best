package com.best.chat;

import java.util.Date;

public class PartyDTO {
	private int party_idx; // 파티 ID (Primary Key, AUTO_INCREMENT)
	private int emp_idx; // 직원 ID (NULL 가능)
	private int chat_idx; // 채팅방 ID
	private Date enter_time; // 입장 시간 (TIMESTAMP)
	private Date exit_time; // 퇴장 시간 (TIMESTAMP)
	
	
	
	public int getParty_idx() {
		return party_idx;
	}
	public void setParty_idx(int party_idx) {
		this.party_idx = party_idx;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public int getChat_idx() {
		return chat_idx;
	}
	public void setChat_idx(int chat_idx) {
		this.chat_idx = chat_idx;
	}
	public Date getEnter_time() {
		return enter_time;
	}
	public void setEnter_time(Date enter_time) {
		this.enter_time = enter_time;
	}
	public Date getExit_time() {
		return exit_time;
	}
	public void setExit_time(Date exit_time) {
		this.exit_time = exit_time;
	}


}
