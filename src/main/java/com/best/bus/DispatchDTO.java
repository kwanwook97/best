package com.best.bus;

import java.time.LocalDate;

public class DispatchDTO {

	private int dispatch_idx;
	private LocalDate date;
	private int driver_idx;
	private int bus_idx;
	private int shift_idx;
	private String shift;
	
	
	public int getShift_idx() {
		return shift_idx;
	}
	public void setShift_idx(int shift_idx) {
		this.shift_idx = shift_idx;
	}
	public String getShift() {
		return shift;
	}
	public void setShift(String shift) {
		this.shift = shift;
	}
	public int getDispatch_idx() {
		return dispatch_idx;
	}
	public void setDispatch_idx(int dispatch_idx) {
		this.dispatch_idx = dispatch_idx;
	}
	public LocalDate getDate() {
		return date;
	}
	public void setDate(LocalDate date) {
		this.date = date;
	}
	public int getDriver_idx() {
		return driver_idx;
	}
	public void setDriver_idx(int driver_idx) {
		this.driver_idx = driver_idx;
	}
	public int getBus_idx() {
		return bus_idx;
	}
	public void setBus_idx(int bus_idx) {
		this.bus_idx = bus_idx;
	}
}
