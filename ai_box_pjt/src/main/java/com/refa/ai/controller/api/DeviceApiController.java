package com.refa.ai.controller.api;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.refa.ai.entity.Device;
import com.refa.ai.repository.DeviceRepository;
import com.refa.ai.service.ActionSetupService;
import com.refa.ai.service.DeviceService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class DeviceApiController {
	
	private final DeviceService deviceService; 
	private final DeviceRepository deviceRepository;
	private final ActionSetupService actionSetupService;
	
	// 모든 장비 리스트를 가져옴
	@PostMapping("/deviceList")
	public List<Device> deviceList(Locale locale) {
		System.out.println("===== locale start =====");

		System.out.println(locale.getLanguage() + " : " + locale.getDisplayLanguage());
		System.out.println("locale = " + locale);
		
		System.out.println("===== locale end =====");
		return deviceService.findAll();
	}

	@PostMapping("/chkChannelByType")
	public Map chkChannelByType(@RequestBody Map dev_info) {
		List<Device> device_list = deviceService.findAll();

		int total_count = 64;

		boolean isJoin = false;

		List<String> chList = new ArrayList<String>();
		String[] arr = new String[total_count];

		if (device_list.size() < total_count) {
			isJoin = true;
			for (int i = 0; i < total_count; i++) {
				if (i <= (device_list.size() - 1)) {
					arr[device_list.get(i).getDev_ch() - 1] = "";
				}

				if (arr[i] == null) {
					arr[i] = (i + 1) + "";
				}
			}
		}

		if (isJoin) {
			actionSetupService.selectAll();
		}

		Arrays.asList(arr).stream().forEach(s -> {
			if (!s.equals("")) {
				chList.add(s);
			}
		});

		Map map = new HashMap();
		map.put("isJoin", isJoin);
		map.put("chList", chList);

		return map;
	}
}
