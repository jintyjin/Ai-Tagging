package com.refa.ai.entity;

import lombok.Getter;

@Getter
public class Gallery {
	
	private Long gallery_idx;
	private Long gallery_count;
	private String gallery_size;
	private int dev_ch;
	private String thumb_name;
	private String event_name;
	private String event_time;
	private String dev_title;
	
	public Gallery(Long gallery_count, String gallery_size, int dev_ch, String thumb_name, String event_name,
			String event_time, String dev_title) {
		this.gallery_count = gallery_count;
		this.gallery_size = gallery_size;
		this.dev_ch = dev_ch;
		this.thumb_name = thumb_name;
		this.event_name = event_name;
		this.event_time = event_time;
		this.dev_title = dev_title;
	}

	protected Gallery(Long gallery_idx, Long gallery_count, String gallery_size, int dev_ch, String thumb_name,
			String event_name, String event_time, String dev_title) {
		this.gallery_idx = gallery_idx;
		this.gallery_count = gallery_count;
		this.gallery_size = gallery_size;
		this.dev_ch = dev_ch;
		this.thumb_name = thumb_name;
		this.event_name = event_name;
		this.event_time = event_time;
		this.dev_title = dev_title;
	}
}
