package com.refa.ai.Handler;
 
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.converter.MessageConverter;
import org.springframework.messaging.converter.StringMessageConverter;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.AbstractWebSocketHandler;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.refa.ai.dao.EventDao;
import com.refa.ai.dto.EventDto;
import com.refa.ai.dto.ImageTableDto;
import com.refa.ai.entity.Device;
import com.refa.ai.entity.User;
import com.refa.ai.infra.AES256Util;
import com.refa.ai.infra.WebSession;
import com.refa.ai.repository.ActionEventMemoryRepository;
import com.refa.ai.repository.DeviceRepository;
import com.refa.ai.repository.PresetRepository;
import com.refa.ai.repository.RejectEventRepository;
import com.refa.ai.repository.ScheduleRepository;
import com.refa.ai.repository.UserRepository;
import com.refa.ai.service.ActionSetupService;
import com.refa.ai.service.AreaSetService;
import com.refa.ai.service.EventStatusService;
import com.refa.ai.service.RejectEventService;
import com.refa.ai.service.WebSocketService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class MyHandler extends AbstractWebSocketHandler {
    
	private final EventDao eventDao;
	private final WebSocketService webSocketService; 
	private final WebSession webSession;
	private final SimpMessagingTemplate template;
	private final ActionSetupService actionSetupService;
	private final AreaSetService areaSetService;
	private final ScheduleRepository scheduleRepository;
	private final ActionEventMemoryRepository actionEventRepository;
	private final EventStatusService eventStatusService;
	private final RejectEventService rejectEventService;
	private final PresetRepository presetRepository;
	private final AES256Util aes256Util;
	private final UserRepository userRepository;
	private final DeviceRepository deviceRepository;

	// 접속 된 클라이언트 WebSocket session 관리 리스트
	private static List<WebSocketSession> sessionUsers = Collections.synchronizedList(new ArrayList<>());
	
	@Override
    public void afterConnectionEstablished(WebSocketSession userSession) throws Exception {
		// 클라이언트가 접속하면 WebSocket세션을 리스트에 저장한다.
		
		webSession.insertSession(userSession);
    }
 
    @Override
    public void afterConnectionClosed(WebSocketSession userSession, CloseStatus status) throws Exception {
		// session 리스트로 접속 끊은 세션을 제거한다.
		
		webSession.deleteSession(userSession);
    }
 
    @Override
    protected void handleTextMessage(WebSocketSession userSession, TextMessage message) throws Exception {
    	super.handleTextMessage(userSession, message);
    	    	
    	String payloadMessage = message.getPayload();
    	
    	//System.out.println("MyHandler 메시지 = " + payloadMessage);

    	Map<String, Object> map = new HashMap();
    	ObjectMapper mapper = new ObjectMapper();
		map = mapper.readValue(payloadMessage, Map.class);

		if (map.get("command") != null) {
			if (map.get("command").toString().equals("RF_RES_IPCAMERA_INFO") && map.get("status").toString().equals("success")) {
				ArrayList<String> list = (ArrayList<String>) map.get("rtsp_url");
				map.put("rtsp_url", "{" + list.toString().substring(1, list.toString().length() - 1) + "}");
				
				Map req_info = (Map) map.get("req_info");
				map.put("dev_type", req_info.get("dev_type"));
				map.put("dev_title", req_info.get("dev_title"));
				map.put("dev_ch", Integer.parseInt(req_info.get("dev_ch").toString()));
				map.put("port", Integer.parseInt(req_info.get("port").toString()));
				map.put("dev_rtsp", req_info.get("dev_rtsp"));
				map.put("dev_mac", map.get("mac"));
				map.put("dev_manufacturer", req_info.get("dev_manufacturer"));
				
				req_info.put("dev_ch", Integer.parseInt(req_info.get("dev_ch").toString()));
				req_info.put("port", Integer.parseInt(req_info.get("port").toString()));
				
				map.put("req_info", req_info);
				
				eventDao.updateDevCon(map);
				
				eventDao.updatePresetByCh(map);

				webSession.sendDifferentMessage(message, webSocketService, userSession);
			} else if (map.get("command").toString().equals("RF_REQ_IPCAMERA_LIST")) {
				List<Map> deviceList = new ArrayList<Map>();
				
				map.put("login_id", map.get("web_user"));
				map.put("dev_type", "ipc");
				
				if (map.get("login_id").toString().equals("admin")) {
					deviceList = eventDao.deviceList(map);
				} else {
					Map userInfo = eventDao.selectUserChById(map);
					if (userInfo != null && !userInfo.get("user_channel").toString().equals("")) {
						for (int i = 0; i < userInfo.get("user_channel").toString().split(",").length; i++) {
							int ch = Integer.parseInt(userInfo.get("user_channel").toString().split(",")[i]);
							Map chMap = new HashMap();
							chMap.put("dev_ch", ch);
							Map devInfo = eventDao.deviceInfoOne2(chMap);
							if (devInfo != null) {
								deviceList.add(devInfo);
//								deviceList = eventDao.devInfo(devInfo);
							}
						}
					}
				}
				
				//System.out.println(deviceList.size());
				//System.out.println(deviceList.toString());
				
				Map returnMap = new LinkedHashMap();
				returnMap.put("command", "RF_RES_IPCAMERA_LIST");
				returnMap.put("sender", "web");
				returnMap.put("web_user", map.get("web_user"));
				returnMap.put("deviceList", deviceList);
				
				TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(returnMap));
				
				webSession.sendEqualMessage(return_message, webSocketService, userSession);
			} else if (map.get("command").toString().equals("RF_REQ_DISCOVERY_ONVIF") || map.get("command").toString().equals("RF_RES_DISCOVERY_ONVIF")) {
				webSession.sendDifferentMessage(message, webSocketService, userSession);
			} else if (map.get("command").toString().equals("RF_REQ_IPCAMERA_INFO")) {
				if (map.get("return") == null) {
					String rtsp_url = "{}";
					
					if (map.get("rtsp_url") != null) {
						ArrayList<String> list = (ArrayList<String>) map.get("rtsp_url");
						
						rtsp_url = "{" + list.toString().substring(1, list.toString().length() - 1) + "}";
					}
					
					//System.out.println(rtsp_url);
					
					map.put("rtsp_url", rtsp_url);
					
					Map req_info = (Map) map.get("req_info");
					
					map.put("dev_type", req_info.get("dev_type"));
					map.put("dev_title", req_info.get("dev_title"));
					map.put("dev_ch", Integer.parseInt(req_info.get("dev_ch").toString()));
					map.put("port", Integer.parseInt(req_info.get("port").toString()));
					map.put("dev_rtsp", req_info.get("dev_rtsp"));
					map.put("dev_mac", req_info.get("dev_mac"));
					map.put("dev_manufacturer", req_info.get("dev_manufacturer"));
					
					String pw = map.get("pw").toString();
					
					pw = aes256Util.encryptAES(pw, false);
					
					map.put("pw", pw);
					
					eventDao.insertDevInfo(map);
					eventDao.insertActionSetup(map);
					actionSetupService.insert(map);
					List<String> list = new ArrayList<String>();
					list.add("fire");
					list.add("falldown");
					list.add("flood");
					list.add("glove");
					list.add("invasion");
					list.add("leak");
					list.add("loitering");
					list.add("handaction");
					list.add("spin");
					for (int i = 0; i < list.size(); i++) {
						Map saveMap = new HashMap();
						saveMap.put("event_name", list.get(i));
						saveMap.put("dev_ch", Integer.parseInt(req_info.get("dev_ch").toString()));
						saveMap.put("dev_title", req_info.get("dev_title"));
						eventDao.saveSchedule(saveMap);
					}

					req_info.put("dev_ch", Integer.parseInt(req_info.get("dev_ch").toString()));
					req_info.put("port", Integer.parseInt(req_info.get("port").toString()));
					
					map.put("req_info", req_info);
					
					TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(map));
					
					webSession.sendDifferentMessage(return_message, webSocketService, userSession);
				}
			} else if (map.get("command").toString().equals("RF_REQ_IPCAMERA_UPDATE") && map.get("sender").equals("web")) {
				eventDao.updateDeviceTag(map);
				
				if (eventDao.selectByChIsConnect(map) != null) {
					map.put("status", "failed");

					String pw = map.get("dev_pwd").toString();
					
					pw = aes256Util.encryptAES(pw, false);
					
					map.put("dev_pwd", pw);
					
					eventDao.updateDevInfo(map);
					eventDao.updatePresetByIsuse(map);
					eventDao.updateActionSetup(map);
					actionSetupService.updateTitle(map);
					
					//eventDao.updateActionInfoTitle(map);
					
					Map device_info = eventDao.deviceInfoOne2(map);

					Map returnMap = new LinkedHashMap();
					returnMap.put("command", "RF_REQ_IPCAMERA_UPDATE");
					returnMap.put("sender", "web");
					returnMap.put("web_user", map.get("web_user"));
					returnMap.put("req_info", device_info);

					TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(returnMap));
					webSession.sendDifferentMessage(return_message, webSocketService, userSession);
					
					Map listMap = new HashMap();
					listMap.put("ip", map.get("dev_ip").toString());
					listMap.put("title", map.get("dev_title").toString());
					listMap.put("ch", Integer.parseInt(map.get("dev_ch").toString()));
					listMap.put("kwater_falldown_detection", map.get("dev_falldown").toString());
					listMap.put("kwater_fire_detection", map.get("dev_fire").toString());
					listMap.put("kwater_flood_detection", map.get("dev_flood").toString());
					listMap.put("kwater_glove_detection", map.get("dev_glove").toString());
					listMap.put("kwater_invasion_detection", map.get("dev_invasion").toString());
					listMap.put("kwater_leak_detection", map.get("dev_leak").toString());
					listMap.put("kwater_loitering_detection", map.get("dev_loitering").toString());
					listMap.put("kwater_handaction_detection", map.get("dev_handaction").toString());
					listMap.put("kwater_spin_detection", map.get("dev_spin").toString());
					listMap.put("kwater_cmtank_leak", map.get("dev_cmtank").toString());
					listMap.put("kwater_outtank_leak", map.get("dev_outtank").toString());
					listMap.put("kwater_overflow", map.get("dev_overflow").toString());
					
					List<Map> list = new ArrayList<Map>();
					list.add(listMap);
					
					Map scadaMap = new HashMap();
					scadaMap.put("status", "update");
					scadaMap.put("setting", list);
					scadaMap.put("scada", "SUCCESS");
					
					return_message = new TextMessage(new ObjectMapper().writeValueAsString(scadaMap));
					webSession.sendMessage(return_message, webSocketService);
					
					//System.out.println("return_message = " + return_message.getPayload());
				}
			} else if (map.get("command").toString().equals("RF_RES_IPCAMERA_UPDATE")) {
				map.put("command", "RF_SET_IPCAMERA_INFO");
				map.put("sender", "web");

				Map req_info = (Map) map.get("req_info");
				
				req_info.put("dev_ch", Integer.parseInt(req_info.get("dev_ch").toString()));
				req_info.put("port", Integer.parseInt(req_info.get("dev_web_port").toString()));
				
				map.put("req_info", req_info);
				
				TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(map));

				webSession.sendMessage(return_message, webSocketService);
				
				ArrayList<String> list = (ArrayList<String>) map.get("rtsp_url");
				map.put("rtsp_url", "{" + list.toString().substring(1, list.toString().length() - 1) + "}");
				
				map.put("dev_type", req_info.get("dev_type"));
				map.put("dev_title", req_info.get("dev_title"));
				map.put("dev_ch", req_info.get("dev_ch"));
				map.put("dev_port", req_info.get("dev_web_port"));
				map.put("dev_rtsp", req_info.get("dev_rtsp"));
				map.put("dev_mac", map.get("mac"));
				map.put("dev_ip", map.get("ip"));
				map.put("dev_id", map.get("id"));
				map.put("dev_pwd", map.get("pw"));
				map.put("dev_manufacturer", req_info.get("dev_manufacturer"));

				eventDao.updateDevInfo(map);

				eventDao.updatePresetByCh(map);
			} else if (map.get("command").toString().equals("RF_SET_IPCAMERA_PRESET_UPDATE")) {
				System.out.println("MyHandler - RF_SET_IPCAMERA_PRESET_UPDATE");
				presetRepository.updatePresetTitleUseAll(map);
				presetRepository.updatePresetIsUseAll(map);
			} else if (map.get("command").toString().equals("RF_REQ_IPCAMERA_DELETE")) {
				eventDao.deleteDeviceInfo(map);
				eventDao.updatePresetByIsuse(map);
				eventDao.deleteActionInfoByTitle(map);
				eventDao.deleteActionSetup(map);
				eventDao.deleteConfdur(map);
				actionSetupService.delete(map);
				eventDao.deleteAreaSet(map);
				areaSetService.deleteCh(map);
				eventDao.deleteSchedule(map);
				scheduleRepository.delete(Integer.parseInt(map.get("dev_ch").toString()));
				actionEventRepository.delete(map.get("dev_title").toString());

				webSession.sendDifferentMessage(message, webSocketService, userSession);
			} else if (map.get("command").toString().equals("RF_STARTUP")) {
				TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(webSocketService.getAes256Lkey()));
				
				webSession.sendEqualMessage(return_message, webSocketService, userSession);
			} else if (map.get("command").toString().equals("RF_REQ_STILL_IMAGE")) {
				TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(map));
				
				webSession.sendMessage(return_message, webSocketService);
			}
		} else {
			if (map.get("test") != null) {
				Date date = new Date();

				SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				String ip = "192.168.100.61";
				int port = 80;
				int ch = 2;
				
				List model_name = new ArrayList();
				model_name.add("KWATER_Falldown_Detection"); 
				model_name.add("KWATER_Fire_Detection");
				model_name.add("KWATER_Flood_Detection"); 
				model_name.add("KWATER_Glove_Detection"); 
				model_name.add("KWATER_Invasion_Detection"); 
				model_name.add("KWATER_Leak_Detection"); 
				model_name.add("KWATER_Loitering_Detection"); 
				model_name.add("KWATER_HandAction_Detection"); 
				model_name.add("KWATER_Spin_Detection"); 
				
				String event_time = transFormat.format(date);
				String scada = "SUCCESS";
				
				Map returnMap = new LinkedHashMap();
				returnMap.put("ip", ip);
				returnMap.put("port", port);
				returnMap.put("ch", ch);
				returnMap.put("model_name", model_name);
				returnMap.put("event_time", event_time);
				returnMap.put("scada", scada);
				
				TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(returnMap));
				
				webSession.sendEqualMessage(return_message, webSocketService, userSession);
			} else if (map.get("scada") != null && map.get("isEventAction") == null) {
//				System.out.println("스카다 = " + new ObjectMapper().writeValueAsString(map));
				
				String ip = map.get("ip").toString();
				int port = (int) map.get("port");
				int ch = (int) map.get("ch");
				List<String> list = (List) map.get("model_name");
				String event_time = map.get("event_time").toString();
				String action_source = "SCADA";
				String event_info = "count : " + 1;
				
				map.put("action_source", action_source);
								
				Map devMap = new HashMap();
				devMap.put("ip", ip);
				devMap.put("port", port);
				
//				Map devInfo = eventDao.selectDeviceInfoByIP(devMap);
				Optional<Device> device = deviceRepository.findByCh(ch);
				
				boolean isAction = false;
				String pre_title = "";
				
//				System.out.println("웹소켓 핸들려 = " + devInfo);
				
				if (device.isPresent()) {
					sendScada(map);
					
					Device devInfo = device.get();
					
					map.put("dev_ch", devInfo.getDev_ch() + "");

					// 이벤트 로그
					EventDto eventDto = new EventDto();

					eventDto.setItem_name(devInfo.getDev_title());
					eventDto.setDev_ip(devInfo.getDev_ip());
					eventDto.setDev_channel(devInfo.getDev_ch() + "");
					eventDto.setEvent_time(event_time);
					eventDto.setUser_id(devInfo.getLogin_id());

					eventDto.setItem_type("1");
					eventDto.setItem_ip(devInfo.getDev_ip());
					eventDto.setItem_id(devInfo.getLogin_id());
					eventDto.setItem_pwd(devInfo.getDev_pwd());
					eventDto.setItem_port(devInfo.getDev_web_port());
					
					String dev_mac_address = "00000";
					if (devInfo.getDev_mac_address() != null) {
						dev_mac_address = devInfo.getDev_mac_address();
					}
					eventDto.setItem_mac(dev_mac_address);
					eventDto.setDev_mac(dev_mac_address);
					eventDto.setDev_id(devInfo.getDev_id());
					eventDto.setDev_pwd(devInfo.getDev_pwd());
					eventDto.setDev_port(port + "");
					eventDto.setDev_web_port(port + "");
					eventDto.setEvent_source("SCADA");
					eventDto.setEvent_info(event_info);
					
					boolean isResult = false;
					String class_name = "";
					List originalTags = new ArrayList();
					List colorTags = new ArrayList();
					
					for (String model_name : list) {
						isResult = true;

						if (model_name.split("_").length > 2) {
							model_name = model_name.split("_")[0].toUpperCase() + 
									"_" + model_name.split("_")[1].split("")[0].toUpperCase() + model_name.split("_")[1].substring(1) + 
									"_" + model_name.split("_")[2].split("")[0].toUpperCase() + model_name.split("_")[2].substring(1);
						} else {
							model_name = model_name.split("_")[0].toUpperCase() + 
									"_" + model_name.split("_")[1].split("")[0].toUpperCase() + model_name.split("_")[1].substring(1);
						}
						
						class_name += model_name + 1;
						originalTags.add(model_name);
						
						eventDto.setEvent_name(model_name);
						eventDao.insertJson(eventDto);
						
						String jsonStr = "";
						ObjectMapper mapper1 = new ObjectMapper();

						try {
							jsonStr = mapper1.writeValueAsString(eventDto);
						} catch (Exception e1) {
							System.out.println("SCADA Websocket Error");
						}

						this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
						this.template.convertAndSend("/receiveMessage", jsonStr);

						map.put("dev_title", devInfo.getDev_title());
						
						Map selectMap = new HashMap();
						selectMap.put("model_name", model_name);
						//selectMap.put("action_action", "프리셋");
						selectMap.put("dev_title", devInfo.getDev_title());
						selectMap.put("action_source", "SCADA");
						
						List<Map> return_maps = eventDao.selectEventActionListByAction(selectMap);

						if (rejectEventService.chkTime(Integer.parseInt(devInfo.getDev_ch() + ""), model_name, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(event_time))) {
							eventReject(map, model_name);
							if (return_maps != null) {
								for (int i = 0; i < return_maps.size(); i++) {
									Map return_map = return_maps.get(i);
									String action_action = return_map.get("action_action").toString();
									
									if (action_action.contains("스피커")) {
										List<Map> speakerList = eventDao.selectNetworkSpeaker();
										
										for (int j = 0; j < speakerList.size(); j++) {
											playNetworkSpeaker(model_name, speakerList.get(j));
										}
									} 
									
									/*
									if (action_action.equals("팝업")) {
										Map returnMap = new LinkedHashMap();
										
										showPopupImage()
										
									} 
									*/
									
									if (action_action.contains("프리셋")) {
										Map statusMap = new HashMap();
										statusMap.put("action_source", map.get("action_source"));
										statusMap.put("event_action", "프리셋");
										statusMap.put("dev_ch", return_map.get("dev_ch"));
										statusMap.put("dev_title", return_map.get("dev_title"));
										statusMap.put("model_name", model_name);
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

										String returnStr = new ObjectMapper().writeValueAsString(statusMap);

										this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
										this.template.convertAndSend("/receiveEventStatus", returnStr);
										
										Map returnMap = new LinkedHashMap();
										returnMap.put("command", "RF_REQ_GOTOPRESET");
										returnMap.put("sender", "web");
										returnMap.put("web_user", devInfo.getLogin_id());
										returnMap.put("ip", devInfo.getDev_ip());
										
										returnMap.put("id", devInfo.getDev_id());
										returnMap.put("pw", devInfo.getDev_pwd());
										returnMap.put("mac", devInfo.getDev_mac_address());
										returnMap.put("preset_name", return_map.get("pre_title"));
										returnMap.put("port", devInfo.getDev_web_port());

										TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(returnMap));
										webSession.sendDifferentMessage(return_message, webSocketService, userSession);
									}
								}
							}
						}
						
						if (isResult) {
							ImageTableDto imageTableDto = new ImageTableDto();
							
							User user = userRepository.findRecentOne();

							imageTableDto.setLogin_id(user.getUser_id());
							imageTableDto.setDev_ch(devInfo.getDev_ch() + "");
							imageTableDto.setDev_pwd(devInfo.getDev_pwd());
							imageTableDto.setStart_time(System.currentTimeMillis());
							imageTableDto.setItem_name("AIBOX1");
							imageTableDto.setDev_ip(devInfo.getDev_ip());
							imageTableDto.setDev_port(devInfo.getDev_web_port());
							imageTableDto.setEvent_time(event_time);
							imageTableDto.setDev_id(devInfo.getDev_id());
							imageTableDto.setDev_web_port(devInfo.getDev_web_port());
							
							String uploadPath = "/webserver/" + user.getUser_id() + "/" + "AIBOX1" + "/"
									+ event_time.split(" ")[0].split("-")[0] + event_time.split(" ")[0].split("-")[1]
									+ event_time.split(" ")[0].split("-")[2] + "/" + "ch" + devInfo.getDev_ch() + "_" + event_time.split(" ")[1].replaceAll(":", "")
									+ ".jpg";
							imageTableDto.setImage_name(uploadPath);
							imageTableDto.setThumb_name(uploadPath.substring(0, uploadPath.lastIndexOf(".")) + "_thumb.jpg");
							String monitoring_tag = "AIBOX1" + "_ch" + devInfo.getDev_ch() + "_" + event_time.split(" ")[0].replaceAll("-", "")
									+ "_" + class_name;
							imageTableDto.setMonitoring_tag(monitoring_tag);
							
							imageTableDto.setUser_name(user.getUser_id());
							imageTableDto.setUser_passwd(user.getUser_pw());

							imageTableDto.setImage_queue(0);

							imageTableDto.setWidth(0);
							imageTableDto.setHeight(0);

							imageTableDto.setColor_tags(colorTags.toString());
							imageTableDto.setTags(originalTags.toString().replaceAll("\\\\", ""));

							eventDao.insertImageEvent(imageTableDto);
							
						}
					}
				}
			} else if (map.get("request") != null && map.get("request").equals("setting")) {
				
				List<Map> list = eventDao.selectDevinfoAsSetting();
				
				Map returnMap = new HashMap();
				returnMap.put("setting", list);
				returnMap.put("scada", "SUCCESS");
				returnMap.put("status", "list");
				
				TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(returnMap));
				
				webSession.sendEqualMessage(return_message, webSocketService, userSession);
			}
		}
    }

	public void playAlarm(Map map) throws JsonProcessingException {
		//System.out.println("playAlarm()");

		ObjectMapper mapper = new ObjectMapper();
		String returnStr = mapper.writeValueAsString(map);
		
		map.put("action_action", "알람");

		String dev_title = "";
		Map returnMap2 = eventDao.deviceInfoOne2(map);
		if (returnMap2 != null) {
			dev_title = returnMap2.get("dev_title").toString();
		}
		map.put("dev_title", dev_title);
		
		Map returnMap = eventDao.selectEventActionByAction(map);
		
		if (returnMap != null) {
			// 이벤트 액션 설정 체크해야됨
			
			List<Map> list = eventDao.selectNetworkSpeaker();
			
			for (int i = 0; i < list.size(); i++) {
//				playNetworkSpeaker(returnMap, list.get(i));
			}
			
			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/playAlarm", returnStr);
		}
	}
	
	public void playNetworkSpeaker(String model_name, Map map) {
//		System.out.println("sendSpeakerNumber()");

		String body = "";
//		String id = "root";
		String id = map.get("network_id").toString();
//		String pw = "00pp;;//";
		String pw = map.get("network_pwd").toString();
		String enc = id + ":" + pw;
		String ip = map.get("network_ip").toString();
		String port = map.get("network_port").toString();
		
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
		
		if (num >= 0) {
			String postUrl = "http://" + ip + ":" + port + "/axis-cgi/playclip.cgi?clip=" + num;
			
			try {
				CloseableHttpClient Getclient = HttpClients.createDefault(); // HttpClient 생성
				
				URL url = new URL(postUrl);
				
				HttpHost GetpostRequest = new HttpHost(url.getHost(), url.getPort(), url.getProtocol()); // POST 메소드 URL 새성
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
			    
			    //HttpGet httpGet = new HttpGet("http://192.168.100.57/axis-cgi/playclip.cgi?clip=0");
			    //CloseableHttpResponse response = Getclient.execute(GetpostRequest, httpGet, context);
			    CloseableHttpResponse response = Getclient.execute(GetpostRequest, httpGet, context);
			  
				if (response.getStatusLine().getStatusCode() == 200) {
					ResponseHandler<String> handler = new BasicResponseHandler();
					body = handler.handleResponse(response);
//					System.out.println("스피커 = " + body);
				} else {
					System.out.println("response is error : " + response.getStatusLine().getStatusCode());
				}
				response.close();
			} catch (Exception e) {
				System.out.println("response is error");
			}
		}
	}

	public void eventReject(Map map, String model_name) throws JsonProcessingException {
		// System.out.println("eventReject");

		Map devInfo = eventDao.deviceInfoOne2(map);

		if (devInfo != null) {
			Map statusMap = new HashMap();
			statusMap.put("action_source", "SCADA");
			statusMap.put("event_action", "무시");
			statusMap.put("dev_ch", Integer.parseInt(devInfo.get("dev_ch").toString()));
			statusMap.put("dev_title", devInfo.get("dev_title"));
			statusMap.put("model_name", model_name);
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
	
	public void sendScada(Map responseMap) throws JsonProcessingException {
		Map map = new LinkedHashMap();
		map.put("ip", responseMap.get("ip").toString());
		map.put("port", Integer.parseInt(responseMap.get("port").toString()));
		map.put("ch", Integer.parseInt(responseMap.get("ch").toString()));
		map.put("model_name", responseMap.get("model_name"));
		map.put("event_time", responseMap.get("event_time").toString());
		map.put("event", "SUCCESS");
		map.put("isEventAction", "Y");

		TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(map));
		webSession.sendMessage(return_message, webSocketService);
	}
}
