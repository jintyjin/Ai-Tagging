package com.refa.ai.dto.gallery;

import lombok.Data;

@Data
public class GalleryMonitoringDto {

	private String event_time;
	private Integer dev_ch;
	private Long count;
	private Long image_idx;
	private String thumb_name;
	
}
