package com.refa.ai.dto;

import java.util.List;

import lombok.Data;

@Data
public class MlResultDto {
	private String model_name;
	private String status;
	private Integer count;
	private List<SegmentsDto> segments;
	private List<BoxesDto> boxes;
}
