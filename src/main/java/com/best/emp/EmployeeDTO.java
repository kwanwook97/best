package com.best.emp;

import java.sql.Date;

public class EmployeeDTO {
    private int emp_idx; // 직원 ID (Primary Key)
    private int parent_emp_idx; // 상위 직원 ID
    private String photo; // 사진 URL 또는 경로
    private String name; // 직원 이름
    private char gender; // 성별 ('M', 'F')
    private String resident_number; // 주민등록번호
    private String address; // 주소
    private String account_number; // 계좌번호
    private int salary; // 급여
    private String email; // 이메일
    private String phone; // 전화번호
    private Date start_date; // 시작일
    private Date end_date; // 종료일 (기본값: 9999-12-31)
    private Boolean enable; // 활성화 상태
    private Boolean state; // 상태
    private String mobile; // 휴대폰 번호
    private int rank_idx; // 직급 ID
    private int depart_idx; // 부서 ID
    private String sign; // 서명
    
	public int getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(int emp_idx) {
		this.emp_idx = emp_idx;
	}
	public int getParent_emp_idx() {
		return parent_emp_idx;
	}
	public void setParent_emp_idx(int parent_emp_idx) {
		this.parent_emp_idx = parent_emp_idx;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public char getGender() {
		return gender;
	}
	public void setGender(char gender) {
		this.gender = gender;
	}
	public String getResident_number() {
		return resident_number;
	}
	public void setResident_number(String resident_number) {
		this.resident_number = resident_number;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAccount_number() {
		return account_number;
	}
	public void setAccount_number(String account_number) {
		this.account_number = account_number;
	}
	public int getSalary() {
		return salary;
	}
	public void setSalary(int salary) {
		this.salary = salary;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public Boolean getEnable() {
		return enable;
	}
	public void setEnable(Boolean enable) {
		this.enable = enable;
	}
	public Boolean getState() {
		return state;
	}
	public void setState(Boolean state) {
		this.state = state;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public int getRank_idx() {
		return rank_idx;
	}
	public void setRank_idx(int rank_idx) {
		this.rank_idx = rank_idx;
	}
	public int getDepart_idx() {
		return depart_idx;
	}
	public void setDepart_idx(int depart_idx) {
		this.depart_idx = depart_idx;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}

}
