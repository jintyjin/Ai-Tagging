package com.refa.ai.dto;

public class ErrorLogDto {
	private int log_idx;
	private String log_time;
	private String log_place;
	private String log_content;
	public int getLog_idx() {
		return log_idx;
	}
	public void setLog_idx(int log_idx) {
		this.log_idx = log_idx;
	}
	public String getLog_time() {
		return log_time;
	}
	public void setLog_time(String log_time) {
		this.log_time = log_time;
	}
	public String getLog_place() {
		return log_place;
	}
	public void setLog_place(String log_place) {
		this.log_place = log_place;
	}
	public String getLog_content() {
		return log_content;
	}
	public void setLog_content(String log_content) {
		this.log_content = log_content;
	}
}
