package com.best.bus;

import java.util.Date;

public class DriveDTO {
	private int drive_idx; // 운행 ID (Primary Key, AUTO_INCREMENT)
	private String status; // 상태
	private Date start_time;
	private Date end_time; 
	private int dispatch_idx;
	
	
	public int getDrive_idx() {
		return drive_idx;
	}
	public void setDrive_idx(int drive_idx) {
		this.drive_idx = drive_idx;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getStart_time() {
		return start_time;
	}
	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}
	public Date getEnd_time() {
		return end_time;
	}
	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}
	public int getDispatch_idx() {
		return dispatch_idx;
	}
	public void setDispatch_idx(int dispatch_idx) {
		this.dispatch_idx = dispatch_idx;
	}

}
