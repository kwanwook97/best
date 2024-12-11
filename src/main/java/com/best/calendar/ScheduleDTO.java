package com.best.calendar;

import java.time.LocalDateTime;

public class ScheduleDTO {
	private int schedule_idx; // 스케줄 ID (Primary Key, AUTO_INCREMENT)
	private int emp_idx; // 직원 ID
	private String category; // 스케줄 카테고리
	private String subject; // 스케줄 제목
	private LocalDateTime start_datetime; // 시작 시간 (DATETIME)
	private LocalDateTime end_datetime; // 종료 시간 (DATETIME)
	private Boolean status; // 상태
	public int getSchedule_idx() {
		return schedule_idx;
	}
	public void setSchedule_idx(int schedule_idx) {
		this.schedule_idx = schedule_idx;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
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
	public Boolean getStatus() {
		return status;
	}
	public void setStatus(Boolean status) {
		this.status = status;
	}

}
