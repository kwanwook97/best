package com.best.bus;

import java.time.LocalTime;

public class RouteDTO {
	private int route_idx; // 노선 ID (Primary Key, AUTO_INCREMENT)
	private String route_name; // 노선 이름
	private String start_area; // 출발 지역
	private String end_area; // 도착 지역
	private int operate_time; // 운행 시간 (정수형, NOT NULL)
	private int drive_distance; // 운행 거리 (정수형, NOT NULL)
	private LocalTime first_time; // 첫차 시간 (TIMESTAMP)
	private LocalTime last_time; // 막차 시간 (TIMESTAMP)
	private String bus_id;
	private int oper_count;
	
	
	public int getOper_count() {
		return oper_count;
	}
	public void setOper_count(int oper_count) {
		this.oper_count = oper_count;
	}
	public int getRoute_idx() {
		return route_idx;
	}
	public void setRoute_idx(int route_idx) {
		this.route_idx = route_idx;
	}
	public String getRoute_name() {
		return route_name;
	}
	public void setRoute_name(String route_name) {
		this.route_name = route_name;
	}
	public String getStart_area() {
		return start_area;
	}
	public void setStart_area(String start_area) {
		this.start_area = start_area;
	}
	public String getEnd_area() {
		return end_area;
	}
	public void setEnd_area(String end_area) {
		this.end_area = end_area;
	}
	public int getOperate_time() {
		return operate_time;
	}
	public void setOperate_time(int operate_time) {
		this.operate_time = operate_time;
	}
	public int getDrive_distance() {
		return drive_distance;
	}
	public void setDrive_distance(int drive_distance) {
		this.drive_distance = drive_distance;
	}
	public LocalTime getFirst_time() {
		return first_time;
	}
	public void setFirst_time(LocalTime first_time) {
		this.first_time = first_time;
	}
	public LocalTime getLast_time() {
		return last_time;
	}
	public void setLast_time(LocalTime last_time) {
		this.last_time = last_time;
	}
	public String getBus_id() {
		return bus_id;
	}
	public void setBus_id(String bus_id) {
		this.bus_id = bus_id;
	}
	


}
