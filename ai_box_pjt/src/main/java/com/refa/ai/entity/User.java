package com.refa.ai.entity;


import java.time.LocalDateTime;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class User {
	
	private Long user_idx;
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_phone;
	private String user_address;
	private String user_email;
	private LocalDateTime user_logindate;
	private LocalDateTime user_joindate;
	private String user_isuse;
	private String user_isadmin;
	private String user_level;
	private String user_tokken;
	private String user_tokken_isuse;
	private String user_setup;
	private String user_channel;

	public User(String user_id, String user_pw) {
		this.user_id = user_id;
		this.user_pw = user_pw;
	}
	
	public User(Long user_idx, String user_id, String user_pw, String user_name, String user_phone, String user_address,
			String user_email, LocalDateTime user_logindate, LocalDateTime user_joindate, String user_isuse,
			String user_isadmin, String user_level, String user_tokken, String user_tokken_isuse, String user_setup,
			String user_channel) {
		this.user_idx = user_idx;
		this.user_id = user_id;
		this.user_pw = user_pw;
		this.user_name = user_name;
		this.user_phone = user_phone;
		this.user_address = user_address;
		this.user_email = user_email;
		this.user_logindate = user_logindate;
		this.user_joindate = user_joindate;
		this.user_isuse = user_isuse;
		this.user_isadmin = user_isadmin;
		this.user_level = user_level;
		this.user_tokken = user_tokken;
		this.user_tokken_isuse = user_tokken_isuse;
		this.user_setup = user_setup;
		this.user_channel = user_channel;
	}
}
