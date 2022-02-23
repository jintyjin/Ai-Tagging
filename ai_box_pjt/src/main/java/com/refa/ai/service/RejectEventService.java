package com.refa.ai.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.refa.ai.dto.RejectDto;
import com.refa.ai.repository.RejectEventRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RejectEventService {
	
	private final RejectEventRepository rejectEventRepository;
	
	public void insert(int dev_ch, String model_name, Date date_time) {
		if (rejectEventRepository.findByCh(dev_ch).isPresent()) {
			Optional<RejectDto> rejectDtoOpt = rejectEventRepository.findByCh(dev_ch);
			RejectDto rejectDto = rejectDtoOpt.get();

			if (model_name.equals("KWATER_Falldown_Detection")) {
				rejectDto.setKWATER_Falldown_Detection(true);
			}

			if (model_name.equals("KWATER_Fire_Detection")) {
				rejectDto.setKWATER_Fire_Detection(true);
			}

			if (model_name.equals("KWATER_Flood_Detection")) {
				rejectDto.setKWATER_Flood_Detection(true);
			}

			if (model_name.equals("KWATER_Glove_Detection")) {
				rejectDto.setKWATER_Glove_Detection(true);
			}

			if (model_name.equals("KWATER_Invasion_Detection")) {
				rejectDto.setKWATER_Invasion_Detection(true);
			}

			if (model_name.equals("KWATER_Leak_Detection")) {
				rejectDto.setKWATER_Leak_Detection(true);
			}

			if (model_name.equals("KWATER_Loitering_Detection")) {
				rejectDto.setKWATER_Loitering_Detection(true);
			}

			if (model_name.equals("KWATER_HandAction_Detection")) {
				rejectDto.setKWATER_HandAction_Detection(true);
			}

			if (model_name.equals("KWATER_Spin_Detection")) {
				rejectDto.setKWATER_Spin_Detection(true);
			}
			
			Map<String, Date> map = rejectDto.getDate_time();
			map.put(model_name, date_time);
			
			rejectDto.setDate_time(map);
			
		} else {
			rejectEventRepository.insert(dev_ch, model_name, date_time);
		}
	}
	
	public boolean chkTime(int dev_ch, String model_name, Date date_time) {
		boolean showImage = true;
	
		if (rejectEventRepository.findByCh(dev_ch).isPresent()) {
			Optional<RejectDto> rejectDto = rejectEventRepository.findByCh(dev_ch);
			
			if (rejectDto.get().getDate_time().containsKey(model_name)) {
				if (rejectDto.get().getDate_time().get(model_name).getTime() >= date_time.getTime()) {
					showImage = false;
				}
			}
		}
		
		return showImage;
	}
	
	public List<RejectDto> findAll() {
		return rejectEventRepository.findAll();
	}
}
