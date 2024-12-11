package com.best.emp;

import java.sql.Date;

public class DriverDTO {

	private int driver_idx; // 운전자 ID (Primary Key, AUTO_INCREMENT)
	private int emp_idx; // 직원 ID
	private String license; // 운전면허 번호
	private Date license_period; // 면허 유효 기간
	private String certificate; // 자격증 번호
	public int getDriverIdx() {
		return driver_idx;
	}
	public void setDriverIdx(int driverIdx) {
		this.driver_idx = driverIdx;
	}
	public int getEmpIdx() {
		return emp_idx;
	}
	public void setEmpIdx(int empIdx) {
		this.emp_idx = empIdx;
	}
	public String getLicense() {
		return license;
	}
	public void setLicense(String license) {
		this.license = license;
	}
	public Date getLicensePeriod() {
		return license_period;
	}
	public void setLicensePeriod(Date licensePeriod) {
		this.license_period = licensePeriod;
	}
	public String getCertificate() {
		return certificate;
	}
	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}
	
	
}
