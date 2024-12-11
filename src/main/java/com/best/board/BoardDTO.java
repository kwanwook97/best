package com.best.board;

import java.time.LocalDateTime;

public class BoardDTO {
	private int board_idx; // 게시판 ID (Primary Key, AUTO_INCREMENT)
	private Integer board_category; // 게시판 카테고리
	private String subject; // 게시글 제목
	private String content; // 게시글 내용
	private Integer emp_idx; // 작성자 직원 ID
	private String name; // 작성자 이름
	private LocalDateTime date; // 작성일 (TIMESTAMP)
	private Integer bhit; // 조회수
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public Integer getBoard_category() {
		return board_category;
	}
	public void setBoard_category(Integer board_category) {
		this.board_category = board_category;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getEmp_idx() {
		return emp_idx;
	}
	public void setEmp_idx(Integer emp_idx) {
		this.emp_idx = emp_idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public LocalDateTime getDate() {
		return date;
	}
	public void setDate(LocalDateTime date) {
		this.date = date;
	}
	public Integer getBhit() {
		return bhit;
	}
	public void setBhit(Integer bhit) {
		this.bhit = bhit;
	}


}
