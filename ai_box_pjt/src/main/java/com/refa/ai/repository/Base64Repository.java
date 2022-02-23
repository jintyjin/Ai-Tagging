package com.refa.ai.repository;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Repository;

import com.refa.ai.dto.RejectDto;

@Repository
public class Base64Repository {

	private static Map<Integer, String> list = new HashMap();
	
	public void save(int dev_ch, String img_data) {
		list.put(dev_ch, img_data);
	}

	public Optional<String> find(int dev_ch) {
		return Optional.ofNullable(list.get(dev_ch));
	}
}
