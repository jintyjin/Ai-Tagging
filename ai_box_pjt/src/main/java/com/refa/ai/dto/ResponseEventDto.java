package com.refa.ai.dto;

import java.util.List;

import lombok.Data;

@Data
public class ResponseEventDto {

	private String base64;
	private MetadataDto metadata;
	private List<MlResultDto> ml_result;
	
}
