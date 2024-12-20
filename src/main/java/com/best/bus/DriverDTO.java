package com.best.bus;

import java.sql.Date;

public class DriverDTO {
	private int driver_idx; // 운전자 ID (Primary Key, AUTO_INCREMENT)
	private int emp_idx; // 직원 ID
	private String license; // 운전면허 번호
	private Date license_period; // 면허 유효 기간
	private String certificate; // 자격증 번호
	private String route_name;
	
	
	
	public String getRoute_name() {
		return route_name;
	}
	public void setRoute_name(String route_name) {
		this.route_name = route_name;
	}
	public int getDriver_idx() {
		return driver_idx;
	}
	public void setDriver_idx(int driver_idx) {
		this.driver_idx = driver_idx;
	}
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public String getLicense() {
		return license;
	}
	public void setLicense(String license) {
		this.license = license;
	}
	public Date getLicense_period() {
		return license_period;
	}
	public void setLicense_period(Date license_period) {
		this.license_period = license_period;
	}
	public String getCertificate() {
		return certificate;
	}
	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}

	
}
