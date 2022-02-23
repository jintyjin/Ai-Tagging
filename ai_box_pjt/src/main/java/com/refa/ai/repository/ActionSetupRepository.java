package com.refa.ai.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Repository;

import com.refa.ai.dao.EventDao;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ActionSetupRepository {

	private final EventDao eventDao;
	
	private static Map<Integer, Map> list = new ConcurrentHashMap<Integer, Map>();
		
	@PostConstruct
	public void selectAll() {
//		System.out.println("========== DB 시간 테스트 ========== 시작");
		long startTime = System.currentTimeMillis();
		List<Map> actionSetup = eventDao.selectActionSetup(new HashMap());
		long endTime = System.currentTimeMillis();
		long resultTime = endTime - startTime;
		
//		System.out.println("resultTime = " + resultTime + " 밀리세컨드");

//		System.out.println("========== DB 시간 테스트 ========== 종료");
		
		for (int i = 0; i < actionSetup.size(); i++) {
			Map map = actionSetup.get(i);
			list.put(Integer.parseInt(map.get("dev_ch").toString()), map);
		}
	}
	
	public Map selectOne(int dev_ch) {
		return list.get(dev_ch);
	}
	
	public boolean selectByChAndEvent(int dev_ch, String event) {
		Optional<Map> info = Optional.ofNullable(list.get(dev_ch));
		
		if (info.isPresent()) {
			for (Object key : info.get().keySet()) {
				if ((key + "").contains(event)) {
					if (Integer.parseInt(info.get().get(key).toString()) == 0) {
						return true;
					}
				}
			}
		}
		 
		return false;
	}
	
	public void insert(Map map) {
		list.put(Integer.parseInt(map.get("dev_ch").toString()), map);
	}
	
	public void updateByCh(int dev_ch, Map map) {
		list.put(dev_ch, map);
	}
	
	public void delete(Map map) {
		if (map.get("dev_ch") != null) {
			list.remove(Integer.parseInt(map.get("dev_ch").toString()));
		}
	}
}
