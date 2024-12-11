package com.best.bus;

import java.sql.Date;

public class CustomerDTO {
	private int route_idx; // 경로 ID
	private int count; // 승객 수
	private Date date; // 날짜
	public int getRoute_idx() {
		return route_idx;
	}
	public void setRoute_idx(int route_idx) {
		this.route_idx = route_idx;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}


	
}
