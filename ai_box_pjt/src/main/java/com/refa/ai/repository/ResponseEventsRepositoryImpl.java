package com.refa.ai.repository;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;

import org.springframework.stereotype.Repository;

import com.refa.ai.dto.ResponseEventDto;

@Repository
public class ResponseEventsRepositoryImpl implements ResponseEventsRepository {

	private static BlockingQueue<ResponseEventDto> responseQ = new LinkedBlockingQueue<ResponseEventDto>(1);
	
	@Override
	public int selectQueueSize() {
		return responseQ.size();
	}
	
	@Override
	public int insertQueue(ResponseEventDto responseEventDto) {
		if (!responseQ.offer(responseEventDto)) {
			responseQ.poll();
			responseQ.offer(responseEventDto);
		}
		return responseQ.size();
	}

	@Override
	public void clear() {
		// TODO Auto-generated method stub
	}
	
	@Override
	public ResponseEventDto takeOne() {
		try {
			return responseQ.take();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
}
