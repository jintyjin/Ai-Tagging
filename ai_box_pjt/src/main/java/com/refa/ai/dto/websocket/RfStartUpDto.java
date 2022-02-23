package com.refa.ai.dto.websocket;

import lombok.Data;

@Data
public class RfStartUpDto {
	
	private String command;
	private String sender;
	private String ver;
	private String lkey;
	private String status;

}
