package com.best.calendar;

import java.sql.Date;
import java.sql.Timestamp;

public class HolidayDTO {
	private int holiday_id;
	private Date holiday_date;
	private String holiday_name;
	private Timestamp created_at;
	public int getHoliday_id() {
		return holiday_id;
	}
	public void setHoliday_id(int holiday_id) {
		this.holiday_id = holiday_id;
	}
	public Date getHoliday_date() {
		return holiday_date;
	}
	public void setHoliday_date(Date holiday_date) {
		this.holiday_date = holiday_date;
	}
	public String getHoliday_name() {
		return holiday_name;
	}
	public void setHoliday_name(String holiday_name) {
		this.holiday_name = holiday_name;
	}
	public Timestamp getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	
	
}
