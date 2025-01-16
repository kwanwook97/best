package com.best.alarm;

import java.util.Date;

public class AlarmDTO {
	private int alarm_idx; // 알람 ID (Primary Key, AUTO_INCREMENT)
	private int emp_idx; // 직원 ID
	private int template_idx; // 템플릿 ID
	private Date date; // 알림 생성 시간 (TIMESTAMP)
	private Boolean flag; // 상태 플래그
	private String type; // 템플릿 유형
	private String content; // 템플릿 내용
	private int source_idx;
	
	
	public int getSource_idx() {
		return source_idx;
	}
	public void setSource_idx(int source_idx) {
		this.source_idx = source_idx;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
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
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Boolean getFlag() {
		return flag;
	}
	public void setFlag(Boolean flag) {
		this.flag = flag;
	}


}
