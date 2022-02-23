package com.refa.ai.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.refa.ai.dao.EventDao;
import com.refa.ai.dto.VersionDto;
import com.refa.ai.infra.AES256Util;
import com.refa.ai.repository.VersionRepository;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class DeviceController {
	
	private final VersionRepository versionRepository;
	private final EventDao eventDao;
	private final AES256Util aes256Util;

	@RequestMapping(value = "/device")
	public String device(Model model, String login_id) {
		VersionDto searchDto = versionRepository.selectVersionInfo("device_search");
		String address = searchDto.getRequest_url();

		model.addAttribute("login_id", login_id);
		model.addAttribute("address", address);
		
		return "./device/device";
	}

	@RequestMapping(value = "/deviceSearch")
	public String deviceSearch(Model model) {
		VersionDto searchDto = versionRepository.selectVersionInfo("device_search");
		String address = searchDto.getRequest_url();
		
		model.addAttribute("address", address);
		
		return "./device/search/deviceSearch";
	}

	@RequestMapping(value = "/addDevice")
	public String addDevice(Model model, String login_id, String dev_ch) {
		// System.out.println("addDevice()");

		Map map = new HashMap();
		map.put("login_id", login_id);
		map.put("dev_ch", dev_ch);

		map = eventDao.deviceInfoOne2(map);

		if (map.get("dev_rtsp_url") != null) {
			String[] arr = (String[]) map.get("dev_rtsp_url");
			String dev_rtsp_url = Arrays.toString(arr);
		}

		model.addAttribute("dev_ch", map.get("dev_ch"));
		model.addAttribute("dev_mac_address", map.get("dev_mac_address"));
		model.addAttribute("dev_title", map.get("dev_title"));
		model.addAttribute("dev_ip", map.get("dev_ip"));
		model.addAttribute("dev_web_port", map.get("dev_web_port"));
		model.addAttribute("dev_id", map.get("dev_id"));

		String dev_pwd = map.get("dev_pwd").toString();
		
		dev_pwd = aes256Util.decryptAES(dev_pwd);
		
		map.put("dev_pwd", dev_pwd);
		
		model.addAttribute("dev_pwd", map.get("dev_pwd"));
		
		model.addAttribute("dev_rtsp", map.get("dev_rtsp"));
		// model.addAttribute("dev_rtsp_url", dev_rtsp_url);
		model.addAttribute("login_id", map.get("login_id"));

		model.addAttribute("fire", map.get("dev_fire"));
		model.addAttribute("falldown", map.get("dev_falldown"));
		model.addAttribute("flood", map.get("dev_flood"));
		model.addAttribute("glove", map.get("dev_glove"));
		model.addAttribute("invasion", map.get("dev_invasion"));
		model.addAttribute("leak", map.get("dev_leak"));
		model.addAttribute("loitering", map.get("dev_loitering"));
		model.addAttribute("hadnaction", map.get("dev_handaction"));
		model.addAttribute("spin", map.get("dev_spin"));

		model.addAttribute("cmtank", map.get("dev_cmtank"));
		model.addAttribute("outtank", map.get("dev_outtank"));
		model.addAttribute("overflow", map.get("dev_overflow"));

		VersionDto searchDto = versionRepository.selectVersionInfo("device_search");
		String address = searchDto.getRequest_url();
		model.addAttribute("address", address);

		return "./device/addDevice";
	}
	
}
