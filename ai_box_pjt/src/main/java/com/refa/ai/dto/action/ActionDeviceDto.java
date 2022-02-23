package com.refa.ai.dto.action;

import lombok.Data;

@Data
public class ActionDeviceDto {
	
	private int dev_ch;
	private int action_fire;
	private int action_falldown;
	private int actopm_flood;
	private int action_glove;
	private int action_invasion;
	private int actopm_leak;
	private int action_loitering;
	private int action_handaction;
	private int action_spin;
	private String dev_rtsp_url;
	private String dev_id;
	private String dev_pwd;
}
