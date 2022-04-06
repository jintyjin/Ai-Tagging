package com.refa.ai.controller;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.refa.ai.dto.user.UserLoginDto;
import com.refa.ai.entity.User;
import com.refa.ai.infra.SessionConst;
import com.refa.ai.repository.LoginCountRepository;
import com.refa.ai.repository.UserRepository;
import com.refa.ai.service.LoginCountService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HomeController {

	private final UserRepository userRepository;
	private final LoginCountRepository loginCountRepository;
	private final LoginCountService loginCountService;
	
	@GetMapping("/login")
	public String login(Model model) {
		return "login";
	}
	
	@PostMapping("/login")
	public String login(@ModelAttribute UserLoginDto userLoginDto, HttpServletRequest request, RedirectAttributes redirectAttribute) {
		String userId = userLoginDto.getUser_id();
		String userPw = userLoginDto.getUser_pw();

		if (userRepository.checkId(userId) == null) {
			redirectAttribute.addFlashAttribute("noLoginId", true);
			return "redirect:/index";
		}
		
		User user = userRepository.checkPw(new User(userId, userPw));
		LocalDateTime now = LocalDateTime.now();
		
		if (user == null) {
			if (!loginCountService.addAndCheckDisabled(userId)) {
				redirectAttribute.addFlashAttribute("isDisabled", !loginCountService.addAndCheckDisabled(userId));
				
				Duration duration = Duration.between(now, loginCountRepository.getDisabledTime(userId));
				redirectAttribute.addFlashAttribute("disabledTime", duration.getSeconds() / 60);
			} else {
				int loginCount = loginCountRepository.getLoginCount(userId);
				redirectAttribute.addFlashAttribute("loginCount", loginCount);
			}
			return "redirect:/index";
		}
		
		if (loginCountRepository.isDisabled(userId)) {
			if (loginCountRepository.getDisabledTime(userId).isEqual(now) || loginCountRepository.getDisabledTime(userId).isBefore(now) && user != null) {
				loginCountRepository.initAll(userId);

				HttpSession session = request.getSession();
				session.setAttribute(SessionConst.LOGIN_MEMBER, user);
				
				return "redirect:/index";
			}

			redirectAttribute.addFlashAttribute("isDisabled", true);
			
			Duration duration = Duration.between(now, loginCountRepository.getDisabledTime(userId));
			redirectAttribute.addFlashAttribute("disabledTime", duration.getSeconds() / 60);
			
			return "redirect:/index";
		}
		
		HttpSession session = request.getSession();
		session.setAttribute(SessionConst.LOGIN_MEMBER, user);

		loginCountRepository.initAll(userId);
		
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
	
	@GetMapping(value = {"/index/{pageUrl}", "/index"})
	public String index(@PathVariable(required = false) String pageUrl, @SessionAttribute(name = SessionConst.LOGIN_MEMBER, required = false) User user, Model model) {
		model.addAttribute("user", user);
		if (pageUrl == null) {
			pageUrl = "dashBoard";
		}
		model.addAttribute("pageUrl", pageUrl);
		
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
