package com.refa.ai.repository;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Repository;

import com.refa.ai.dto.LoginCountDto;

@Repository
public class LoginCountRepository {
	
	private static Map<String, LoginCountDto> list = new ConcurrentHashMap<String, LoginCountDto>();
	
	private final int MAX_LOGIN_COUNT = 5;
	private final int LIMIT_MINUTE = 5;
	
	public int addCount(String loginId) {
		if (isNull(loginId)) {
			list.put(loginId, new LoginCountDto(1));
			return 1;
		}
		
		list.get(loginId).setCount(list.get(loginId).getCount() + 1);
		
		if (list.get(loginId).getCount() == MAX_LOGIN_COUNT) {
			updateDate(loginId);
		}
		
		return list.get(loginId).getCount();
		
	}
	
	public boolean isMaxLoginCount(int loginCount) {
		return loginCount == MAX_LOGIN_COUNT;
	}
	
	public LocalDateTime getDisabledTime(String loginId) {
		if (isNull(loginId)) {
			return null;
		}
		
		return list.get(loginId).getDisabledTime();
	}
	
	public int getLoginCount(String loginId) {
		if (isNull(loginId)) {
			return 0;
		}
		
		return list.get(loginId).getCount();
		
	}
	
	public boolean isDisabled(String loginId) {
		if (isNull(loginId) || list.get(loginId).getCount() < MAX_LOGIN_COUNT) {
			return false;
		}
		
		return true;
	}

	private boolean isNull(String loginId) {
		return list.get(loginId) == null;
	}

	private void updateDate(String loginId) {
		list.get(loginId).setDisabledTime(LocalDateTime.now().plusMinutes(LIMIT_MINUTE));
	}
	
	public void initAll(String loginId) {
		list.remove(loginId);
	}

}
