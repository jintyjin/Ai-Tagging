package com.refa.ai.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashBoardController {

	@GetMapping(value = "/main")
	public String main(Model model) {
		return "./dashboard/main";
	}
	
	@GetMapping("/dashBoard")
	public String dashBoard(Model model) {
		return "./dashboard/dashBoard";
	}
	
}
