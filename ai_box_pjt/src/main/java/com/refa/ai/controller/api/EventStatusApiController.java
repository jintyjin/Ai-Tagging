package com.refa.ai.controller.api;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.refa.ai.service.EventStatusService;
import com.refa.ai.service.RejectEventService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class EventStatusApiController {
	
	private final RejectEventService rejectEventService;
	private final EventStatusService eventStatusService;

	@PostMapping(value = "/rejectTimeSetup")
	public Map rejectTimeSetup(@RequestBody Map<String, String> login) throws java.text.ParseException {
		// System.out.println("rejectTimeSetup()");

		int dateTime = Integer.parseInt(login.get("datetime"));
		int dev_ch = Integer.parseInt(login.get("dev_ch"));
		String model_name = login.get("model_name");
		String event_time = login.get("event_time");

		Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(event_time);
		Calendar cal = Calendar.getInstance();

		cal.setTime(date);

		cal.add(Calendar.HOUR, dateTime);

		rejectEventService.insert(dev_ch, model_name, cal.getTime());

		eventStatusService.remove(login);

		Map map = new HashMap();

		return map;
	}

}
