package com.best.document;

import java.time.LocalDateTime;

public class DocumentDTO {
	private int doc_idx; // 문서 ID (Primary Key, AUTO_INCREMENT)
	private int form_idx; // 폼 ID
	private String doc_subject; // 문서 제목
	private String doc_content; // 문서 내용
	private int emp_idx; // 직원 ID
	private LocalDateTime doc_date; // 작성 날짜 (TIMESTAMP)
	private String status; // 상태
	private String doc_number;
	
	
	public String getDoc_number() {
		return doc_number;
	}
	public void setDoc_number(String doc_number) {
		this.doc_number = doc_number;
	}
	public int getDoc_idx() {
		return doc_idx;
	}
	public void setDoc_idx(int doc_idx) {
		this.doc_idx = doc_idx;
	}
	public int getForm_idx() {
		return form_idx;
	}
	public void setForm_idx(int form_idx) {
		this.form_idx = form_idx;
	}
	public String getDoc_subject() {
		return doc_subject;
	}
	public void setDoc_subject(String doc_subject) {
		this.doc_subject = doc_subject;
	}
	public String getDoc_content() {
		return doc_content;
	}
	public void setDoc_content(String doc_content) {
		this.doc_content = doc_content;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	
	public LocalDateTime getDoc_date() {
		return doc_date;
	}
	public void setDoc_date(LocalDateTime doc_date) {
		this.doc_date = doc_date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}


}
