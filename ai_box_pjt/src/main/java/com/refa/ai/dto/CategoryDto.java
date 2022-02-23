package com.refa.ai.dto;

public class CategoryDto {
	private int category_idx;
	private String category_small;
	private String category_middle;
	private String category_big;
	private String login_id;
	
	public String getCategory_small() {
		return category_small;
	}
	public void setCategory_small(String category_small) {
		this.category_small = category_small;
	}
	public String getCategory_big() {
		return category_big;
	}
	public void setCategory_big(String category_big) {
		this.category_big = category_big;
	}
	public String getLogin_id() {
		return login_id;
	}
	public void setLogin_id(String login_id) {
		this.login_id = login_id;
	}
	public String getCategory_middle() {
		return category_middle;
	}
	public void setCategory_middle(String category_middle) {
		this.category_middle = category_middle;
	}
	public int getCategory_idx() {
		return category_idx;
	}
	public void setCategory_idx(int category_idx) {
		this.category_idx = category_idx;
	}
}
