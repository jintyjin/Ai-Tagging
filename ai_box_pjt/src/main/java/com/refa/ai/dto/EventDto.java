package com.refa.ai.dto;

import lombok.Data;

@Data
public class EventDto {
	private int data_idx;
	private String item_type;
	private String item_name;
	private String item_mac;
	private String item_ip;
	private String item_id;
	private String item_pwd;
	private String item_port;
	private String dev_ip;
	private String dev_mac;
	private String dev_id;
	private String dev_pwd;
	private String dev_port;
	private String dev_web_port;
	private String dev_channel;
	private String user_id;
	private String event_name;
	private String event_info;
	private String event_time;
	private String event_isCheck;
	private String image_name;
	private String img_data;
	private String img_type;
	private String is_data;
	private String event_source;
	private double event_confidence;
	
}
