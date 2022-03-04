package com.refa.ai.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.refa.ai.repository.ResponseEventsRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ResponseEventsServiceImpl implements ResponseEventsService {

	private final ResponseEventsRepository responseEventsRepository;

	@Override
	public void insertResponseQ(Map data) {
		try {
			responseEventsRepository.save(data);
		} catch (InterruptedException e) {
			System.out.println("ResponseEventsService.insertResponseQ Error");
		}
	}
}
