package com.refa.ai.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.PostConstruct;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.refa.ai.dao.EventDao;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AreaSetRepository {
	
	private static Map<Integer, Map<String, Map>> list = new ConcurrentHashMap<Integer, Map<String, Map>>();
	private final SqlSessionTemplate sqlSession;

	@PostConstruct
	public void selectAll() {
		List<Map> areaSet = sqlSession.selectList("event.selectAreaSetAll");
		
		for (int i = 0; i < areaSet.size(); i++) {
			Map map = areaSet.get(i);
			Map eventMap = new HashMap();
			eventMap.put(map.get("area_event"), map);
			list.put(Integer.parseInt(map.get("dev_ch").toString()), eventMap);
		}
	}

	public Map selectOne(int dev_ch, String area_event) {
		if (list.get(dev_ch) != null && list.get(dev_ch).get(area_event) != null) {
			return list.get(dev_ch).get(area_event);
		}
		return null;
	}
	
	public void insert(Map map) {
		if (list.get(Integer.parseInt(map.get("dev_ch").toString())) == null) {
			Map eventMap = new HashMap();
			eventMap.put(map.get("area_event"), map);
			list.put(Integer.parseInt(map.get("dev_ch").toString()), eventMap);
		} else {
			list.get(Integer.parseInt(map.get("dev_ch").toString())).put(map.get("area_event").toString(), map);
		}
	}

	public void deleteCh(Map map) {
		if (list.get(Integer.parseInt(map.get("dev_ch").toString())) != null) {
			list.remove(Integer.parseInt(map.get("dev_ch").toString()));
		}
	}
	
	public List<Map> selectInCh(List<Integer> chList) {
		return sqlSession.selectList("event.selectAreaSetInCh", chList);
	}
}
