package com.refa.ai.repository;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.stereotype.Repository;

import com.refa.ai.dao.EventDao;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ActionEventMemoryRepository {
	
	private static Map<String, Map<String, Map>> list = new ConcurrentHashMap<String, Map<String,Map>>();
	
	private final ActionEventRepository actionEventRepository;
	
	@PostConstruct
	public void selectAll() {
		List<Map> actionList = actionEventRepository.findByIsuse();
		
		for (int i = 0; i < actionList.size(); i++) {
			if (list.get(actionList.get(i).get("dev_title").toString()) == null) {
				Map<String, Map> eventList = new HashedMap<String, Map>();
				eventList.put(actionList.get(i).get("action_event").toString(), actionList.get(i));
				list.put(actionList.get(i).get("dev_title").toString(), eventList);
			} else {
				if (list.get(actionList.get(i).get("dev_title").toString()).get(actionList.get(i).get("action_event").toString()) == null) {
					list.get(actionList.get(i).get("dev_title").toString()).put(actionList.get(i).get("action_event").toString(), actionList.get(i));
				}
			}
		}
	}
	
	public Map<String, Map<String, Map>> findAll() {
		return list;
	}
	
	public Map<String, Map> findByTitle(String dev_title) {
		if (list.get(dev_title) == null) {
			return null;
		}
		return list.get(dev_title);
	}
	
	public Map findByEvent(String dev_title, String event_name) {
//		System.out.println("===== 이벤트 액션 정보 검사 시작 =====");
		
//		System.out.println("dev_title = " + dev_title);
//		System.out.println("event_name = " + event_name);
		
//		System.out.println("get title = " + list.get(dev_title));
		
		if (list.get(dev_title) == null) {
			return null;
		}

//		System.out.println("get event_name = " + list.get(dev_title).get(event_name));
		
		if (list.get(dev_title).get(event_name) == null) {
			return null;
		}

//		System.out.println("get action_isuse = " + list.get(dev_title).get(event_name).get("action_isuse"));
		
		if (list.get(dev_title).get(event_name).get("action_isuse").equals("N")) {
			return null;
		}

//		System.out.println("===== 이벤트 액션 정보 검사 종료 =====");
		
		return list.get(dev_title).get(event_name);
	}
	
	public void save(Map map) {
		String dev_title = map.get("dev_title").toString();
		String event_name = map.get("action_event").toString();

		if (list.get(dev_title) == null) {
			Map<String, Map> eventList = new HashedMap<String, Map>();
			eventList.put(event_name, map);
			list.put(dev_title, eventList);
		} else {
			if (list.get(dev_title).get(event_name) == null) {
				list.get(dev_title).put(event_name, map);
			}
		}
	}
	
	public void update(Map map) {
		String event_name = map.get("action_event").toString();
		String dev_title = map.get("dev_title").toString();
		String action_action = map.get("action_action").toString();
		
		if (list.get(dev_title) != null) {
			if (list.get(dev_title).get(event_name) != null) {
				list.get(dev_title).get(event_name).put("action_action", action_action);
				list.get(dev_title).get(event_name).put("pre_title", map.get("pre_title"));
				list.get(dev_title).get(event_name).put("network_title", map.get("network_title"));
			}
		}
	}
	
	public void delete(String dev_title) {
		if (list.get(dev_title) != null) {
			list.remove(dev_title);
		}
	}
	
	public void deleteOne(String dev_title, String event_name) {
		if (list.get(dev_title) != null) {
			if (list.get(dev_title).get(event_name) != null) {
				list.get(dev_title).remove(event_name);
			}
		}
	}
}
