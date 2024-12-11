package com.best.document;

public class ReferenceDTO {
	private int ref_idx; // 참조 ID (Primary Key, AUTO_INCREMENT)
	private int doc_idx; // 문서 ID
	private int emp_idx; // 직원 ID
	public int getRef_idx() {
		return ref_idx;
	}
	public void setRef_idx(int ref_idx) {
		this.ref_idx = ref_idx;
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


}
