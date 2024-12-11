package com.best.bus;

public class DriveDTO {
	private int drive_idx; // 운행 ID (Primary Key, AUTO_INCREMENT)
	private int driver_idx2; // 운전자 ID
	private String bus_idx; // 버스 ID
	private String status; // 상태
	public int getDrive_idx() {
		return drive_idx;
	}
	public void setDrive_idx(int drive_idx) {
		this.drive_idx = drive_idx;
	}
	public int getDriver_idx2() {
		return driver_idx2;
	}
	public void setDriver_idx2(int driver_idx2) {
		this.driver_idx2 = driver_idx2;
	}
	public String getBus_idx() {
		return bus_idx;
	}
	public void setBus_idx(String bus_idx) {
		this.bus_idx = bus_idx;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

}
