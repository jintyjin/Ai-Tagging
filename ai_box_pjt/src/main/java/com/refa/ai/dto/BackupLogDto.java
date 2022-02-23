package com.refa.ai.dto;

public class BackupLogDto {
	private int log_idx;
	private String log_time;
	private String log_content;
	private int log_count;
	private String log_taken;
	private String log_size;
	
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
	public String getLog_content() {
		return log_content;
	}
	public void setLog_content(String log_content) {
		this.log_content = log_content;
	}
	public int getLog_count() {
		return log_count;
	}
	public void setLog_count(int log_count) {
		this.log_count = log_count;
	}
	public String getLog_taken() {
		return log_taken;
	}
	public void setLog_taken(String log_taken) {
		this.log_taken = log_taken;
	}
	public String getLog_size() {
		return log_size;
	}
	public void setLog_size(String log_size) {
		this.log_size = log_size;
	}
}
