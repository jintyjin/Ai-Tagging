package com.refa.ai.repository;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Repository;

import com.refa.ai.dto.RejectDto;

@Repository
public class RejectEventRepository implements RejectRepository{

	private static Map<Integer, RejectDto> list = new ConcurrentHashMap<Integer, RejectDto>();
	
	@Override
	public void insert(int dev_ch, String model_name, Date date_time) {
		// TODO Auto-generated method stub
		RejectDto rejectDto = makeData(dev_ch, model_name, date_time);
		list.put(dev_ch, rejectDto);
	}

	@Override
	public Optional<RejectDto> findByCh(int dev_ch) {
		// TODO Auto-generated method stub
		return Optional.ofNullable(list.get(dev_ch));
	}

	public RejectDto makeData(int dev_ch, String model_name, Date date_time) {
		RejectDto rejectDto = new RejectDto();
		rejectDto.setDev_ch(dev_ch);
		
		if (model_name.equals("KWATER_Falldown_Detection")) {
			rejectDto.setKWATER_Falldown_Detection(true);
		} else {
			rejectDto.setKWATER_Falldown_Detection(false);
		}

		if (model_name.equals("KWATER_Fire_Detection")) {
			rejectDto.setKWATER_Fire_Detection(true);
		} else {
			rejectDto.setKWATER_Fire_Detection(false);
		}

		if (model_name.equals("KWATER_Flood_Detection")) {
			rejectDto.setKWATER_Flood_Detection(true);
		} else {
			rejectDto.setKWATER_Flood_Detection(false);
		}

		if (model_name.equals("KWATER_Glove_Detection")) {
			rejectDto.setKWATER_Glove_Detection(true);
		} else {
			rejectDto.setKWATER_Glove_Detection(false);
		}

		if (model_name.equals("KWATER_Invasion_Detection")) {
			rejectDto.setKWATER_Invasion_Detection(true);
		} else {
			rejectDto.setKWATER_Invasion_Detection(false);
		}

		if (model_name.equals("KWATER_Leak_Detection")) {
			rejectDto.setKWATER_Leak_Detection(true);
		} else {
			rejectDto.setKWATER_Leak_Detection(false);
		}

		if (model_name.equals("KWATER_Loitering_Detection")) {
			rejectDto.setKWATER_Loitering_Detection(true);
		} else {
			rejectDto.setKWATER_Loitering_Detection(false);
		}

		if (model_name.equals("KWATER_HandAction_Detection")) {
			rejectDto.setKWATER_HandAction_Detection(true);
		} else {
			rejectDto.setKWATER_HandAction_Detection(false);
		}

		if (model_name.equals("KWATER_Spin_Detection")) {
			rejectDto.setKWATER_Spin_Detection(true);
		} else {
			rejectDto.setKWATER_Spin_Detection(false);
		}
		
		
		Map<String, Date> map = new HashMap<>();
		map.put(model_name, date_time);
		
		rejectDto.setDate_time(map);
		
		return rejectDto;
	}
	
	@Override
	public List<RejectDto> findAll() {
		return new ArrayList<>(list.values());
	}
}
