package com.refa.ai.dto.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import lombok.Data;

@Data
public class EventInfoDto {
	
	private int ch;
	private List<String> event_list = new ArrayList<String>();
	private List<String> rtsp_url = new ArrayList<String>();
	private String id;
	private String key;
	List<List<List<Integer>>> loitering_areas = new ArrayList<List<List<Integer>>>();
	List<List<List<Integer>>> invasion_areas = new ArrayList<List<List<Integer>>>();
	List<List<List<Integer>>> panel_areas = new ArrayList<List<List<Integer>>>();
	
	public EventInfoDto(ActionDeviceDto actionDeviceDto) {
		this.ch = actionDeviceDto.getDev_ch();
		
		if (actionDeviceDto.getAction_fire() == 0) {
			event_list.add("kwater_fire");
		}
		if (actionDeviceDto.getAction_falldown() == 0) {
			event_list.add("kwater_falldown");
		}
		if (actionDeviceDto.getActopm_flood() == 0) {
			event_list.add("kwater_flood");
		}
		if (actionDeviceDto.getAction_glove() == 0) {
			event_list.add("kwater_glove");
		}
		if (actionDeviceDto.getAction_invasion() == 0) {
			event_list.add("kwater_invasion");
		}
		if (actionDeviceDto.getActopm_leak() == 0) {
			event_list.add("kwater_leak");
		}
		if (actionDeviceDto.getAction_loitering() == 0) {
			event_list.add("kwater_loitering");
		}
		if (actionDeviceDto.getAction_handaction() == 0) {
			event_list.add("kwater_handaction");
		}
		if (actionDeviceDto.getAction_spin() == 0) {
			event_list.add("kwater_spin");
		}
		
		String rtsp_url = actionDeviceDto.getDev_rtsp_url().substring(1, actionDeviceDto.getDev_rtsp_url().length() - 1);
		
		if (rtsp_url.length() > 0) {
			this.rtsp_url = Arrays.asList(rtsp_url.split(","));
		}
		
		this.id = actionDeviceDto.getDev_id();
		this.key = actionDeviceDto.getDev_pwd();
	}
}
