package com.refa.ai.entity;

import java.time.LocalDateTime;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Device {
	
	private Long dev_idx;
	private String dev_type;
	private int dev_ch;
	private String dev_title;
	private String dev_ip;
	private String dev_web_port;
	private String dev_app_port;
	private String dev_enable_https;
	private String login_id;
	private String dev_pwd;
	private String dev_mac_address;
	private String dev_model_name;
	private LocalDateTime dev_join_time;
	private String dev_isconnect;
	private String dev_rtsp;
	private String dev_id;
	private String dev_rtsp_url;
	private String dev_group;
	
	private String dev_fire;
	private String dev_falldown;
	private String dev_flood;
	private String dev_glove;
	private String dev_invasion;
	private String dev_leak;
	private String dev_loitering;
	private String dev_handaction;
	private String dev_spin;
	private String dev_cmtank;
	private String dev_outtank;
	private String dev_overflow;
	
}
