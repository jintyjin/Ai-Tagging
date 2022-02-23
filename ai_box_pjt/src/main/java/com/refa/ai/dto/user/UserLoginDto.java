package com.refa.ai.dto.user;

import com.refa.ai.entity.User;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class UserLoginDto {

	private String user_id;
	private String user_pw;
	
	public UserLoginDto(User user) {
		this.user_id = user.getUser_id();
		this.user_pw = user.getUser_pw();
	}
}
