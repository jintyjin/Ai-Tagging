package com.refa.ai.dto;

import java.util.List;

import lombok.Data;

@Data
public class SegmentsDto {

	//private String class;		// ����
	private List<List<Double>> vector;	// 2�� �迭
	private Double confidence;
	
}
