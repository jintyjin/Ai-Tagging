package com.refa.ai.controller.api;

import java.text.ParseException;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.refa.ai.dto.CmdDto;
import com.refa.ai.dto.ResponseEventDto;
import com.refa.ai.dto.device.DeviceCmdDto;
import com.refa.ai.service.ActionService;
import com.refa.ai.service.ResponseEventsService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class HomeApiController {
	
	private final ActionService actionService;
	private final ResponseEventsService responseEventsService;
	
	@PostMapping("/cmdDeviceInfo")
	public DeviceCmdDto jsonCmdDeviceInfo(@RequestBody CmdDto cmdDto) {
		if (cmdDto.getCommand().equals("JSON_CMD_DEVICE_INFO")) {
			return actionService.selectActionDeviceDto(cmdDto);
		}
		
		return null;
	}
	
	@PostMapping("/responseEvents2")	// °¥¾Æ ³¢¿ö¾ß µÊ
	public Map responseEvents(@RequestBody ResponseEventDto responseEventDto) throws ParseException {
		return responseEventsService.addQueue(responseEventDto);
	}
}
