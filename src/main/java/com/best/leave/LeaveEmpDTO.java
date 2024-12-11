package com.best.leave;

import java.time.LocalDateTime;

public class LeaveEmpDTO {
	private int leave_idx; // 휴가 ID (Primary Key, AUTO_INCREMENT)
	private int emp_idx; // 직원 ID
	private int total_leave; // 총 휴가 일수
	private int used_leave; // 사용된 휴가 일수
	private int remain_leave; // 남은 휴가 일수
	private int year; // 연도
	private String content; // 비고
	private LocalDateTime create_date; // 생성일 (TIMESTAMP)
	private LocalDateTime last_date; // 마지막 업데이트일 (TIMESTAMP)
	public int getLeave_idx() {
		return leave_idx;
	}
	public void setLeave_idx(int leave_idx) {
		this.leave_idx = leave_idx;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public Integer getTotal_leave() {
		return total_leave;
	}
	public void setTotal_leave(Integer total_leave) {
		this.total_leave = total_leave;
	}
	public Integer getUsed_leave() {
		return used_leave;
	}
	public void setUsed_leave(Integer used_leave) {
		this.used_leave = used_leave;
	}
	public Integer getRemain_leave() {
		return remain_leave;
	}
	public void setRemain_leave(Integer remain_leave) {
		this.remain_leave = remain_leave;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public LocalDateTime getCreate_date() {
		return create_date;
	}
	public void setCreate_date(LocalDateTime create_date) {
		this.create_date = create_date;
	}
	public LocalDateTime getLast_date() {
		return last_date;
	}
	public void setLast_date(LocalDateTime last_date) {
		this.last_date = last_date;
	}

}
