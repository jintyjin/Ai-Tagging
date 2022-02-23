package com.refa.ai.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.refa.ai.dto.user.UserDto;
import com.refa.ai.dto.user.UserLoginDto;
import com.refa.ai.dto.user.UserSaveDto;
import com.refa.ai.entity.Device;
import com.refa.ai.entity.User;
import com.refa.ai.repository.DeviceRepository;
import com.refa.ai.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {
	
	private final UserRepository userRepository;
	private final DeviceRepository deviceRepository;
	
	public Map login(UserLoginDto userLoginDto) {
		Map map = new HashMap();
		
		User user = userRepository.findById(userLoginDto.getUser_id());
		
		if (user != null && user.getUser_pw().equals(userLoginDto.getUser_pw())) {
			userRepository.updateLoginDate(user.getUser_id());
			map = new ObjectMapper().convertValue(user, Map.class);
			map.put("return", "success");
			return map;
		}
		
		map.put("return", "incorrect");
		
		return map;
	}

	public void save(UserSaveDto userSaveDto) {
		User user = new User(
				null, userSaveDto.getUser_id(), userSaveDto.getUser_pw(), userSaveDto.getUser_name(), userSaveDto.getUser_phone(), null,
				userSaveDto.getUser_email(), null, null, null,
				userSaveDto.getUser_isadmin(), null, userSaveDto.getUser_tokken(), userSaveDto.getUser_tokkenIsuse(), null,
				userSaveDto.getUser_channel()
			);
		
		userRepository.save(user);
	}
	
	public UserDto userInfo(String userId) {
		User user = userRepository.findById(userId);
		
		UserDto userDto = new UserDto(user);

		List<Device> devices = deviceRepository.findAll();
		
		userDto.changeDevices(devices);

		return userDto;	
	}

	public String chkUserId(String userId) {
		User user = userRepository.findById(userId);
		
		if (user == null) {
			return null;
		}

		return userId;
	}

	public List<UserDto> userList(String isUse) {
		List<User> list = userRepository.findByIsUse(isUse);
		return list.stream()
			.map(UserDto::new)
			.collect(Collectors.toList());
	}

}
