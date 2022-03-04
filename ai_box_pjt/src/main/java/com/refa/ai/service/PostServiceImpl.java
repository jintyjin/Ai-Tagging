package com.refa.ai.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.refa.ai.repository.PostRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PostServiceImpl implements PostService {

	private final PostRepository postRepository;
	private final int LIMIT_SIZE = 60;
	
	@Override
	public void insertPostQ(Map data) {
		try {
			postRepository.save(data);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public boolean chkQSize() {
		if (postRepository.size() <= LIMIT_SIZE) {
			return true;
		}
		
		return false;
	}
}
