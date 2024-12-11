package com.best.Attendance;

import java.time.LocalDateTime;

public class AttendanceHistoryDTO {
	private int attend_update_idx; // 업데이트 ID (Primary Key, AUTO_INCREMENT)
	private int emp_idx; // 직원 ID
	private int attend_idx; // 출석 ID
	private String before_update; // 이전 상태
	private String after_update; // 변경 후 상태
	private String content; // 비고
	private LocalDateTime date; // 업데이트 날짜 (TIMESTAMP)
	public int getAttend_update_idx() {
		return attend_update_idx;
	}
	public void setAttend_update_idx(int attend_update_idx) {
		this.attend_update_idx = attend_update_idx;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public int getAttend_idx() {
		return attend_idx;
	}
	public void setAttend_idx(int attend_idx) {
		this.attend_idx = attend_idx;
	}
	public String getBefore_update() {
		return before_update;
	}
	public void setBefore_update(String before_update) {
		this.before_update = before_update;
	}
	public String getAfter_update() {
		return after_update;
	}
	public void setAfter_update(String after_update) {
		this.after_update = after_update;
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
