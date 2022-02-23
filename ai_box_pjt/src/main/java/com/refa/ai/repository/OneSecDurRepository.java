package com.refa.ai.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Repository;

import com.refa.ai.dto.OneSecDurDto;

@Repository
public class OneSecDurRepository {
	
	private static Map<Integer, OneSecDurDto> list = new ConcurrentHashMap<Integer, OneSecDurDto>();
	
	public void save(OneSecDurDto oneSecDurDto) {
		list.put(oneSecDurDto.getDev_ch(), oneSecDurDto);
	}
	
	public Optional<OneSecDurDto> findByCh(int dev_ch) {
		return Optional.ofNullable(list.get(dev_ch));
	}
	
	public List<OneSecDurDto> findAll() {
		return new ArrayList<OneSecDurDto>(list.values());
	}

}
