package com.refa.ai.repository;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import com.refa.ai.dto.RejectDto;

public interface RejectRepository {
	void insert(int dev_ch, String model_name, Date date_time);
	Optional<RejectDto> findByCh(int dev_ch);
	List<RejectDto> findAll();
}
