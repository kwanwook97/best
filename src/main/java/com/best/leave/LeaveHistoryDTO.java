package com.best.leave;

import java.time.LocalDate;

public class LeaveHistoryDTO {
	private int leave_update_idx; // 업데이트 ID (Primary Key, AUTO_INCREMENT)
	private int emp_idx; // 직원 ID
	private int leave_idx; // 휴가 ID
	private Integer category; // 카테고리
	private LocalDate start_date; // 시작 날짜
	private LocalDate end_date; // 종료 날짜
	public int getLeave_update_idx() {
		return leave_update_idx;
	}
	public void setLeave_update_idx(int leave_update_idx) {
		this.leave_update_idx = leave_update_idx;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public int getLeave_idx() {
		return leave_idx;
	}
	public void setLeave_idx(int leave_idx) {
		this.leave_idx = leave_idx;
	}
	public Integer getCategory() {
		return category;
	}
	public void setCategory(Integer category) {
		this.category = category;
	}
	public LocalDate getStart_date() {
		return start_date;
	}
	public void setStart_date(LocalDate start_date) {
		this.start_date = start_date;
	}
	public LocalDate getEnd_date() {
		return end_date;
	}
	public void setEnd_date(LocalDate end_date) {
		this.end_date = end_date;
	}

}
