package com.refa.ai.dto;

import lombok.Data;

@Data
public class ImageTableDto {
	private int image_idx;
	private String login_id;
	private String dev_ch;		// req_info Ω√¿€
	private String dev_pwd;
	private long start_time;
	private String item_name;
	private String dev_ip;
	private String dev_port;
	private String event_time;
	private String dev_id;
	private String dev_web_port;	// req_info ≥°
	private String image_name;
	private String monitoring_tag;
	private String user_name;
	private String user_passwd;
	private int image_queue;
	private String thumb_name;
	private int width;
	private int height;
	private String color_tags;
	private String tags;
	private int limit_num;
	private int row_num;
	
}
