package com.best.document;

public class FormDTO {
	private int form_idx; // 양식 ID (Primary Key, AUTO_INCREMENT)
	private String form_subject; // 양식 제목
	private String form_content; // 양식 내용
	
	
	public int getForm_idx() {
		return form_idx;
	}
	public void setForm_idx(int form_idx) {
		this.form_idx = form_idx;
	}
	public String getForm_subject() {
		return form_subject;
	}
	public void setForm_subject(String form_subject) {
		this.form_subject = form_subject;
	}
	public String getForm_content() {
		return form_content;
	}
	public void setForm_content(String form_content) {
		this.form_content = form_content;
	}


}
