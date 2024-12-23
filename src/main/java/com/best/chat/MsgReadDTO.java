package com.best.chat;

import java.util.Date;

public class MsgReadDTO {

	private int msg_idx;
	private int emp_idx;
	private boolean is_read;
	private Date read_at;
	
	
	public int getMsg_idx() {
		return msg_idx;
	}
	public void setMsg_idx(int msg_idx) {
		this.msg_idx = msg_idx;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public boolean isIs_read() {
		return is_read;
	}
	public void setIs_read(boolean is_read) {
		this.is_read = is_read;
	}
	public Date getRead_at() {
		return read_at;
	}
	public void setRead_at(Date read_at) {
		this.read_at = read_at;
	}
}
