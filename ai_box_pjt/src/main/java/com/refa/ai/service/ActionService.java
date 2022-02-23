package com.refa.ai.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.refa.ai.dto.CmdDto;
import com.refa.ai.dto.MetadataDto;
import com.refa.ai.dto.action.ActionDeviceDto;
import com.refa.ai.dto.action.EventInfoDto;
import com.refa.ai.dto.device.DeviceCmdDto;
import com.refa.ai.infra.AES256Util;
import com.refa.ai.repository.ActionRepository;
import com.refa.ai.repository.AreaSetRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ActionService {
	
	private final ActionRepository actionRepository;
	private final AreaSetRepository aresAreaSetRepository;
	private final AES256Util aES256Util;
	
	public DeviceCmdDto selectActionDeviceDto(CmdDto cmdDto) {
		int cmd_type = 1;
		String version = "1.0";
		
		DeviceCmdDto deviceCmdDto = new DeviceCmdDto();
		deviceCmdDto.setCommand("JSON_CMD_DEVICE_INFO");
		
		deviceCmdDto.setCmd_type(cmd_type);
		deviceCmdDto.setVer(version);

		MetadataDto metadata = new MetadataDto();
		metadata.setUser_name("kuser1");
		metadata.setUser_passwd("0");
		metadata.setDev_ip("192.168.100.61");
		metadata.setDev_port("8000");
		metadata.setDev_web_port("8000");
		metadata.setDev_id("admin");
		metadata.setDev_pwd("1");
		metadata.setStart(1627461100077L);
		metadata.setImg_name("ch2_173432.jpg");
		metadata.setItem_name("AIBOX1");
		metadata.setDev_ch("2");
		metadata.setEvent_time("2022-01-05 17:34:32");
		metadata.setVer("2.1");
		
		String lkey = "";
		String aes256Key = aES256Util.getKeyString() + aES256Util.getIvString();
		Random random = new Random();
		StringBuffer stringBuffer = new StringBuffer();
		for (int i = 0; i < aes256Key.length() * 3; i++) {
			if (i % 3 == 2) {
				stringBuffer.append(aes256Key.charAt(i / 3));
			} else {
				if (random.nextBoolean()) {
					stringBuffer.append((char)(random.nextInt(26) + 97));
				} else {
					stringBuffer.append(random.nextInt(10));
				}
			}
		}
		lkey = stringBuffer.toString();
		metadata.setLkey(lkey);
		
		deviceCmdDto.setMetadata(metadata);
		
		List<Integer> chList = new ArrayList<Integer>();
		
		List<EventInfoDto> eventInfoList = new ArrayList<EventInfoDto>();

		List<ActionDeviceDto> actionDeviceList = actionRepository.selectActionDeviceDto();
		
		if (actionDeviceList.size() > 0) {
			for (ActionDeviceDto actionDeviceDto : actionDeviceList) {
				EventInfoDto eventInfoDto = new EventInfoDto(actionDeviceDto);
				
				if (eventInfoDto.getEvent_list().size() == 0 || eventInfoDto.getRtsp_url().size() == 0) {
					continue;
				}
				
				chList.add(actionDeviceDto.getDev_ch());
				eventInfoList.add(eventInfoDto);
			}
		}
		
		if (chList.size() > 0) {
			List<Map> areaList = aresAreaSetRepository.selectInCh(chList);
			for (int i = eventInfoList.size() - 1; i >= 0; i--) {
				EventInfoDto eventInfoDto = eventInfoList.get(i);
				for (int j = areaList.size() - 1; j >= 0; j--) {
					Map areaSet = areaList.get(j);
					if (eventInfoDto.getCh() == (Integer)areaSet.get("dev_ch")) {
						eventInfoDto.getEvent_list()
							.stream().forEach(event -> {
								if (event.contains(areaSet.get("area_event").toString())) {
									List<Map> totalList;
									try {
										totalList = new ObjectMapper().readValue(
												areaSet.get("area_total").toString(),
												new TypeReference<List<Map>>() {
												});
										if (areaSet.get("area_event").toString().equals("loitering")) {
											eventInfoDto.setLoitering_areas(makeAreaData(totalList));
										} else if (areaSet.get("area_event").toString().equals("invasion")) {
											eventInfoDto.setInvasion_areas(makeAreaData(totalList));
										} else {
											eventInfoDto.setPanel_areas(makeAreaData(totalList));
										}
									} catch (Exception e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}
								}
							});
					}
				}
			}
		}
		deviceCmdDto.setCh(chList);
		deviceCmdDto.setEvent_info_list(eventInfoList);
		
		return deviceCmdDto;
	}
	
	public List<List<List<Integer>>> makeAreaData(List<Map> totalList) {
		List<List<List<Integer>>> areas = new ArrayList<List<List<Integer>>>();
		List pathList = new ArrayList();
		List tmpList = new ArrayList();
		for (int k = 0; k < totalList.size(); k++) {
			Map listMap = totalList.get(k);
			if (listMap.get("x") != null) {
				pathList = new ArrayList();
				pathList.add(listMap.get("x"));
				pathList.add(listMap.get("y"));
				tmpList.add(pathList);
				if (k == totalList.size() - 1) {
					areas.add(tmpList);
				}
			} else {
				if (k != 0) {
					areas.add(tmpList);
					tmpList = new ArrayList();
				}
			}
		}
		
		return areas;
	}
}
