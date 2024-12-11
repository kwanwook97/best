package com.best.bus;

public class FareDTO {
	private int fare_idx; // 요금 ID (Primary Key, AUTO_INCREMENT)
	private String bus_type; // 버스 유형
	private String age_group; // 연령 그룹
	private int amount; // 요금 금액
	public int getFare_idx() {
		return fare_idx;
	}
	public void setFare_idx(int fare_idx) {
		this.fare_idx = fare_idx;
	}
	public String getBus_type() {
		return bus_type;
	}
	public void setBus_type(String bus_type) {
		this.bus_type = bus_type;
	}
	public String getAge_group() {
		return age_group;
	}
	public void setAge_group(String age_group) {
		this.age_group = age_group;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}


}
