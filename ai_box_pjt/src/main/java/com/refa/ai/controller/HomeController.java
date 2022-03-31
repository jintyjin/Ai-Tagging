package com.refa.ai.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.refa.ai.dto.user.UserLoginDto;
import com.refa.ai.entity.User;
import com.refa.ai.infra.SessionConst;
import com.refa.ai.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HomeController {

	private final UserRepository userRepository;
	
	@GetMapping("/login")
	public String login(Model model) {
		return "login";
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute UserLoginDto userLoginDto, HttpServletRequest request) {
		User user = userRepository.login(new User(userLoginDto.getUser_id(), userLoginDto.getUser_pw()));
		
		if (user == null) {
			return "index";
		}
		
		HttpSession session = request.getSession();
		session.setAttribute(SessionConst.LOGIN_MEMBER, user);
		
		return "redirect:/index";
	}

	@PostMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		
		return "redirect:/index";
	}
	
	@GetMapping("/index")
	public String index(@SessionAttribute(name = SessionConst.LOGIN_MEMBER, required = false) User user, Model model) {
		model.addAttribute("user", user);
		
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
