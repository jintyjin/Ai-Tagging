package com.refa.ai.dto.dashboard;

import lombok.Data;

@Data
public class EventCountTimeDto {
	
	private String time;
	private String event;
	private Long count;
	private Long idx;

}
