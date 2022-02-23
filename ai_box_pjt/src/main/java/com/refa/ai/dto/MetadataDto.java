package com.refa.ai.dto;

import java.util.ArrayList;
import java.util.List;

import com.refa.ai.dto.action.EventInfoDto;

import lombok.Data;

@Data
public class MetadataDto {
	
	private String user_name;
	private String user_passwd;
	private String dev_ip;
	private String dev_port;
	private String dev_web_port;
	private String dev_id;
	private String dev_pwd;
	private Long start;
	private String img_name;
	private String item_name;
	private String dev_ch;
	private String event_time;
	private List<EventInfoDto> event_info_list = new ArrayList<EventInfoDto>();
	private List<List<List<Integer>>> loitering_areas = new ArrayList<List<List<Integer>>>();
	private List<List<List<Integer>>> invasion_areas = new ArrayList<List<List<Integer>>>();
	private List<List<List<Integer>>> panel_areas = new ArrayList<List<List<Integer>>>();
	private String ver;
	private String lkey;
	
}
