package com.refa.ai.repository;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.ConnectException;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

import javax.annotation.PostConstruct;
import javax.imageio.ImageIO;

import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.impl.auth.DigestScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.messaging.converter.MessageConverter;
import org.springframework.messaging.converter.StringMessageConverter;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.socket.TextMessage;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.refa.ai.dao.EventDao;
import com.refa.ai.dto.ActionLogDto;
import com.refa.ai.dto.EventDto;
import com.refa.ai.dto.ImageTableDto;
import com.refa.ai.dto.MonitoringDto;
import com.refa.ai.infra.WebSession;
import com.refa.ai.service.ActionSetupService;
import com.refa.ai.service.DurationService;
import com.refa.ai.service.EventStatusService;
import com.refa.ai.service.ImageService;
import com.refa.ai.service.RejectEventService;
import com.refa.ai.service.WebSocketService;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ResponseEventsRepositoryImpl implements ResponseEventsRepository {

	private final ThreadPoolRepository threadPoolRepository;
	private final ImageService imageService;
	private final VersionMemoryRepository versionMemoryRepository;
	private final ActionSetupService actionSetupService;
	private final DurationService durationService;
	private final DurationRepository durationRepository;
	private final ScheduleRepository scheduleRepository;
	private final EventDao eventDao;
	private final SimpMessagingTemplate template;
	private final WebSession webSession;
	private final WebSocketService webSocketService;
	private final RejectEventService rejectEventService;
	private final ActionEventMemoryRepository actionEventMemoryRepository;
	private final EventStatusService eventStatusService;
	
	private static Map boxList = new HashMap();
	private static BlockingQueue<Map> responseQ = new LinkedBlockingQueue<Map>();

	@PostConstruct
	public void init() {
		startResponseQ();
		boxList();
	}

	private void boxList() {
		boxList.put("KWATER_Falldown_Detection", "boxes");
		boxList.put("KWATER_Fire_Detection", "segments");
		boxList.put("KWATER_Flood_Detection", "segments");
		boxList.put("KWATER_Glove_Detection", "boxes");
		boxList.put("KWATER_Invasion_Detection", "boxes");
		boxList.put("KWATER_Leak_Detection", "segments");
		boxList.put("KWATER_Loitering_Detection", "boxes");
		boxList.put("KWATER_HandAction_Detection", "boxes");
		boxList.put("KWATER_Spin_Detection", "boxes");
	}
	
	@Override
	public boolean isBox(String eventName) {
		if (boxList.get(eventName) == null) {
			return false;
		}
		return true;
	}
	
	@Override
	public int size() {
		return responseQ.size();
	}

	@Override
	public <E> void save(E data) throws InterruptedException {
		// TODO Auto-generated method stub
		responseQ.put((Map) data);
	}

	@Override
	public void clear() {
		responseQ.clear();
	}

	@Override
	public void startResponseQ() {
		System.out.println("startResponseQ()");
		Runnable runnable = new Runnable() {
			@Override
			public void run() {
				while (true) {
//					ResponseEventDto responseEventDto;
					Map map;
					try {
//						responseEventDto = responseQ.take();
						map = responseQ.take();
						
//						String base64 = responseEventDto.getBase64();
						String base64 = map.get("base64").toString();
						
//						MetadataDto metadata = responseEventDto.getMetadata();
						Map metadata = (Map) map.get("metadata");
						
//						List<MlResultDto> ml_result = responseEventDto.getMl_result();
						ArrayList ml_result = (ArrayList) map.get("ml_result");

						// insertResponseLogJson(map); // ���� ����

						// insertResponseLog(map); // ���� ����

						/**
						 * 1. �ݺ��� 1���� �� ������ ���� ���� ���� ����
						 * 2. �� �ݺ��� �۾��� controller���� �� �� service���� �� �� ��� ��
						 *   if i) controller���� �ϸ� controller�� ����������(Ư�� ������ ������ �� ����� ���� ����)
						 *   if ii) service���� �ϸ� service���� service�� ȣ���ϴ� ���� ������ 
						 * 3. �̹��� ���񽺴� ���� �̹����� ����� �̹��� ����� ������ ���� �����ϸ� �Ű������� dto�� ���� ����
						 * 4. �˻� ���(monitoring) ���񽺵� �̹��� ����(����ϰ� �����̹��� �ߺ�?)�� �̹��� ������ ������ ������ �����ϸ� �Ű������� dto�� ������ ��?
						 * 5. ��ī�ٷ� �������� ������ ������ �ݺ������� �̺�Ʈ�� ����Ʈ�� ���� �� ���� ����
						 * 6. ��������� ��ȹ�� �־���� �ϹǷ� ��Ʈ�ѷ������� �̹��� + �����͸� �ϳ��� �������� ������ �� �ִٴ� �͵� ����ؾ� ��
						 * 7. �� �� �̺�Ʈ �׼ǵ� ���� �����ε� �����忡 �������� ���� �� ���� ���� ���� �� �� ����غ��� �� 
						 */
						
						boolean isDuration = false;
						try {
							isDuration = saveImage(metadata, ml_result, base64);
						} catch(Exception e) {
							System.out.println("saveImage Error");
						}
						
						if (isDuration) {
							try {
								saveImageData(metadata, ml_result);
							} catch(Exception e) {
								System.out.println("saveImageData Error");
							}

//							monitoringThread(metadata, ml_result);

							try {
								sendScada(map);
							} catch(Exception e) {
								System.out.println("sendScada Error");
							}

							try {
								dashThread(metadata, ml_result);
							} catch(Exception e) {
								System.out.println("dashThread Error");
							}

							try {
								logThread(metadata, ml_result);
							} catch(Exception e) {
								System.out.println("logThread Error");
							}


							// sendEventAction(metadata, ml_result); // ���� ����

							try {
								checkShowPopUp(metadata, ml_result);
							} catch (Exception e) {
								System.out.println("checkShowPopUp Error");
							}
							
							try {
								sendWebsocket(map);
							} catch (Exception e) {
								System.out.println("sendWebsocket Error");
							}
						}
					} catch (Exception e) {
						// TODO Auto-generated catch block
						System.out.println("startResponseQ Error");
					}
				}
			}
		};
		// ������Ǯ���� �۾� ó�� ��û
		threadPoolRepository.execute(runnable);
	}

	private boolean saveImage(Map metadata, ArrayList ml_result, String base64)
			throws ParseException, java.text.ParseException, IOException {
		// System.out.println("saveImage()");
		boolean isDuration = false;
		
		if (ml_result.size() > 0) {

			String class_name = "";
			String monitoring_info = "";

			/**
			 * duration ���� �ش� �̹����� ���� ����� ������ �� ����� �� �� �� �ϳ��� �෹�̼�(default 10��)�� �����Ǹ� �۾�
			 * ���� 1.�ݺ��� ���Ƽ� ���� ��� Ȯ�� 2.���� ��� Ȯ���ϸ鼭 ������ �෹�̼� Ȯ�� 3.���ٰ� �߰��� �ϳ��� �෹�̼� �����Ǹ�
			 * true(�ƴϸ� false �״��) ������ : �ݺ��� ���ٰ� �߰� �Ǵ� ���������� �෹�̼� ������ �� ����Ǹ� �ٽ� ó������ �ݺ��� ���鼭
			 * �෹�̼� �ʱ�ȭ �� ���ΰ� �����غ����� �� : �� ������ŭ �ݺ��� ���� �� ���� �޸𸮿� �����̶� ������ �� ���ΰ�(�ִ� 10���̸�)
			 * ��� : ���� �� �� �� �����Ƿ� �׳� �ݺ��� ����
			 */

			String dev_ip = metadata.get("dev_ip").toString();
			String dev_ch = metadata.get("dev_ch").toString();
			String event_time = metadata.get("event_time").toString();

			LocalDate date = LocalDate.of(
					Integer.parseInt(event_time.split(" ")[0].split("-")[0].toString()),
					Integer.parseInt(event_time.split(" ")[0].split("-")[1].toString()),
					Integer.parseInt(event_time.split(" ")[0].split("-")[2].toString()));
			DayOfWeek dayOfWeek = date.getDayOfWeek();

			String day = dayOfWeek.getDisplayName(TextStyle.SHORT, Locale.KOREAN) + "_"
					+ Integer.parseInt(event_time.split(" ")[1].split(":")[0].toString());

			for (int i = 0; i < ml_result.size(); i++) {
				Map ml_result_map = (Map) ml_result.get(i);
				if (ml_result_map.get("status").toString().equals("SUCCESS")
						&& Integer.parseInt(ml_result_map.get("count").toString()) > 0) {
					String model_name = ml_result_map.get("model_name").toString();
					class_name += model_name + 1;
					monitoring_info += "/" + model_name + ":" + 1;
					
					boolean isTrue = scheduleRepository.chkDate(Integer.parseInt(dev_ch), model_name.split("_")[1].toLowerCase(), day);
					boolean isTrue1 = actionSetupService.checkOn(Integer.parseInt(dev_ch), model_name);
					boolean isTrue2 = actionSetupService.selectOne(Integer.parseInt(dev_ch)) != null;
					boolean isTrue3 = actionSetupService.selectOne(Integer.parseInt(dev_ch)).get("confidence") == null;
					boolean isTrue4 = Integer.parseInt(actionSetupService.selectOne(Integer.parseInt(dev_ch))
							.get("confidence").toString()) == 1;
					boolean isTrue5 = Integer.parseInt(actionSetupService.selectOne(Integer.parseInt(dev_ch))
							.get("confidence").toString()) <= Double.parseDouble(
									((Map) ((List) ml_result_map.get(boxList.get(model_name))).get(0))
											.get("confidence").toString());
					boolean isTrue6 = durationService.chkDuration(dev_ip, dev_ch, model_name, event_time);
					
					if (isTrue && isTrue1 && isTrue2 && (isTrue3 || isTrue4 || isTrue5) && isTrue6) {
						isDuration = true;
						durationRepository.save(dev_ip + "_" + dev_ch + "_" + model_name, event_time);
					}
				}
			}
			
			if (isDuration) {
				String firstPath = ":/web_server/";
				String img_name = metadata.get("img_name").toString(); // ���� �̹��� ���ϸ����� ����
				String login_id = metadata.get("user_name").toString(); // ����� ID
				String item_name = metadata.get("item_name").toString();
				String img_data = base64;
				String monitoring_tag = item_name + "_ch" + dev_ch + "_" + event_time.split(" ")[0].replaceAll("-", "")
						+ "_" + class_name;

				String img_size = imageService.saveImage(firstPath, login_id, item_name, event_time, img_data, img_name);
				
				String uploadPath = versionMemoryRepository.findMasterDriveName() + firstPath + login_id + "/" + item_name + "/" + event_time.split(" ")[0].split("-")[0] + event_time.split(" ")[0].split("-")[1]
						+ event_time.split(" ")[0].split("-")[2] + "/" + img_name;
				
				String thumb_name = (uploadPath + img_name).substring(0, (uploadPath + img_name).lastIndexOf("."))
						+ "_thumb.jpg";
 				
				MonitoringDto monitoringDto = new MonitoringDto();
				monitoringDto.setMonitoring_src(thumb_name.substring(thumb_name.indexOf("/")));
				monitoringDto.setMonitoring_time(event_time);
				monitoringDto.setMonitoring_item(item_name);
				monitoringDto.setMonitoring_ch(dev_ch);
				monitoringDto.setMonitoring_tag(monitoring_tag);
				monitoringDto.setMonitoring_info(monitoring_info.substring(1));
				monitoringDto.setLogin_id(login_id);
				monitoringDto.setMonitoring_size(img_size);

				sendMonitoring(monitoringDto);
			}
		}
		return isDuration;
	}

	private void sendMonitoring(MonitoringDto monitoringDto) {
		JSONObject jsonObjec2 = new JSONObject();

		jsonObjec2.put("src", monitoringDto.getMonitoring_src());
		jsonObjec2.put("dev_ch", monitoringDto.getMonitoring_ch());

		Map map = new HashMap();
		map.put("dev_ch", monitoringDto.getMonitoring_ch());
		Map return_map = eventDao.deviceInfoOne2(map);

		if (return_map != null) {
			jsonObjec2.put("dev_title", return_map.get("dev_title"));

			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/showMonitor", jsonObjec2.toJSONString());

			eventDao.updateMonitoring(monitoringDto);

			jsonObjec2.put("monitoring_src", monitoringDto.getMonitoring_src());
			jsonObjec2.put("monitoring_time", monitoringDto.getMonitoring_time());
			jsonObjec2.put("monitoring_item", monitoringDto.getMonitoring_item());
			jsonObjec2.put("monitoring_ch", monitoringDto.getMonitoring_ch());
			jsonObjec2.put("monitoring_tag", monitoringDto.getMonitoring_tag());
			jsonObjec2.put("monitoring_info", monitoringDto.getMonitoring_info());
			jsonObjec2.put("login_id", monitoringDto.getLogin_id());
			jsonObjec2.put("monitoring_size", monitoringDto.getMonitoring_size());

//			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
//			this.template.convertAndSend("/showImage", jsonObjec2.toJSONString());
		}
	}

	private void saveImageData(Map metadata, ArrayList ml_result) throws ParseException, IOException {
		// System.out.println("saveImageData()");

		if (ml_result.size() > 0) {
			boolean isResult = false;

			String class_name = "";
			List originalTags = new ArrayList();
			List colorTags = new ArrayList();

			for (int i = 0; i < ml_result.size(); i++) {
				Map ml_result_map = (Map) ml_result.get(i);
				if (ml_result_map.get("status").toString().equals("SUCCESS")
						&& Integer.parseInt(ml_result_map.get("count").toString()) > 0) {
					isResult = true;
					class_name += ml_result_map.get("model_name").toString() + 1;
					originalTags.add(ml_result_map.get("model_name").toString());
				}
			}

			if (isResult) {
				ImageTableDto imageTableDto = new ImageTableDto();

				String login_id = metadata.get("user_name").toString(); // ����� ID
				String dev_ch = metadata.get("dev_ch").toString();
				String item_name = metadata.get("item_name").toString();
				String dev_ip = metadata.get("dev_ip").toString();
				String event_time = metadata.get("event_time").toString();
				String dev_pwd = metadata.get("dev_pwd").toString();
				String dev_port = metadata.get("dev_port").toString();
				String dev_web_port = metadata.get("dev_web_port").toString();
				String dev_id = metadata.get("dev_id").toString();
				String user_passwd = metadata.get("user_passwd").toString();
				long start = (Long) metadata.get("start");

				String img_name = metadata.get("img_name").toString(); // ���� �̹��� ���ϸ����� ����
				String monitoring_tag = item_name + "_ch" + dev_ch + "_" + event_time.split(" ")[0].replaceAll("-", "")
						+ "_" + class_name;

				String uploadPath = versionMemoryRepository.findMasterDriveName() + ":/web_server/" + login_id + "/" + item_name + "/"
						+ event_time.split(" ")[0].split("-")[0] + event_time.split(" ")[0].split("-")[1]
						+ event_time.split(" ")[0].split("-")[2] + "/" + img_name;

				File f = new File(uploadPath);

				BufferedImage bi = ImageIO.read(f);

				int hWidth = bi.getWidth();
				int hHeight = bi.getHeight();

				uploadPath = uploadPath.replace("web_server", "webserver");
				
				imageTableDto.setLogin_id(login_id);
				imageTableDto.setDev_ch(dev_ch);
				imageTableDto.setDev_pwd(dev_pwd);
				imageTableDto.setStart_time(start);
				imageTableDto.setItem_name(item_name);
				imageTableDto.setDev_ip(dev_ip);
				imageTableDto.setDev_port(dev_port);
				imageTableDto.setEvent_time(event_time);
				imageTableDto.setDev_id(dev_id);
				imageTableDto.setDev_web_port(dev_web_port);
				imageTableDto.setImage_name(uploadPath.substring(uploadPath.indexOf("/")));
				imageTableDto.setMonitoring_tag(monitoring_tag);
				imageTableDto.setUser_name(login_id);
				imageTableDto.setUser_passwd(user_passwd);

				imageTableDto.setImage_queue(0);
				imageTableDto.setThumb_name(
						uploadPath.substring(uploadPath.indexOf("/"), uploadPath.lastIndexOf(".")) + "_thumb.jpg");
				imageTableDto.setWidth(hWidth);
				imageTableDto.setHeight(hHeight);
				imageTableDto.setColor_tags(colorTags.toString());
				imageTableDto.setTags(originalTags.toString().replaceAll("\\\\", ""));

				eventDao.insertImageEvent(imageTableDto);
			}
		}
	}

	private void sendScada(Map responseMap) throws JsonProcessingException {
		// System.out.println("sendWebsocket()");

		Map metadata = (Map) responseMap.get("metadata");

		ArrayList ml_result = (ArrayList) responseMap.get("ml_result");

		if (ml_result.size() > 0) {
			String ip = metadata.get("dev_ip").toString();
			int port = Integer.parseInt(metadata.get("dev_port").toString());
			int ch = Integer.parseInt(metadata.get("dev_ch").toString());
			List list = new ArrayList();
			String event_time = metadata.get("event_time").toString();
			String scada = "SUCCESS";
			boolean isResult = false;

			List<Map> result_list = new ArrayList<Map>();

			for (int i = 0; i < ml_result.size(); i++) {
				Map ml_result_map = (Map) ml_result.get(i);
				
				boolean isTrue1 = ml_result_map.get("status").toString().equals("SUCCESS");
				boolean isTrue2 = Integer.parseInt(ml_result_map.get("count").toString()) > 0;
				
				if (isTrue1 && isTrue2) {
					result_list.add(ml_result_map);
					String model_name = ml_result_map.get("model_name").toString();

					list.add(model_name);

					isResult = true;
				}
			}
			
			if (isResult) {
				Map map = new LinkedHashMap();
				map.put("ip", ip);
				map.put("port", port);
				map.put("ch", ch);
				map.put("model_name", list);
				map.put("result_list", result_list);
				map.put("event_time", event_time);
				map.put("event", scada);
				map.put("isEventAction", "Y");

				TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(map));
				webSession.sendMessage(return_message, webSocketService);
			}
		}
	}

	private void dashThread(Map metadata, ArrayList ml_result) throws ParseException {
		// System.out.println("dashThread()");

		if (ml_result.size() > 0) {
			boolean isResult = false;

			String class_name = "";
			List originalTags = new ArrayList();

			for (int i = 0; i < ml_result.size(); i++) {
				Map ml_result_map = (Map) ml_result.get(i);
				if (ml_result_map.get("status").toString().equals("SUCCESS")
						&& Integer.parseInt(ml_result_map.get("count").toString()) > 0) {
					isResult = true;
					String model_name = ml_result_map.get("model_name").toString();
					class_name += model_name + 1;
					originalTags.add(model_name);
				}
			}

			if (isResult) {
				String item_name = metadata.get("item_name").toString();
				String dev_ip = metadata.get("dev_ip").toString();
				String dev_id = metadata.get("dev_id").toString();
				String dev_pwd = metadata.get("dev_pwd").toString();
				String dev_port = metadata.get("dev_port").toString();
				String dev_web_port = metadata.get("dev_web_port").toString();

				String dev_channel = metadata.get("dev_ch").toString();
				String event_time = metadata.get("event_time").toString();
				String event_info = "count : " + 1;
				String user_id = metadata.get("user_name").toString();
				String img_name = "/web_server/" + user_id + "/" + item_name + "/"
						+ event_time.split(" ")[0].split("-")[0] + event_time.split(" ")[0].split("-")[1]
						+ event_time.split(" ")[0].split("-")[2] + "/" + metadata.get("img_name").toString();

				EventDto eventDto = new EventDto();

				// �����忡�� ��ų �۾� ����
				for (int i = 0; i < originalTags.size(); i++) {
					eventDto.setItem_name(item_name);
					eventDto.setDev_ip(dev_ip);
					eventDto.setDev_channel(dev_channel);
					eventDto.setEvent_time(event_time);
					eventDto.setUser_id(user_id);

					eventDto.setItem_type("1");
					eventDto.setItem_ip(dev_ip);
					eventDto.setItem_id(user_id);
					eventDto.setItem_pwd("00pp;;//");
					eventDto.setItem_port("7000");
					eventDto.setItem_mac("000C280B691B");
					eventDto.setDev_mac("000C280B691B");
					eventDto.setDev_id(dev_id);
					eventDto.setDev_pwd(dev_pwd);
					eventDto.setDev_port(dev_port);
					eventDto.setDev_web_port(dev_web_port);
					eventDto.setImage_name(img_name);

					eventDto.setEvent_info(event_info);

					String event_name = originalTags.get(i).toString();

					eventDto.setEvent_name(event_name);

					insertDash(eventDto);

				}
			}
		}
	}
	
	public void insertDash(EventDto eventDto) {
		// System.out.println("insertDash()");

		eventDao.updateCount(eventDto);

		// System.out.println("updateCount = " + (nano - start2)/1000.0 + "��");

		String jsonStr = "";
		ObjectMapper mapper = new ObjectMapper();

		try {
			jsonStr = mapper.writeValueAsString(eventDto);
		} catch (Exception e1) {
			System.out.println("���� �߻�");
		}

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/receiveCount", jsonStr);

	}

	private void logThread(Map metadata, ArrayList ml_result) throws ParseException {
//		System.out.println("logThread()");
		if (ml_result.size() > 0) {
			boolean isResult = false;

			String class_name = "";
			List originalTags = new ArrayList();
			List<Double> confidenceList = new ArrayList<>();

			for (int i = 0; i < ml_result.size(); i++) {
				Map ml_result_map = (Map) ml_result.get(i);
				if (ml_result_map.get("status").toString().equals("SUCCESS")
						&& Integer.parseInt(ml_result_map.get("count").toString()) > 0) {
					isResult = true;
					class_name += ml_result_map.get("model_name").toString() + 1;
					originalTags.add(ml_result_map.get("model_name").toString());
					double confidence = Double.parseDouble(
							((Map) ((List) ml_result_map.get(boxList.get(ml_result_map.get("model_name").toString()))).get(0))
							.get("confidence").toString());
					confidenceList.add(confidence);
				}
			}

			if (isResult) {
				String item_name = metadata.get("item_name").toString();
				String dev_ip = metadata.get("dev_ip").toString();
				String dev_id = metadata.get("dev_id").toString();
				String dev_pwd = metadata.get("dev_pwd").toString();
				String dev_port = metadata.get("dev_port").toString();
				String dev_web_port = metadata.get("dev_web_port").toString();

				String dev_channel = metadata.get("dev_ch").toString();
				String event_time = metadata.get("event_time").toString();
				String event_info = "count : " + 1;
				String user_id = metadata.get("user_name").toString();

				for (int i = 0; i < originalTags.size(); i++) {
					String event_name = originalTags.get(i).toString();

					EventDto eventDto = new EventDto();

					eventDto.setItem_name(item_name);
					eventDto.setDev_ip(dev_ip);
					eventDto.setDev_channel(dev_channel);
					// System.out.println("insertLog = " + dev_channel);
					eventDto.setEvent_time(event_time);
					eventDto.setUser_id(user_id);

					eventDto.setItem_type("1");
					eventDto.setItem_ip(dev_ip);
					eventDto.setItem_id(user_id);
					eventDto.setItem_pwd("00pp;;//");
					eventDto.setItem_port("7000");
					eventDto.setItem_mac("000C280B691B");
					eventDto.setDev_mac("000C280B691B");
					eventDto.setDev_id(dev_id);
					eventDto.setDev_pwd(dev_pwd);
					eventDto.setDev_port(dev_port);
					eventDto.setDev_web_port(dev_web_port);
					eventDto.setEvent_source("���������������ý���");
					eventDto.setEvent_confidence(confidenceList.get(i));

					eventDto.setEvent_info(event_info);

					eventDto.setEvent_name(event_name);

					insertLog(eventDto);
				}
			}
		}
	}

	private void insertLog(EventDto eventDto) {

		eventDao.insertJson(eventDto);

		String jsonStr = "";
		ObjectMapper mapper = new ObjectMapper();

		try {
			jsonStr = mapper.writeValueAsString(eventDto);
		} catch (Exception e1) {
			System.out.println("���� �߻�");
		}

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/receiveMessage", jsonStr);

	}

	private void checkShowPopUp(Map metadata, ArrayList ml_result) throws Exception { // �˾� ������ �� Ȯ���ϴ� ����
//		System.out.println("checkShowPopUp()");

		try {
			if (ml_result.size() > 0) {
				boolean isResult = false;

				String class_name = "";
				
				String login_id = metadata.get("user_name").toString(); // ����� ID
				String dev_ch = metadata.get("dev_ch").toString();
				String dev_title = "";
				String dev_mac_address = "";
				Map return_map = eventDao.deviceInfoOne2(metadata);
				if (return_map != null) {
					if (return_map.get("dev_title") != null) {
						dev_title = return_map.get("dev_title").toString();
					}
					if (return_map.get("dev_mac_address") != null) {
						dev_mac_address = return_map.get("dev_mac_address").toString();
					}
				}
				String dev_id = metadata.get("dev_id").toString();
				String dev_pwd = metadata.get("dev_pwd").toString();
				String item_name = metadata.get("item_name").toString();
				String dev_ip = metadata.get("dev_ip").toString();
				String event_time = metadata.get("event_time").toString();
				String img_name = metadata.get("img_name").toString(); // ���� �̹��� ���ϸ����� ����
				String dev_web_port = metadata.get("dev_web_port").toString();

				for (int i = 0; i < ml_result.size(); i++) {
					Map ml_result_map = (Map) ml_result.get(i);
					if (ml_result_map.get("status").toString().equals("SUCCESS")
							&& Integer.parseInt(ml_result_map.get("count").toString()) > 0) {
						String model_name = ml_result_map.get("model_name").toString();

						String uploadPath = versionMemoryRepository.findMasterDriveName() + ":/web_server/" + login_id + "/" + item_name + "/"
								+ event_time.split(" ")[0].split("-")[0] + event_time.split(" ")[0].split("-")[1]
								+ event_time.split(" ")[0].split("-")[2] + "/" + img_name;

						File f = new File(uploadPath);

						BufferedImage bi = ImageIO.read(f);

						int hWidth = bi.getWidth();
						int hHeight = bi.getHeight();

						Map map = new HashMap();
						map.put("img_name", uploadPath.substring(uploadPath.indexOf("/")));
						map.put("width", hWidth);
						map.put("height", hHeight);
						map.put("event_name", login_id + "_" + dev_ch + "_" + model_name);
						map.put("dev_ip", dev_ip);
						map.put("login_id", login_id);
						map.put("dev_ch", dev_ch);
						map.put("model_name", model_name);
						map.put("event_time", event_time);
						map.put("dev_title", dev_title);
						map.put("action_source", "���������������ý���");
						map.put("dev_id", dev_id);
						map.put("dev_pwd", dev_pwd);
						map.put("dev_web_port", dev_web_port);
						map.put("dev_mac_address", dev_mac_address);

						Date date_time = new Date();

//						System.out.println("���� ���� = " + rejectEventService.chkTime(Integer.parseInt(dev_ch), model_name, date_time));

						if (rejectEventService.chkTime(Integer.parseInt(dev_ch), model_name,
								new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(event_time))) {
//							System.out.println(model_name + " / " + dev_ch);

							eventReject(map);

							if (actionEventMemoryRepository.findByEvent(dev_title, model_name) != null) {
								Map actionMap = actionEventMemoryRepository.findByEvent(dev_title, model_name);

								String action_action = actionMap.getOrDefault("action_action", "").toString();
								
								if (action_action.contains("�˾�")) {
									showPopupImage(map);
								}

								if (action_action.contains("�˶�")) {
									playAlarm(map);
								}

								if (action_action.contains("������")) {
									goToPreset(map);
								}
								
								if (action_action.contains("����Ŀ")) {
									checkNetworkSpeaker(map);
								}

							}

						}
					}
				}

				if (isResult) {
				}
			}
		} catch (Exception e) {
			System.out.println("checkShowPopUp error");
		}
	}
	
	private void eventReject(Map map) throws JsonProcessingException {
		// System.out.println("eventReject");

		Map devInfo = eventDao.deviceInfoOne2(map);

		if (devInfo != null) {
			Map statusMap = new HashMap();
			statusMap.put("action_source", map.get("action_source"));
			statusMap.put("event_action", "����");
			statusMap.put("dev_ch", devInfo.get("dev_ch"));
			statusMap.put("dev_title", devInfo.get("dev_title"));
			statusMap.put("model_name", map.get("model_name"));
			statusMap.put("dev_ip", devInfo.get("dev_ip"));
			statusMap.put("event_time", map.get("event_time"));
			statusMap.put("dev_id", devInfo.get("dev_id"));
			statusMap.put("dev_pwd", devInfo.get("dev_pwd"));
			statusMap.put("login_id", devInfo.get("login_id"));
			statusMap.put("dev_web_port", devInfo.get("dev_web_port"));
			statusMap.put("dev_mac_address", devInfo.get("dev_mac_address"));

			boolean isPresent = eventStatusService.save(statusMap);

			statusMap.put("isPresent", isPresent);

			ObjectMapper mapper = new ObjectMapper();
			String returnStr = mapper.writeValueAsString(statusMap);

			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/eventStatus", returnStr);

			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/receiveEventStatus", returnStr);
		}
	}

	private void showPopupImage(Map map) throws JsonProcessingException { // �˾��� ������ ����, �����ε�
		// System.out.println("showPopupImage()");

		ObjectMapper mapper = new ObjectMapper();
		String returnStr = mapper.writeValueAsString(map);

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/showPopupImage", returnStr);
	}

	private void playAlarm(Map map) throws JsonProcessingException {
		// System.out.println("playAlarm()");

		ObjectMapper mapper = new ObjectMapper();
		String returnStr = mapper.writeValueAsString(map);

		map.put("action_action", "�˶�");

		String dev_title = "";
		Map returnMap2 = eventDao.deviceInfoOne2(map);
		if (returnMap2 != null) {
			dev_title = returnMap2.get("dev_title").toString();
		}
		map.put("dev_title", dev_title);
		map.put("isEvent", true);

		Map returnMap = eventDao.selectEventActionByAction(map);

		if (returnMap != null) {
			// �̺�Ʈ �׼� ���� üũ�ؾߵ�

//			List<Map> list = eventDao.selectNetworkSpeaker();

//			for (int i = 0; i < list.size(); i++) {
//				playNetworkSpeaker(returnMap, list.get(i));
//			}

			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/playAlarm", returnStr);
		}
	}

	private void goToPreset(Map map) throws JsonProcessingException {
		// System.out.println("goToPreset()");

		map.put("action_action", "������");

		String dev_title = "";
		Map returnMap2 = eventDao.deviceInfoOne2(map);
		if (returnMap2 != null) {
			dev_title = returnMap2.get("dev_title").toString();
		}

		map.put("dev_title", dev_title);
		map.put("isEvent", true);

		Map return_map = eventDao.selectEventActionByAction(map);

		if (return_map != null) {
			// �̺�Ʈ �׼� ���� üũ�ؾߵ�
			Map statusMap = new HashMap();
			statusMap.put("action_source", map.get("action_source"));
			statusMap.put("event_action", "������");
			statusMap.put("dev_ch", return_map.get("dev_ch"));
			statusMap.put("dev_title", return_map.get("dev_title"));
			statusMap.put("model_name", map.get("model_name"));
			statusMap.put("dev_ip", return_map.get("dev_ip"));
			statusMap.put("event_time", map.get("event_time"));
			statusMap.put("dev_id", return_map.get("dev_id"));
			statusMap.put("dev_pwd", return_map.get("dev_pwd"));
			statusMap.put("login_id", return_map.get("login_id"));
			statusMap.put("dev_web_port", return_map.get("dev_web_port"));
			statusMap.put("dev_mac_address", return_map.get("dev_mac_address"));
			statusMap.put("pre_title", map.get("pre_title"));

			boolean isPresent = eventStatusService.save(statusMap);

			statusMap.put("isPresent", isPresent);

			ObjectMapper mapper = new ObjectMapper();
			String returnStr = mapper.writeValueAsString(statusMap);

			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/receiveEventStatus", returnStr);

			Map returnMap = new LinkedHashMap();
			returnMap.put("command", "RF_REQ_GOTOPRESET");
			returnMap.put("sender", "web");
			returnMap.put("web_user", map.get("login_id"));
			returnMap.put("ip", return_map.get("dev_ip"));
			returnMap.put("id", return_map.get("dev_id"));
			returnMap.put("pw", return_map.get("dev_pwd"));
			returnMap.put("mac", return_map.get("dev_mac_address"));
			returnMap.put("preset_name", return_map.get("pre_title"));
			returnMap.put("port", return_map.get("dev_web_port"));

			TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(returnMap));
			webSession.sendMessage(return_message, webSocketService);
		}
	}

	private void checkNetworkSpeaker(Map map) throws ClientProtocolException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		String returnStr = mapper.writeValueAsString(map);

		map.put("action_action", "����Ŀ");

		String dev_title = "";
		String dev_ch = "";
		Map returnMap2 = eventDao.deviceInfoOne2(map);
		if (returnMap2 != null) {
			dev_title =returnMap2.get("dev_title").toString();
			dev_ch = "ch" + returnMap2.get("dev_ch").toString();
		}
		map.put("dev_ch", dev_ch);
		map.put("dev_title", dev_title);
		map.put("isEvent", true);

		Map returnMap = eventDao.selectEventActionByAction(map);

		if (returnMap != null) {
			// �̺�Ʈ �׼� ���� üũ�ؾߵ�

			List<Map> list = eventDao.selectNetworkSpeaker();

			for (Map networkSpeaker : list) {
				if (networkSpeaker.get("network_title").toString().equals(returnMap.get("network_title").toString())) {
					playNetworkSpeaker(returnMap, networkSpeaker);
					break;
				}
			}
		}
	}
	
	private void playNetworkSpeaker(Map returnMap, Map map) throws ClientProtocolException, IOException {
//		System.out.println("sendSpeakerNumber()");

		String body = "";
//		String id = "root";
		String id = map.get("network_id").toString();
//		String pw = "00pp;;//";
		String pw = map.get("network_pwd").toString();
		String enc = id + ":" + pw;
		String ip = map.get("network_ip").toString();
		String port = map.get("network_port").toString();

		String model_name = returnMap.get("action_event").toString();

		int num = 0;

		if (model_name.toLowerCase().equals("KWATER_Falldown_Detection".toLowerCase())) {
			if (!map.get("network_falldown").toString().equals("")) {
				num = Integer.parseInt(map.get("network_falldown").toString().split(", ")[1]);
			}
		} else if (model_name.toLowerCase().equals("KWATER_Fire_Detection".toLowerCase())) {
			if (!map.get("network_fire").toString().equals("")) {
				num = Integer.parseInt(map.get("network_fire").toString().split(", ")[1]);
			}
		} else if (model_name.toLowerCase().equals("KWATER_Flood_Detection".toLowerCase())) {
			if (!map.get("network_flood").toString().equals("")) {
				num = Integer.parseInt(map.get("network_flood").toString().split(", ")[1]);
			}
		} else if (model_name.toLowerCase().equals("KWATER_Glove_Detection".toLowerCase())) {
			if (!map.get("network_glove").toString().equals("")) {
				num = Integer.parseInt(map.get("network_glove").toString().split(", ")[1]);
			}
		} else if (model_name.toLowerCase().equals("KWATER_Invasion_Detection".toLowerCase())) {
			if (!map.get("network_invasion").toString().equals("")) {
				num = Integer.parseInt(map.get("network_invasion").toString().split(", ")[1]);
			}
		} else if (model_name.toLowerCase().equals("KWATER_Leak_Detection".toLowerCase())) {
			if (!map.get("network_leak").toString().equals("")) {
				num = Integer.parseInt(map.get("network_leak").toString().split(", ")[1]);
			}
		} else if (model_name.toLowerCase().equals("KWATER_Loitering_Detection".toLowerCase())) {
			if (!map.get("network_loitering").toString().equals("")) {
				num = Integer.parseInt(map.get("network_loitering").toString().split(", ")[1]);
			}
		} else if (model_name.toLowerCase().equals("KWATER_HandAction_Detection".toLowerCase())) {
			if (!map.get("network_handaction").toString().equals("")) {
				num = Integer.parseInt(map.get("network_handaction").toString().split(", ")[1]);
			}
		} else if (model_name.toLowerCase().equals("KWATER_Spin_Detection".toLowerCase())) {
			if (!map.get("network_spin").toString().equals("")) {
				num = Integer.parseInt(map.get("network_spin").toString().split(", ")[1]);
			}
		} else if (model_name.toLowerCase().equals("KWATER_Cmtank_leak".toLowerCase())) {
			if (!map.get("network_cmtank").toString().equals("")) {
				num = Integer.parseInt(map.get("network_cmtank").toString().split(", ")[1]);
			}
		} else if (model_name.toLowerCase().equals("KWATER_Outtank_leak".toLowerCase())) {
			if (!map.get("network_outtank").toString().equals("")) {
				num = Integer.parseInt(map.get("network_outtank").toString().split(", ")[1]);
			}
		} else if (model_name.toLowerCase().equals("KWATER_Overflow".toLowerCase())) {
			if (!map.get("network_overflow").toString().equals("")) {
				num = Integer.parseInt(map.get("network_overflow").toString().split(", ")[1]);
			}
		}

//		System.out.println("alarm num = " + num);
		
		if (num >= 0) {
			String postUrl = "http://" + ip + ":" + port + "/axis-cgi/playclip.cgi?clip=" + num;

//			System.out.println("postUrl = " + postUrl);
			
			try {
				CloseableHttpClient Getclient = HttpClients.createDefault(); // HttpClient ����

				URL url = new URL(postUrl);

				HttpHost GetpostRequest = new HttpHost(url.getHost(), url.getPort(), url.getProtocol()); // POST �޼ҵ� URL
																											// ����
				HttpClientContext context = HttpClientContext.create();

				CredentialsProvider credsProvider = new BasicCredentialsProvider();
				credsProvider.setCredentials(AuthScope.ANY, new UsernamePasswordCredentials(id, pw));
				AuthCache authCache = new BasicAuthCache();
				DigestScheme digestScheme = new DigestScheme();
				digestScheme.overrideParamter("realm", "realm");
				digestScheme.overrideParamter("nonce", "whatever");
				digestScheme.overrideParamter("clip", "0");
				authCache.put(GetpostRequest, digestScheme);

				context.setCredentialsProvider(credsProvider);
				context.setAuthCache(authCache);
//			    String payload = "clip=0";
//			    HttpPost httpPost = new HttpPost(url.getPath());
//			    httpPost.setEntity(new StringEntity(payload));

				HttpGet httpGet = new HttpGet(postUrl);

				// HttpGet httpGet = new
				// HttpGet("http://192.168.100.57/axis-cgi/playclip.cgi?clip=0");
				// CloseableHttpResponse response = Getclient.execute(GetpostRequest, httpGet,
				// context);
				CloseableHttpResponse response = Getclient.execute(GetpostRequest, httpGet, context);

				if (response.getStatusLine().getStatusCode() == 200) {
					ResponseHandler<String> handler = new BasicResponseHandler();
					body = handler.handleResponse(response);
//					System.out.println("����Ŀ = " + body);
				} else {
//					System.out.println("response is error : " + response.getStatusLine().getStatusCode());
				}
				response.close();
			} catch(ConnectException e) {
				System.out.println("playNetworkSpeaker Error");
			}
		}
	}

	private void sendWebsocket(Map responseMap) throws Exception {
//		System.out.println("sendWebsocket()");

		Map metadata = (Map) responseMap.get("metadata");

		ArrayList ml_result = (ArrayList) responseMap.get("ml_result");

		try {
			if (ml_result.size() > 0) {
				boolean isResult = false;

				String class_name = "";

				String ip = metadata.get("dev_ip").toString();
				int port = Integer.parseInt(metadata.get("dev_port").toString());
				int ch = Integer.parseInt(metadata.get("dev_ch").toString());
				List list = new ArrayList();
				String event_time = metadata.get("event_time").toString();
				String scada = "SUCCESS";

				String login_id = metadata.get("user_name").toString(); // ����� ID
				String dev_ch = metadata.get("dev_ch").toString();

				String dev_title = "";
				Map return_map = eventDao.deviceInfoOne2(metadata);
				if (return_map != null) {
					dev_title = return_map.get("dev_title").toString();
				}
				metadata.put("dev_title", dev_title);

				String item_name = metadata.get("item_name").toString();
				String img_name = metadata.get("img_name").toString(); // ���� �̹��� ���ϸ����� ����

				List<Map> result_list = new ArrayList<Map>();

				for (int i = 0; i < ml_result.size(); i++) {
					Map ml_result_map = (Map) ml_result.get(i);
					
					boolean isTrue1 = ml_result_map.get("status").toString().equals("SUCCESS");
					boolean isTrue2 = Integer.parseInt(ml_result_map.get("count").toString()) > 0;

//					System.out.println("sendWebsocket method isTrue1 = " + isTrue1);
//					System.out.println("sendWebsocket method isTrue2 = " + isTrue2);
					
					if (isTrue1 && isTrue2) {
						result_list.add(ml_result_map);
						String model_name = ml_result_map.get("model_name").toString();

						Date date_time = new Date();
						
						boolean isTrue3 = rejectEventService.chkTime(Integer.parseInt(dev_ch), model_name,
								new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(event_time));

//						System.out.println("sendWebsocket method isTrue3 = " + isTrue3);
						
						if (!isTrue3) {
							return;
						}

						metadata.put("model_name", model_name);
						metadata.put("action_action", "SMS(SCADA)");
						metadata.put("action_source", "���������������ý���");
						metadata.put("isEvent", true);

						Map returnMap = eventDao.selectEventActionByAction(metadata);

						boolean isTrue4 = actionEventMemoryRepository.findByEvent(dev_title, model_name) != null;

//						System.out.println("sendWebsocket method isTrue4 = " + isTrue4);
						
						if (isTrue4) {
							Map actionMap = actionEventMemoryRepository.findByEvent(dev_title, model_name);

							String action_action = actionMap.get("action_action").toString();

							boolean isTrue5 = returnMap != null && action_action.indexOf("SMS(SCADA)") != -1;

//							System.out.println("sendWebsocket method isTrue5 = " + isTrue5);
							
							if (isTrue5) {
								isResult = true;
							}
						}

						list.add(model_name);
					}
				}
				
//				System.out.println("sendWebsocket method isResult = " + isResult);

				if (isResult) {
					Map map = new LinkedHashMap();
					map.put("ip", ip);
					map.put("port", port);
					map.put("ch", ch);
					map.put("model_name", list);
					map.put("result_list", result_list);
					map.put("event_time", event_time);
					map.put("scada", scada);
					map.put("isEventAction", "Y");

					TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(map));
					webSession.sendMessage(return_message, webSocketService);
				}
			}
		} catch (Exception e) {
			System.out.println("sendWebsocket error");
		}
	}
}
