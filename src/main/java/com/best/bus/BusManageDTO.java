package com.best.bus;

import java.time.LocalDate;

public class BusManageDTO {
	private int bus_manage_idx; // 관리 ID (Primary Key, AUTO_INCREMENT)
	private int bus_idx; // 버스 ID
	private int emp_idx; // 직원 ID
	private double distance; // 운행 거리
	private String content; // 내용
	private LocalDate inspect_date; // 점검 날짜
	private LocalDate next_inspect_date; // 다음 점검 날짜
	private int amount; // 비용
	private String status; // 상태

	
	
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getBus_manage_idx() {
		return bus_manage_idx;
	}
	public void setBus_manage_idx(int bus_manage_idx) {
		this.bus_manage_idx = bus_manage_idx;
	}
	public int getBus_idx() {
		return bus_idx;
	}
	public void setBus_idx(int bus_idx) {
		this.bus_idx = bus_idx;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public double getDistance() {
		return distance;
	}
	public void setDistance(double distance) {
		this.distance = distance;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public LocalDate getInspect_date() {
		return inspect_date;
	}
	public void setInspect_date(LocalDate inspect_date) {
		this.inspect_date = inspect_date;
	}
	public LocalDate getNext_inspect_date() {
		return next_inspect_date;
	}
	public void setNext_inspect_date(LocalDate next_inspect_date) {
		this.next_inspect_date = next_inspect_date;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

}
