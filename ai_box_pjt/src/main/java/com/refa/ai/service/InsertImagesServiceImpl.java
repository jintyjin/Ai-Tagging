package com.refa.ai.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.refa.ai.repository.InsertImagesRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InsertImagesServiceImpl implements InsertImagesService {
	
	private final InsertImagesRepository insertImagesRepository;

	@Override
	public void insertInsertQ(Map data) {
		try {
			insertImagesRepository.save(data);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			System.out.println("insertInsertQ Error");
		}
	}

}
