package com.refa.ai.repository;

import com.refa.ai.dto.ResponseEventDto;

public interface ResponseEventsRepository {
	int selectQueueSize();
	int insertQueue(ResponseEventDto responseEventDto);
	void clear();
	ResponseEventDto takeOne();
}
