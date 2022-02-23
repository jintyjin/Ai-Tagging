package com.refa.ai.service;

import org.springframework.stereotype.Service;

import com.refa.ai.repository.LogRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LogService {

	private final LogRepository logRepository;
	
}
