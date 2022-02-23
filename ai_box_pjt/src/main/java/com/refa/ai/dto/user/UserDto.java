package com.refa.ai.dto.user;

import java.time.LocalDateTime;
import java.util.List;

import javax.validation.constraints.NotBlank;

import com.refa.ai.entity.Device;
import com.refa.ai.entity.User;

import lombok.Data;

@Data
public class UserDto {
	
	private Long user_idx;
	@NotBlank
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_phone;
	private String user_email;
	private LocalDateTime user_logindate;
	private LocalDateTime user_joindate;
	private String user_isuse;
	private String user_isadmin;
	private String user_level;
	private String user_tokken;
	private String user_channel;
	private List<Device> devices;

	public UserDto() {
	}

	public UserDto(User user) {
		this.user_idx = user.getUser_idx();
		this.user_id = user.getUser_id();
		this.user_pw = user.getUser_pw();
		this.user_name = user.getUser_name();
		this.user_phone = user.getUser_phone();
		this.user_email = user.getUser_email();
		this.user_logindate = user.getUser_logindate();
		this.user_joindate = user.getUser_joindate();
		this.user_isuse = user.getUser_isuse();
		this.user_isadmin = user.getUser_isadmin();
		this.user_level = user.getUser_level();
		this.user_tokken = user.getUser_tokken();
		this.user_channel = user.getUser_channel();
	}
	
	public void changeDevices(List<Device> devices) {
		this.devices = devices;
	}

}
