package com.refa.ai.dto;

public class ImageDto {
	private int image_idx;
	private String image_json;
	// 장비 및 채널 정보 추가 예정
	
	public int getImage_idx() {
		return image_idx;
	}
	public void setImage_idx(int image_idx) {
		this.image_idx = image_idx;
	}
	public String getImage_json() {
		return image_json;
	}
	public void setImage_json(String image_json) {
		this.image_json = image_json;
	}
}
