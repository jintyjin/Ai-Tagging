package com.refa.ai.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.refa.ai.repository.ActionSetupRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ActionSetupService {
	
	private final ActionSetupRepository actionSetupRepository;

	public void selectAll() {
		actionSetupRepository.selectAll();
	}
	
	public Map selectOne(int dev_ch) {
		return actionSetupRepository.selectOne(dev_ch);
	}
	
	public boolean checkOn(int dev_ch, String event_name) {
		String event = event_name.split("_")[1].toLowerCase();
		
		return actionSetupRepository.selectByChAndEvent(dev_ch, event);
	}
	
	public void insert(Map map) {
		Map actionMap = new HashMap();
		actionMap.put("dev_ch", map.get("dev_ch"));
		actionMap.put("dev_title", map.get("dev_title"));
		actionMap.put("action_fire", 0);
		actionMap.put("action_falldown", 0);
		actionMap.put("actopm_flood", 0);
		actionMap.put("action_glove", 0);
		actionMap.put("action_invasion", 0);
		actionMap.put("actopm_leak", 0);
		actionMap.put("action_loitering", 0);
		actionMap.put("action_handaction", 0);
		actionMap.put("action_spin", 0);
		actionSetupRepository.insert(map);
	}
	
	public void updateTitle(Map map) {
		int dev_ch = Integer.parseInt(map.get("dev_ch").toString());
		String dev_title = map.get("dev_title").toString();
		Map actionMap = selectOne(dev_ch);
		actionMap.put("dev_title", dev_title);
		
		actionSetupRepository.updateByCh(dev_ch, actionMap);
	}

	public void updateModel(Map map) {
		int dev_ch = Integer.parseInt(map.get("dev_ch").toString());
		String model_name = map.get("model_name").toString();
		int opt = Integer.parseInt(map.get(model_name).toString());
		
		Map actionMap = selectOne(dev_ch);
		actionMap.put(model_name, opt);
		actionMap.put("confidence", map.get("confidence"));
		actionMap.put("duration", map.get("duration"));
		
		actionSetupRepository.updateByCh(dev_ch, actionMap);
	}
	
	public void delete(Map map) {
		actionSetupRepository.delete(map);
	}
}
