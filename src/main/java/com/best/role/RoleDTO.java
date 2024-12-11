package com.best.role;

public class RoleDTO {
	private int role_idx; // 역할 ID (Primary Key, AUTO_INCREMENT)
	private String category; // 역할 카테고리
	private String role; // 역할 이름
	public int getRole_idx() {
		return role_idx;
	}
	public void setRole_idx(int role_idx) {
		this.role_idx = role_idx;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}

}
