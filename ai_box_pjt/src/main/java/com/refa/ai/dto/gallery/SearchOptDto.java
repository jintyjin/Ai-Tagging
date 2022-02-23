package com.refa.ai.dto.gallery;

import lombok.Data;

@Data
public class SearchOptDto {
	
	private Long image_idx;
	private String keyword;
	private String status;
	private Long offset;
}
