package com.best.bus;

import java.math.BigDecimal;
import java.time.LocalDate;

public class BusDTO {
	private String bus_idx; // 버스 ID (Primary Key)
	private String license_plate; // 차량 번호판
	private int bus_number; // 버스 번호
	private String drive_status; // 운행 상태
	private LocalDate buy_date; // 구입 날짜
	private String bus_conpany; // 소속 회사
	private int seat_number; // 좌석 수
	private BigDecimal fuel_efficiency; // 연비
	private String depot_location; // 차고지 위치
	private String bus_type; // 버스 유형
	public String getBus_idx() {
		return bus_idx;
	}
	public void setBus_idx(String bus_idx) {
		this.bus_idx = bus_idx;
	}
	public String getLicense_plate() {
		return license_plate;
	}
	public void setLicense_plate(String license_plate) {
		this.license_plate = license_plate;
	}
	public int getBus_number() {
		return bus_number;
	}
	public void setBus_number(int bus_number) {
		this.bus_number = bus_number;
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
	public String getBus_conpany() {
		return bus_conpany;
	}
	public void setBus_conpany(String bus_conpany) {
		this.bus_conpany = bus_conpany;
	}
	public int getSeat_number() {
		return seat_number;
	}
	public void setSeat_number(int seat_number) {
		this.seat_number = seat_number;
	}
	public BigDecimal getFuel_efficiency() {
		return fuel_efficiency;
	}
	public void setFuel_efficiency(BigDecimal fuel_efficiency) {
		this.fuel_efficiency = fuel_efficiency;
	}
	public String getDepot_location() {
		return depot_location;
	}
	public void setDepot_location(String depot_location) {
		this.depot_location = depot_location;
	}
	public String getBus_type() {
		return bus_type;
	}
	public void setBus_type(String bus_type) {
		this.bus_type = bus_type;
	}


}
