package com.refa.ai.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.refa.ai.repository.ActionSetupRepository;
import com.refa.ai.repository.AreaSetRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AreaSetService {

	private final AreaSetRepository areaSetRepository;

	public void selectAll() {
		areaSetRepository.selectAll();
	}
	
	public Map selectOne(Map map) {
		return areaSetRepository.selectOne(Integer.parseInt(map.get("dev_ch").toString()), map.get("area_event").toString());
	}

	public void insert(Map map) {
		Map areaMap = new HashMap();
		areaMap.put("dev_ch", map.get("dev_ch"));
		areaMap.put("dev_title", map.get("dev_title"));
		areaMap.put("area_total", map.get("area_total"));
		areaMap.put("area_now", map.get("area_now"));
		areaMap.put("area_event", map.get("area_event"));
		
		areaSetRepository.insert(map);
	}
	
	public void updateTitle(Map map) {
		String dev_title = map.get("dev_title").toString();
		Map areaMap = selectOne(map);
		if (areaMap != null) {
			areaMap.put("dev_title", dev_title);
			
			areaSetRepository.insert(areaMap);
		}
	}

	public void updateArea(Map map) {
		Map areaMap = selectOne(map);
		if (areaMap != null) {
			areaMap.put("area_total", map.get("area_total"));
			areaMap.put("area_now", map.get("area_now"));
			areaMap.put("area_event", map.get("area_event"));
			
			areaSetRepository.insert(areaMap);
		}
	}
	
	public void deleteCh(Map map) {
		areaSetRepository.deleteCh(map);
	}
	
}
