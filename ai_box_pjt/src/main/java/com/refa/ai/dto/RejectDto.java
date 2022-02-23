package com.refa.ai.dto;

import java.util.Date;
import java.util.Map;

import lombok.Data;

@Data
public class RejectDto {
	private int dev_ch;
	private boolean KWATER_Falldown_Detection;
	private boolean KWATER_Fire_Detection;
	private boolean KWATER_Flood_Detection;
	private boolean KWATER_Glove_Detection;
	private boolean KWATER_Invasion_Detection;
	private boolean KWATER_Leak_Detection;
	private boolean KWATER_Loitering_Detection;
	private boolean KWATER_HandAction_Detection;
	private boolean KWATER_Spin_Detection;
	private Map<String, Date> date_time;
}
