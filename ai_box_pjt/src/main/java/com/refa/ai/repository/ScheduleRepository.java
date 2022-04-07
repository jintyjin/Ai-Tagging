package com.refa.ai.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.stereotype.Repository;

import com.refa.ai.dao.EventDao;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ScheduleRepository {
	
	private static Map<Integer, Map<String, Map>> list = new ConcurrentHashMap<Integer, Map<String, Map>>();
	
	private final EventDao eventDao;
	
	@PostConstruct
	public void selectAll() {
		List<Map> AllList = eventDao.selectScheduleAll();
		for (int i = 0; i < AllList.size(); i++) {
			Map map = AllList.get(i);
			if (list.get(Integer.parseInt(map.get("dev_ch").toString())) != null) {
				list.get(Integer.parseInt(map.get("dev_ch").toString())).put(map.get("event_name").toString(), map);
			} else {
				Map<String, Map> map2 = new HashedMap<String, Map>();
				map2.put(map.get("event_name").toString(), map);
				list.put(Integer.parseInt(map.get("dev_ch").toString()), map2);
			}
		}
	}
	
	public Map<Integer, Map<String, Map>> findAll() {
		return list;
	}
	
	public Map find(int dev_ch, String event_name) {
		if (list.get(dev_ch) == null) {
			return null;
		} else {
			if (list.get(dev_ch).get(event_name) == null) {
				return null;
			} else {
				return list.get(dev_ch).get(event_name);
			}
		}
	}
	
	public boolean chkDate(int dev_ch, String event_name, String day) {
		if (find(dev_ch, event_name) != null && find(dev_ch, event_name).get("schedule_content") != null && !find(dev_ch, event_name).get("schedule_content").toString().isEmpty()) {
			if (find(dev_ch, event_name).get("schedule_content").toString().indexOf(day) != -1) {
				return true;
			}
		}
		return false;
	}
	
	public void delete(int dev_ch) {
		if (list.get(dev_ch) != null) {
			list.remove(dev_ch);
		}
	}
	
	public void save(Map map) {
		int dev_ch = Integer.parseInt(map.get("dev_ch").toString());
		String event_name = map.get("event_name").toString();
		String schedule_content = map.get("id_list").toString();
		
		Map saveMap = new HashMap();
		saveMap.put("dev_ch", dev_ch);
		saveMap.put("event_name", event_name);
		saveMap.put("schedule_content", schedule_content);

		if (list.get(dev_ch) == null) {
			Map<String, Map> strMap = new HashedMap<String, Map>();
			strMap.put(event_name, saveMap);
			list.put(dev_ch, strMap);
		} else {
			list.get(dev_ch).put(event_name, saveMap);
		}
	}
} 
