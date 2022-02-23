package com.refa.ai.dto;

import java.util.List;

import lombok.Data;

@Data
public class SegmentsDto {

	//private String class;		// 보류
	private List<List<Double>> vector;	// 2중 배열
	private Double confidence;
	
}
