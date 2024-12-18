package com.best.bus;

import java.time.LocalDate;

public class BusDTO {
	private int bus_idx; // 버스 ID (Primary Key)
	private String license_plate; // 차량 번호판
	private String route_name; // 버스 번호
	private String drive_status; // 운행 상태
	private LocalDate buy_date; // 구입 날짜
	private String bus_company; // 소속 회사
	private int seat_number; // 좌석 수
	private Double fuel_efficiency; // 연비
	private String bus_type; // 버스 유형
	
	
	
	public String getRoute_name() {
		return route_name;
	}
	public void setRoute_name(String route_name) {
		this.route_name = route_name;
	}
	public int getBus_idx() {
		return bus_idx;
	}
	public void setBus_idx(int bus_idx) {
		this.bus_idx = bus_idx;
	}
	public String getLicense_plate() {
		return license_plate;
	}
	public void setLicense_plate(String license_plate) {
		this.license_plate = license_plate;
	}
	public String getDrive_status() {
		return drive_status;
	}
	public void setDrive_status(String drive_status) {
		this.drive_status = drive_status;
	}
	public LocalDate getBuy_date() {
		return buy_date;
	}
	public void setBuy_date(LocalDate buy_date) {
		this.buy_date = buy_date;
	}
	public String getBus_company() {
		return bus_company;
	}
	public void setBus_conpany(String bus_company) {
		this.bus_company = bus_company;
	}
	public int getSeat_number() {
		return seat_number;
	}
	public void setSeat_number(int seat_number) {
		this.seat_number = seat_number;
	}
	public Double getFuel_efficiency() {
		return fuel_efficiency;
	}
	public void setFuel_efficiency(Double fuel_efficiency) {
		this.fuel_efficiency = fuel_efficiency;
	}
	public String getBus_type() {
		return bus_type;
	}
	public void setBus_type(String bus_type) {
		this.bus_type = bus_type;
	}


}
