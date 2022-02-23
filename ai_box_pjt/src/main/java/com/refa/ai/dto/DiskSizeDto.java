package com.refa.ai.dto;

public class DiskSizeDto {
	private String drive_name;
	private double total_space;
	private double usable_space;
	private double free_space;
	private double used_space;
	public String getDrive_name() {
		return drive_name;
	}
	public void setDrive_name(String drive_name) {
		this.drive_name = drive_name;
	}
	public double getUsable_space() {
		return usable_space;
	}
	public void setUsable_space(double usable_space) {
		this.usable_space = usable_space;
	}
	public double getFree_space() {
		return free_space;
	}
	public void setFree_space(double free_space) {
		this.free_space = free_space;
	}
	public double getUsed_space() {
		return used_space;
	}
	public void setUsed_space(double used_space) {
		this.used_space = used_space;
	}
	public double getTotal_space() {
		return total_space;
	}
	public void setTotal_space(double total_space) {
		this.total_space = total_space;
	}
	
	
}
