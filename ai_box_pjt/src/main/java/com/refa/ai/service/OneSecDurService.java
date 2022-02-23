package com.refa.ai.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.refa.ai.dto.OneSecDurDto;
import com.refa.ai.repository.OneSecDurRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OneSecDurService {

	private final OneSecDurRepository oneSecDurRepository;
	
	public boolean join(OneSecDurDto oneSecDurDto) throws ParseException {
		Optional<OneSecDurDto> findData = oneSecDurRepository.findByCh(oneSecDurDto.getDev_ch());
		if (findData.isPresent()) {
			return checkDate(oneSecDurDto, findData);
		} else {
			oneSecDurRepository.save(oneSecDurDto);
			return true;
		}
	}

	private boolean checkDate(OneSecDurDto oneSecDurDto, Optional<OneSecDurDto> findData) throws ParseException {
		String event_time = oneSecDurDto.getEvent_time();
		String event_time2 = findData.get().getEvent_time();
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date past = dateFormat.parse(event_time2);
		Date now = dateFormat.parse(event_time);
		
		System.out.println("===== duration check 시작 ======");
		
		System.out.println("현재 = " + now.getTime());
		System.out.println("과거 = " + past.getTime());
		System.out.println("시작차이 = " + ((now.getTime() - past.getTime()) / 1000) + "초");
		
		System.out.println("===== duration check 종료 ======");
		
		if ((now.getTime() - past.getTime()) / 1000 >= 1) {
			oneSecDurRepository.save(oneSecDurDto);
			return true;
		}
		
		return false;
	}
}
