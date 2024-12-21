package com.best.document;

import java.time.LocalDateTime;

public class ApprovDTO {
	private int approv_num; // 승인 번호 (Primary Key, AUTO_INCREMENT)
	private int doc_idx; // 문서 ID
	private int emp_idx; // 직원 ID
	private int approv_order; // 승인 순서
	private String status; // 승인 상태
	private LocalDateTime approv_date; // 승인 날짜 (TIMESTAMP)
	private boolean doc_read;
	
	
	public boolean isDoc_read() {
		return doc_read;
	}
	public void setDoc_read(boolean doc_read) {
		this.doc_read = doc_read;
	}
	public int getApprov_num() {
		return approv_num;
	}
	public void setApprov_num(int approv_num) {
		this.approv_num = approv_num;
	}
	public int getDoc_idx() {
		return doc_idx;
	}
	public void setDoc_idx(int doc_idx) {
		this.doc_idx = doc_idx;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public int getApprov_order() {
		return approv_order;
	}
	public void setApprov_order(int approv_order) {
		this.approv_order = approv_order;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public LocalDateTime getApprov_date() {
		return approv_date;
	}
	public void setApprov_date(LocalDateTime approv_date) {
		this.approv_date = approv_date;
	}

}
