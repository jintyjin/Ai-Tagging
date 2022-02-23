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
		if (durationRepository.findByKey(metadata.getDev_ch() + "_" + m.getModel_name()) == null) {
			return true;
		}

		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now = dateFormat.parse(metadata.getEvent_time());
		Date past = dateFormat.parse(durationRepository.findByKey(metadata.getDev_ch() + "_" + m.getModel_name()));
		
		int duration = actionSetupService.selectOne(Integer.parseInt(metadata.getDev_ch())).get("duration") != null ? Integer
				.parseInt(actionSetupService.selectOne(Integer.parseInt(metadata.getDev_ch())).get("duration").toString()) : 10;
		
		if (now.getTime() - past.getTime() >= duration * 1000) {
			durationRepository.save(metadata.getDev_ch() + "_" + m.getModel_name(), metadata.getEvent_time());
			return true;
		}
		
		return false;
		
	}
	
	public boolean boxesOrSegments(MlResultDto m, int beforeConfidence) {
		Double confidence = m.getSegments() != null ? m.getSegments().get(0).getConfidence() : m.getBoxes().get(0).getConfidence();
		
		return beforeConfidence <= confidence;
	}
}
