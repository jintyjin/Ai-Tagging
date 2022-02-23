package com.refa.ai.dto.user;

import lombok.Data;

@Data
public class UserSaveDto {
	
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_phone;
	private String user_email;
	private String user_isadmin;
	private String user_tokken;
	private String user_tokkenIsuse;
	private String user_channel;
	
}
