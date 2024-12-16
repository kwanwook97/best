package com.best.attendance;

import java.time.LocalDateTime;

public class AttendanceDTO {
	private int attend_idx; // 출석 기록 ID (Primary Key, AUTO_INCREMENT)
	private int emp_idx; // 직원 ID
	private LocalDateTime start_time; // 시작 시간 (TIMESTAMP)
	private LocalDateTime end_time; // 종료 시간 (TIMESTAMP)
	private Integer calculate_time; // 계산된 근무 시간
	private String status; // 출석 상태 (예: 출근, 조퇴 등)
	private String content; // 비고
	private LocalDateTime date; // 기록 날짜 (TIMESTAMP)
	public int getAttend_idx() {
		return attend_idx;
	}
	public void setAttend_idx(int attend_idx) {
		this.attend_idx = attend_idx;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public LocalDateTime getStart_time() {
		return start_time;
	}
	public void setStart_time(LocalDateTime start_time) {
		this.start_time = start_time;
	}
	public LocalDateTime getEnd_time() {
		return end_time;
	}
	public void setEnd_time(LocalDateTime end_time) {
		this.end_time = end_time;
	}
	public Integer getCalculate_time() {
		return calculate_time;
	}
	public void setCalculate_time(Integer calculate_time) {
		this.calculate_time = calculate_time;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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

}
