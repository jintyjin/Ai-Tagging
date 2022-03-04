package com.refa.ai.repository;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

import javax.annotation.PostConstruct;
import javax.xml.bind.DatatypeConverter;

import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.refa.ai.dao.EventDao;
import com.refa.ai.service.ActionSetupService;
import com.refa.ai.service.AreaSetService;
import com.refa.ai.service.PostService;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class InsertImagesRepositoryImpl implements InsertImagesRepository {

	private final ThreadPoolRepository threadPoolRepository;
	private final PostService postService;
	private final InsertImagesTimeRepository insertImagesTimeRepository;
	private final EventDao eventDao;
	private final ActionSetupService actionSetupService;
	private final ScheduleRepository scheduleRepository;
	private final AreaSetService areaSetService;
	private final VersionMemoryRepository versionMemoryRepository;
	
	private static BlockingQueue<Map> insertQ = new LinkedBlockingQueue<Map>();
	
	@Override
	public <E> void save(E data) throws InterruptedException {
		insertQ.put((Map) data);
	}

	@Override
	public int size() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	@PostConstruct
	public void startInsertQ() {
		Runnable runnable = new Runnable() {
			@Override
			public void run() {
				while (true) {
					Map map;
					try {
						map = insertQ.take();

						if (postService.chkQSize()) {
							if (map.get("img_data") != null) {

								// sendMonitor(map);

								// insertImageLogJson(map);

								// insertImageLog(map);

								Map postMap = new HashMap();

								String base64 = map.get("img_data").toString();

								Map metadata = new HashMap();

								long start = System.currentTimeMillis();
								int dev_ch = Integer.parseInt(map.get("dev_ch").toString());
								String event_time = map.get("event_time").toString();

								if (insertImagesTimeRepository.findTime(dev_ch).isPresent()) {
									SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									Date now = dateFormat.parse(event_time);
									Date past = dateFormat.parse(insertImagesTimeRepository.findTime(dev_ch).get());

									int second = 40;

									if (now.getTime() - past.getTime() > second * 1000) {
										insertImagesTimeRepository.insertTime(dev_ch, event_time);
//										base64Repository.save(dev_ch, base64);

										String uploadPath = versionMemoryRepository.findPartDriveName() + ":/web_server/" + "roi/";

										File folder = new File(uploadPath);

										if (!folder.exists()) {
											try {
												folder.mkdir();
											} catch (Exception e) {
												System.out.println("폴더 생성 오류");
											}
										}

										uploadPath += dev_ch + ".jpg";

										String data = base64;

										byte[] imageBytes = DatatypeConverter.parseBase64Binary(data);

										try {
											File lOutFile = new File(uploadPath);

											FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);

											lFileOutputStream.write(imageBytes);

											lFileOutputStream.close();

										} catch (Exception e) {
											System.out.println("원본 이미지 저장 안됨");
										}
									}
								} else {
									insertImagesTimeRepository.insertTime(dev_ch, event_time);
//									base64Repository.save(dev_ch, base64);

									String uploadPath = versionMemoryRepository.findPartDriveName() + ":/web_server/" + "roi/";

									File folder = new File(uploadPath);

									if (!folder.exists()) {
										try {
											folder.mkdir();
										} catch (Exception e) {
											System.out.println("폴더 생성 오류");
										}
									}

									uploadPath += dev_ch + ".jpg";

									String data = base64;

									byte[] imageBytes = DatatypeConverter.parseBase64Binary(data);

									try {
										File lOutFile = new File(uploadPath);

										FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);

										lFileOutputStream.write(imageBytes);

										lFileOutputStream.close();

									} catch (Exception e) {
										System.out.println("원본 이미지 저장 안됨");
									}
								}

								postMap.put("dev_ch", dev_ch);
								Map devInfo = eventDao.deviceInfoOne2(map);

								if (devInfo != null) {
									String dev_title = devInfo.get("dev_title").toString();

									String img_name = "ch" + dev_ch + "_" + event_time.split(" ")[1].replaceAll(":", "")
											+ ".jpg";

									int dev_web_port = Integer.parseInt(map.get("dev_web_port").toString());
									int dev_port = Integer.parseInt(map.get("dev_port").toString());

									metadata.put("start", start);
									metadata.put("item_name", map.get("item_name").toString());
									metadata.put("dev_ip", map.get("dev_ip").toString());
									metadata.put("dev_id", map.get("dev_id").toString());
									metadata.put("dev_pwd", map.get("dev_pw").toString());
									metadata.put("dev_port", dev_port);
									metadata.put("dev_web_port", dev_web_port);
									metadata.put("dev_ch", dev_ch);
									metadata.put("event_time", event_time);
									metadata.put("user_name", map.get("user_name").toString());
									metadata.put("user_passwd", map.get("user_passwd").toString());
									metadata.put("img_name", img_name);

									List ml_functions = new ArrayList();

									Map actionEvent = actionSetupService.selectOne(dev_ch);

									LocalDate date = LocalDate.of(
											Integer.parseInt(event_time.split(" ")[0].split("-")[0].toString()),
											Integer.parseInt(event_time.split(" ")[0].split("-")[1].toString()),
											Integer.parseInt(event_time.split(" ")[0].split("-")[2].toString()));
									DayOfWeek dayOfWeek = date.getDayOfWeek();

									String day = dayOfWeek.getDisplayName(TextStyle.SHORT, Locale.KOREAN) + "_"
											+ Integer.parseInt(event_time.split(" ")[1].split(":")[0].toString());

									if (actionEvent != null) {
										if (Integer.parseInt(actionEvent.get("action_fire").toString()) == 0
												&& scheduleRepository.chkDate(dev_ch, "fire", day)) {
											ml_functions.add("kwater_fire");
										}
										if (Integer.parseInt(actionEvent.get("action_falldown").toString()) == 0
												&& scheduleRepository.chkDate(dev_ch, "falldown", day)) {
											ml_functions.add("kwater_falldown");
										}
										if (Integer.parseInt(actionEvent.get("actopm_flood").toString()) == 0
												&& scheduleRepository.chkDate(dev_ch, "flood", day)) {
											ml_functions.add("kwater_flood");
										}
										if (Integer.parseInt(actionEvent.get("action_glove").toString()) == 0
												&& scheduleRepository.chkDate(dev_ch, "glove", day)) {
											ml_functions.add("kwater_glove");
											Map areaMap = new HashMap();
											areaMap.put("dev_ch", dev_ch);
											areaMap.put("area_event", "glove");
											Map area = areaSetService.selectOne(areaMap);
											if (area != null) {
												ArrayList<Map> list = new ObjectMapper().readValue(
														area.get("area_total").toString(),
														new TypeReference<List<Map>>() {
														});
												List pathList = new ArrayList();
												List tmpList = new ArrayList();
												List returnList = new ArrayList();
												for (int i = 0; i < list.size(); i++) {
													Map listMap = list.get(i);
													if (listMap.get("x") != null) {
														pathList = new ArrayList();
														pathList.add(listMap.get("x"));
														pathList.add(listMap.get("y"));
														tmpList.add(pathList);
														if (i == list.size() - 1) {
															returnList.add(tmpList);
														}
													} else {
														if (i != 0) {
															returnList.add(tmpList);
															tmpList = new ArrayList();
														}
													}
												}
												metadata.put("panel_areas", returnList);
											}
										}
										if (Integer.parseInt(actionEvent.get("action_invasion").toString()) == 0
												&& scheduleRepository.chkDate(dev_ch, "invasion", day)) {
											ml_functions.add("kwater_invasion");
											Map areaMap = new HashMap();
											areaMap.put("dev_ch", dev_ch);
											areaMap.put("area_event", "invasion");
											Map area = areaSetService.selectOne(areaMap);
											if (area != null) {
												ArrayList<Map> list = new ObjectMapper().readValue(
														area.get("area_total").toString(),
														new TypeReference<List<Map>>() {
														});
												List pathList = new ArrayList();
												List tmpList = new ArrayList();
												List returnList = new ArrayList();
												for (int i = 0; i < list.size(); i++) {
													Map listMap = list.get(i);
													if (listMap.get("x") != null) {
														pathList = new ArrayList();
														pathList.add(listMap.get("x"));
														pathList.add(listMap.get("y"));
														tmpList.add(pathList);
														if (i == list.size() - 1) {
															returnList.add(tmpList);
														}
													} else {
														if (i != 0) {
															returnList.add(tmpList);
															tmpList = new ArrayList();
														}
													}
												}
												metadata.put("invasion_areas", returnList);
											}
										}
										if (Integer.parseInt(actionEvent.get("actopm_leak").toString()) == 0
												&& scheduleRepository.chkDate(dev_ch, "leak", day)) {
											ml_functions.add("kwater_leak");
										}
										if (Integer.parseInt(actionEvent.get("action_loitering").toString()) == 0
												&& scheduleRepository.chkDate(dev_ch, "loitering", day)) {
											ml_functions.add("kwater_loitering");
											Map areaMap = new HashMap();
											areaMap.put("dev_ch", dev_ch);
											areaMap.put("area_event", "loitering");
											Map area = areaSetService.selectOne(areaMap);
											if (area != null) {
												ArrayList<Map> list = new ObjectMapper().readValue(
														area.get("area_total").toString(),
														new TypeReference<List<Map>>() {
														});
												List pathList = new ArrayList();
												List tmpList = new ArrayList();
												List returnList = new ArrayList();
												for (int i = 0; i < list.size(); i++) {
													Map listMap = list.get(i);
													if (listMap.get("x") != null) {
														pathList = new ArrayList();
														pathList.add(listMap.get("x"));
														pathList.add(listMap.get("y"));
														tmpList.add(pathList);
														if (i == list.size() - 1) {
															returnList.add(tmpList);
														}
													} else {
														if (i != 0) {
															returnList.add(tmpList);
															tmpList = new ArrayList();
														}
													}
												}
												metadata.put("loitering_areas", returnList);
											}
										}
										if (Integer.parseInt(actionEvent.get("action_handaction").toString()) == 0
												&& scheduleRepository.chkDate(dev_ch, "handaction", day)) {
											ml_functions.add("kwater_handaction");
										}
										if (Integer.parseInt(actionEvent.get("action_spin").toString()) == 0
												&& scheduleRepository.chkDate(dev_ch, "spin", day)) {
											ml_functions.add("kwater_spin");
										}

										if (ml_functions.size() != 0) {
											postMap.put("base64", base64);
											postMap.put("base64_return", true);
											postMap.put("metadata", metadata);
											postMap.put("ml_functions", ml_functions);
											String requestUrl = versionMemoryRepository.findVersion().getRequest_url();
											postMap.put("callback_url", requestUrl);

											postService.insertPostQ(postMap);
//											System.out.println("postQ.size() = " + postQ.size());
										}
									}
								}
							}
						}
					} catch (Exception e) {
						// TODO Auto-generated catch block
						System.out.println("startInsertQ 통합 오류");
					}
				}
			}
		};
		// 스레드풀에게 작업 처리 요청
		threadPoolRepository.execute(runnable);
	}

}
