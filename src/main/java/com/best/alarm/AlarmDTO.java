package com.best.alarm;

import java.time.LocalDateTime;

public class AlarmDTO {
	private int alarm_idx; // 알람 ID (Primary Key, AUTO_INCREMENT)
	private int emp_idx; // 직원 ID
	private int template_idx; // 템플릿 ID
	private LocalDateTime date; // 알림 생성 시간 (TIMESTAMP)
	private Boolean flag; // 상태 플래그
	public int getAlarm_idx() {
		return alarm_idx;
	}
	public void setAlarm_idx(int alarm_idx) {
		this.alarm_idx = alarm_idx;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public int getTemplate_idx() {
		return template_idx;
	}
	public void setTemplate_idx(int template_idx) {
		this.template_idx = template_idx;
	}
	public LocalDateTime getDate() {
		return date;
	}
	public void setDate(LocalDateTime date) {
		this.date = date;
	}
	public Boolean getFlag() {
		return flag;
	}
	public void setFlag(Boolean flag) {
		this.flag = flag;
	}


}
