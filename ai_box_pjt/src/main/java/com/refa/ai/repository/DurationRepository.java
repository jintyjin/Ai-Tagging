package com.refa.ai.repository;

import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Repository;

import com.refa.ai.dto.MetadataDto;
import com.refa.ai.dto.MlResultDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DurationRepository {
	
	private static Map<String, String> durationList = new ConcurrentHashMap<String, String>();

	public void save(String key, String eventTime) {
		durationList.put(key, eventTime);
	}
	
	public Optional<String> findByKey(String key) {
		return Optional.ofNullable(durationList.get(key));
	}
}
