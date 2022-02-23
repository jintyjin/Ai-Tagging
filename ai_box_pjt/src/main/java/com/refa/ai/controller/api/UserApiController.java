package com.refa.ai.controller.api;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.refa.ai.dto.user.UserDto;
import com.refa.ai.dto.user.UserLoginDto;
import com.refa.ai.dto.user.UserSaveDto;
import com.refa.ai.service.UserService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class UserApiController {

	private final UserService userService;

	// ���ԵǾ��ִ� �� Ȯ���ϰ� �α��� ������
	@PostMapping("/loginList")
	public Map loginList(@RequestBody UserLoginDto userLoginDto) {
		return userService.login(userLoginDto);
	}
	
	// Ż������ ���� ����� ���
	@PostMapping("/userList")
	public List<UserDto> userList(@RequestBody String isUse) {
		return userService.userList(isUse);
	}
	
	// ������ ������� ���� ������
	@PostMapping("/userInfo")
	public UserDto userInfo(@RequestBody String userId) {
		return userService.userInfo(userId);
	}
	
	// ���̵� �ߺ� �˻�
	@PostMapping(value = "/chkUserId")
	public String chkUserId(@RequestBody String userId) {
		return userService.chkUserId(userId);
	}
	
	// ����� �߰�
	@PostMapping("/addUser")
	public void addUser(@RequestBody UserSaveDto userSaveDto) {
		userService.save(userSaveDto);
	}
	
	
}
