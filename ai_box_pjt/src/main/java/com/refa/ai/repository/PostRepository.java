package com.refa.ai.repository;

public interface PostRepository {
	
	void startPostQ();
	
	int size();
	
	<E> void save(E data) throws InterruptedException;
}
