package com.best.attachment;

public class AttachmentDTO {
	private int attach_idx; // 첨부 파일 ID (Primary Key, AUTO_INCREMENT)
	private Integer attach_category; // 첨부 파일 카테고리 (NULL 가능)
	private String file_name; // 첨부 파일 이름
	public int getAttach_idx() {
		return attach_idx;
	}
	public void setAttach_idx(int attach_idx) {
		this.attach_idx = attach_idx;
	}
	public Integer getAttach_category() {
		return attach_category;
	}
	public void setAttach_category(Integer attach_category) {
		this.attach_category = attach_category;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}


}
