package com.refa.ai.dto.device;

import java.util.ArrayList;
import java.util.List;

import com.refa.ai.dto.MetadataDto;
import com.refa.ai.dto.action.EventInfoDto;

import lombok.Data;

@Data
public class DeviceCmdDto {
	
	private String command;
	private int cmd_type;
	private List<Integer> ch = new ArrayList<Integer>();
	private String ver;
	private MetadataDto metadata;
	private List<EventInfoDto> event_info_list = new ArrayList<EventInfoDto>();
	
}
