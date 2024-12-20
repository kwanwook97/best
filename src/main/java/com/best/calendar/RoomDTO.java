package com.best.calendar;

public class RoomDTO {
	private int room_idx;
	private String name;
	private String photo;
	private int max_capacity;
	
	
	public int getMax_capacity() {
		return max_capacity;
	}
	public void setMax_capacity(int max_capacity) {
		this.max_capacity = max_capacity;
	}
	public int getRoom_idx() {
		return room_idx;
	}
	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	
}
