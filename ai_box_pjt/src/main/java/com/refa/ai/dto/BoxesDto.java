package com.refa.ai.dto;

import java.util.List;

import lombok.Data;

@Data
public class BoxesDto {
	
//	private String class	// ����
	private List<Integer> xyxy;
	private Double confidence;
}
