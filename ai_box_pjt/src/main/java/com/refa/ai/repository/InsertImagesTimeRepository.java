package com.refa.ai.repository;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Repository;

@Repository
public class InsertImagesTimeRepository {
	
	private static Map<Integer, String> list = new HashMap<Integer, String>();

	public void insertTime(int dev_ch, String event_time) {
		list.put(dev_ch, event_time);
	}
	
	public Optional<String> findTime(int dev_ch) {
		return Optional.ofNullable(list.get(dev_ch));
	}
	
}
