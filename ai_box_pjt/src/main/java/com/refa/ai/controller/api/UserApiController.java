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

	// 가입되어있는 지 확인하고 로그인 시켜줌
	@PostMapping("/loginList")
	public Map loginList(@RequestBody UserLoginDto userLoginDto) {
		return userService.login(userLoginDto);
	}
	
	// 탈퇴하지 않은 사용자 목록
	@PostMapping("/userList")
	public List<UserDto> userList(@RequestBody String isUse) {
		return userService.userList(isUse);
	}
	
	// 선택한 사용자의 정보 보여줌
	@PostMapping("/userInfo")
	public UserDto userInfo(@RequestBody String userId) {
		return userService.userInfo(userId);
	}
	
	// 아이디 중복 검사
	@PostMapping(value = "/chkUserId")
	public String chkUserId(@RequestBody String userId) {
		return userService.chkUserId(userId);
	}
	
	// 사용자 추가
	@PostMapping("/addUser")
	public void addUser(@RequestBody UserSaveDto userSaveDto) {
		userService.save(userSaveDto);
	}
	
	
}
