package com.refa.ai.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EventStatusController {

	@GetMapping(value = "/rejectTimeSetup")
	public String rejectTimeSetup(Model model, String row, String dev_ch, String dev_title, String model_name,
			String event_time) {
		// System.out.println("rejectTimeSetup()");

		model.addAttribute("row", row);
		model.addAttribute("dev_ch", dev_ch);
		model.addAttribute("dev_title", dev_title);
		model.addAttribute("model_name", model_name);
		model.addAttribute("event_time", event_time);

		return "./event/eventStatus/rejectTimeSetup";
	}
	
}
