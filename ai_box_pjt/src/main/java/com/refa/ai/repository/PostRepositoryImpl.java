package com.refa.ai.repository;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.Map;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PostRepositoryImpl implements PostRepository {

	private final VersionMemoryRepository versionMemoryRepository;
	private final ThreadPoolRepository threadPoolRepository;
	
	
	private static BlockingQueue<Map> postQ = new LinkedBlockingQueue<Map>();

	@Override
	public <E> void save(E data) throws InterruptedException {
		postQ.put((Map) data);
	}

	@Override
	public int size() {
		// TODO Auto-generated method stub
		return postQ.size();
	}
	
	@Override
	@PostConstruct
	public void startPostQ() {
		Runnable runnable = new Runnable() {
			@Override
			public void run() {
				// 스레드에게 시킬 작업 내용
				while (true) {
					try {
						Thread.sleep(1);
					} catch (InterruptedException e1) {
						System.out.println("startPostQ() sleep() error");
					}
					Map map;
					try {
						map = postQ.take();

						ObjectMapper mapper = new ObjectMapper();

						String json = null;

						try {
							json = mapper.writeValueAsString(map);
						} catch (JsonProcessingException e1) {
							e1.printStackTrace();
						}

						String body = "";

						try {
							String analyzeUrl = versionMemoryRepository.findVersion().getAnalyze_url();
							URL url = new URL(analyzeUrl);
							HttpURLConnection con = (HttpURLConnection) url.openConnection();
							con.setRequestMethod("POST");
							con.setRequestProperty("Content-Type", "application/json");
							con.setRequestProperty("Accept", "application/json");

							con.setDoOutput(true);
							DataOutputStream wr = new DataOutputStream(con.getOutputStream());
							wr.writeBytes(json);
							wr.flush();
							wr.close();

							Charset charset = Charset.forName("UTF-8");
							BufferedReader in = new BufferedReader(
									new InputStreamReader(con.getInputStream(), charset));

							String inputLine;
							StringBuffer response = new StringBuffer();

							while ((inputLine = in.readLine()) != null) {
								response.append(inputLine);
							}

							in.close();

							long start = System.currentTimeMillis();

							// Response 출력

							/*
							 * if (con.getResponseCode() == 200) { ResponseHandler<String> handler = new
							 * BasicResponseHandler(); body = handler.handleResponse(response); } else {
							 * //System.out.println("response is error : " +
							 * response.getStatusLine().getStatusCode()); client =
							 * HttpClientBuilder.create().build(); // HttpClient 생성 postRequest = new
							 * HttpPost(analyze_url); postRequest.setHeader("Accept", "application/json");
							 * postRequest.setHeader("Connection", "keep-alive");
							 * postRequest.setHeader("Content-Type", "application/json"); }
							 */
						} catch (Exception e) {
							System.err.println(e.toString());
						}

					} catch (InterruptedException e) {
						e.printStackTrace();
					} catch (Exception e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				}
			}
		};
		// 스레드풀에게 작업 처리 요청
		threadPoolRepository.execute(runnable);
	}

}
