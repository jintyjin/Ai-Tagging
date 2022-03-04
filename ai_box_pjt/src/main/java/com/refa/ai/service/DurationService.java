package com.refa.ai.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Service;

import com.refa.ai.dto.MetadataDto;
import com.refa.ai.dto.MlResultDto;
import com.refa.ai.repository.DurationRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DurationService {

	private final ActionSetupService actionSetupService;
	private final DurationRepository durationRepository;
	
	public boolean chkDuration(MetadataDto metadata, MlResultDto m) throws ParseException {
		String key = metadata.getDev_ip() + "_" + metadata.getDev_ch() + "_" + m.getModel_name();
		if (isDurationNull(key)) {
			return true;
		}
		
		return chkTime(metadata.getEvent_time(), key, Integer.parseInt(metadata.getDev_ch()), m.getModel_name());
		
	}

	public boolean chkDuration(String dev_ip, String dev_ch, String model_name, String event_time) throws NumberFormatException, ParseException {
		// TODO Auto-generated method stub
		String key = dev_ip + "_" + dev_ch + "_" + model_name;
		if (isDurationNull(key)) {
			return true;
			
		}
		return chkTime(event_time, key, Integer.parseInt(dev_ch), model_name);
	}
	
	private boolean isDurationNull(String key) {
		return durationRepository.findByKey(key) == null;
	}
	
	private boolean chkTime(String eventTime, String key, int ch, String model_name) throws ParseException {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = dateFormat.parse(eventTime);
		Date past = dateFormat.parse(durationRepository.findByKey(key).get());
		
		int duration = actionSetupService.selectOne(ch).get("duration") != null ? Integer
				.parseInt(actionSetupService.selectOne(ch).get("duration").toString()) : 10;
		
		if (now.getTime() - past.getTime() >= duration * 1000) {
			durationRepository.save(key, eventTime);
			return true;
		}
		
		return false;
		
	}
	
	public boolean boxesOrSegments(MlResultDto m, int beforeConfidence) {
		Double confidence = m.getSegments() != null ? m.getSegments().get(0).getConfidence() : m.getBoxes().get(0).getConfidence();
		
		return beforeConfidence <= confidence;
	}
}
