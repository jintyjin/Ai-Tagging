package com.refa.ai.dto;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class LoginCountDto {
	
	private int count;
	private LocalDateTime disabledTime;
	
	public LoginCountDto(int count) {
		this.count = count;
	}
}
