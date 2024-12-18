package com.best.calendar;

import java.time.LocalDateTime;


public class ReserveDTO {
    private int reserve_idx;     // 예약 ID
    private LocalDateTime start_datetime;  // 예약 시작 시간
    private LocalDateTime end_datetime;    // 예약 종료 시간
    private String subject;    // 주제
    private int emp_idx;        // 직원 ID
    private int room_idx;       // 방 ID
    private LocalDateTime created_at;
    
	public int getReserve_idx() {
		return reserve_idx;
	}
	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}
	public LocalDateTime getStart_datetime() {
		return start_datetime;
	}
	public void setStart_datetime(LocalDateTime start_datetime) {
		this.start_datetime = start_datetime;
	}
	public LocalDateTime getEnd_datetime() {
		return end_datetime;
	}
	public void setEnd_datetime(LocalDateTime end_datetime) {
		this.end_datetime = end_datetime;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public int getRoom_idx() {
		return room_idx;
	}
	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}
	public LocalDateTime getCreated_at() {
		return created_at;
	}
	public void setCreated_at(LocalDateTime created_at) {
		this.created_at = created_at;
	}
    
}
