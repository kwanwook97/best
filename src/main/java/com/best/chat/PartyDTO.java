package com.best.chat;

import java.time.LocalDateTime;

public class PartyDTO {
	private int party_idx; // 파티 ID (Primary Key, AUTO_INCREMENT)
	private int emp_idx; // 직원 ID (NULL 가능)
	private int chat_idx; // 채팅방 ID
	private LocalDateTime first_time; // 최초 참여 시간 (TIMESTAMP)
	private LocalDateTime enter_time; // 입장 시간 (TIMESTAMP)
	private LocalDateTime exit_time; // 퇴장 시간 (TIMESTAMP)
	private int count; // 참여 횟수 (NULL 가능)
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
	public LocalDateTime getFirst_time() {
		return first_time;
	}
	public void setFirst_time(LocalDateTime first_time) {
		this.first_time = first_time;
	}
	public LocalDateTime getEnter_time() {
		return enter_time;
	}
	public void setEnter_time(LocalDateTime enter_time) {
		this.enter_time = enter_time;
	}
	public LocalDateTime getExit_time() {
		return exit_time;
	}
	public void setExit_time(LocalDateTime exit_time) {
		this.exit_time = exit_time;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}

}
