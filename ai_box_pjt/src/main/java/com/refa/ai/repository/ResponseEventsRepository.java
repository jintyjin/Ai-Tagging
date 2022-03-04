package com.refa.ai.repository;

import com.refa.ai.dto.ResponseEventDto;

public interface ResponseEventsRepository {
	void startResponseQ();
	
	int size();
	
	<E> void save(E data) throws InterruptedException;
	
	void clear();
	
	boolean isBox(String eventName);
}
