package com.refa.ai.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.springframework.stereotype.Service;

@Service
public class EventStatusService {

	private static Map<String, Map> list = new LinkedHashMap<String, Map>();
	
	public boolean save(Map map) {
		int dev_ch = Integer.parseInt(map.get("dev_ch").toString());
		String event_action = map.get("event_action").toString();
		String model_name = map.get("model_name").toString();
		
		String key = dev_ch + "_" + event_action + "_" + model_name;
		
		if (findByKey(key).isPresent()) {
			list.put(key, map);
			
			return false;
		}

		list.put(key, map);
		
		return true;
	}
	
	public void remove(Map map) {
		int dev_ch = Integer.parseInt(map.get("dev_ch").toString());
		String event_action = map.get("event_action").toString();
		String model_name = map.get("model_name").toString();
		
		String key = dev_ch + "_" + event_action + "_" + model_name;
				
		list.remove(key);
	}
	
	public Optional<Map> findByKey(String key) {
		return Optional.ofNullable(list.get(key));
	}
	
	public List<Map> findAll() {
		return new ArrayList<Map>(list.values());
	}
}
