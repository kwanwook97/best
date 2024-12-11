package com.best.alarm;

public class AlarmTemplateDTO {
	private int template_idx; // 템플릿 ID (Primary Key, AUTO_INCREMENT)
	private String type; // 템플릿 유형
	private String content; // 템플릿 내용
	public int getTemplate_idx() {
		return template_idx;
	}
	public void setTemplate_idx(int template_idx) {
		this.template_idx = template_idx;
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


}
