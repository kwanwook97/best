package com.best.expense;

import java.time.LocalDate;

public class ExpenseDTO {

	private int ex_idx;
	private int doc_idx;
	private LocalDate ex_date;
	private String ex_item;
	private String description;
	private long ex_amount;
	private String remark;
	
	public int getEx_idx() {
		return ex_idx;
	}
	public void setEx_idx(int ex_idx) {
		this.ex_idx = ex_idx;
	}
	public int getDoc_idx() {
		return doc_idx;
	}
	public void setDoc_idx(int doc_idx) {
		this.doc_idx = doc_idx;
	}
	public LocalDate getEx_date() {
		return ex_date;
	}
	public void setEx_date(LocalDate ex_date) {
		this.ex_date = ex_date;
	}
	public String getEx_item() {
		return ex_item;
	}
	public void setEx_item(String ex_item) {
		this.ex_item = ex_item;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public long getEx_amount() {
		return ex_amount;
	}
	public void setEx_amount(long ex_amount) {
		this.ex_amount = ex_amount;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
