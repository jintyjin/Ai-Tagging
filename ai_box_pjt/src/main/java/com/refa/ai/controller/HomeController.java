package com.refa.ai.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

	@GetMapping("/login")
	public String login(Model model) {
		return "login";
	}

	@GetMapping("/index")
	public String index(Model model) {
		return "index";
	}

	@GetMapping("/popUpImage")
	public String popUpImage(Model model, String src, String width, String height, String event_name, String dev_ip) {
		String title = src.split("/")[3] + "(" + dev_ip + ")" + " " + src.split("/")[5].split("_")[0] + " "
				+ src.split("/")[4].substring(0, 4) + "-" + src.split("/")[4].substring(4, 6) + "-"
				+ src.split("/")[4].substring(6, 8) + " " + src.split("/")[5].split("_")[1].substring(0, 2) + ":"
				+ src.split("/")[5].split("_")[1].substring(2, 4) + ":"
				+ src.split("/")[5].split("_")[1].substring(4, 6) + " " + event_name;
		
		model.addAttribute("src", src);
		model.addAttribute("width", width);
		model.addAttribute("height", height);
		model.addAttribute("title", title);

		return "popUpImage";
	}

}
