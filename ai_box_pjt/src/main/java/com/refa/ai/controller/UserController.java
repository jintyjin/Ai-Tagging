package com.refa.ai.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class UserController {

	@GetMapping("/userList")
	public String userList(Model model) {
		return "./user/userList";
	}

	@GetMapping(value = "/userInfo")
	public String userInfo(Model model) {
		return "./user/userInfo";
	}

	@GetMapping(value = "/addUser")
	public String addUser(Model model) {
		return "./user/addUser";
	}

}
