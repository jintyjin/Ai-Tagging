package com.refa.ai.repository;

public interface InsertImagesRepository {
	
	<E> void save(E data) throws InterruptedException;

	int size();
	
	void startInsertQ();
	
}
