package com.refa.ai.service;

import org.springframework.stereotype.Service;

import com.refa.ai.repository.LoginCountRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginCountService {
	
	private final LoginCountRepository loginCountRepository;
	
	public boolean addAndCheckDisabled(String loginId) {
		if (loginCountRepository.isDisabled(loginId)) {
			return false;
		}
		
		if (loginCountRepository.isMaxLoginCount(loginCountRepository.addCount(loginId))) {
			return false;
		}
		
		return true;
	}

}
