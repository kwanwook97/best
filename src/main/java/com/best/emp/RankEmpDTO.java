package com.best.emp;

public class RankEmpDTO {
    private int rank_idx;      // 직급 ID
    private String rank_name;  // 직급 이름
    private int role_idx;      // 역할 ID
    private int position_idx;      // 직책 ID
    
	public int getRank_idx() {
		return rank_idx;
	}
	public void setRank_idx(int rank_idx) {
		this.rank_idx = rank_idx;
	}
	public String getRank_name() {
		return rank_name;
	}
	public void setRank_name(String rank_name) {
		this.rank_name = rank_name;
	}
	public int getRole_idx() {
		return role_idx;
	}
	public void setRole_idx(int role_idx) {
		this.role_idx = role_idx;
	}
	public int getPosition_idx() {
		return position_idx;
	}
	public void setPosition_idx(int position_idx) {
		this.position_idx = position_idx;
	}
	
    
}
