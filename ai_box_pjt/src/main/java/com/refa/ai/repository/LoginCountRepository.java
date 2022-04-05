package com.refa.ai.repository;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Repository;

@Repository
public class LoginCountRepository {
	
	private static Map<String, Integer> list = new ConcurrentHashMap<String, Integer>();
	
	private final int MAX_LOGIN_COUNT = 5;
	
	public int addLoginCount(String loginId) {
		if (isNull(loginId)) {
			list.put(loginId, 1);
			return 1;
		}
		
		if (isDisabled(loginId)) {
			return 5;
		}
		
		list.put(loginId, list.get(loginId) + 1);
		return list.get(loginId);
		
	}
	
	public int getLoginCount(String loginId) {
		if (isNull(loginId)) {
			return 0;
		}
		
		return list.get(loginId);
		
	}
	
	public boolean isDisabled(String loginId) {
		if (isNull(loginId) || list.get(loginId) < MAX_LOGIN_COUNT) {
			return false;
		}
		
		return true;
	}

	private boolean isNull(String loginId) {
		return list.get(loginId) == null;
	}
}
