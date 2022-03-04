package com.refa.ai.repository;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.springframework.stereotype.Repository;

@Repository
public class ThreadPoolRepository {

	private static ExecutorService executorService = Executors.newCachedThreadPool();

	public void execute(Runnable runnable) {
		executorService.submit(runnable);
	}
}
