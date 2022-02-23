package com.refa.ai.controller;

import static java.lang.Math.toIntExact;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.attribute.BasicFileAttributes;
import java.nio.file.attribute.FileTime;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Optional;
import java.util.Queue;
import java.util.Set;
import java.util.TimeZone;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JFrame;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.collections4.map.HashedMap;
import org.apache.commons.io.FileUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.DigestScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.MessagingException;
import org.springframework.messaging.converter.MessageConverter;
import org.springframework.messaging.converter.StringMessageConverter;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.lang.GeoLocation;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifSubIFDDirectory;
import com.drew.metadata.exif.GpsDirectory;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.refa.ai.dao.EventDao;
import com.refa.ai.dao.LoginDao;
import com.refa.ai.dto.ActionDto;
import com.refa.ai.dto.ActionLogDto;
import com.refa.ai.dto.BackupLogDto;
import com.refa.ai.dto.CategoryDto;
import com.refa.ai.dto.CountDto;
import com.refa.ai.dto.DBackupDto;
import com.refa.ai.dto.DeviceInfoDto;
import com.refa.ai.dto.DiskSizeDto;
import com.refa.ai.dto.ErrorLogDto;
import com.refa.ai.dto.EventDto;
import com.refa.ai.dto.ImageLogDto;
import com.refa.ai.dto.ImageLogJsonDto;
import com.refa.ai.dto.ImageTableDto;
import com.refa.ai.dto.MetadataDto;
import com.refa.ai.dto.MlResultDto;
import com.refa.ai.dto.MonitoringDto;
import com.refa.ai.dto.OneSecDurDto;
import com.refa.ai.dto.ResponseEventDto;
import com.refa.ai.dto.ResponseLogDto;
import com.refa.ai.dto.SettingDto;
import com.refa.ai.dto.VersionDto;
import com.refa.ai.dto.user.UserDto;
import com.refa.ai.entity.User;
import com.refa.ai.infra.DeleteImageDay;
import com.refa.ai.infra.EasyImage;
import com.refa.ai.infra.WebSession;
import com.refa.ai.repository.ActionEventRepository;
import com.refa.ai.repository.ActionSetupRepository;
import com.refa.ai.repository.Base64Repository;
import com.refa.ai.repository.GalleryRepository;
import com.refa.ai.repository.InsertImagesTimeRepository;
import com.refa.ai.repository.RejectEventRepository;
import com.refa.ai.repository.ScheduleRepository;
import com.refa.ai.repository.VersionRepository;
import com.refa.ai.service.ActionSetupService;
import com.refa.ai.service.AreaSetService;
import com.refa.ai.service.EventStatusService;
import com.refa.ai.service.OneSecDurService;
import com.refa.ai.service.RejectEventService;
import com.refa.ai.service.WebSocketService;

import lombok.RequiredArgsConstructor;
import sun.misc.BASE64Encoder;

@Controller
@RequiredArgsConstructor
public class EventController {
	private SimpMessagingTemplate template;

	private final EventDao eventDao;
	private final WebSession webSession;
	private final WebSocketService webSocketService;
	private final RejectEventService rejectEventService;
	private final EventStatusService eventStatusService;
	private final ActionSetupRepository actionSetupRepository;
	private final ActionSetupService actionSetupService;
	private final AreaSetService areaSetService;
	private final Base64Repository base64Repository;
	private final InsertImagesTimeRepository insertImagesTimeRepository;
	private final ScheduleRepository scheduleRepository;
	private final ActionEventRepository actionEventRepository;
	private final OneSecDurService oneSecDurService;
	private final VersionRepository versionRepository;
	private final GalleryRepository galleryRepository;

	RestTemplate rest;
	private List<Map> actionListTotal;
	private JSONObject imageTotal;
	private HttpClient client;
	private List<Map<String, Object>> dashBoardInfo;
	private ExecutorService executorService;
	private int queue;
	private VersionDto versionDto;
	private String request_url;
	private String client_code;
	private String analyze_url;
	private HttpPost postRequest;
	// private HttpResponse response;
	private String durationResponse;
	private Timer timer;
	private TimerTask task;
	private Timer timerBackup;
	private TimerTask taskBackup;
	private Queue<String> insertImageQ;
	private Queue<String> responseEventQ;
	private String url;
	private String user;
	private String password;
	private Connection conn;
	private String str; // 라이센스 정보

	private int drive_count; // 드라이브 갯수
	private String master_drive_name; // 주 드라이브 이름(톰캣 설치되어 있는 것)
	private String part_drive_name; // 부 드라이브 이름(주 드라이브 제외하고 알파벳순을 맨 앞)

	private BlockingQueue<Map> insertQ;
//	private BlockingQueue<ResponseEventDto> responseQ;
	private BlockingQueue<Map> responseQ;
	private BlockingQueue<Map> postQ;
	private BlockingQueue<Map> eventActionQ;

	private Map resultMap;
	private Map durationMap;
	private Map<Integer, Map<String, Map>> scheduleList;

	// private List<ActionDto> actionListTotal = eventDao.actionInfoIsuse();

	@PostConstruct
	public void init()
			throws ParseException, java.text.ParseException, ClientProtocolException, IOException, SQLException {
		actionListTotal = eventDao.actionInfoIsuse();
		client = HttpClientBuilder.create().build(); // HttpClient 생성

		versionDto = versionRepository.selectVersionInfo("kwater");
		request_url = versionDto.getRequest_url();
		client_code = versionDto.getClient_code();
		analyze_url = versionDto.getAnalyze_url();
		postRequest = new HttpPost(analyze_url);
		postRequest.setHeader("Accept", "application/json");
		postRequest.setHeader("Connection", "keep-alive");
		postRequest.setHeader("Content-Type", "application/json");

		dashBoardInfo = new ArrayList<Map<String, Object>>();
		executorService = Executors.newCachedThreadPool();
		insertImageQ = new LinkedList<String>();
		responseEventQ = new LinkedList<String>();
		// response = client.execute(postRequest);
//	    int thread_count = 100;
//	    executorService = Executors.newFixedThreadPool(thread_count);
		// executorService = Executors.newSingleThreadExecutor();
		// insertImageTime();
		// responseEventTime();
		url = "jdbc:postgresql://localhost:5432/postgres";
		user = "postgres";
		password = "1234";
		conn = DriverManager.getConnection(url, user, password);
		conn.setAutoCommit(false);
		// renewal_license_date();
		// getLicenseInfo(analyze_url.substring(0, analyze_url.lastIndexOf("/")) +
		// "/get_license");
		init_drive_name();
		backupImageDay(null);
		deleteImageDay(null);
		if (drive_count > 1) {
			deleteImageDay2(null);
		}

		insertQ = new LinkedBlockingQueue<Map>();
//		responseQ = new LinkedBlockingQueue<ResponseEventDto>();
		responseQ = new LinkedBlockingQueue<Map>();
		postQ = new LinkedBlockingQueue<Map>();
		eventActionQ = new LinkedBlockingQueue<Map>();

		resultMap = new HashMap();
		resultMap.put("KWATER_Falldown_Detection", "boxes");
		resultMap.put("KWATER_Fire_Detection", "segments");
		resultMap.put("KWATER_Flood_Detection", "segments");
		resultMap.put("KWATER_Glove_Detection", "boxes");
		resultMap.put("KWATER_Invasion_Detection", "boxes");
		resultMap.put("KWATER_Leak_Detection", "segments");
		resultMap.put("KWATER_Loitering_Detection", "boxes");
		resultMap.put("KWATER_HandAction_Detection", "boxes");
		resultMap.put("KWATER_Spin_Detection", "boxes");

		durationMap = new ConcurrentHashMap();

		startInsertQ();
		startResponseQ();
		startPostQ();
		// startEventActionQ();

		scheduleList = scheduleRepository.findAll();
	}

	@Autowired
	public void setMessagingTemplate(SimpMessagingTemplate template) {
		this.template = template;
	}

	@RequestMapping(value = "/imageInfo")
	@ResponseBody
	public List<String> imageInfo(@RequestBody Map<String, Object> login) throws ParseException {
		// System.out.println("imageInfo()");
		// System.out.println("login_id = " + login.get("login_id"));

		long now = System.currentTimeMillis();

		List<MonitoringDto> list = null;
		List<String> list2 = new ArrayList<String>();

		list = eventDao.monitoringList(login.get("login_id").toString());

		// long end = System.currentTimeMillis();

		// System.out.println((end - now)/1000.0 + "초");

		JSONObject json = new JSONObject();
		if (list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				json = new JSONObject();
				json.put("monitoring_src", list.get(i).getMonitoring_src());
				json.put("monitoring_time", list.get(i).getMonitoring_time());
				json.put("monitoring_item", list.get(i).getMonitoring_item());
				json.put("monitoring_ch", list.get(i).getMonitoring_ch());
				json.put("monitoring_tag", list.get(i).getMonitoring_tag());
				json.put("monitoring_count", list.get(i).getMonitoring_count());
				json.put("monitoring_info", list.get(i).getMonitoring_info());
				json.put("login_id", list.get(i).getLogin_id());
				json.put("monitoring_size", list.get(i).getMonitoring_size());
				list2.add(json.toString().replaceAll("\\\\", ""));
			}
		}

		// end = System.currentTimeMillis();

		// System.out.println((end - now)/1000.0 + "초");

		return list2;
	}

	@RequestMapping(value = "/downloadImageGroup")
	@ResponseBody
	public int downloadImage(@RequestBody Map<String, Object> login, HttpServletResponse response) throws IOException {

		// System.out.println("Heap Size(M) : " + heapSize / (1024 * 1024) + " MB");

		long now = System.currentTimeMillis();

		String fileName = downloadZipGroup(login, response, login.get("fileName").toString());
		// System.out.println(fileName);

		long end = System.currentTimeMillis();

		// System.out.println((end - now)/1000.0 + "초");

		// this.template.setMessageConverter((MessageConverter) new
		// StringMessageConverter());
		// this.template.convertAndSend("/downloadZip",
		// login.get("fileName").toString());

		// String fileName = URLDecoder.decode(tempPath.substring(tempPath.indexOf("/"))
		// + zipName, "UTF-8");

		if (fileName.equals("")) {
			return 0;
		} else {
			return drive_count;
		}
	}

	@RequestMapping(value = "/downloadImage")
	@ResponseBody
	public int downloadImageGroup(@RequestBody Map<String, Object> login, HttpServletResponse response)
			throws IOException {
		// System.out.println("downloadImage()");

		long now = System.currentTimeMillis();

		String fileName = downloadZip(login, response, login.get("fileName").toString());
		// System.out.println(fileName);

		long end = System.currentTimeMillis();

		// System.out.println((end - now)/1000.0 + "초");

		// String fileName = URLDecoder.decode(tempPath.substring(tempPath.indexOf("/"))
		// + zipName, "UTF-8");

		if (fileName.equals("")) {
			return 0;
		} else {
			return drive_count;
		}
	}

	@GetMapping(value = "/showImageInfo")
	public String showImageInfo(Model model, @RequestParam int ch) {
		// System.out.println("showImageInfo()");

		Map map = eventDao.selectmonitorByCh(ch);

		model.addAttribute("monitor_size", map.get("monitor_size"));
		model.addAttribute("monitor_src", map.get("monitor_src"));
		model.addAttribute("event_time", map.get("event_time"));
		model.addAttribute("dev_ch", map.get("dev_ch"));
		model.addAttribute("tags", map.get("tags"));

		return "./gallery/image2";
	}

	@RequestMapping(value = "/showImageInfoOne")
	public String showImageInfoOne(Model model, @RequestParam("image_idx") int image_idx) {
		// System.out.println("showImageInfo()");

		Map map = new HashMap();
		map.put("image_idx", image_idx);

		Map returnMap = eventDao.selectModalImage(map);

		model.addAttribute("width", returnMap.get("width").toString());
		model.addAttribute("height", returnMap.get("height").toString());
		model.addAttribute("thumb_name", returnMap.get("thumb_name").toString());
		model.addAttribute("event_time", returnMap.get("event_time").toString());
		model.addAttribute("dev_title", returnMap.get("dev_title").toString());
		model.addAttribute("tags", returnMap.get("tags").toString());

		return "./gallery/searchBar2";
	}

	@RequestMapping(value = "/searchFilterUpImage")
	@ResponseBody
	public List searchFilterUpImage(@RequestBody Map<String, Object> login) throws ParseException {
		// System.out.println("searchFilterUpImage()");

		long now = System.currentTimeMillis();

		// System.out.println("keyword = " + login.get("keyword"));
		// System.out.println("value = " + login.get("value"));

		String login_id = login.get("login_id").toString();
		String keyword = login.get("keyword").toString();
		int limit_num = 100;
		int row_num = 0;

		if (login.get("limit_num") != null) {
			limit_num = (Integer) login.get("limit_num");
		}

		if (login.get("row_num") != null) {
			row_num = (Integer) login.get("row_num");
		}

		// System.out.println("limit_num = " + limit_num);
		// System.out.println("row_num = " + row_num);
		// System.out.println("keyword = " + keyword);

		ImageTableDto imageTableDto = new ImageTableDto();

		imageTableDto.setLogin_id(login_id);
		imageTableDto.setLimit_num(limit_num);
		imageTableDto.setRow_num(row_num);

		List<ImageTableDto> imageList = null;

		if (login.get("value") != null && login.get("value").toString().equals("갯수")) {
			imageTableDto.setMonitoring_tag(keyword);
			imageList = eventDao.searchUpMonitoring(imageTableDto);
		} else if (login.get("value") != null && login.get("value").toString().equals("검색")) {
			imageTableDto.setTags(keyword);
			imageList = eventDao.searchUpTag(imageTableDto);
		}

		// System.out.println(imageList.size());

		return imageList;
	}

	@RequestMapping(value = "/searchFilterImage")
	@ResponseBody
	public List<ImageTableDto> searchFilterImage(@RequestBody Map<String, Object> login) throws ParseException {
		// System.out.println("searchFilterImage()");

		String login_id = login.get("login_id").toString();
		String tags = login.get("tags").toString();
		String event_time = login.get("event_time").toString();

		ImageTableDto imageTableDto = new ImageTableDto();

		imageTableDto.setLogin_id(login_id);
		imageTableDto.setEvent_time(event_time);

		List<ImageTableDto> imageList = new ArrayList<ImageTableDto>();

		if (login.get("val") != null && login.get("val").toString().equals("Y")) {
			imageTableDto.setMonitoring_tag(tags);
			imageList = eventDao.searchFilterMonitoring(imageTableDto);
		} else {
			imageTableDto.setTags(tags);
			imageList = eventDao.searchFilterImage(imageTableDto);
		}

		// System.out.println(imageList.size());

		return imageList;
	}

	@RequestMapping(value = "/searchFilterImage2")
	@ResponseBody
	public List<ImageTableDto> searchFilterImage2(@RequestBody Map<String, Object> login) throws ParseException {
		// System.out.println("searchFilterImage2()");

		String login_id = login.get("login_id").toString();
		String tags = login.get("tags").toString();
		String event_time = login.get("event_time").toString();
		int row_num = (Integer) login.get("row_num");

		ImageTableDto imageTableDto = new ImageTableDto();

		imageTableDto.setLogin_id(login_id);
		imageTableDto.setEvent_time(event_time);
		imageTableDto.setRow_num(row_num);

		List<ImageTableDto> imageList = new ArrayList<ImageTableDto>();

		if (login.get("val") != null && login.get("val").toString().equals("Y")) {
			imageTableDto.setMonitoring_tag(tags);
			imageList = eventDao.searchFilterMonitoring2(imageTableDto);
		} else {
			imageTableDto.setTags(tags);
			imageList = eventDao.searchFilterImage2(imageTableDto);
		}

		return imageList;
	}

	@RequestMapping(value = "/searchDevice")
	@ResponseBody
	public Map searchDevice(@RequestBody Map map) {
		// System.out.println("searchDevice()");

		ObjectMapper mapper = new ObjectMapper();

		String msg = null;

		try {
			msg = mapper.writeValueAsString(map);
		} catch (JsonProcessingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		Map returnMap = new HashMap();
		returnMap.put("status", "ok");

		return returnMap;
	}

	// 장비 정보 가져옴
	@RequestMapping(value = "/deviceModifyInfo")
	@ResponseBody
	public Map deviceModifyInfo(@RequestBody Map map) {
		// System.out.println("deviceModifyInfo()");

		Map dto = eventDao.deviceInfoOne2(map);

		return dto;
	}

	// 장비 정보 수정
	@RequestMapping(value = "/updateDeviceInfo")
	@ResponseBody
	public Map updateDeviceInfo(@RequestBody Map<String, Object> map) {
		// System.out.println("updateDeviceInfo()");

		Map dto = eventDao.deviceInfoOne2(map);

		Map returnMap = new HashMap();

		if (dto.get("dev_pwd").equals(map.get("dev_pwd"))) {
			eventDao.updateDevInfo(map);
			returnMap.put("result", true);
		} else {
			returnMap.put("result", false);
		}

		return returnMap;

	}

	// 장비 삭제 처리
	@RequestMapping(value = "/deleteDeviceInfo")
	@ResponseBody
	public void deleteDeviceInfo(@RequestBody Map<String, Object> map) {
		// System.out.println("deleteDeviceInfo()");

		eventDao.deleteDeviceInfo(map);
	}

	@RequestMapping(value = "/log")
	public String monitoring(Model model) {
		// System.out.println("log()");

		return "./log/log";
	}

	@GetMapping("/logPopup")
	public String logPopup(Model model, String dev_ch, String event_time) {
		// System.out.println("logPopup()");

		Map map = new HashMap();
		map.put("dev_ch", dev_ch);
		map.put("event_time", event_time);

		Map returnMap = eventDao.selectLogPopup(map);

		if (returnMap != null) {
			model.addAttribute("image_name", returnMap.get("image_name"));
			model.addAttribute("width", returnMap.get("width"));
			model.addAttribute("height", returnMap.get("height"));
		}

		return "./log/logPopup";
	}

	@PostMapping("/selectLogPopup")
	@ResponseBody
	public Map selectLogPopup(@RequestBody Map map) {
		// System.out.println("selectLogPopup()");

		Map returnMap = new HashMap();

		return returnMap;
	}

	@GetMapping("/monitor")
	public String monitor(Model model) {
		// System.out.println("monitor()");

		return "./monitoring/monitor";
	}

	@PostMapping("/monitor")
	@ResponseBody
	public List<Map> monitor(@RequestBody Map map) {
		// System.out.println("monitorPost()");

		List<Map> list = eventDao.selectMonitorAll();

		return list;
	}

	@GetMapping("/urlSetup")
	public String urlSetup(Model model) {
		// System.out.println();

		model.addAttribute("request_url", request_url);
		model.addAttribute("analyze_url", analyze_url);

		return "./setup/urlSetup";
	}

	@PostMapping("/urlSetup")
	@ResponseBody
	public Map urlSetup(@RequestBody Map map) {
		// System.out.println("urlSetupPost()");

		request_url = map.get("request_url").toString();
		analyze_url = map.get("analyze_url").toString();

		String socketUrl = request_url.substring(request_url.lastIndexOf("/", 10) + 1, request_url.lastIndexOf("/"))
				+ "/broadsocket";
		map.put("socketUrl", socketUrl);

		postRequest = new HttpPost(analyze_url);
		postRequest.setHeader("Accept", "application/json");
		postRequest.setHeader("Connection", "keep-alive");
		postRequest.setHeader("Content-Type", "application/json");

		eventDao.updateUrlSetup(map);
		eventDao.updateDeviceUrlSetup(map);

		return map;
	}

	@GetMapping("/eventActionList")
	public String eventAction(Model model) {
		// System.out.println("eventAction()");

		return "./event/eventAction/eventActionList";
	}

	@GetMapping("/networkSpeakerList")
	public String networkSpeakerSetup(Model model) {
		// System.out.println("networkSpeakerSetup()");

		return "./device/networkSpeaker/networkSpeakerList";
	}

	@PostMapping("/networkSpeakerSetup")
	@ResponseBody
	public List<Map> networkSpeakerSetup(@RequestBody Map map) {
		// System.out.println("networkSpeakerSetup()");

		List<Map> list = eventDao.selectNetworkSpeaker();

		return list;
	}

	@GetMapping("/addNetworkSpeaker")
	public String addNetworkSpeaker(Model model, String status, String speakerIdx) {
		// System.out.println("addNetworkSpeaker()");

		model.addAttribute("status", status);
		model.addAttribute("speakerIdx", speakerIdx);

		return "./device/networkSpeaker/addNetworkSpeaker";

	}

	@PostMapping("/addNetworkSpeaker")
	@ResponseBody
	public Map addNetworkSpeakerInfo(@RequestBody Map map) throws JsonProcessingException {
		// System.out.println("addNetworkSpeaker()");

		if (map.get("status").toString().equals("modify")) {
			eventDao.updateNetworkSpeaker(map);
		} else {
			eventDao.insertNetworkSpeaker(map);
		}

		return map;
	}

	@PostMapping("/getNetworkSpeaker")
	@ResponseBody
	public Map getNetworkSpeaker(@RequestBody Map map) {
		// System.out.println("getNetworkSpeaker()");

		map = eventDao.selectNetworkSpeakerByIdx(map);

		return map;
	}

	@PostMapping("/deleteNetworkSpeaker")
	@ResponseBody
	public Map deleteNetworkSpeaker(@RequestBody Map map) {
		// System.out.println("deleteNetworkSpeaker()");

		eventDao.deleteNetworkSpeakerByIdx(map);

		return map;
	}

	@PostMapping("/getSpeakerList")
	@ResponseBody
	public String getSpeakerList(@RequestBody Map map) throws org.apache.http.ParseException, IOException {
		// System.out.println("getSpeakerList()");

		String body = "";
//		String id = "root";
		String id = map.get("id").toString();
//		String pw = "00pp;;//";
		String pw = map.get("pwd").toString();
		String enc = id + ":" + pw;
		String ip = map.get("ip").toString();
//		String postUrl = "http://192.168.100.57/axis-cgi/param.cgi";
		String postUrl = "http://" + ip + "/axis-cgi/param.cgi";

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
			digestScheme.overrideParamter("action", "list");
			digestScheme.overrideParamter("group", "MediaClip");
			authCache.put(GetpostRequest, digestScheme);

			context.setCredentialsProvider(credsProvider);
			context.setAuthCache(authCache);
			String payload = "action=list&group=MediaClip";
			HttpPost httpPost = new HttpPost(url.getPath());
			httpPost.setEntity(new StringEntity(payload));
			CloseableHttpResponse response = Getclient.execute(GetpostRequest, httpPost, context);

			if (response.getStatusLine().getStatusCode() == 200) {
				ResponseHandler<String> handler = new BasicResponseHandler();
				body = handler.handleResponse(response);
//				System.out.println("스피커 = " + body);
			} else {
				System.out.println("response is error : " + response.getStatusLine().getStatusCode());
			}
			response.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return body;
	}

	@PostMapping("/sendSpeakerNumber")
	@ResponseBody
	public Map sendSpeakerNumber(@RequestBody Map map) {
		System.out.println("sendSpeakerNumber()");

		String body = "";
//		String id = "root";
		String id = map.get("id").toString();
//		String pw = "00pp;;//";
		String pw = map.get("pwd").toString();
		String enc = id + ":" + pw;
		String ip = map.get("ip").toString();
		String port = map.get("port").toString();

		String postUrl = "http://" + ip + ":" + port + "/axis-cgi/playclip.cgi?clip=" + map.get("num").toString();
//		String postUrl = "http://192.168.100.57/axis-cgi/param.cgi";

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
//		    String payload = "clip=0";
//		    HttpPost httpPost = new HttpPost(url.getPath());
//		    httpPost.setEntity(new StringEntity(payload));

			HttpGet httpGet = new HttpGet(postUrl);

			// HttpGet httpGet = new
			// HttpGet("http://192.168.100.57/axis-cgi/playclip.cgi?clip=0");
			// CloseableHttpResponse response = Getclient.execute(GetpostRequest, httpGet,
			// context);
			CloseableHttpResponse response = Getclient.execute(GetpostRequest, httpGet, context);

			if (response.getStatusLine().getStatusCode() == 200) {
				ResponseHandler<String> handler = new BasicResponseHandler();
				body = handler.handleResponse(response);
//				System.out.println("스피커 = " + body);
			} else {
				System.out.println("response is error : " + response.getStatusLine().getStatusCode());
			}
			response.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return map;
	}

	public void playNetworkSpeaker(Map returnMap, Map map) {
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
				CloseableHttpClient Getclient = HttpClients.createDefault(); // HttpClient 생성

				URL url = new URL(postUrl);

				HttpHost GetpostRequest = new HttpHost(url.getHost(), url.getPort(), url.getProtocol()); // POST 메소드 URL
																											// 새성
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
//					System.out.println("스피커 = " + body);
				} else {
					System.out.println("response is error : " + response.getStatusLine().getStatusCode());
				}
				response.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@GetMapping("/eventStatusSetup")
	public String eventStatusSetup(Model model) {
		// System.out.println("eventStatusSetup()");

		return "./event/eventStatus/eventStatusSetup";
	}

	@PostMapping("/eventStatusSetup")
	@ResponseBody
	public List<Map> eventStatusSetup() {
		// System.out.println("eventStatusSetupPost()");

		List<Map> list = eventStatusService.findAll();

		return list;
	}

	@PostMapping("/runEventAction")
	@ResponseBody
	public Map runEventAction(@RequestBody Map map) throws JsonProcessingException {
		// System.out.println("runEventAction()");

		Map returnMap = new LinkedHashMap();
		returnMap.put("command", "RF_REQ_GOTOPRESET");
		returnMap.put("sender", "web");
		returnMap.put("web_user", map.get("login_id"));
		returnMap.put("ip", map.get("dev_ip"));
		returnMap.put("id", map.get("dev_id"));
		returnMap.put("pw", map.get("dev_pwd"));
		returnMap.put("mac", map.get("dev_mac_address"));

		returnMap.put("preset_name", map.get("pre_title"));

		returnMap.put("port", map.get("dev_web_port"));

		TextMessage return_message = new TextMessage(new ObjectMapper().writeValueAsString(returnMap));
		webSession.sendMessage(return_message, webSocketService);

		eventStatusService.remove(map);

		return map;
	}

	@PostMapping("/cancelEventAction")
	@ResponseBody
	public Map cancelEventAction(@RequestBody Map map) {
		// System.out.println("cancelEventAction()");

		eventStatusService.remove(map);

		return map;
	}

	@GetMapping("/eventSetup")
	public String eventSetup(Model model) {
		// System.out.println("eventSetup()");

		return "./event/eventSetup/eventSetup";
	}

	@PostMapping("/eventSetup")
	@ResponseBody
	public List<Map> eventSetup(Map map) {
		// System.out.println("eventSetupPost()");

		List<Map> actionList = eventDao.selectActionSetup(map);

		return actionList;
	}

	@GetMapping(value = "/eventSetupInfo")
	public String eventActionSetup(Model model, String model_name, int dev_ch, String opt) {
		// System.out.println("eventActionSetup()");

		model.addAttribute("model_name", model_name);
		Map map = new HashMap();
		map.put("dev_ch", dev_ch);
		Map devinfo = eventDao.deviceInfoOne2(map);
		model.addAttribute("dev_title", devinfo.get("dev_title").toString());
		model.addAttribute("dev_ch", dev_ch);
		model.addAttribute("on_off", opt);

		return "./event/eventSetup/eventSetupInfo";
	}

	@PostMapping("/eventSetupInfo")
	@ResponseBody
	public Map<String, Object> saveActionSetup(@RequestBody Map params) throws JsonProcessingException {
		// System.out.println("saveActionSetup()");

		String model_name = params.get("model_name").toString();
		String dev_title = (String) params.get("dev_title");
		int dev_ch = Integer.parseInt(params.get("dev_ch").toString());
		int opt = Integer.parseInt(params.get("opt").toString());
		boolean chk = Boolean.parseBoolean(params.get("chk").toString());

		Map map = new HashMap();

		if (model_name.equals("화재")) {
			map.put("action_fire", opt);
			map.put("model_name", "action_fire");
		} else if (model_name.equals("누수")) {
			map.put("actopm_leak", opt);
			map.put("model_name", "actopm_leak");
		} else if (model_name.equals("약품 미투입")) {
			map.put("action_spin", opt);
			map.put("model_name", "action_spin");
		} else if (model_name.equals("침입")) {
			map.put("action_invasion", opt);
			map.put("model_name", "action_invasion");
		} else if (model_name.equals("배회")) {
			map.put("action_loitering", opt);
			map.put("model_name", "action_loitering");
		} else if (model_name.equals("쓰러짐")) {
			map.put("action_falldown", opt);
			map.put("model_name", "action_falldown");
		} else if (model_name.equals("수신호")) {
			map.put("action_handaction", opt);
			map.put("model_name", "action_handaction");
		} else if (model_name.equals("장갑미착용")) {
			map.put("action_glove", opt);
			map.put("model_name", "action_glove");
		} else if (model_name.equals("침수")) {
			map.put("actopm_flood", opt);
			map.put("model_name", "actopm_flood");
		}

		map.put("confidence", params.get("confidence"));
		map.put("duration", params.get("duration"));

		// System.out.println(mapper.writeValueAsString(map));

		if (!chk) {
			map.put("dev_ch", dev_ch);
			eventDao.updateActionSetupBySetup(map);
			eventDao.updateConfdur(map);
			actionSetupService.updateModel(map);
		} else {
			for (int i = 0; i < dev_title.split(",").length; i++) {
				map.put("dev_ch", Integer.parseInt(dev_title.split(",")[i]));
				eventDao.updateActionSetupBySetup(map);
				eventDao.updateConfdur(map);
				actionSetupService.updateModel(map);
			}
		}

		return null;
	}

	@GetMapping(value = "/areaSet")
	public String areaSet(Model model, String area_event, int dev_ch) throws IOException {
		VersionDto searchDto = versionRepository.selectVersionInfo("device_search");
		String address = searchDto.getRequest_url();
		
		model.addAttribute("address", address);
		model.addAttribute("area_event", area_event);
		model.addAttribute("dev_ch", dev_ch);
		Map map = new HashMap();
		map.put("dev_ch", dev_ch);
		Map devinfo = eventDao.deviceInfoOne2(map);
		model.addAttribute("dev_title", devinfo.get("dev_title").toString());

		String path = part_drive_name + ":/web_server/" + "roi/";

		File folder = new File(path);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		folder = new File(path + dev_ch + ".jpg");

		if (folder.exists()) {
			EasyImage easyImage = new EasyImage(folder);
			BufferedImage bi = ImageIO.read(folder);

			if (!easyImage.isSupportedImageFormat()) {
				System.out.println("not supported image type");
			}

			int hWidth = bi.getWidth();
			int hHeight = bi.getHeight();

			model.addAttribute("isImg", true);
			model.addAttribute("path", "/web_server/roi/" + dev_ch + ".jpg");
			model.addAttribute("width", hWidth);
			model.addAttribute("height", hHeight);
		} else {
			model.addAttribute("isImg", false);
		}

		return "./event/eventSetup/areaSet";
	}

	@PostMapping("/areaSet")
	@ResponseBody
	public Map areaSet(@RequestBody Map map) throws IOException {
		// System.out.println("areaSet()");

		Map returnMap = eventDao.selectAreaSet(map);

		if (returnMap == null) {
			returnMap = new HashMap();
			returnMap.put("result", "failed");
		} else {
			returnMap.put("result", "success");
		}

//		if (base64Repository.find(Integer.parseInt(map.get("dev_ch").toString())).isPresent()) {
//			returnMap.put("base64", base64Repository.find(Integer.parseInt(map.get("dev_ch").toString())).get());
//		}

		return returnMap;
	}

	@PostMapping("/setAreaSet")
	@ResponseBody
	public Map setAreaSet(@RequestBody Map map) throws JsonProcessingException {
		// System.out.println("setAreaSet()");

		map.put("area_total", new ObjectMapper().writeValueAsString(map.get("area_total")));
		map.put("area_now", new ObjectMapper().writeValueAsString(map.get("area_now")));

		eventDao.setAreaSet(map);
		if (areaSetService.selectOne(map) != null) {
			areaSetService.updateArea(map);
		} else {
			areaSetService.insert(map);
		}

		return map;
	}

	@GetMapping(value = "/schedule_setup")
	public String schedule_setup(Model model, String event_name, int dev_ch) throws IOException {
		// System.out.println("schedule_setup()");

		model.addAttribute("event_name", event_name);
		model.addAttribute("dev_ch", dev_ch);
		Map map = new HashMap();
		map.put("dev_ch", dev_ch);
		Map devinfo = eventDao.deviceInfoOne2(map);
		model.addAttribute("dev_title", devinfo.get("dev_title").toString());

		return "./event/eventSetup/schedule_setup";
	}

	@PostMapping("/schedule_setup")
	@ResponseBody
	public Map selectSchedule(@RequestBody Map map) {
		// System.out.println("selectSchedule()");

		if (eventDao.selectSchedule(map).isPresent()) {
			Map returmMap = eventDao.selectSchedule(map).get();
			return returmMap;
		}

		return new HashMap();
	}

	@PostMapping("/saveSchedule")
	@ResponseBody
	public Map saveSchedule(@RequestBody Map map) throws Exception {
		// System.out.println("saveSchedule()");
		String event_name = map.get("event_name").toString();
		String dev_ch = map.get("dev_ch").toString();
		String dev_title = map.get("dev_title").toString();
		map.put("id_list", map.get("id_list").toString().replaceAll("[\\[\\]]", ""));

		eventDao.saveSchedule(map);
		scheduleRepository.save(map);

		// List<String> list =
		// Arrays.asList(map.get("id_list").toString().replaceAll("[\\[\\]]","").split(","));

		Map returnMap = new HashMap();
		returnMap.put("status", "success");

		return returnMap;
	}

	@RequestMapping(value = "/license")
	public String license(Model model) {
		// System.out.println("license()");

		return "./setup/license";
	}

	@RequestMapping(value = "/get_license_info")
	@ResponseBody
	public String get_license_info() {
		// System.out.println("get_license_info()");

		return str;
	}

	@RequestMapping(value = "/get_license_request_code")
	@ResponseBody
	public String get_license_request_code() throws ParseException {
		// System.out.println("get_license_request_code()");

		int minute = 2;

		StringBuilder sb = new StringBuilder();

		BufferedReader in = null;

		HttpURLConnection con = null;

		String get_url = analyze_url.substring(0, analyze_url.lastIndexOf("/")) + "/get_license_request_code";

		try {
			URL req = new URL(get_url);
			con = (HttpURLConnection) req.openConnection();
			con.setConnectTimeout(minute * 60 * 1000); // 2분
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "text/html; charset=UTF-8");
			in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String line;
			while ((line = in.readLine()) != null) { // response를 차례대로 출력
				sb.append(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (con != null)
					con.disconnect();
				if (in != null)
					in.close();
			} catch (Exception se) {
			}
		}

		// System.out.println(sb.toString());

		String uploadPath = master_drive_name + ":/web_server/";
		File folder = new File(uploadPath);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		uploadPath += "text" + "/";
		folder = new File(uploadPath);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		// File file = new File("C:/home/mjs/test/text.txt");
		String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		date = date.split(" ")[0].replaceAll("-", "") + date.split(" ")[1].replaceAll(":", "") + ".txt";

		File file = new File(uploadPath + date);

		JSONParser jsonParser = new JSONParser();
		JSONObject json = new JSONObject();

		try {
			BufferedWriter writer = new BufferedWriter(new FileWriter(file));
			json = (JSONObject) jsonParser.parse(sb.toString());
			writer.write(json.get("request_code").toString());
			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		uploadPath = uploadPath.replace(master_drive_name + ":/web_server", "/webserver") + date;

		return uploadPath;
	}

	@RequestMapping(value = "/set_license_code")
	@ResponseBody
	public String set_license_code(@RequestBody String txt) {
		// System.out.println("set_license_code()");
		String result = "";

		JSONObject json = new JSONObject();

		json.put("license_code", txt);

		String body = "";

		String requestURL = analyze_url.substring(0, analyze_url.lastIndexOf("/")) + "/set_license_code";

		try {
			HttpClient client1 = HttpClientBuilder.create().build(); // HttpClient 생성

			HttpPost postRequest1 = new HttpPost(requestURL); // POST 메소드 URL 새성

			postRequest1.setHeader("Accept", "application/json");
			postRequest1.setHeader("Connection", "keep-alive");
			postRequest1.setHeader("Content-Type", "application/json");

			postRequest1.setEntity(new StringEntity(json.toJSONString().replaceAll("\\\\", ""))); // json 메시지 입력

			HttpResponse response1 = client1.execute(postRequest1);

			// Response 출력
			if (response1.getStatusLine().getStatusCode() == 200) {
				ResponseHandler<String> handler = new BasicResponseHandler();
				body = handler.handleResponse(response1);
				result = body;
			} else {
				result = "response is error : " + response1.getStatusLine().getStatusCode();
				// System.out.println("response is error : " +
				// response1.getStatusLine().getStatusCode());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@RequestMapping(value = "/oem")
	public String oem(Model model) {
		// System.out.println("oem()");

		return "./setup/oem";
	}

	@RequestMapping(value = "/driveSize")
	public String driveSize(Model model) {
		// System.out.println("driveSize()");

		return "./setup/driveSize";
	}

	// 議곌굔�뿉 �뵲瑜� �뜲�씠�꽣 諛쏆븘�샂
	@RequestMapping(value = "/selectEventAction")
	@ResponseBody
	public List selectEventAction(@RequestBody Map map) {
		// System.out.println("selectEventAction()");

		List list = new ArrayList();

		List<Map> itemDto = eventDao.itemInfo();

		list.add(itemDto);
		list.add(eventDao.actionInfoIsuse());

		return list;
	}

	@RequestMapping(value = "/selectPreset250")
	@ResponseBody
	public List<Map> selectPreset250(@RequestBody Map map) {
		// System.out.println("selectPreset250()");

		List<Map> list = eventDao.selectPreset250(map);
		// System.out.println("title = " + map.get("dev_title"));

		return list;
	}

	@RequestMapping(value = "/insertActionInfo")
	@ResponseBody
	public List<Map> insertActionInfo(@RequestBody Map map) throws JsonProcessingException {
		// System.out.println("insertActionInfo()");

		Map devInfo = eventDao.selectDeviceInfoByTitle(map);
		String dev_ip = devInfo.get("dev_ip").toString();

		List<String> eventList = Arrays
				.asList(map.get("action_event").toString().replaceAll("[\\[\\]]", "").split(", "));
		String action_action = map.get("action_action").toString().replaceAll("[\\[\\]]", "");

		Map saveMap = new HashMap();
		saveMap.put("action_ip", dev_ip);
		saveMap.put("action_action", action_action);
		saveMap.put("action_source", map.get("action_source").toString());
		saveMap.put("dev_title", map.get("dev_title").toString());

		if (Boolean.parseBoolean(map.get("isPreset").toString())) {
			saveMap.put("pre_title", map.get("pre_title").toString());
		}
		if (Boolean.parseBoolean(map.get("isNetwork").toString())) {
			saveMap.put("network_title", map.get("network_title").toString());
		}

		List<Map> returnList = new ArrayList<Map>();

		for (int i = 0; i < eventList.size(); i++) {
			String action_key = map.get("dev_title") + "_" + eventList.get(i) + "_" + map.get("action_source");
			saveMap.put("action_event", eventList.get(i));
			saveMap.put("action_key", action_key);
			Map result = eventDao.insertActionInfo(saveMap);
			actionEventRepository.save(saveMap);
			if (result != null) {
				actionListTotal.add(result);
				returnList.add(result);
			}
		}

		return returnList;
	}

	@PostMapping("/updateActionIsuse")
	@ResponseBody
	public Map updateActionIsuse(@RequestBody Map map) {
		// System.out.println("updateActionIsuse()");

		eventDao.updateActionIsuse(map);

		return map;
	}

	@RequestMapping(value = "/updateActionIsuseAll")
	@ResponseBody
	public void updateActionIsuseAll(@RequestBody Map map) {
		// System.out.println("updateActionIsuseAll()");

		eventDao.updateActionIsuseAll(map);

	}

	@RequestMapping(value = "/updateActionInfo")
	@ResponseBody
	public Map updateActionInfo(@RequestBody Map map) {
		// System.out.println("updateActionInfo()");

		Map updateMap = new HashMap();
		updateMap.put("action_key", map.get("action_key").toString());

		if (Boolean.parseBoolean(map.get("isPreset").toString())) {
			updateMap.put("pre_title", map.get("pre_title").toString());
		}
		if (Boolean.parseBoolean(map.get("isNetwork").toString())) {
			updateMap.put("network_title", map.get("network_title").toString());
		}

		String action_action = map.get("action_action").toString().replaceAll("[\\[\\]]", "");
		updateMap.put("action_action", action_action);

		eventDao.updateActionInfo(updateMap);
		updateMap.put("action_event", map.get("action_event").toString());
		updateMap.put("dev_title", map.get("dev_title").toString());

		actionEventRepository.update(updateMap);

		return updateMap;
	}

	int roiNum = 0;
	ArrayList<JSONObject> tagList = null;
	JSONObject tokkenTime = new JSONObject();

	@RequestMapping(value = "/deleteActionInfo")
	@ResponseBody
	public Map deleteActionInfo(@RequestBody Map map) {
		// System.out.println("deleteActionInfo()");

		eventDao.deleteActionInfo(map);
		actionEventRepository.deleteOne(map.get("dev_title").toString(), map.get("action_event").toString());

//		for (int i = 0; i < actionListTotal.size(); i++) {
//			if (actionListTotal.get(i).get("action_key").equals(map.get("action_key"))) {
//				actionListTotal.remove(i);
//				break;
//			}
//		}

		Map return_map = new HashMap();
		return_map.put("status", "success");

		return return_map;
	}

	// 議곌굔�뿉 �뵲瑜� �뜲�씠�꽣 諛쏆븘�샂
	@RequestMapping(value = "/event/list")
	@ResponseBody
	public List<String> itemList(@RequestBody Map<String, Object> login) throws Exception {
		// System.out.println("itemList()");

		List<String> list = eventDao.eventListDate(login);

		return list;
	}

	@RequestMapping(value = "/filterCount")
	@ResponseBody
	public List<CountDto> filterCount(@RequestBody Map<String, Object> login) {
		// System.out.println("filterCount()");

		List<CountDto> list = null;

		String event_name = login.get("event_name").toString();

		if (login.get("value") != null) {
			list = eventDao.filterCount2(event_name);

		} else {
			list = eventDao.filterCount(event_name);
		}

		return list;
	}

	@Resource(name = "uploadPath")
	private String uploadPath;

	/*
	 * // �옣鍮꾨줈遺��꽣 �뜲�씠�꽣 諛쏆븘�샂
	 * 
	 * @RequestMapping(value = "/insert")
	 * 
	 * @ResponseBody public void insert(@RequestBody EventDto eventDto) {
	 * System.out.println("insert()");
	 * 
	 * File folder = new File(uploadPath);
	 * 
	 * if (!folder.exists()) { try { System.out.println("폴더 생성"); folder.mkdir(); }
	 * catch (Exception e) { e.getStackTrace(); } } else {
	 * System.out.println("폴더가 이미 존재합니다."); }
	 * 
	 * ObjectMapper mapper = new ObjectMapper(); //
	 * mapper.configure(Feature.ALLOW_BACKSLASH_ESCAPING_ANY_CHARACTER, true);
	 * String jsonStr = "";
	 * 
	 * try { jsonStr = mapper.writeValueAsString(eventDto); } catch
	 * (JsonProcessingException e1) { System.out.println("오류 발생");
	 * e1.printStackTrace(); }
	 * 
	 * if (eventDto.getImg_type() != null && eventDto.getImg_type() != null &&
	 * (eventDto.getImg_type().equals("jpg") || eventDto.getImg_type().equals("bmp")
	 * || eventDto.getImg_type().equals("png"))) {
	 * 
	 * //eventDto.setImg_data(eventDto.getImg_data().replaceAll("_", "/"));
	 * //eventDto.setImg_data(eventDto.getImg_data().replaceAll("-", "+"));
	 * 
	 * 
	 * byte[] decodedBytes =
	 * DatatypeConverter.parseBase64Binary(eventDto.getImg_data());
	 * 
	 * // int num = Integer.parseInt(eventDao.countImage()) + 40; String name =
	 * eventDto.getDev_ip() + "_" + eventDto.getDev_channel() + "_" +
	 * eventDto.getEvent_name().replaceAll(" ", "_") + "_" +
	 * eventDto.getEvent_time().replaceAll("-", "").replaceAll(":",
	 * "").replaceAll(" ", "_"); System.out.println(name);
	 * 
	 * try { BufferedImage bufImg = ImageIO.read(new
	 * ByteArrayInputStream(decodedBytes)); ImageIO.write(bufImg, "jpg", new
	 * File(uploadPath + "/" + name + "." + eventDto.getImg_type()));
	 * eventDto.setImage_name(uploadPath + "/" + name + "." +
	 * eventDto.getImg_type()); System.out.println(eventDto.getImage_name());
	 * //eventDao.insertImage(eventDto);
	 * this.template.setMessageConverter((MessageConverter) new
	 * StringMessageConverter()); this.template.convertAndSend("/showImage",
	 * eventDto.getImage_name()); } catch (IOException e) { e.printStackTrace(); } }
	 * 
	 * if (eventDto.getEvent_name() != "test" && eventDto.getEvent_name() != "Test")
	 * { if (Integer.parseInt(eventDao.selectCount(eventDto).get(0)) > 0) {
	 * eventDao.updateCount(eventDto); } else { eventDao.insertCount(eventDto); }
	 * eventDao.insertJson(eventDto); }
	 * 
	 * this.template.setMessageConverter((MessageConverter) new
	 * StringMessageConverter()); this.template.convertAndSend("/receiveMessage",
	 * jsonStr);
	 * 
	 * this.template.setMessageConverter((MessageConverter) new
	 * StringMessageConverter()); this.template.convertAndSend("/receiveCount",
	 * jsonStr);
	 * 
	 * }
	 */
	public void startPostQ() {
		// System.out.println("startPostQ()");

		Runnable runnable = new Runnable() {
			@Override
			public void run() {
				// 스레드에게 시킬 작업 내용
				while (true) {
					Map map;
					try {
//						System.out.println("in = " + postQ.size());

						map = postQ.take();

						ObjectMapper mapper = new ObjectMapper();

						String json = null;

						try {
							json = mapper.writeValueAsString(map);
						} catch (JsonProcessingException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}

						String body = "";

						try {
							// HttpClient client = HttpClientBuilder.create().build(); // HttpClient 생성
							long now = System.currentTimeMillis();

							URL url = new URL(analyze_url);
							HttpURLConnection con = (HttpURLConnection) url.openConnection();
							con.setRequestMethod("POST");
//							con.setRequestProperty("Content-Type", "application/json; utf-8");
							con.setRequestProperty("Content-Type", "application/json");
							con.setRequestProperty("Accept", "application/json");

							con.setDoOutput(true);
							DataOutputStream wr = new DataOutputStream(con.getOutputStream());
							wr.writeBytes(json);
							wr.flush();
							wr.close();

//							System.out.println("postQ code = " + con.getResponseCode());

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
							StringWriter error = new StringWriter();
							e.printStackTrace(new PrintWriter(error));
							String errorMsg = error.toString();
							ErrorLogDto errorLogDto = new ErrorLogDto();
							errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
							errorLogDto.setLog_place("POST 오류");
							errorLogDto.setLog_content(errorMsg);
							eventDao.insertErrorLog(errorLogDto);
							errorWebsocket(errorLogDto);
						}

					} catch (Exception e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				}
			}
		};
		// 스레드풀에게 작업 처리 요청
		executorService.submit(runnable);
	}

	JSONObject durationJSON = new JSONObject();
	int testCount = 0;
	Date date4 = new Date();
	long duration4 = date4.getTime();
	double insertImageTime = 0;

	JSONObject insertImageReturn = new JSONObject();

	@PostMapping("/insertImages")
	@ResponseBody
	public Map insertImages(@RequestBody Map map) {
//		System.out.println("insertImages()");

		Map returnMap = new HashMap();

		if (postQ.size() <= 60) {
			try {
				insertQ.put(map);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			returnMap.put("status", "ok");
		} else {
			returnMap.put("status", "postQ is full");
		}

		returnMap.put("insertQ", insertQ.size());
		returnMap.put("postQ", postQ.size());
		returnMap.put("responseQ", responseQ.size());

		return returnMap;
	}

	public void startInsertQ() {
		Runnable runnable = new Runnable() {
			@Override
			public void run() {
				while (true) {
					Map map;
					try {
						map = insertQ.take();

						if (postQ.size() <= 60) {
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

										String uploadPath = part_drive_name + ":/web_server/" + "roi/";

										File folder = new File(uploadPath);

										if (!folder.exists()) {
											try {
												folder.mkdir();
											} catch (Exception e) {
												e.getStackTrace();
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
											e.printStackTrace();
											System.out.println("원본 이미지 저장 안됨");
										}
									}
								} else {
									insertImagesTimeRepository.insertTime(dev_ch, event_time);
//									base64Repository.save(dev_ch, base64);

									String uploadPath = part_drive_name + ":/web_server/" + "roi/";

									File folder = new File(uploadPath);

									if (!folder.exists()) {
										try {
											folder.mkdir();
										} catch (Exception e) {
											e.getStackTrace();
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
										e.printStackTrace();
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
											postMap.put("callback_url", request_url);

											postQ.put(postMap);
//											System.out.println("postQ.size() = " + postQ.size());
										}
									}
								}
							}
						}
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		};
		// 스레드풀에게 작업 처리 요청
		executorService.submit(runnable);
	}

	@RequestMapping(value = "/insertImage", method = RequestMethod.POST)
	@ResponseBody
	public String insertImage(@RequestBody String tmpResponse)
			throws IOException, ParseException, ImageProcessingException, java.text.ParseException {
		// System.out.println("insertImage()");

		long start = System.currentTimeMillis();

		/*
		 * testCount ++; Date date5 = new Date(); long duration5 = date5.getTime(); if
		 * ((duration5 - duration4) / 1000 == 10 || (duration5 - duration4) / 1000 > 10)
		 * { //System.out.println("count = " + testCount); date4 = new Date(); duration4
		 * = date4.getTime(); testCount = 0; }
		 */

		try {
			// insertImageLogJson(tmpResponse);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.err.println(e.toString());
			StringWriter error = new StringWriter();
			e.printStackTrace(new PrintWriter(error));
			String errorMsg = error.toString();
			ErrorLogDto errorLogDto = new ErrorLogDto();
			errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			errorLogDto.setLog_place("insertImage JSON 형태 로그 저장 오류");
			errorLogDto.setLog_content(errorMsg);
			eventDao.insertErrorLog(errorLogDto);
			errorWebsocket(errorLogDto);
		}
		long nano = System.currentTimeMillis();
		// System.out.println("insertImageLogJson 받는 시간 = " + (nano - start)/1000.0 +
		// "초");

		try {
			// insertImageLog(tmpResponse);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.err.println(e.toString());
			StringWriter error = new StringWriter();
			e.printStackTrace(new PrintWriter(error));
			String errorMsg = error.toString();
			ErrorLogDto errorLogDto = new ErrorLogDto();
			errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			errorLogDto.setLog_place("insertImage 테이블 형태 로그 저장 오류");
			errorLogDto.setLog_content(errorMsg);
			eventDao.insertErrorLog(errorLogDto);
			errorWebsocket(errorLogDto);
		}
		nano = System.currentTimeMillis();
		// System.out.println("insertImageLog 받는 시간 = " + (nano - start)/1000.0 + "초");

		JSONParser jsonParser = new JSONParser();
		JSONObject json = new JSONObject();

		try {
			json = (JSONObject) jsonParser.parse(tmpResponse);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.err.println(e.toString());
			StringWriter error = new StringWriter();
			e.printStackTrace(new PrintWriter(error));
			String errorMsg = error.toString();
			ErrorLogDto errorLogDto = new ErrorLogDto();
			errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
			errorLogDto.setLog_place("insertImage 문자열을 JSON 형태로 형변환 하는 과정 오류");
			errorLogDto.setLog_content(errorMsg);
			eventDao.insertErrorLog(errorLogDto);
			errorWebsocket(errorLogDto);
		}

		if (json.get("img_data") == null) {
			// requestJson.put("status", "failed");
			// System.out.println("insertImage() 이미지 없음");
		} else {
			String item_name = json.get("item_name").toString();
			String dev_ip = json.get("dev_ip").toString();
			String dev_id = json.get("dev_id").toString();
			String dev_ch = json.get("dev_ch").toString();
			String dev_port = json.get("dev_port").toString();
			String dev_web_port = json.get("dev_web_port").toString();
			String dev_pw = json.get("dev_pw").toString();
			String event_time = json.get("event_time").toString();

			String duration_keyword = item_name + "_" + dev_ip + "_" + dev_id + "_" + dev_port + "_" + dev_ch;

			Date date = null;
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(event_time);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.err.println(e.toString());
				StringWriter error = new StringWriter();
				e.printStackTrace(new PrintWriter(error));
				String errorMsg = error.toString();
				ErrorLogDto errorLogDto = new ErrorLogDto();
				errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
				errorLogDto.setLog_place("insertImage 날짜 문자열을 날짜 객체로 형변환 오류1");
				errorLogDto.setLog_content(errorMsg);
				eventDao.insertErrorLog(errorLogDto);
				errorWebsocket(errorLogDto);
			}
			long duration1 = date.getTime();
			long duration;

			long durationTime = 0; // 1000 = 초, 60000 = 분, 3600000 = 시간

			JSONObject jsonObject = null;
			ArrayList<String> originalTags = null;

			// System.out.println("duration_keyword = " + duration_keyword);
			// System.out.println("durationJSON.get(duration_keyword) != null = " +
			// (durationJSON.get(duration_keyword) != null));

			if (durationJSON.get(duration_keyword) != null) {
				JSONParser jsonParser2 = new JSONParser();
				JSONObject durationResponse = (JSONObject) durationJSON.get(duration_keyword);
				try {
					jsonObject = (JSONObject) jsonParser.parse(durationResponse.get("durationResponse").toString());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					System.err.println(e.toString());
					StringWriter error = new StringWriter();
					e.printStackTrace(new PrintWriter(error));
					String errorMsg = error.toString();
					ErrorLogDto errorLogDto = new ErrorLogDto();
					errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
					errorLogDto.setLog_place("insertImage 해당 장비의 이전 데이터 형변환 도중 오류");
					errorLogDto.setLog_content(errorMsg);
					eventDao.insertErrorLog(errorLogDto);
					errorWebsocket(errorLogDto);
				}
				try {
					date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(event_time);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					System.err.println(e.toString());
					StringWriter error = new StringWriter();
					e.printStackTrace(new PrintWriter(error));
					String errorMsg = error.toString();
					ErrorLogDto errorLogDto = new ErrorLogDto();
					errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
					errorLogDto.setLog_place("insertImage 날짜 문자열을 날짜 객체로 형변환 오류2");
					errorLogDto.setLog_content(errorMsg);
					eventDao.insertErrorLog(errorLogDto);
					errorWebsocket(errorLogDto);
				}
				duration1 = date.getTime();
				duration = (Long) durationResponse.get("duration");
				// System.out.println("event_time = " + event_time);
				// System.out.println(new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss").format(new
				// Date(duration)));
				// System.out.println(new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss").format(date)
				// + " = " + new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss").format(new
				// Date(duration)));
				durationTime = (duration1 - duration) / 1000;
				// System.out.println("durationTime = " + durationTime);
				originalTags = (JSONArray) jsonObject.get("tags");
			}

			// System.out.println("ch = " + dev_ch + " / duration1 = " + duration1 + " /
			// durationTime = " + Math.abs(durationTime));

			if ((durationJSON.get(duration_keyword) != null) && (Math.abs(durationTime) < 5)) {
				// JSONObject jsonObject =
				// (JSONObject)jsonParser2.parse(durationJSON.get(duration_keyword).toString());
				/*
				 * JSONObject req_info = (JSONObject)jsonObject.get("req_info");
				 * req_info.put("event_time", event_time); req_info.put("img_data",
				 * json.get("img_data").toString()); String img_name = "ch" + dev_ch + "_" +
				 * event_time.split(" ")[1].split(":")[0] +
				 * event_time.split(" ")[1].split(":")[1] +
				 * event_time.split(" ")[1].split(":")[2] + ".jpg"; jsonObject.put("img_name",
				 * img_name); jsonObject.put("req_info", req_info);
				 * //System.out.println(jsonObject.toJSONString().replaceAll("\\\\", ""));
				 * //System.out.println(jsonObject.toJSONString().replaceAll("\\\\", "")); try {
				 * responseEvent2(jsonObject.toJSONString().replaceAll("\\\\", "")); } catch
				 * (Exception e) { // TODO Auto-generated catch block e.printStackTrace(); }
				 */
			} else {
				JSONObject req_info = new JSONObject();
				req_info.put("item_name", item_name);
				req_info.put("dev_ip", dev_ip);
				req_info.put("dev_id", dev_id);
				req_info.put("dev_pwd", dev_pw);
				req_info.put("dev_port", dev_port);
				req_info.put("dev_web_port", dev_web_port);
				req_info.put("dev_ch", dev_ch);
				req_info.put("event_time", event_time);
				req_info.put("start_time", start);
				req_info.put("img_data", json.get("img_data").toString());

				String img_data = json.get("img_data").toString();

				if (json.get("mot_data") != null) {
					img_data = json.get("mot_data").toString();
				}

				String img_type = json.get("img_type").toString();
				String user_name = json.get("user_name").toString();
				String img_name = "ch" + dev_ch + "_" + event_time.split(" ")[1].split(":")[0]
						+ event_time.split(" ")[1].split(":")[1] + event_time.split(" ")[1].split(":")[2] + ".jpg";
				json = new JSONObject();
				json.put("req_info", req_info);
				json.put("img_name", img_name);
				json.put("img_data", img_data);
				json.put("img_type", "jpg");
				json.put("client_code", client_code);

				if (client_code.equals("poldrone")) {
					json.put("event_request", "People Detect");
				}
				// json.put("client_code", "samsung_heavy_industries"); //cheongju_battalion
				// samsung_heavy_industries
				json.put("user_name", user_name);
				json.put("user_passwd", "12lsxdfq");
				json.put("request_url", request_url);
				// json.put("request_url", "https://192.168.100.101:20101/responseEvent");

				// String response = post("http://192.168.100.102:5000/search_async",
				// json.toJSONString().replaceAll("\\\\", ""));

				// System.out.println("보내고 결과 받는 시간 = " + (now - start)/1000.0 + "초");

				// post(json.toJSONString().replaceAll("\\\\", ""));

				// json.put("event_request", "People Detect");
				// json.put("request_url", "https://211.117.45.3:20101/responseEvent");
				// json.put("request_url", "http://127.0.0.1:20102/responseEvent");
				// String response = post("http://59.10.218.200:5000/search_async",
				// json.toJSONString().replaceAll("\\\\", ""));
				// jsonParser = new JSONParser();
				// JSONObject queue = (JSONObject)jsonParser.parse(response);

				long now = System.currentTimeMillis();
				if ((now - start) / 1000.0 > 0.03) {
					// System.out.println("insertImage 분석 시간 = " + (now - start)/1000.0 + "초");
				}
				// System.out.println("쓰레드 갯수 = " + ((ThreadPoolExecutor)
				// executorService).getPoolSize());
			}
			// requestJson.put("status", "success");
		}

		JSONParser jsonParser2 = new JSONParser();
		JSONObject json2 = new JSONObject();

		try {
			json2 = (JSONObject) jsonParser2.parse(tmpResponse);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String item_name = json2.get("item_name").toString();
		String dev_ip = json2.get("dev_ip").toString();
		String dev_id = json2.get("dev_id").toString();
		String dev_port = json2.get("dev_port").toString();
		String dev_ch = json2.get("dev_ch").toString();

		String duration_keyword = item_name + "_" + dev_ip + "_" + dev_id + "_" + dev_port + "_" + dev_ch;

		String event_time = json2.get("event_time").toString();
		String event_result = "none";
		String ch = dev_ch;

		if (insertImageReturn.get(duration_keyword) != null) {
			JSONObject insertImageReturnResponse = (JSONObject) insertImageReturn.get(duration_keyword);
			event_time = insertImageReturnResponse.get("event_time").toString();
			event_result = insertImageReturnResponse.get("event_result").toString();
			ch = insertImageReturnResponse.get("ch").toString();
		}

		JSONObject requestJson = new JSONObject();
		requestJson.put("status", "success");
		requestJson.put("event_result", event_result);
		requestJson.put("event_time", event_time);
		requestJson.put("ch", Integer.parseInt(ch));

		long nono = System.currentTimeMillis();

		// System.out.println("insertImage() = " + (nano - start)/1000.0 + "초");
		// System.out.println("16채널 기준 insertImage() = " + (((nano - start)/1000.0) *
		// 16) + "초");
		insertImageTime = (((nano - start) / 1000.0) * 16);

		return requestJson.toJSONString().replaceAll("\\\\", "");
	}

	@RequestMapping(value = "/responseEvent_poldrone", method = RequestMethod.POST)
	@ResponseBody
	public void responseEvent_poldrone(@RequestBody String tmpResponse)
			throws IOException, ParseException, ImageProcessingException, java.text.ParseException {
		// System.out.println("responseEvent_poldrone()");
		long start = System.currentTimeMillis();

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = new JSONObject();
		try {
			jsonObject = (JSONObject) jsonParser.parse(tmpResponse);
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		jsonObject.put("color_tags", (JSONArray) jsonObject.get("tags"));
		jsonObject.remove("tags");

		JSONArray object_list = (JSONArray) jsonObject.get("object_list");

		LinkedHashSet<String> linkedHashSet = new LinkedHashSet<String>();

		for (int i = 0; i < object_list.size(); i++) {
			JSONObject object_json = (JSONObject) object_list.get(i);
			linkedHashSet.add(object_json.get("class_name").toString());
		}

		object_list = new JSONArray();

		for (int i = 0; i < linkedHashSet.size(); i++) {
			if (linkedHashSet.toArray()[i].equals("person")) {
				object_list.add(linkedHashSet.toArray()[i]);
			}
		}

		jsonObject.put("tags", object_list);
		jsonObject.remove("object_list");

		tmpResponse = jsonObject.toJSONString().replaceAll("\\\\", "");

		long nano = System.currentTimeMillis();
		// System.out.println("1차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
		JSONObject req_info = (JSONObject) jsonObject.get("req_info");

		if (jsonObject.get("req_info") != null) {
			nano = System.currentTimeMillis();
			// System.out.println("4차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				// saveImage(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("saveImage 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				insertResponseLogJson(tmpResponse);
			} catch (Exception e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("insertResponseLogJson 결과 받는 시간 = " + (nano -
			// start)/1000.0 + "초");

			String event_time = req_info.get("event_time").toString();

			Date date = new Date();
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(event_time);
			} catch (Exception e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			long duration1 = date.getTime();
			long duration;
			// System.out.println("json 변수 만드는 시간 = " + (now - start)/1000.0 + "초");

			long durationTime = 0; // 1000 = 초, 60000 = 분, 3600000 = 시간

			String item_name = req_info.get("item_name").toString();
			String dev_ip = req_info.get("dev_ip").toString();
			String dev_id = req_info.get("dev_id").toString();
			String dev_port = req_info.get("dev_port").toString();
			String dev_ch = req_info.get("dev_ch").toString();

			String duration_keyword = item_name + "_" + dev_ip + "_" + dev_id + "_" + dev_port + "_" + dev_ch;

			ArrayList<String> originalTags = (JSONArray) jsonObject.get("tags");

			int count = originalTags.size();

			String event_result = "";

			if (count > 0) {
				event_result = "detect";
			} else {
				event_result = "none";
			}

			JSONObject insertImageJson = new JSONObject();
			insertImageJson.put("event_time", event_time);
			insertImageJson.put("event_result", event_result);
			insertImageJson.put("ch", dev_ch);

			insertImageReturn.put(duration_keyword, insertImageJson);

			// System.out.println("태그 존재 여부 = " + count);

			if (durationJSON.get(duration_keyword) != null) {
				JSONParser jsonParser2 = new JSONParser();
				JSONObject durationResponse = (JSONObject) durationJSON.get(duration_keyword);
				try {
					jsonObject = (JSONObject) jsonParser2.parse(durationResponse.get("durationResponse").toString());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				duration = (Long) durationResponse.get("duration");
				durationTime = (duration1 - duration) / 1000;
			}

			if (count > 0 && (durationJSON.get(duration_keyword) == null || Math.abs(durationTime) == 5
					|| Math.abs(durationTime) > 5)) {
				// System.out.println("durationTime = ch" + dev_ch + "_" + event_time);
				JSONObject json = new JSONObject();
				((JSONObject) jsonObject.get("req_info")).remove("img_data");
				durationResponse = jsonObject.toJSONString().replaceAll("\\\\", "");
				duration = date.getTime();
				json.put("durationResponse", durationResponse);
				json.put("date", date);
				json.put("duration", duration);
				durationJSON.put(duration_keyword, json);
			}
			/*
			 * if (durationJSON.get(duration_keyword) != null && durationTime < 10) { } else
			 * { }
			 */
			// System.out.println("분석 서버에서 받은 시간 = " + new SimpleDateFormat("yyyy-MM-dd
			// HH:mm:ss.SSS").format(nano));

			nano = System.currentTimeMillis();
			// System.out.println("2차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				updateImageLog(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("updateImageLog 결과 받는 시간 = " + (nano - start)/1000.0 +
			// "초");
			try {
				insertResponseLog(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("insertResponseLog 결과 받는 시간 = " + (nano - start)/1000.0 +
			// "초");
			try {
				// saveImageData(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("saveImageData 결과 받는 시간 = " + (nano - start)/1000.0 +
			// "초");
			try {
				// dashThread(tmpResponse);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("7차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				// logThread(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("8차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				// monitoringThread(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("9차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				sendEventAction(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("10차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");

			ThreadPoolExecutor threadPoolExecutor = (ThreadPoolExecutor) executorService;

			// System.out.println("전체 쓰레드 갯수 = " + threadPoolExecutor.getPoolSize());

			// System.out.println("responseEvent 결과 = " + tmpResponse.toString());
			if (count > 0) {
				long now = System.currentTimeMillis();

				// System.out.println("responseEvent() = " + (now - start)/1000.0 + "초");
				// System.out.println("16채널 기준 responseEvent() = " + (((now - start)/1000.0) *
				// 16) + "초");
				System.out.println("16채널 기준 insert + response = " + (insertImageTime + (((now - start) / 1000.0) * 16))
						+ "초" + " / 검출 객체 수 = " + count + "개");
				if ((insertImageTime + (((now - start) / 1000.0) * 16)) > 1) {
					System.out.println("insertImage() = " + insertImageTime);
					System.out.println("responseEvent() = " + (((now - start) / 1000.0) * 16));
				}
			} else {
				// System.out.println("검출된 객체 없음");
			}
		}
		long end = System.currentTimeMillis();
		// System.out.println("responseEvent() = " + (end - start)/1000.0 + "초");
	}

	@PostMapping("/responseEvents")
	@ResponseBody
//	public Map responseEvents(@RequestBody ResponseEventDto responseEventDto) throws JsonProcessingException, java.text.ParseException {
	public Map responseEvents(@RequestBody Map map) throws JsonProcessingException, java.text.ParseException {
//		System.out.println("responseEvents()");
		
//		MetadataDto metadata = responseEventDto.getMetadata();
		Map metadata = (Map) map.get("metadata");
		
		OneSecDurDto oneSecDurDto = new OneSecDurDto();
//		oneSecDurDto.setDev_ch(Integer.parseInt(metadata.getDev_ch()));
//		oneSecDurDto.setEvent_time(metadata.getEvent_time());
		oneSecDurDto.setDev_ch(Integer.parseInt(metadata.get("dev_ch").toString()));
		oneSecDurDto.setEvent_time(metadata.get("event_time").toString());

		Map returnMap = new LinkedHashMap();

		ArrayList<Map> ml_result = (ArrayList) map.get("ml_result");

		for (Map ml_result_map : ml_result) {
			String model_name = ml_result_map.get("model_name").toString();
//			System.out.println("===== responseEvents 검사 시작 =====");
//			System.out.println("model_name = " + model_name);
//			System.out.println("resultMap.get(model_name) = " + resultMap.get(model_name));
//			System.out.println("===== responseEvents 검사 종료 =====");
			if (resultMap.get(model_name) == null) {
				returnMap.put("status", "failed");
				returnMap.put("detail", "not support");
				returnMap.put("model_name", model_name);
			
				return returnMap;
			}
		}
		
		if (oneSecDurService.join(oneSecDurDto)) {
			try {
//				responseQ.put(responseEventDto);
				responseQ.put(map);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			returnMap.put("queue", responseQ.size());
			returnMap.put("status", "ok");

			return returnMap;
		} 

		returnMap.put("status", "failed");
		returnMap.put("detail", "please one second over");
	
		return returnMap;
	}

	@Transactional
	public void startResponseQ() {
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
						
						// insertResponseLogJson(map); // 추후 수정

						// insertResponseLog(map); // 추후 수정

						/**
						 * 1. 반복문 1바퀴 돌 때마다 로직 여러 개를 넣음
						 * 2. 그 반복문 작업을 controller에서 할 지 service에서 할 지 고민 중
						 *   if i) controller에서 하면 controller가 지저분해짐(특이 사항이 없으면 이 방법을 택할 예정)
						 *   if ii) service에서 하면 service에서 service를 호출하는 일이 벌어짐 
						 * 3. 이미지 서비스는 원본 이미지와 썸네일 이미지 만드는 로직이 각각 존재하며 매개변수는 dto를 만들 예정
						 * 4. 검색 결과(monitoring) 서비스도 이미지 저장(썸네일과 원본이미지 중복?)과 이미지 데이터 저장이 별도로 존재하며 매개변수는 dto로 만들어야 함?
						 * 5. 스카다로 웹소켓을 보내는 로직은 반복문으로 이벤트를 리스트에 넣은 후 로직 실행
						 * 6. 쓰레드까지 계획에 넣어놔야 하므로 컨트롤러에서는 이미지 + 데이터를 하나의 로직으로 실행할 수 있다는 것도 고려해야 함
						 * 7. 그 외 이벤트 액션도 개편 예정인데 쓰레드에 통합으로 넣을 지 각각 넣을 지는 좀 더 고민해봐야 함 
						 */
						
						boolean isDuration = saveImage(metadata, ml_result, base64);
						if (isDuration) {
							saveImageData(metadata, ml_result);

							monitoringThread(metadata, ml_result);

							sendScada(map);

							dashThread(metadata, ml_result);

							logThread(metadata, ml_result);

							// sendEventAction(metadata, ml_result); // 추후 수정

							checkShowPopUp(metadata, ml_result);

							sendWebsocket(map);
						}
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		};
		// 스레드풀에게 작업 처리 요청
		executorService.submit(runnable);
	}

	@RequestMapping(value = "/responseEvent", method = RequestMethod.POST)
	@ResponseBody
	public void responseEvent(@RequestBody String tmpResponse)
			throws IOException, ParseException, ImageProcessingException, java.text.ParseException {
		// System.out.println("responseEvent()");

		// System.out.println("tmpResponse = " + tmpResponse);

		long start = System.currentTimeMillis();

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = new JSONObject();

		try {
			jsonObject = (JSONObject) jsonParser.parse(tmpResponse);
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		long nano = System.currentTimeMillis();
		// System.out.println("1차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
		JSONObject req_info = (JSONObject) jsonObject.get("req_info");

		if (jsonObject.get("req_info") != null) {
			nano = System.currentTimeMillis();
			// System.out.println("4차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				// saveImage(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("saveImage 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				insertResponseLogJson(tmpResponse);
			} catch (Exception e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("insertResponseLogJson 결과 받는 시간 = " + (nano -
			// start)/1000.0 + "초");

			String event_time = req_info.get("event_time").toString();

			Date date = new Date();
			try {
				date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(event_time);
			} catch (Exception e2) {
				// TODO Auto-generated catch block
				e2.printStackTrace();
			}
			long duration1 = date.getTime();
			long duration;
			// System.out.println("json 변수 만드는 시간 = " + (now - start)/1000.0 + "초");

			long durationTime = 0; // 1000 = 초, 60000 = 분, 3600000 = 시간

			String item_name = req_info.get("item_name").toString();
			String dev_ip = req_info.get("dev_ip").toString();
			String dev_id = req_info.get("dev_id").toString();
			String dev_port = req_info.get("dev_port").toString();
			String dev_ch = req_info.get("dev_ch").toString();

			String duration_keyword = item_name + "_" + dev_ip + "_" + dev_id + "_" + dev_port + "_" + dev_ch;

			ArrayList<String> originalTags = (JSONArray) jsonObject.get("tags");

			int count = originalTags.size();

			String event_result = "";

			if (count > 0) {
				event_result = "detect";
			} else {
				event_result = "none";
			}

			JSONObject insertImageJson = new JSONObject();
			insertImageJson.put("event_time", event_time);
			insertImageJson.put("event_result", event_result);
			insertImageJson.put("ch", dev_ch);

			insertImageReturn.put(duration_keyword, insertImageJson);

			// System.out.println("태그 존재 여부 = " + count);

			if (durationJSON.get(duration_keyword) != null) {
				JSONParser jsonParser2 = new JSONParser();
				JSONObject durationResponse = (JSONObject) durationJSON.get(duration_keyword);
				try {
					jsonObject = (JSONObject) jsonParser2.parse(durationResponse.get("durationResponse").toString());
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				duration = (Long) durationResponse.get("duration");
				durationTime = (duration1 - duration) / 1000;
			}

			if (count > 0 && (durationJSON.get(duration_keyword) == null || Math.abs(durationTime) == 5
					|| Math.abs(durationTime) > 5)) {
				// System.out.println("durationTime = ch" + dev_ch + "_" + event_time);
				JSONObject json = new JSONObject();
				((JSONObject) jsonObject.get("req_info")).remove("img_data");
				durationResponse = jsonObject.toJSONString().replaceAll("\\\\", "");
				duration = date.getTime();
				json.put("durationResponse", durationResponse);
				json.put("date", date);
				json.put("duration", duration);
				durationJSON.put(duration_keyword, json);
			}
			/*
			 * if (durationJSON.get(duration_keyword) != null && durationTime < 10) { } else
			 * { }
			 */
			// System.out.println("분석 서버에서 받은 시간 = " + new SimpleDateFormat("yyyy-MM-dd
			// HH:mm:ss.SSS").format(nano));

			nano = System.currentTimeMillis();
			// System.out.println("2차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				updateImageLog(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("updateImageLog 결과 받는 시간 = " + (nano - start)/1000.0 +
			// "초");
			try {
				insertResponseLog(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("insertResponseLog 결과 받는 시간 = " + (nano - start)/1000.0 +
			// "초");
			try {
				// saveImageData(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("saveImageData 결과 받는 시간 = " + (nano - start)/1000.0 +
			// "초");
			try {
				// dashThread(tmpResponse);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("7차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				// logThread(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("8차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				// monitoringThread(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("9차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
			try {
				sendEventAction(tmpResponse);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			nano = System.currentTimeMillis();
			// System.out.println("10차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");

			ThreadPoolExecutor threadPoolExecutor = (ThreadPoolExecutor) executorService;

			// System.out.println("전체 쓰레드 갯수 = " + threadPoolExecutor.getPoolSize());

			// System.out.println("responseEvent 결과 = " + tmpResponse.toString());
			if (count > 0) {
				long now = System.currentTimeMillis();

				// System.out.println("responseEvent() = " + (now - start)/1000.0 + "초");
				// System.out.println("16채널 기준 responseEvent() = " + (((now - start)/1000.0) *
				// 16) + "초");
				System.out.println("16채널 기준 insert + response = " + (insertImageTime + (((now - start) / 1000.0) * 16))
						+ "초" + " / 검출 객체 수 = " + count + "개");
				if ((insertImageTime + (((now - start) / 1000.0) * 16)) > 1) {
					System.out.println("insertImage() = " + insertImageTime);
					System.out.println("responseEvent() = " + (((now - start) / 1000.0) * 16));
				}
			} else {
				// System.out.println("검출된 객체 없음");
			}
		}
		long end = System.currentTimeMillis();
		// System.out.println("responseEvent() = " + (end - start)/1000.0 + "초");
	}

	@RequestMapping(value = "/requestImage", method = RequestMethod.POST)
	@ResponseBody
	public String requestImage(@RequestBody String tmpResponse) {
		System.out.println("requestImage()");

		JSONObject jsonObject = new JSONObject();
		jsonObject.put("status", "success");

		return jsonObject.toJSONString().replaceAll("\\\\", "");
	}

	public boolean saveImage(Map metadata, ArrayList ml_result, String base64)
			throws ParseException, java.text.ParseException {
		// System.out.println("saveImage()");
		boolean isDuration = false;
		if (ml_result.size() > 0) {

			String class_name = "";
			String monitoring_info = "";

			/**
			 * duration 적용 해당 이미지의 검출 결과가 존재할 때 검출된 모델 중 단 하나라도 듀레이션(default 10초)이 오버되면 작업
			 * 시작 1.반복문 돌아서 검출 결과 확인 2.검출 결과 확인하면서 있으면 듀레이션 확인 3.돌다가 중간에 하나라도 듀레이션 오버되면
			 * true(아니면 false 그대로) 문제점 : 반복문 돌다가 중간 또는 마지막에서 듀레이션 오버된 게 검출되면 다시 처음부터 반복문 돌면서
			 * 듀레이션 초기화 할 것인가 생각해봐야할 점 : 모델 갯수만큼 반복문 도는 게 과연 메모리에 조금이라도 무리가 갈 것인가(최대 10개미만)
			 * 결론 : 무리 안 갈 것 같으므로 그냥 반복문 돌림
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

					
//					System.out.println("=====EventController isDuration 체크 시작=====");
					
//					System.out.println("model_name = " + model_name);

					boolean isTrue = scheduleRepository.chkDate(Integer.parseInt(dev_ch), model_name.split("_")[1].toLowerCase(), day);
					boolean isTrue1 = actionSetupService.checkOn(Integer.parseInt(dev_ch), model_name);
					boolean isTrue2 = actionSetupService.selectOne(Integer.parseInt(dev_ch)) != null;
					boolean isTrue3 = actionSetupService.selectOne(Integer.parseInt(dev_ch)).get("confidence") == null;
					boolean isTrue4 = Integer.parseInt(actionSetupService.selectOne(Integer.parseInt(dev_ch))
							.get("confidence").toString()) == 1;
					boolean isTrue5 = Integer.parseInt(actionSetupService.selectOne(Integer.parseInt(dev_ch))
							.get("confidence").toString()) <= Double.parseDouble(
									((Map) ((List) ml_result_map.get(resultMap.get(model_name))).get(0))
											.get("confidence").toString());
					boolean isTrue6 = chkDuration(dev_ip, dev_ch, model_name, event_time);

//					System.out.println("isTrue = " + isTrue);
//					System.out.println("isTrue1 = " + isTrue1);
//					System.out.println("isTrue2 = " + isTrue2);
//					System.out.println("isTrueMiddle = " + (isTrue3 || isTrue4 || isTrue5));
//					System.out.println("isTrue6 = " + isTrue6);
					
//					System.out.println("=====EventController isDuration 체크 종료=====");
					
					if (isTrue && isTrue1 && isTrue2 && (isTrue3 || isTrue4 || isTrue5) && isTrue6) {
						isDuration = true;
						durationMap.put(dev_ip + "_" + dev_ch + "_" + model_name, event_time);
					}
//					List class_list = (List) ml_result_map.get(resultMap.get(ml_result_map.get("model_name")));
//					for (int j = 0; j < class_list.size(); j++) {
//						Map class_map = (Map) class_list.get(j);
//						class_name += class_map.get("class").toString() + 1; 
//						monitoring_info += "/" + class_map.get("class").toString() + ":" + 1;
//					} 
				}
			}

			System.out.println("isDuration = " + isDuration);
			
			if (isDuration) {
				String img_name = metadata.get("img_name").toString(); // 원본 이미지 파일명으로 받음
				String login_id = metadata.get("user_name").toString(); // 사용자 ID
				String item_name = metadata.get("item_name").toString();
				String img_data = base64;
				String monitoring_tag = item_name + "_ch" + dev_ch + "_" + event_time.split(" ")[0].replaceAll("-", "")
						+ "_" + class_name;

				String img_size = "";

				// 폴더 경로 잡아줌 - 장비 및 채널 정보 가져와서 추가로 만들어줌
				String uploadPath = master_drive_name + ":/web_server/";
				File folder = new File(uploadPath);

				if (!folder.exists()) {
					try {
						folder.mkdir();
					} catch (Exception e) {
						e.getStackTrace();
					}
				}

				uploadPath += login_id + "/";
				folder = new File(uploadPath);

				if (!folder.exists()) {
					try {
						folder.mkdir();
					} catch (Exception e) {
						e.getStackTrace();
					}
				}

				uploadPath += item_name + "/";
				folder = new File(uploadPath);

				if (!folder.exists()) {
					try {
						folder.mkdir();
					} catch (Exception e) {
						e.getStackTrace();
					}
				}

				uploadPath += event_time.split(" ")[0].split("-")[0] + event_time.split(" ")[0].split("-")[1]
						+ event_time.split(" ")[0].split("-")[2] + "/";
				folder = new File(uploadPath);

				if (!folder.exists()) {
					try {
						folder.mkdir();
					} catch (Exception e) {
						e.getStackTrace();
					}
				}

				String data = img_data;

				byte[] imageBytes = DatatypeConverter.parseBase64Binary(data);

				try {
					File lOutFile = new File(uploadPath + img_name);

					FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);

					lFileOutputStream.write(imageBytes);

					lFileOutputStream.close();

				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("원본 이미지 저장 안됨");
				}

				File f = new File(uploadPath + img_name);
				String thumb_name = (uploadPath + img_name).substring(0, (uploadPath + img_name).lastIndexOf("."))
						+ "_thumb.jpg";
				try {
					EasyImage easyImage = new EasyImage(f);
					BufferedImage bi = ImageIO.read(f);

					if (!easyImage.isSupportedImageFormat()) {
						System.out.println("not supported image type");
					}

					int hWidth = bi.getWidth();
					int hHeight = bi.getHeight();

					img_size = hWidth + "-" + hHeight;

					if (hWidth < 640 || hHeight < 480) {
						File lOutFile = new File(thumb_name);

						FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);

						lFileOutputStream.write(imageBytes);

						lFileOutputStream.close();

					} else {
						// resize
						EasyImage resizedImage = easyImage.resize(640, 480);

						FileOutputStream out = new FileOutputStream(thumb_name);

						resizedImage.writeTo(out, "jpg");

						out.close();
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.out.println("썸네일 이미지 저장 안됨");
				}

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

	public void saveImageData(Map metadata, ArrayList ml_result) throws ParseException, IOException {
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

				String login_id = metadata.get("user_name").toString(); // 사용자 ID
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

				String img_name = metadata.get("img_name").toString(); // 원본 이미지 파일명으로 받음
				String monitoring_tag = item_name + "_ch" + dev_ch + "_" + event_time.split(" ")[0].replaceAll("-", "")
						+ "_" + class_name;

				String uploadPath = master_drive_name + ":/web_server/" + login_id + "/" + item_name + "/"
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

	JFrame jFrame;

	public void showPopupImage(String img_size, ActionLogDto actionLogDto) {
		// System.out.println("showPopupImage()");

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/showPopupImage", img_size);

		long nano = System.currentTimeMillis();
		// System.out.println("팝업 이미지 던진 시간 = " + new SimpleDateFormat("yyyy-MM-dd
		// HH:mm:ss.SSS").format(nano));
	}

	public void playAlarm(String img_size, ActionLogDto actionLogDto) {
		// System.out.println("playAlarm()");
		long nano = System.currentTimeMillis();

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/playAlarm", img_size);

		// System.out.println("알람 던진 시간 = " + new SimpleDateFormat("yyyy-MM-dd
		// HH:mm:ss.SSS").format(nano));
	}

	public void sendEventAction(String tmpResponse) throws ParseException, IOException {
		// System.out.println("sendEventAction()");

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(tmpResponse);

		final ArrayList<String> originalTags = (JSONArray) jsonObject.get("tags");
		JSONObject req_info = (JSONObject) jsonObject.get("req_info");
		final String dev_ch = req_info.get("dev_ch").toString();
		final String dev_ip = req_info.get("dev_ip").toString();
		final String dev_id = req_info.get("dev_id").toString();
		final String dev_port = req_info.get("dev_port").toString();
		final String event_time = req_info.get("event_time").toString();
		final String dev_web_port = req_info.get("dev_web_port").toString();
		final String login_id = jsonObject.get("user_name").toString(); // 사용자 ID
		final String item_name = req_info.get("item_name").toString();
		final JSONObject img_size = (JSONObject) jsonObject.get("img_size");

		String img_name = jsonObject.get("img_name").toString(); // 원본 이미지 파일명으로 받음

		final String uploadPath = "/web_server/" + login_id + "/" + item_name + "/"
				+ event_time.split(" ")[0].split("-")[0] + event_time.split(" ")[0].split("-")[1]
				+ event_time.split(" ")[0].split("-")[2] + "/" + img_name;

		img_size.put("img_name", uploadPath);
		img_size.put("dev_ip", dev_ip);
		img_size.put("login_id", login_id);

		final ActionLogDto actionLogDto = new ActionLogDto();
		actionLogDto.setAction_ip(dev_ip);
		actionLogDto.setAction_channel(dev_ch);
		// actionLogDto.set

		// img_name = (uploadPath + "/" + img_name).substring((uploadPath + "/" +
		// img_name).indexOf("/"));
		// uploadPath = "D:" + img_name;

		if (originalTags.size() > 0) {
			// 스레드에게 시킬 작업 내용
			for (int j = 0; j < originalTags.size(); j++) {
				String event_name = originalTags.get(j);
				img_size.put("event_name", event_name);
				actionLogDto.setAction_event(event_name);
				actionLogDto.setAction_src(uploadPath);
				for (int i = 0; i < actionListTotal.size(); i++) {
					Map action = actionListTotal.get(i);
					if (action.get("action_isuse").equals("Y") && action.get("action_event").equals(event_name)
							&& action.get("action_ip").equals(dev_ip) && action.get("action_channel").equals(dev_ch)
							&& !action.get("action_target").equals("admin")) {
						actionLogDto.setAction_target(action.get("action_target").toString());
						if (action.get("action_action").toString().indexOf("라인 메세지 보내기") > -1) { // 라인일 경우
							// System.out.println("라인 출발");
							if (tokkenTime.get(event_name + "_" + dev_ip + "_" + dev_ch) != null) {
								long end = Long
										.parseLong(tokkenTime.get(event_name + "_" + dev_ip + "_" + dev_ch).toString());
								long now = System.currentTimeMillis();

								if ((now - end) / 1000.0 > 300) {
									String tokkenAddress = eventDao
											.selectUser_Tokken(action.get("action_target").toString());
									String message = "[ReCon-Now] 이벤트발생(" + event_name + ") "
											+ event_time.split(" ")[0].split("-")[0] + "년 "
											+ Integer.parseInt(event_time.split(" ")[0].split("-")[1]) + "월 "
											+ Integer.parseInt(event_time.split(" ")[0].split("-")[2]) + "일 "
											+ event_time.split(" ")[1].split(":")[0] + "시 "
											+ event_time.split(" ")[1].split(":")[1] + "분 "
											+ event_time.split(" ")[1].split(":")[2] + "초 " + " 장비 : " + dev_ip + "(채널"
											+ dev_ch + ")";
									String encoded;
									try {
										encoded = URLEncoder.encode(message, "UTF-8");
										// System.out.println(message);
										tokenTest("https://notify-api.line.me/api/notify?message=" + encoded,
												"Bearer " + tokkenAddress);
									} catch (Exception e) {
										// TODO Auto-generated catch block
										e.printStackTrace();
									}

									tokkenTime.put(event_name + "_" + dev_ip + "_" + dev_ch, now + "");
								}
							} else {
								String tokkenAddress = eventDao
										.selectUser_Tokken(action.get("action_target").toString());
								String message = "[ReCon-Now] 이벤트발생(" + event_name + ") "
										+ event_time.split(" ")[0].split("-")[0] + "년 "
										+ Integer.parseInt(event_time.split(" ")[0].split("-")[1]) + "월 "
										+ Integer.parseInt(event_time.split(" ")[0].split("-")[2]) + "일 "
										+ event_time.split(" ")[1].split(":")[0] + "시 "
										+ event_time.split(" ")[1].split(":")[1] + "분 "
										+ event_time.split(" ")[1].split(":")[2] + "초 " + " 장비 : " + dev_ip + "(채널"
										+ dev_ch + ")";
								String encoded;
								try {
									encoded = URLEncoder.encode(message, "UTF-8");
									// System.out.println(message);
									tokenTest("https://notify-api.line.me/api/notify?message=" + encoded,
											"Bearer " + tokkenAddress);
								} catch (Exception e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
								}

								tokkenTime.put(event_name + "_" + dev_ip + "_" + dev_ch,
										System.currentTimeMillis() + "");
							}

							action.put("action_src", uploadPath);
							// action.setAction_action("라인");
							actionLogDto.setAction_action("라인");
							// eventDao.insertActionLogInfo(actionLogDto);

							long start = System.currentTimeMillis();
//							ResponseEvent responseEvent = new ResponseEvent();
							// responseEvent.insertActionLogInfo(actionLogDto, conn);
							long nano = System.currentTimeMillis();
							// System.out.println("라인 = " + (nano - start)/1000.0 + "초");
						}

						if (action.get("action_action").toString().indexOf("팝업") > -1) { // 팝업일 경우
							String duration_keyword = item_name + "_" + dev_ip + "_" + dev_id + "_" + dev_port + "_"
									+ dev_ch;

							if (insertImageReturn.get(duration_keyword) != null) {
								JSONObject insertImageReturnResponse = (JSONObject) insertImageReturn
										.get(duration_keyword);
								insertImageReturnResponse.put("event_action", "popup");
								insertImageReturn.put(duration_keyword, insertImageReturnResponse);
							}

							String event_result = "none";
							String ch = dev_ch;

							action.put("action_src", uploadPath);
							actionLogDto.setAction_action("팝업");
							action.put("action_action", "팝업");
							// System.out.println("알람 팝업 ip = " + actionLogDto.getAction_ip());
							// System.out.println("알람 팝업 ch = " + actionLogDto.getAction_channel());
							showPopupImage(img_size.toJSONString().replaceAll("\\\\", ""), actionLogDto);

							// eventDao.insertActionLogInfo(actionLogDto);

							long start = System.currentTimeMillis();
//							ResponseEvent responseEvent = new ResponseEvent();
							// responseEvent.insertActionLogInfo(actionLogDto, conn);
							long nano = System.currentTimeMillis();
							// System.out.println("팝업 = " + (nano - start)/1000.0 + "초");
						}

						if (action.get("action_action").toString().indexOf("알람") > -1) { // 알람일 경우
							action.put("action_src", uploadPath);
							actionLogDto.setAction_action("알람");
							action.put("action_action", "알람");
							playAlarm(img_size.toJSONString().replaceAll("\\\\", ""), actionLogDto);
							// eventDao.insertActionLogInfo(actionLogDto);
							long start = System.currentTimeMillis();
//							ResponseEvent responseEvent = new ResponseEvent();
							// responseEvent.insertActionLogInfo(actionLogDto, conn);
							long nano = System.currentTimeMillis();
							// System.out.println("알람 = " + (nano - start)/1000.0 + "초");
						}

						if (actionLogDto.getAction_event().equals("person")
								&& action.get("action_action").toString().indexOf("침입") > -1) { // 카메라일 경우
							action.put("action_src", uploadPath);
							actionLogDto.setAction_action("침입");
							// System.out.println("http://" + dev_ip + ":" + dev_web_port +
							// "/cgi-bin/net_io_Box.cgi?method=GetBoxStatus&BoxInput=fffffe&BoxRelay=0");
							// sendGet("http://" + dev_ip + ":" + dev_web_port +
							// "/cgi-bin/net_io_Box.cgi?method=GetBoxStatus&BoxInput=fffffe&BoxRelay=0",
							// actionLogDto);
							// eventDao.insertActionLogInfo(actionLogDto);
							long start = System.currentTimeMillis();
//							ResponseEvent responseEvent = new ResponseEvent();
							// responseEvent.insertActionLogInfo(actionLogDto, conn);
							long nano = System.currentTimeMillis();
							// System.out.println("침입 = " + (nano - start)/1000.0 + "초");
						}
					}
				}
			}
			/*
			 * Runnable runnable = new Runnable() {
			 * 
			 * @Override public void run() { } }; //스레드풀에게 작업 처리 요청
			 * executorService.submit(runnable);
			 */
		}
	}

	public void insertDash(EventDto eventDto) {
		// System.out.println("insertDash()");

		eventDao.updateCount(eventDto);

		// System.out.println("updateCount = " + (nano - start2)/1000.0 + "초");

		String jsonStr = "";
		ObjectMapper mapper = new ObjectMapper();

		try {
			jsonStr = mapper.writeValueAsString(eventDto);
		} catch (Exception e1) {
			System.out.println("오류 발생");
			e1.printStackTrace();
		}

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/receiveCount", jsonStr);

	}

	public void dashThread(Map metadata, ArrayList ml_result) throws ParseException {
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

				// 스레드에게 시킬 작업 내용
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

	public void insertImageLogJson(Map map) throws ParseException {
		// System.out.println("insertImageLogJson()");

		if (map.get("img_data") == null) {
			System.out.println("insertImageLogJson : 이미지 데이터 없음");
		} else {
			String img_type = map.get("img_type").toString();
			String dev_ch = map.get("dev_ch").toString();
			String user_name = map.get("user_name").toString();
			String item_name = map.get("item_name").toString();
			String dev_id = map.get("dev_id").toString();
			String img_name = map.get("img_name").toString();
			String user_passwd = map.get("user_passwd").toString();
			String event_request = map.get("event_request").toString();
			String dev_pw = map.get("dev_pw").toString();
			String dev_ip = map.get("dev_ip").toString();
			String dev_port = map.get("dev_port").toString();
			String event_time = map.get("event_time").toString();
			String dev_web_port = map.get("dev_web_port").toString();

			ImageLogJsonDto imageLogJsonDto = new ImageLogJsonDto();
			imageLogJsonDto.setImg_type(img_type);
			imageLogJsonDto.setDev_ch(dev_ch);
			imageLogJsonDto.setUser_name(user_name);
			imageLogJsonDto.setItem_name(item_name);
			imageLogJsonDto.setDev_id(dev_id);
			imageLogJsonDto.setImg_name(img_name);
			imageLogJsonDto.setUser_passwd(user_passwd);
			imageLogJsonDto.setEvent_request(event_request);
			imageLogJsonDto.setDev_pw(dev_pw);
			imageLogJsonDto.setDev_ip(dev_ip);
			imageLogJsonDto.setDev_port(dev_port);
			imageLogJsonDto.setEvent_time(event_time);
			imageLogJsonDto.setDev_web_port(dev_web_port);

//			eventDao.insertImageLogInfoJson(imageLogJsonDto);

//			InsertImage insertImage = new InsertImage();
//			insertImage.insertImageLogInfoJson(imageLogJsonDto, conn);
		}
	}

	public void insertImageLog(Map map) throws ParseException {
		// System.out.println("insertImageLog()");

		if (map.get("img_data") == null) {
			System.out.println("insertImageLog : 이미지 데이터 없음");
		} else {
			String item_name = map.get("item_name").toString();
			String dev_ip = map.get("dev_ip").toString();
			String dev_id = map.get("dev_id").toString();
			String dev_pw = map.get("dev_pw").toString();
			String dev_port = map.get("dev_port").toString();
			String dev_web_port = map.get("dev_web_port").toString();
			String dev_ch = map.get("dev_ch").toString();
			String event_time = map.get("event_time").toString();
			String img_type = map.get("img_type").toString();
			String user_name = map.get("user_name").toString();
			String event_date1 = event_time.split(" ")[0];
			String event_date2 = event_time.split(" ")[1];
			String img_data = "/web_server/" + user_name + "/" + item_name + "/" + event_date1.split("-")[0]
					+ event_date1.split("-")[1] + event_date1.split("-")[2] + "/" + event_date2.split(":")[0]
					+ "/image/ch" + dev_ch + "_" + event_date2.split(":")[0] + event_date2.split(":")[1]
					+ event_date2.split(":")[2] + "_thumb.jpg";

			ImageLogDto imageLogDto = new ImageLogDto();

			imageLogDto.setItem_name(item_name);
			imageLogDto.setDev_ip(dev_ip);
			imageLogDto.setDev_id(dev_id);
			imageLogDto.setDev_pw(dev_pw);
			imageLogDto.setDev_port(Integer.parseInt(dev_port));
			imageLogDto.setDev_web_port(Integer.parseInt(dev_web_port));
			imageLogDto.setDev_ch(Integer.parseInt(dev_ch));
			imageLogDto.setEvent_time(event_time);
			imageLogDto.setImg_data(img_data);
			imageLogDto.setImg_type(img_type);
			imageLogDto.setUser_name(user_name);
			imageLogDto.setIsAnalyze("분석중");
			imageLogDto.setTags("");
			imageLogDto.setColor_tags("");

//			long start = System.currentTimeMillis();
//			InsertImage insertImage = new InsertImage();
//			long nano = System.currentTimeMillis();
		}
	}

	public void updateImageLog(String tmpResponse) throws ParseException {
		// System.out.println("updateResponseLog()");
		long start = System.currentTimeMillis();

		// System.out.println("1차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");
		JSONParser jsonParser = new JSONParser();
		final JSONObject jsonObject = (JSONObject) jsonParser.parse(tmpResponse);

		JSONObject req_info = (JSONObject) jsonObject.get("req_info");
		JSONObject img_size = (JSONObject) jsonObject.get("img_size");
		ArrayList<String> originalTags = (JSONArray) jsonObject.get("tags");
		ArrayList<String> colorTags = (JSONArray) jsonObject.get("color_tags");
		JSONObject processing_info = (JSONObject) jsonObject.get("processing_info");

		long nano = System.currentTimeMillis();
		// System.out.println("2차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");

		String tags = "";
		String color_tags = "";

		String img_name = jsonObject.get("img_name").toString();
		int dev_ch = Integer.parseInt(req_info.get("dev_ch").toString());
		String dev_pw = req_info.get("dev_pwd").toString();
		String item_name = req_info.get("item_name").toString();
		String dev_ip = req_info.get("dev_ip").toString();
		int dev_port = Integer.parseInt(req_info.get("dev_port").toString());
		String event_time = req_info.get("event_time").toString();
		String dev_id = req_info.get("dev_id").toString();
		int dev_web_port = Integer.parseInt(req_info.get("dev_web_port").toString());
		String user_name = jsonObject.get("user_name").toString();
		String user_passwd = jsonObject.get("user_passwd").toString();
		int width = Integer.parseInt(img_size.get("width").toString());
		int height = Integer.parseInt(img_size.get("height").toString());

		int image_queue = 0;
		if (processing_info.get("image_queue") != null) {
			image_queue = Integer.parseInt(processing_info.get("image_queue").toString());
		}
		String img_type = "jpg";
		String event_date1 = event_time.split(" ")[0];
		String event_date2 = event_time.split(" ")[1];
		String img_data = "/web_server/" + user_name + "/" + item_name + "/" + event_date1.split("-")[0]
				+ event_date1.split("-")[1] + event_date1.split("-")[2] + "/" + event_date2.split(":")[0] + "/image/ch"
				+ dev_ch + "_" + event_date2.split(":")[0] + event_date2.split(":")[1] + event_date2.split(":")[2]
				+ "_thumb.jpg";

		nano = System.currentTimeMillis();
		// System.out.println("3차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");

		if (originalTags.size() > 0) {
			for (int i = 0; i < originalTags.size(); i++) {
				/*
				 * if (originalTags.get(i).equals("person")) { Date date1 = null; try { date1 =
				 * f.parse(event_time); } catch (java.text.ParseException e) { // TODO
				 * Auto-generated catch block e.printStackTrace(); } long duration1 =
				 * date1.getTime(); long durationTime = (duration1 - duration) / 1000; // 1000 =
				 * 초, 60000 = 분, 3600000 = 시간 if (durationTime < 30) { } else { duration =
				 * duration1; date = date1; JSONObject req_info =
				 * (JSONObject)json.get("req_info");
				 * ((JSONObject)json.get("req_info")).remove("img_data"); durationResponse =
				 * json.toJSONString().replaceAll("\\\\", ""); } }
				 */
				if (i == 0) {
					tags += originalTags.get(i);
				} else {
					tags += "," + originalTags.get(i);
				}
			}
		} else {
			tags = "없음";
		}

		nano = System.currentTimeMillis();
		// System.out.println("4차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");

		// System.out.println("updateImageLog = " + tags + "_" + event_time);

		if (colorTags.size() > 0) {
			for (int i = 0; i < colorTags.size(); i++) {
				if (i == 0) {
					color_tags += colorTags.get(i);
				} else {
					color_tags += "," + colorTags.get(i);
				}
			}
		} else {
			color_tags = "없음";
		}

		nano = System.currentTimeMillis();
		// System.out.println("5차 보내고 결과 받는 시간 = " + (nano - start)/1000.0 + "초");

		ImageLogDto imageLogDto = new ImageLogDto();

		imageLogDto.setItem_name(item_name);
		imageLogDto.setDev_ip(dev_ip);
		imageLogDto.setDev_id(dev_id);
		imageLogDto.setDev_pw(dev_pw);
		imageLogDto.setDev_port(dev_port);
		imageLogDto.setDev_web_port(dev_web_port);
		imageLogDto.setDev_ch(dev_ch);
		imageLogDto.setEvent_time(event_time);
		imageLogDto.setImg_data(img_data);
		imageLogDto.setImg_type(img_type);
		imageLogDto.setUser_name(user_name);
		imageLogDto.setIsAnalyze("분석완료");
		imageLogDto.setTags(tags);
		imageLogDto.setColor_tags(color_tags);

		// eventDao.updateImageLogInfo(imageLogDto);
		// eventDao.insertImageLogInfo(imageLogDto);

		long end = System.currentTimeMillis();
//		ResponseEvent responseEvent = new ResponseEvent();
//		InsertImage insertImage = new InsertImage();
//		insertImage.insertImageLogInfo(imageLogDto, conn);
		// responseEvent.updateImageLogInfo(imageLogDto, conn);
		nano = System.currentTimeMillis();
		// System.out.println("updateImageLog = " + (nano - start)/1000.0 + "초");
		// System.out.println("updateImageLog2 = " + (nano - end)/1000.0 + "초");

		/*
		 * Runnable runnable = new Runnable() {
		 * 
		 * @Override public void run() { } }; executorService.submit(runnable);
		 */
	}

	public void insertResponseLogJson(String tmpResponse) throws ParseException {
		// System.out.println("insertResponseLogJson()");

		// System.out.println("tmpResponse = " + tmpResponse);
		JSONParser jsonParser = new JSONParser();
		final JSONObject json = (JSONObject) jsonParser.parse(tmpResponse);

		JSONObject req_info = (JSONObject) json.get("req_info");
		long nano = System.currentTimeMillis();
		// System.out.println("insertResponseLogJson 시간1 = " + (nano - start)/1000.0 +
		// "초");

		// System.out.println("req_info = " + req_info.toJSONString());

		if (req_info != null && req_info.get("img_data") != null) {
			// System.out.println("req_info는 null이 아님");
			// System.out.println("insertResponseLogJson 시간2 = " + (nano - start)/1000.0 +
			// "초");
			((JSONObject) json.get("req_info")).remove("img_data");
			// System.out.println("insertResponseLogJson 시간3 = " + (nano - start)/1000.0 +
			// "초");
			// eventDao.insertResponseLogInfoJson(json.toJSONString().replaceAll("\\\\",
			// ""));

			long start = System.currentTimeMillis();
//			ResponseEvent responseEvent = new ResponseEvent();
//			responseEvent.insertResponseLogInfoJson(json.toJSONString().replaceAll("\\\\", ""), conn);
			nano = System.currentTimeMillis();
			// System.out.println("insertResponseLogJson = " + (nano - start)/1000.0 + "초");
		} else {
			if (json.get("req_info") == null) {
				System.out.println("req_info가 없음");
			}

			if (json.get("req_info") != null && req_info.get("img_data") == null) {
				System.out.println("insertResponseLogJson : img_data가 없음");
			}

			System.out.println("insertResponseLogJson : 이미지 데이터 없음");
		}
		nano = System.currentTimeMillis();
		// System.out.println("insertResponseLogJson 시간4 = " + (nano - start)/1000.0 +
		// "초");
		/*
		 * Runnable runnable = new Runnable() {
		 * 
		 * @Override public void run() { } }; executorService.submit(runnable);
		 */
	}

	public void insertResponseLog(String tmpResponse) throws ParseException {
		// System.out.println("insertResponseLog()");

		JSONParser jsonParser = new JSONParser();
		final JSONObject jsonObject = (JSONObject) jsonParser.parse(tmpResponse);
		final JSONObject req_info = (JSONObject) jsonObject.get("req_info");
		final JSONObject img_size = (JSONObject) jsonObject.get("img_size");
		final ArrayList<String> originalTags = (JSONArray) jsonObject.get("tags");
		final ArrayList<String> colorTags = (JSONArray) jsonObject.get("color_tags");
		final JSONObject processing_info = (JSONObject) jsonObject.get("processing_info");

		String tags = "";
		String color_tags = "";

		String img_name = jsonObject.get("img_name").toString();
		int dev_ch = Integer.parseInt(req_info.get("dev_ch").toString());
		String dev_pw = req_info.get("dev_pwd").toString();
		String item_name = req_info.get("item_name").toString();
		String dev_ip = req_info.get("dev_ip").toString();
		int dev_port = Integer.parseInt(req_info.get("dev_port").toString());
		String event_time = req_info.get("event_time").toString();
		String dev_id = req_info.get("dev_id").toString();
		int dev_web_port = Integer.parseInt(req_info.get("dev_web_port").toString());
		String user_name = jsonObject.get("user_name").toString();
		String user_passwd = jsonObject.get("user_passwd").toString();
		int width = Integer.parseInt(img_size.get("width").toString());
		int height = Integer.parseInt(img_size.get("height").toString());
		int image_queue = 0;
		if (processing_info.get("image_queue") != null) {
			image_queue = Integer.parseInt(processing_info.get("image_queue").toString());
		}
		String event_date1 = event_time.split(" ")[0];
		String event_date2 = event_time.split(" ")[1];
		String img_data = "/web_server/" + user_name + "/" + item_name + "/" + event_date1.split("-")[0]
				+ event_date1.split("-")[1] + event_date1.split("-")[2] + "/" + event_date2.split(":")[0] + "/image/ch"
				+ dev_ch + "_" + event_date2.split(":")[0] + event_date2.split(":")[1] + event_date2.split(":")[2]
				+ "_thumb.jpg";
		if (originalTags.size() > 0) {
			for (int i = 0; i < originalTags.size(); i++) {
				if (i == 0) {
					tags += originalTags.get(i);
				} else {
					tags += "," + originalTags.get(i);
				}
			}
		} else {
			tags = "없음";
		}

		if (colorTags.size() > 0) {
			for (int i = 0; i < colorTags.size(); i++) {
				if (i == 0) {
					color_tags += colorTags.get(i);
				} else {
					color_tags += "," + colorTags.get(i);
				}
			}
		} else {
			color_tags = "없음";
		}
		String uploadPath = "/web_server/" + user_name + "/" + item_name + "/" + event_time.split(" ")[0].split("-")[0]
				+ event_time.split(" ")[0].split("-")[1] + event_time.split(" ")[0].split("-")[2] + "/";

		ResponseLogDto responseLogDto = new ResponseLogDto();
		responseLogDto.setImg_name(uploadPath + img_name);
		responseLogDto.setDev_ch(dev_ch);
		responseLogDto.setDev_pw(dev_pw);
		responseLogDto.setItem_name(item_name);
		responseLogDto.setDev_ip(dev_ip);
		responseLogDto.setDev_port(dev_port);
		responseLogDto.setEvent_time(event_time);
		responseLogDto.setDev_id(dev_id);
		responseLogDto.setDev_web_port(dev_web_port);
		responseLogDto.setImg_data(img_data);
		responseLogDto.setUser_name(user_name);
		responseLogDto.setUser_passwd(user_passwd);
		responseLogDto.setWidth(width);
		responseLogDto.setHeight(height);
		responseLogDto.setImage_queue(image_queue);
		responseLogDto.setTags(tags);
		responseLogDto.setColor_tags(color_tags);

		// eventDao.insertResponseLogInfo(responseLogDto);

		long start = System.currentTimeMillis();
//		ResponseEvent responseEvent = new ResponseEvent();
//		responseEvent.insertResponseLogInfo(responseLogDto, conn);
		long nano = System.currentTimeMillis();
		// System.out.println("insertResponseLogInfo = " + (nano - start)/1000.0 + "초");
		/*
		 * Runnable runnable = new Runnable() {
		 * 
		 * @Override public void run() { } }; executorService.submit(runnable);
		 */
	}

	public void insertLog(EventDto eventDto) {

		eventDao.insertJson(eventDto);

		String jsonStr = "";
		ObjectMapper mapper = new ObjectMapper();

		try {
			jsonStr = mapper.writeValueAsString(eventDto);
		} catch (Exception e1) {
			System.out.println("오류 발생");
			e1.printStackTrace();
		}

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/receiveMessage", jsonStr);

	}

	public void logThread(Map metadata, ArrayList ml_result) throws ParseException {
		if (ml_result.size() > 0) {
			boolean isResult = false;

			String class_name = "";
			List originalTags = new ArrayList();

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
					eventDto.setEvent_source("지능형안전관리시스템");

					eventDto.setEvent_info(event_info);

					eventDto.setEvent_name(event_name);

					insertLog(eventDto);
				}
			}
		}
	}

	public void sendMonitoring(MonitoringDto monitoringDto) {
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

	public void insertMonitoring(MonitoringDto monitoringDto) {
		Map map = new HashMap();
		map.put("dev_ch", monitoringDto.getMonitoring_ch());
		Map return_map = eventDao.deviceInfoOne2(map);

		if (return_map != null) {
//			eventDao.updateMonitoring(monitoringDto);
			return_map.put("monitor_src", monitoringDto.getMonitoring_src());
			return_map.put("monitor_size", monitoringDto.getMonitoring_size());

			eventDao.updateMonitor(return_map);
		}

	}

	public void monitoringThread(Map metadata, ArrayList ml_result) throws ParseException, IOException {
		// System.out.println("monitoringThread()");

		if (ml_result.size() > 0) {
			boolean isResult = false;

			String class_name = "";
			String monitoring_info = "";

			String img_name = metadata.get("img_name").toString(); // 원본 이미지 파일명으로 받음
			String login_id = metadata.get("user_name").toString(); // 사용자 ID
			String item_name = metadata.get("item_name").toString();
			String event_time = metadata.get("event_time").toString();
			String dev_ch = metadata.get("dev_ch").toString();
			String dev_ip = metadata.get("dev_ip").toString();
			JSONObject img_size = (JSONObject) metadata.get("img_size");

			String uploadPath = master_drive_name + ":/web_server/" + login_id + "/" + item_name + "/"
					+ event_time.split(" ")[0].split("-")[0] + event_time.split(" ")[0].split("-")[1]
					+ event_time.split(" ")[0].split("-")[2] + "/" + img_name;

			File f = new File(uploadPath);

			int hWidth = 0;
			int hHeight = 0;

			if (f.exists()) {
				BufferedImage bi = ImageIO.read(f);

				hWidth = bi.getWidth();
				hHeight = bi.getHeight();
			}

			uploadPath = uploadPath.replace("web_server", "webserver");
			
			Map devInfo = eventDao.deviceInfoOne2(metadata);
			
			if (devInfo != null) {
				for (int i = 0; i < ml_result.size(); i++) {
					Map ml_result_map = (Map) ml_result.get(i);

					if (ml_result_map.get("status").toString().equals("SUCCESS")
							&& Integer.parseInt(ml_result_map.get("count").toString()) > 0) {
						isResult = true;
						String model_name = ml_result_map.get("model_name").toString();
						class_name += model_name + 1;
						monitoring_info += "/" + model_name + ":" + 1;

						Map saveMap = new HashMap();
						saveMap.put("gallery_count", 1);
						saveMap.put("gallery_size", hWidth + "-" + hHeight);
						saveMap.put("dev_ch", Integer.parseInt(dev_ch));
						saveMap.put("thumb_name",
								uploadPath.substring(uploadPath.indexOf("/"), uploadPath.lastIndexOf(".")) + "_thumb.jpg");
						saveMap.put("event_name", model_name);
						saveMap.put("event_time", event_time);
						saveMap.put("dev_title", devInfo.get("dev_title").toString());

						eventDao.insertGallery(saveMap);

					}
				}
			}
		}
	}

	public void monitorThread(Map metadata, ArrayList ml_result) throws ParseException, IOException {
		// System.out.println("monitorThread()");

		if (ml_result.size() > 0) {
			for (int i = 0; i < ml_result.size(); i++) {
				Map ml_result_map = (Map) ml_result.get(i);
				if (ml_result_map.get("status").equals("SUCCESS")) {

					String img_name = metadata.get("img_name").toString(); // 원본 이미지 파일명으로 받음
					String login_id = metadata.get("user_name").toString(); // 사용자 ID
					String item_name = metadata.get("item_name").toString();
					String event_time = metadata.get("event_time").toString();
					String dev_ch = metadata.get("dev_ch").toString();
					String dev_ip = metadata.get("dev_ip").toString();
					JSONObject img_size = (JSONObject) metadata.get("img_size");

					String uploadPath = master_drive_name + ":/web_server/" + login_id + "/" + item_name + "/"
							+ event_time.split(" ")[0].split("-")[0] + event_time.split(" ")[0].split("-")[1]
							+ event_time.split(" ")[0].split("-")[2] + "/" + img_name;

					File f = new File(uploadPath);

					BufferedImage bi = ImageIO.read(f);

					int hWidth = bi.getWidth();
					int hHeight = bi.getHeight();

					Map map = new HashMap();

					MonitoringDto monitoringDto = new MonitoringDto();
					monitoringDto.setMonitoring_src(
							uploadPath.substring(uploadPath.indexOf("/"), uploadPath.lastIndexOf(".")) + "_thumb.jpg");
					monitoringDto.setMonitoring_time(event_time);
					monitoringDto.setMonitoring_item(item_name);
					monitoringDto.setMonitoring_ch(dev_ch);
					monitoringDto.setLogin_id(login_id);
					monitoringDto.setMonitoring_size(hWidth + "-" + hHeight);

					insertMonitoring(monitoringDto);

				}
			}
		}
	}

	public String downloadZipGroup(Map<String, Object> login, HttpServletResponse response, String zipName)
			throws IOException {
		System.out.println("downloadZipGroup()");
		// long heapSize = Runtime.getRuntime().totalMemory();

		// System.out.println("Heap Size(M) : " + heapSize / (1024 * 1024) + " MB");
		List<String> files = new ArrayList<String>();

		ZipOutputStream zout = null;

		// 파일 이름은 유저이름 + 날짜 + 시간(초단위)로 변경
		String tempPath = "";

		List<String> idxList = (List<String>) login.get("downloadTag");

		List<Map> imageList = new ArrayList<Map>();
		
		Map map = new HashMap();
		map.put("event_name", login.get("event_name"));
		for (String idx : idxList) {
			map.put("idx", Long.parseLong(idx));
			List<Map> imageInfo = galleryRepository.selectDownloadGroupImages(map);
			imageList.addAll(imageInfo);
		}

		double file_size = 0;
		int count = 0;
		
		for (Map i : imageList) {
			if (i.get("image_name").toString().indexOf("web_server") > 0) {
				files.add(part_drive_name + ":" + i.get("image_name").toString());
//				i.put("image_name", part_drive_name + ":" + i.get("image_name").toString());
			} else {
				files.add(master_drive_name + ":" + i.get("image_name").toString().replace("webserver", "web_server"));
//				i.put("image_name", master_drive_name + ":" + i.get("image_name").toString());
			}
			
			if (new File(i.get("image_name").toString()).exists()) {
				file_size += FileUtils.sizeOf(new File(i.get("image_name").toString()));
				count++;
			}
		}

		if (files.size() > 0) {
			if (drive_count > 1) {
				tempPath = part_drive_name + ":/web_server/";
				File[] roots = File.listRoots();
				double usableSpace = 0;
				for (File root : roots) {
					String drive = root.getAbsolutePath().substring(0, 1);
					if (drive.equals(part_drive_name)) {
						// 사용가능한 디스크 용량
						usableSpace = root.getUsableSpace();
						break;
					}
				}
				if (file_size > usableSpace) {
					return "";
				}
			} else {
				tempPath = master_drive_name + ":/web_server/";
				File[] roots = File.listRoots();
				double usableSpace = 0;
				for (File root : roots) {
					String drive = root.getAbsolutePath().substring(0, 1);
					if (drive.equals(master_drive_name)) {
						// 사용가능한 디스크 용량
						usableSpace = root.getUsableSpace();
						break;
					}
				}
				if (file_size > usableSpace) {
					return "";
				}
			}

			File folder = new File(tempPath);

			if (!folder.exists()) {
				try {
					// System.out.println("폴더 생성");
					folder.mkdir();
				} catch (Exception e) {
					e.getStackTrace();
				}
			} else {
				// System.out.println("폴더가 이미 존재합니다.");
			}

			tempPath += "/download/";

			folder = new File(tempPath);

			if (!folder.exists()) {
				try {
					// System.out.println("폴더 생성");
					folder.mkdir();
				} catch (Exception e) {
					e.getStackTrace();
				}
			} else {
				// System.out.println("폴더가 이미 존재합니다.");
			}

			zout = new ZipOutputStream(new FileOutputStream(tempPath + zipName));
			byte[] buffer = new byte[1024];
			FileInputStream in = null;

			for (int k = 0; k < files.size(); k++) {
				try {
					in = new FileInputStream(files.get(k));
				} catch (Exception e) {
					in = new FileInputStream(files.get(k));
				}
				// zout.putNextEntry(new
				// ZipEntry(files.get(k).substring(files.get(k).lastIndexOf("/") + 1)));
				zout.putNextEntry(new ZipEntry(files.get(k).split("/")[4] + "_" + files.get(k).split("/")[5]));
				// heapSize = Runtime.getRuntime().totalMemory();

				// System.out.println("Heap Size(M) : " + heapSize / (1024 * 1024) + " MB");
				// System.out.println("압축에 들어간 파일명 : " + files.get(k).split("/")[4] + "_" +
				// files.get(k).split("/")[5]);

				int len;
				while ((len = in.read(buffer)) > 0) {
					zout.write(buffer, 0, len);
				}

				zout.closeEntry();
				in.close();

				if ((k % 100) == 0) {
//					System.out.println("이미지 압축 현황 : " + k + " / " + files.size());
				}
			}

			zout.close();
		}

		// System.out.println("다운로드 한 파일 갯수 : " + files.size());
		String fileName = tempPath.substring(tempPath.indexOf("/")) + zipName;

		return fileName;
	}

	public String downloadZip(Map<String, Object> login, HttpServletResponse response, String zipName)
			throws IOException {
		List<String> files = new ArrayList<String>();

		ZipOutputStream zout = null;

		// 파일 이름은 유저이름 + 날짜 + 시간(초단위)로 변경
		String tempPath = "";

		List<String> idxArr = (List<String>) login.get("idxArr");
		
		List<Map> imageList = galleryRepository.selectDownloadImages(idxArr);

		int count = 0;

		double file_size = 0;
		
		for (Map i : imageList) {
			if (i.get("image_name").toString().indexOf("web_server") > 0) {
				files.add(part_drive_name + ":" + i.get("image_name").toString());
			} else {
				files.add(master_drive_name + ":" + i.get("image_name").toString().replace("webserver", "web_server"));
			}
			
			if (new File(i.get("image_name").toString()).exists()) {
				file_size += FileUtils.sizeOf(new File(i.get("image_name").toString()));
				count++;
			}
		}

		if (files.size() > 0) {
			if (drive_count > 1) {
				tempPath = part_drive_name + ":/web_server/" + "/download/";
				File[] roots = File.listRoots();
				double usableSpace = 0;
				for (File root : roots) {
					String drive = root.getAbsolutePath().substring(0, 1);
					if (drive.equals(part_drive_name)) {
						// 사용가능한 디스크 용량
						usableSpace = root.getUsableSpace();
						break;
					}
				}
				if (file_size > usableSpace) {
					return "";
				}
			} else {
				tempPath = master_drive_name + ":/web_server/" + "/download/";
				File[] roots = File.listRoots();
				double usableSpace = 0;
				for (File root : roots) {
					String drive = root.getAbsolutePath().substring(0, 1);
					if (drive.equals(master_drive_name)) {
						// 사용가능한 디스크 용량
						usableSpace = root.getUsableSpace();
						break;
					}
				}
				if (file_size > usableSpace) {
					return "";
				}
			}

			File folder = new File(tempPath);

			if (!folder.exists()) {
				try {
					// System.out.println("폴더 생성");
					folder.mkdir();
				} catch (Exception e) {
					e.getStackTrace();
				}
			} else {
				// System.out.println("폴더가 이미 존재합니다.");
			}

			zout = new ZipOutputStream(new FileOutputStream(tempPath + zipName));
			byte[] buffer = new byte[1024];
			FileInputStream in = null;

			for (int k = 0; k < files.size(); k++) {
				try {
					in = new FileInputStream(files.get(k));
				} catch (Exception e) {
					in = new FileInputStream(files.get(k));
				}
				zout.putNextEntry(new ZipEntry(files.get(k).split("/")[4] + "_" + files.get(k).split("/")[5]));

				int len;
				while ((len = in.read(buffer)) > 0) {
					zout.write(buffer, 0, len);
				}

				zout.closeEntry();
				in.close();
			}

			zout.close();
		}

		String fileName = tempPath + zipName;

		return fileName;
	}

	// 회원 정보 추가
	@RequestMapping(value = "/insertUserInfo")
	@ResponseBody
	public void insertUserInfo(@RequestBody UserDto userDto) {
		System.out.println("insertUserInfo()");
		// System.out.println(userDto.getUser_id());

		eventDao.insertUserInfo(userDto);
	}

	// 데이터 복사
	@RequestMapping(value = "/updateData")
	public void updateData() throws ParseException, IOException {
		System.out.println("updateData()");

		List<MonitoringDto> monitoringList = eventDao.selectMonitoringAll();

		if (monitoringList.size() > 0) {
			for (int i = 0; i < monitoringList.size(); i++) {
				if (eventDao.selectTestImage(monitoringList.get(i)).size() < 1) {
					System.out.println(monitoringList.get(i).getMonitoring_tag());
					eventDao.deleteBackupMonitoring(monitoringList.get(i).getMonitoring_src());
				}
				System.out.println("현황 = " + (i + 1) + " / " + monitoringList.size());
			}
		}
	}

	// 회원 정보 수정
	@RequestMapping(value = "/updateUserInfo")
	@ResponseBody
	public void updateUserInfo(@RequestBody User userDto) {
//		System.out.println("updateUserInfo()");
		// System.out.println(userDto.getUser_id());

		if (userDto.getUser_pw().length() > 0) {
			eventDao.updatePwInfo(userDto);
		} else {
			eventDao.updateUserInfo(userDto);
		}
	}

	/*
	 * // 토큰 테스트
	 * 
	 * @RequestMapping(value = "/chkTokken")
	 * 
	 * @ResponseBody public String chkTokken(@RequestBody UserDto userDto) {
	 * System.out.println("chkTokken");
	 * 
	 * String response =
	 * tokenTest("https://notify-api.line.me/api/notify?message=AlarmSendTest",
	 * "Bearer " + userDto.getUser_tokken());
	 * 
	 * // System.out.println("response = " + response);
	 * 
	 * return response; }
	 */

	public String tokenTest(String requestURL, String token) {
		String body = "";

		try {
			// HttpClient client = HttpClientBuilder.create().build(); // HttpClient 생성
			HttpPost postRequest = new HttpPost(requestURL); // POST 메소드 URL 새성
			// postRequest.setHeader("Accept", "application/json");
			// postRequest.setHeader("Connection", "keep-alive");
			// postRequest.setHeader("Content-Type", "multipart/form-data");
			// postRequest.addHeader("x-api-key", RestTestCommon.API_KEY); //KEY 입력
			postRequest.setHeader("Authorization", token); // token 이용시

			// postRequest.setEntity(new StringEntity(jsonMessage)); // json 메시지 입력

			HttpResponse response = client.execute(postRequest);

			// Response 출력
			if (response.getStatusLine().getStatusCode() == 200) {
				ResponseHandler<String> handler = new BasicResponseHandler();
				body = handler.handleResponse(response);
			} else {
				System.out.println("response is error : " + response.getStatusLine().getStatusCode());
				body = response.getStatusLine().getStatusCode() + "";
			}
		} catch (Exception e) {
			System.err.println(e.toString());
		}

		return body;
	}

	// 회원 삭제 처리(사용 여부 수정)

	@RequestMapping(value = "/deleteUserInfo")
	@ResponseBody
	public void deleteUserInfo(@RequestBody UserDto userDto) {
		System.out.println("deleteUserInfo()");
		// System.out.println(userDto.getUser_id());

		eventDao.updateIsUse(userDto);

	}

	@RequestMapping(value = "/image", method = RequestMethod.GET)
	public ModelAndView image(ModelAndView mv, String scroll) {
		System.out.println("image()");
		// System.out.println("scroll = ");

		if (scroll == null) {
			scroll = "";
		}
		mv.setViewName("./gallery/image");
		mv.addObject("scroll", scroll);

		return mv;
	}

	@RequestMapping(value = "/showRightInfoImage")
	@ResponseBody
	public ImageTableDto showRightInfoImage(@RequestBody ImageTableDto imageTableDto) throws IOException {
		// System.out.println("showRightInfoImage()");

		imageTableDto = eventDao.showRightInfoImage(imageTableDto);

		return imageTableDto;
	}

	@RequestMapping(value = "/isErrorImg")
	@ResponseBody
	public String isErrorImg(@RequestBody ImageTableDto imageDto) throws IOException {
		System.out.println("isErrorImg()");

		String image_name = part_drive_name + ":" + imageDto.getImage_name();
		String thumb_name = part_drive_name + ":" + imageDto.getThumb_name();

		File f = new File(image_name);

		BufferedImage bi = ImageIO.read(f);

		String answer = "";

		if (f.exists()) {
			if (bi.getWidth() < 640 || bi.getHeight() < 480) {
				f = new File(thumb_name);
				ImageIO.write(bi, "jpg", f);
			} else {
				EasyImage easyImage = new EasyImage(f);
				if (!easyImage.isSupportedImageFormat()) {
					System.out.println("not supported image type");
				}
				EasyImage resizedImage = easyImage.resize(640, 480);
				FileOutputStream out = new FileOutputStream(thumb_name);
				resizedImage.writeTo(out, "jpg");
				out.close();
			}
			answer = "success";
		} else {
			eventDao.deleteBackupImage(imageDto.getThumb_name());
			eventDao.deleteBackupMonitoring(imageDto.getThumb_name());

			answer = "failed";
		}

		return answer;
	}

	@RequestMapping(value = "/dateImage")
	@ResponseBody
	public List<MonitoringDto> dateImage(@RequestBody Map<String, Object> login) throws ParseException {
		System.out.println("dateImage()");

		String monitoring_time = login.get("monitoring_time").toString();

		List<MonitoringDto> monitoringAll = eventDao.searchDateImage(monitoring_time);

		return monitoringAll;
	}

	/*
	 * @RequestMapping(value = "/getDevice", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public String getDevice(@RequestBody String response) throws
	 * ParseException { System.out.println("getDevice()"); //
	 * System.out.println("response = " + response);
	 * 
	 * JSONParser jsonParser = new JSONParser(); JSONObject jsonObject =
	 * (JSONObject) jsonParser.parse(response);
	 * 
	 * String user_id = jsonObject.get("user_id").toString(); String user_pw =
	 * jsonObject.get("user_pw").toString();
	 * 
	 * UserDto userDto = new UserDto();
	 * 
	 * userDto.setUser_id(user_id); userDto.setUser_pw(user_pw);
	 * 
	 * UserDto dto = eventDao.login(userDto);
	 * 
	 * JSONObject json = new JSONObject(); ArrayList list = new ArrayList();
	 * 
	 * try { if (dto == null) { System.out.println("존재하지 않는 ID");
	 * json.put("response", "ID does not exist / Error : " + 1); } else if
	 * (!dto.getUser_pw().equals(userDto.getUser_pw())) {
	 * System.out.println("비밀번호 일치하지 않음"); json.put("response",
	 * "Invalid password / Error : " + 2); } else if
	 * (dto.getUser_pw().equals(userDto.getUser_pw())) { // 성공 시 에러 코드 0
	 * System.out.println("아이디와 비밀번호 일치"); List<DeviceInfoDto> deviceInfo =
	 * eventDao.selectDeviceInfo(userDto); if (deviceInfo.size() > 0) { for (int i =
	 * 0; i < deviceInfo.size(); i++) { JSONObject jsonList = new JSONObject();
	 * jsonList.put("dev_name", deviceInfo.get(i).getDev_name());
	 * jsonList.put("dev_private_ip", deviceInfo.get(i).getDev_private_ip());
	 * jsonList.put("dev_public_ip", deviceInfo.get(i).getDev_public_ip());
	 * jsonList.put("dev_id", deviceInfo.get(i).getDev_id());
	 * jsonList.put("dev_pwd", deviceInfo.get(i).getDev_pwd());
	 * jsonList.put("dev_port", deviceInfo.get(i).getDev_port());
	 * jsonList.put("dev_web_port", deviceInfo.get(i).getDev_web_port());
	 * jsonList.put("dev_channel", deviceInfo.get(i).getDev_channel());
	 * jsonList.put("dev_enable_channel",
	 * deviceInfo.get(i).getDev_enable_channel()); jsonList.put("dev_time",
	 * deviceInfo.get(i).getDev_time()); jsonList.put("login_id",
	 * deviceInfo.get(i).getLogin_id()); jsonList.put("dev_aibox",
	 * deviceInfo.get(i).getDev_aibox()); list.add(jsonList); } json.put("response",
	 * list); } else { json.put("response", "Device does not exist / Error : " + 3);
	 * } } else { System.out.println("예외 발생"); json.put("response",
	 * "Error / Error : " + 9); } } catch (Exception e) {
	 * System.out.println(e.getMessage()); json.put("response", "Error / Error : " +
	 * 9); }
	 * 
	 * return json.toString().replaceAll("\\\\", "");
	 * 
	 * }
	 */
	public void deleteImageDay2(final ImageTableDto totalImageTableDto) {
		System.out.println("deleteImageDay2()");

		if (totalImageTableDto != null && totalImageTableDto.getLogin_id() != null
				&& totalImageTableDto.getLogin_id().equals("admin")) {
			totalImageTableDto.setLogin_id(null);
		}

		// long period = 1000 * 60;
		long period = 1000 * 60 * 5;

//		DeleteImageDay deleteImageDay = new DeleteImageDay();

		Calendar calendar = new GregorianCalendar(Locale.KOREA);
		calendar.set(Calendar.SECOND, 0);

		long nowDate = new Date().getTime();

		if (nowDate >= calendar.getTime().getTime()) {
			calendar.add(Calendar.MINUTE, 1);
		}

		Date firstTime = new Date(calendar.getTimeInMillis());
		firstTime = new Date();
		timer = new Timer();
		task = new TimerTask() {
			@Override
			public void run() {
				Calendar cal = Calendar.getInstance();
//				System.out.println("스케줄2 = " + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cal.getTimeInMillis()));

				String drive;
				double totalSpace = 0, usedSpace, freeSpace, usableSpace = 0; // 하드디스크의 루트 드라이버들을 배열로 반환한다.
				File[] roots = File.listRoots();

				int n = 2;
				double n2 = Math.pow(10.0, n);

				for (File root : roots) {
					drive = root.getAbsolutePath().substring(0, 1);
					if (drive.equals(part_drive_name)) {
						// 하드디스크 전체 용량
						totalSpace = Math.round(root.getTotalSpace() / Math.pow(1024, 3) * n2) / n2;
						// 사용가능한 디스크 용량
						usableSpace = Math.round(root.getUsableSpace() / Math.pow(1024, 3) * n2) / n2;
						// 여유 디스크 용량
						freeSpace = Math.round(root.getFreeSpace() / Math.pow(1024, 3) * n2) / n2;
						// 사용한 디스크 용량
						usedSpace = Math.round((totalSpace - usableSpace) * n2) / n2;
						// System.out.println("사용 가능한 디스크 용량 : " + usableSpace + "GB");
					}
				}

				String uploadPath = part_drive_name + ":/web_server";
				File folder = new File(uploadPath);

				if (!folder.exists()) {
					try {
						folder.mkdir();
					} catch (Exception e) {
						String errorMsg = null;
						StringWriter error = new StringWriter();
						e.printStackTrace(new PrintWriter(error));
						errorMsg = error.toString();
						ErrorLogDto errorLogDto = new ErrorLogDto();
						errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
						errorLogDto.setLog_place(part_drive_name + "드라이브 web_server폴더 생성 시 오류");
						errorLogDto.setLog_content(errorMsg);
						eventDao.insertErrorLog(errorLogDto);
						deleteImageDay2(null);
						errorWebsocket(errorLogDto);
					}
				}

				int dateCount = 181;

				String setting_name = "tagging";

				SettingDto settingDto = eventDao.settingData(setting_name);

				String setting_driveD = settingDto.getSetting_drived();

				Pattern pattern = Pattern.compile("[!@#$%^&*(),.?\":{}|<>]");

				// double limitedSpace = totalSpace * 0.6;

				double limitedSpace = totalSpace * 0.2; // 남은 용량

				if (pattern.matcher(setting_driveD).find()) {
					limitedSpace = totalSpace
							* ((Double.parseDouble((setting_driveD.substring(0, setting_driveD.indexOf("%")))) / 100));
				} else {
					limitedSpace = Double.parseDouble(setting_driveD.substring(0, setting_driveD.indexOf("G")));
				}

				if (totalImageTableDto != null && totalImageTableDto.getLimit_num() > 0) {
					limitedSpace = totalImageTableDto.getLimit_num();
				}

				if (totalImageTableDto != null && totalImageTableDto.getLimit_num() > 0) {
					limitedSpace = totalImageTableDto.getLimit_num();
				}

				while (usableSpace < limitedSpace && dateCount > 0) { // 102번 : 364기가
					String errorMsg = null;
					dateCount--;
					List<ImageTableDto> imageTableDtoList = eventDao.selectDeleteD(dateCount);
					if (imageTableDtoList.size() > 0) {
						long end = System.currentTimeMillis();
						BackupLogDto backupLogDto = new BackupLogDto();
						backupLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
						double file_size = 0;
						n = 2;
						n2 = Math.pow(10.0, n);
						for (int i = 0; i < imageTableDtoList.size(); i++) {
							ImageTableDto imageTableDto = imageTableDtoList.get(i);
							System.out.println(part_drive_name + ":" + imageTableDto.getImage_name());
							eventDao.deleteOverDateMonitoring2(imageTableDto);
							File file = new File(part_drive_name + ":" + imageTableDto.getImage_name());
							backupLogDto.setLog_content(part_drive_name + "드라이브 / " + part_drive_name + ":"
									+ imageTableDto.getImage_name());
							try {
								file_size += Math.round(FileUtils.sizeOfDirectory(file) * n2) / n2;
								// file_size += file.length() / Math.pow(1024, 3);
								FileUtils.deleteDirectory(file);
							} catch (Exception e) {
								StringWriter error = new StringWriter();
								e.printStackTrace(new PrintWriter(error));
								errorMsg = error.toString();
								ErrorLogDto errorLogDto = new ErrorLogDto();
								errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
								errorLogDto.setLog_place(part_drive_name + "드라이브 폴더 삭제 시 오류");
								errorLogDto.setLog_content(errorMsg);
								eventDao.insertErrorLog(errorLogDto);
								deleteImageDay2(null);
								errorWebsocket(errorLogDto);
							}

							String image_path = imageTableDto.getImage_name();
							image_path = image_path.substring(0, image_path.lastIndexOf("/"));
							String imageList[] = image_path.split("/");
							for (int j = 0; j < 2; j++) {
								image_path = image_path.substring(0, image_path.lastIndexOf("/"));
								file = new File(part_drive_name + ":" + image_path);
								if (file.exists()) {
									String fileList[] = file.list();
									try {
										if (fileList != null && fileList.length == 0) {
											FileUtils.deleteDirectory(file);
										} else {
											break;
										}
									} catch (Exception e) {
										StringWriter error = new StringWriter();
										e.printStackTrace(new PrintWriter(error));
										errorMsg = error.toString();
										ErrorLogDto errorLogDto = new ErrorLogDto();
										errorLogDto.setLog_time(
												new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
										errorLogDto.setLog_place(part_drive_name + "드라이브 이미지 삭제 후 폴더 삭제");
										errorLogDto.setLog_content(errorMsg);
										eventDao.insertErrorLog(errorLogDto);
										deleteImageDay2(null);
										errorWebsocket(errorLogDto);
									}
								}
							}
							file_size = Math.round(file_size / Math.pow(1024, 3) * Math.pow(10.0, 3))
									/ Math.pow(10.0, 3);

							backupLogDto.setLog_size(file_size + "GB");
							long now = System.currentTimeMillis();
							backupLogDto.setLog_taken((now - end) / 1000.0 + "초");
							if (file_size > 0) {
								// eventDao.insertBackupLog(backupLogDto);
								backupWebsocket(backupLogDto);
							}
						}
					}

					for (File root : roots) {
						drive = root.getAbsolutePath().substring(0, 1);
						if (drive.equals(part_drive_name)) {
							// 하드디스크 전체 용량
							totalSpace = Math.round(root.getTotalSpace() / Math.pow(1024, 3) * n2) / n2;
							// 사용가능한 디스크 용량
							usableSpace = Math.round(root.getUsableSpace() / Math.pow(1024, 3) * n2) / n2;
							// 여유 디스크 용량
							freeSpace = Math.round(root.getFreeSpace() / Math.pow(1024, 3) * n2) / n2;
							// 사용한 디스크 용량
							usedSpace = Math.round((totalSpace - usableSpace) * n2) / n2;
							// System.out.println("사용 가능한 디스크 용량 : " + usableSpace + "GB");
						}
					}
				}
			}
		};
		timer.scheduleAtFixedRate(task, firstTime, period);
	}

	public void deleteImageDay(final ImageTableDto totalImageTableDto) {
		System.out.println("deleteImageDay()");

		if (totalImageTableDto != null && totalImageTableDto.getLogin_id() != null
				&& totalImageTableDto.getLogin_id().equals("admin")) {
			totalImageTableDto.setLogin_id(null);
		}

		// long period = 1000 * 60;
		long period = 1000 * 60 * 5;

//		DeleteImageDay deleteImageDay = new DeleteImageDay();

		Calendar calendar = new GregorianCalendar(Locale.KOREA);
		calendar.set(Calendar.SECOND, 0);

		long nowDate = new Date().getTime();

		if (nowDate >= calendar.getTime().getTime()) {
			calendar.add(Calendar.MINUTE, 1);
		}

		Date firstTime = new Date(calendar.getTimeInMillis());
		firstTime = new Date();
		timer = new Timer();
		task = new TimerTask() {
			@Override
			public void run() {
				Calendar cal = Calendar.getInstance();
//				System.out.println("스케줄 = " + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cal.getTimeInMillis()));

				String drive;
				double totalSpace = 0, usedSpace, freeSpace, usableSpace = 0; // 하드디스크의 루트 드라이버들을 배열로 반환한다.
				File[] roots = File.listRoots();

				int n = 2;
				double n2 = Math.pow(10.0, n);

				for (File root : roots) {
					drive = root.getAbsolutePath().substring(0, 1);
					if (drive.equals(master_drive_name)) {
						// 하드디스크 전체 용량
						totalSpace = Math.round(root.getTotalSpace() / Math.pow(1024, 3) * n2) / n2;
						// 사용가능한 디스크 용량
						usableSpace = Math.round(root.getUsableSpace() / Math.pow(1024, 3) * n2) / n2;
						// 여유 디스크 용량
						freeSpace = Math.round(root.getFreeSpace() / Math.pow(1024, 3) * n2) / n2;
						// 사용한 디스크 용량
						usedSpace = Math.round((totalSpace - usableSpace) * n2) / n2;
						// System.out.println("사용 가능한 디스크 용량 : " + usableSpace + "GB");
					}
				}

				if (drive_count > 1) {
					String uploadPath = part_drive_name + ":/web_server";
					File folder = new File(uploadPath);

					if (!folder.exists()) {
						try {
							folder.mkdir();
						} catch (Exception e) {
							String errorMsg = null;
							StringWriter error = new StringWriter();
							e.printStackTrace(new PrintWriter(error));
							errorMsg = error.toString();
							ErrorLogDto errorLogDto = new ErrorLogDto();
							errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
							errorLogDto.setLog_place(master_drive_name + "드라이브 web_server폴더 생성 오류");
							errorLogDto.setLog_content(errorMsg);
							eventDao.insertErrorLog(errorLogDto);
							deleteImageDay(null);
							errorWebsocket(errorLogDto);
						}
					}

					int dateCount = 8;

					String setting_name = "tagging";

					SettingDto settingDto = eventDao.settingData(setting_name);

					String setting_driveC = settingDto.getSetting_drivec();

					Pattern pattern = Pattern.compile("[!@#$%^&*(),.?\":{}|<>]");

					// double limitedSpace = totalSpace * 0.6;

					double limitedSpace = totalSpace * 0.4; // 남은 용량

					if (pattern.matcher(setting_driveC).find()) {
						limitedSpace = totalSpace
								* ((Double.parseDouble((setting_driveC.substring(0, setting_driveC.indexOf("%"))))
										/ 100));
					} else {
						limitedSpace = Double.parseDouble(setting_driveC.substring(0, setting_driveC.indexOf("G")));
					}

					if (totalImageTableDto != null && totalImageTableDto.getLimit_num() > 0) {
						limitedSpace = totalImageTableDto.getLimit_num();
					}

//					System.out.println(master_drive_name + "드라이브 남은 용량 = " + usableSpace + "GB");
//					System.out.println(master_drive_name + "드라이브 제한 용량 = " + limitedSpace + "GB");

					while (usableSpace < limitedSpace && dateCount > 0) { // 102번 : 60기가
						String errorMsg = null;
						dateCount--;
						List<ImageTableDto> imageTableDtoList = eventDao.selectDeleteC(dateCount);
						if (imageTableDtoList.size() > 0) {
							long end = System.currentTimeMillis();
							BackupLogDto backupLogDto = new BackupLogDto();
							backupLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
							double file_size = 0;
							n = 2;
							n2 = Math.pow(10.0, n);
							for (int i = 0; i < imageTableDtoList.size(); i++) {
								ImageTableDto imageTableDto = imageTableDtoList.get(i);
								backupLogDto.setLog_content(master_drive_name + "드라이브 / " + master_drive_name + ":"
										+ imageTableDto.getImage_name());
								// System.out.println("백업 로그 = " + backupLogDto.getLog_content());
								File file = new File(master_drive_name + ":" + imageTableDto.getImage_name());
								File file2 = new File(part_drive_name + ":" + imageTableDto.getImage_name());
								String imageDate = imageTableDto.getImage_name().substring(0,
										imageTableDto.getImage_name().lastIndexOf("/"));
								imageDate = imageDate.substring(imageDate.lastIndexOf("/") + 1);
								if (new File(master_drive_name + ":" + imageTableDto.getImage_name()).exists()) {
									if (imageDate.equals(new SimpleDateFormat("yyyyMMdd").format(new Date()))) {
										String fileList[] = new File(
												master_drive_name + ":" + imageTableDto.getImage_name()).list();
										try {
											uploadPath = part_drive_name + ":" + imageTableDto.getImage_name();
											folder = new File(uploadPath);

											if (!folder.exists()) {
												try {
													folder.mkdir();
												} catch (Exception e) {
													StringWriter error = new StringWriter();
													e.printStackTrace(new PrintWriter(error));
													errorMsg = error.toString();
													ErrorLogDto errorLogDto = new ErrorLogDto();
													errorLogDto.setLog_time(
															new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
													errorLogDto.setLog_place(
															"오늘자 " + master_drive_name + "드라이브 이미지 백업 폴더 생성 오류");
													errorLogDto.setLog_content(errorMsg);
													eventDao.insertErrorLog(errorLogDto);
													deleteImageDay(null);
													errorWebsocket(errorLogDto);
												}
											}

											if (fileList != null) {
												for (int j = 0; j < fileList.length; j++) {
													file_size += Math.round(new File(master_drive_name + ":"
															+ imageTableDto.getImage_name() + fileList[j]).length() * n2) / n2;
													if (!(new File(
															part_drive_name + ":" + imageTableDto.getImage_name() + fileList[j])
																	.exists())) {
														try {
															FileUtils.moveFile(
																	new File(master_drive_name + ":"
																			+ imageTableDto.getImage_name() + fileList[j]),
																	new File(part_drive_name + ":"
																			+ imageTableDto.getImage_name() + fileList[j]));
														} catch (Exception e) {
															StringWriter error = new StringWriter();
															e.printStackTrace(new PrintWriter(error));
															errorMsg = error.toString();
															ErrorLogDto errorLogDto = new ErrorLogDto();
															errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
																	.format(new Date()));
															errorLogDto
																	.setLog_place("오늘자 " + master_drive_name + "드라이브 이미지 백업");
															errorLogDto.setLog_content(errorMsg);
															eventDao.insertErrorLog(errorLogDto);
															deleteImageDay(null);
															errorWebsocket(errorLogDto);
														} // 조건에 맞게 디렉토리를 옮길 수도 있고 삭제할 수도 있음
													} else {
														FileUtils.deleteQuietly(new File(master_drive_name + ":"
																+ imageTableDto.getImage_name() + fileList[j]));
													}
												}
											}
										} catch(Exception e) {
											e.printStackTrace();
										}
										
									} else {
										if (!(new File(part_drive_name + ":" + imageTableDto.getImage_name())
												.exists())) { // D드라이브에 폴더는 존재함
											try {
												file_size += Math.round(FileUtils.sizeOfDirectory(new File(
														master_drive_name + ":" + imageTableDto.getImage_name())) * n2)
														/ n2;
												FileUtils.moveDirectory(
														new File(master_drive_name + ":"
																+ imageTableDto.getImage_name()),
														new File(
																part_drive_name + ":" + imageTableDto.getImage_name()));
											} catch (Exception e) {
												// TODO Auto-generated catch block
												StringWriter error = new StringWriter();
												e.printStackTrace(new PrintWriter(error));
												errorMsg = error.toString();
												ErrorLogDto errorLogDto = new ErrorLogDto();
												errorLogDto.setLog_time(
														new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
												errorLogDto.setLog_place(
														"D드라이브에 폴더 없는 " + master_drive_name + "드라이브 이미지 백업");
												errorLogDto.setLog_content(errorMsg);
												eventDao.insertErrorLog(errorLogDto);
												deleteImageDay(null);
												errorWebsocket(errorLogDto);
											}
										} else { // D드라이브에 폴더도 존재하지 않음
											String fileList[] = new File(
													master_drive_name + ":" + imageTableDto.getImage_name()).list();
											try {
												if (fileList != null) {
													for (int j = 0; j < fileList.length; j++) {
														if (!(new File(part_drive_name + ":" + imageTableDto.getImage_name()
																+ fileList[j]).exists())) {
															try {
																file_size += Math.round(new File(master_drive_name + ":"
																		+ imageTableDto.getImage_name() + fileList[j]).length()
																		* n2) / n2;
																FileUtils.moveFile(
																		new File(master_drive_name + ":"
																				+ imageTableDto.getImage_name() + fileList[j]),
																		new File(part_drive_name + ":"
																				+ imageTableDto.getImage_name() + fileList[j]));
															} catch (Exception e) {
																// TODO Auto-generated catch block
																StringWriter error = new StringWriter();
																e.printStackTrace(new PrintWriter(error));
																errorMsg = error.toString();
																ErrorLogDto errorLogDto = new ErrorLogDto();
																errorLogDto
																		.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
																				.format(new Date()));
																errorLogDto.setLog_place(
																		"D드라이브에 폴더 있는 " + master_drive_name + "드라이브 이미지 백업");
																errorLogDto.setLog_content(errorMsg);
																eventDao.insertErrorLog(errorLogDto);
																deleteImageDay(null);
																errorWebsocket(errorLogDto);
															} // 조건에 맞게 디렉토리를 옮길 수도 있고 삭제할 수도 있음
														}
													}
												}
											} catch(Exception e) {
												e.printStackTrace();
											}
										}
									}
								}

								String image_path = imageTableDto.getImage_name();
								String imageList[] = image_path.split("/");
								for (int j = 0; j < 3; j++) {
									image_path = image_path.substring(0, image_path.lastIndexOf("/"));
									file = new File(master_drive_name + ":" + image_path);
									// System.out.println("C:" + image_path);
									if (file.exists()) {
										try {
											String fileList[] = file.list();
											if (fileList != null && fileList.length == 0) {
												FileUtils.deleteDirectory(file);
											} else {
												break;
											}
										} catch (Exception e) {
											StringWriter error = new StringWriter();
											e.printStackTrace(new PrintWriter(error));
											errorMsg = error.toString();
											ErrorLogDto errorLogDto = new ErrorLogDto();
											errorLogDto.setLog_time(
													new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
											errorLogDto.setLog_place(master_drive_name + "드라이브 백업 후 폴더 삭제");
											errorLogDto.setLog_content(errorMsg);
											eventDao.insertErrorLog(errorLogDto);
											deleteImageDay2(null);
											errorWebsocket(errorLogDto);
										}
									}
								}

								file_size = Math.round(file_size / Math.pow(1024, 2) * n2) / n2;
								// file_size = Math.round(file_size * 100) / 100.0;
								backupLogDto.setLog_size(file_size + "MB");
								long now = System.currentTimeMillis();
								backupLogDto.setLog_taken((now - end) / 1000.0 + "초");
								if (file_size > 0) {
//									System.out.println(master_drive_name + "드라이브 청소 시작");
//									System.out.println(master_drive_name + "C드라이브 옮긴 용량 = " + file_size);
//									System.out.println(master_drive_name + "드라이브 삭제 용량 = " + file_size + "MB");
									// eventDao.insertBackupLog(backupLogDto);
									backupWebsocket(backupLogDto);
//									System.out.println(master_drive_name + "드라이브 청소 끝");
								}
							}
						}

						for (File root : roots) {
							drive = root.getAbsolutePath().substring(0, 1);
							if (drive.equals(master_drive_name)) {
								// 하드디스크 전체 용량
								totalSpace = Math.round(root.getTotalSpace() / Math.pow(1024, 3) * n2) / n2;
								// 사용가능한 디스크 용량
								usableSpace = Math.round(root.getUsableSpace() / Math.pow(1024, 3) * n2) / n2;
								// 여유 디스크 용량
								freeSpace = Math.round(root.getFreeSpace() / Math.pow(1024, 3) * n2) / n2;
								// 사용한 디스크 용량
								usedSpace = Math.round((totalSpace - usableSpace) * n2) / n2;
								// System.out.println("사용 가능한 디스크 용량 : " + usableSpace + "GB");
							}
						}
					}
				} else {
					String uploadPath = part_drive_name + ":/web_server";
					File folder = new File(uploadPath);

					if (!folder.exists()) {
						try {
							folder.mkdir();
						} catch (Exception e) {
							String errorMsg = null;
							StringWriter error = new StringWriter();
							e.printStackTrace(new PrintWriter(error));
							errorMsg = error.toString();
							ErrorLogDto errorLogDto = new ErrorLogDto();
							errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
							errorLogDto.setLog_place(master_drive_name + "드라이브 web_server폴더 생성 오류");
							errorLogDto.setLog_content(errorMsg);
							eventDao.insertErrorLog(errorLogDto);
							deleteImageDay(null);
							errorWebsocket(errorLogDto);
						}
					}

					int dateCount = 8;

					String setting_name = "tagging";

					SettingDto settingDto = eventDao.settingData(setting_name);

					String setting_driveC = settingDto.getSetting_drivec();

					Pattern pattern = Pattern.compile("[!@#$%^&*(),.?\":{}|<>]");

					// double limitedSpace = totalSpace * 0.6;

					double limitedSpace = totalSpace * 0.4; // 남은 용량

					if (pattern.matcher(setting_driveC).find()) {
						limitedSpace = totalSpace
								* ((Double.parseDouble((setting_driveC.substring(0, setting_driveC.indexOf("%"))))
										/ 100));
					} else {
						limitedSpace = Double.parseDouble(setting_driveC.substring(0, setting_driveC.indexOf("G")));
					}

					if (totalImageTableDto != null && totalImageTableDto.getLimit_num() > 0) {
						limitedSpace = totalImageTableDto.getLimit_num();
					}

//					System.out.println(master_drive_name + "드라이브 남은 용량 = " + usableSpace + "GB");
//					System.out.println(master_drive_name + "드라이브 제한 용량 = " + limitedSpace + "GB");

					while (usableSpace < limitedSpace && dateCount > 0) { // 102번 : 60기가
						String errorMsg = null;
						dateCount--;
						List<ImageTableDto> imageTableDtoList = eventDao.selectDeleteC(dateCount);
						if (imageTableDtoList.size() > 0) {
							long end = System.currentTimeMillis();
							BackupLogDto backupLogDto = new BackupLogDto();
							backupLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
							double file_size = 0;
							n = 2;
							n2 = Math.pow(10.0, n);
							for (int i = 0; i < imageTableDtoList.size(); i++) {
								ImageTableDto imageTableDto = imageTableDtoList.get(i);
								backupLogDto.setLog_content(master_drive_name + "드라이브 / " + master_drive_name + ":"
										+ imageTableDto.getImage_name());
								File file = new File(master_drive_name + ":" + imageTableDto.getImage_name());
								String imageDate = imageTableDto.getImage_name().substring(0,
										imageTableDto.getImage_name().lastIndexOf("/"));
								imageDate = imageDate.substring(imageDate.lastIndexOf("/") + 1);
								if (file.exists()) {
									backupLogDto.setLog_content(master_drive_name + "드라이브 / " + master_drive_name + ":"
											+ imageTableDto.getImage_name());
									try {
										file_size += Math.round(FileUtils.sizeOfDirectory(file) * n2) / n2;
										// file_size += file.length() / Math.pow(1024, 3);
										FileUtils.deleteDirectory(file);
									} catch (Exception e) {
										StringWriter error = new StringWriter();
										e.printStackTrace(new PrintWriter(error));
										errorMsg = error.toString();
										ErrorLogDto errorLogDto = new ErrorLogDto();
										errorLogDto.setLog_time(
												new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
										errorLogDto.setLog_place(master_drive_name + "드라이브 폴더 삭제 시 오류");
										errorLogDto.setLog_content(errorMsg);
										eventDao.insertErrorLog(errorLogDto);
										deleteImageDay(null);
										errorWebsocket(errorLogDto);
									}
								}

								String image_path = imageTableDto.getImage_name();
								image_path = image_path.substring(0, image_path.lastIndexOf("/"));
								String imageList[] = image_path.split("/");
								for (int j = 0; j < 2; j++) {
									image_path = image_path.substring(0, image_path.lastIndexOf("/"));
									file = new File(master_drive_name + ":" + image_path);
									if (file.exists()) {
										String fileList[] = file.list();
										try {
											if (fileList != null && fileList.length == 0) {
												FileUtils.deleteDirectory(file);
											} else {
												break;
											}
										} catch (Exception e) {
											StringWriter error = new StringWriter();
											e.printStackTrace(new PrintWriter(error));
											errorMsg = error.toString();
											ErrorLogDto errorLogDto = new ErrorLogDto();
											errorLogDto.setLog_time(
													new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
											errorLogDto.setLog_place(master_drive_name + "드라이브 이미지 삭제 후 폴더 삭제");
											errorLogDto.setLog_content(errorMsg);
											eventDao.insertErrorLog(errorLogDto);
											deleteImageDay2(null);
											errorWebsocket(errorLogDto);
										}
									}
								}

								file_size = Math.round(file_size / Math.pow(1024, 3) * Math.pow(10.0, 3))
										/ Math.pow(10.0, 3);

								backupLogDto.setLog_size(file_size + "GB");
								System.out.println(master_drive_name + "드라이브 삭제 용량 = " + file_size + "GB");
								long now = System.currentTimeMillis();
								backupLogDto.setLog_taken((now - end) / 1000.0 + "초");
								if (file_size > 0) {
									// eventDao.insertBackupLog(backupLogDto);
									backupWebsocket(backupLogDto);
								}
							}
						}
					}
				}
			}
		};
		timer.scheduleAtFixedRate(task, firstTime, period);
	}

	public void backupImageDay(final ImageTableDto totalImageTableDto) {
		System.out.println("backupImageDay()");

		if (totalImageTableDto != null && totalImageTableDto.getLogin_id() != null
				&& totalImageTableDto.getLogin_id().equals("admin")) {
			totalImageTableDto.setLogin_id(null);
		}

		long period = 1000 * 60 * 60 * 24;
		// long period = 1000 * 60;

		Calendar calendar = new GregorianCalendar(Locale.KOREA);
		calendar.set(Calendar.HOUR_OF_DAY, 3);
		// calendar.set(Calendar.HOUR_OF_DAY, 17);
		calendar.set(Calendar.MINUTE, 5);
		// calendar.set(Calendar.MINUTE, 26);
		calendar.set(Calendar.SECOND, 0);

		Date nowDate = new Date();

		if (nowDate.getTime() >= calendar.getTime().getTime()) {
			calendar.add(Calendar.DATE, 1);
		}

		// Date firstTime = new Date(new SimpleDateFormat("yyyy-MM-dd
		// HH:mm:ss").format(calendar.getTime()));
		Date firstTime = new Date(calendar.getTimeInMillis());

		calendar.set(Calendar.HOUR_OF_DAY, 2);
		calendar.set(Calendar.MINUTE, 0);

		final String untilTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTimeInMillis()); // 오전
																													// 2시까지

		calendar.add(Calendar.DATE, -1);
		calendar.set(Calendar.HOUR_OF_DAY, 2);

		final String imageTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(calendar.getTimeInMillis());

		// firstTime = new Date();
		timerBackup = new Timer();
		taskBackup = new TimerTask() {
			@Override
			public void run() {
				Calendar cal = Calendar.getInstance();
				// System.out.println("데일리 스케줄 = " + new SimpleDateFormat("yyyy-MM-dd
				// HH:mm:ss").format(cal.getTimeInMillis()));

				NumberFormat nf = NumberFormat.getInstance();
				nf.setMaximumFractionDigits(2);
				if (drive_count > 1) {
					String uploadPath = part_drive_name + ":/web_server";
					File folder = new File(uploadPath);

					if (!folder.exists()) {
						try {
							folder.mkdir();
						} catch (Exception e) {
							String errorMsg = null;
							StringWriter error = new StringWriter();
							e.printStackTrace(new PrintWriter(error));
							errorMsg = error.toString();
							ErrorLogDto errorLogDto = new ErrorLogDto();
							errorLogDto.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
							errorLogDto.setLog_place("데일리 백업 web_server폴더 생성 시 오류");
							errorLogDto.setLog_content(errorMsg);
							eventDao.insertErrorLog(errorLogDto);
							backupImageDay(null);
							errorWebsocket(errorLogDto);
						}
					}
					// 원본 파일경로
					// String oriFilePath = "D:/web_server/testuser/AIBOX_OFFICE/20200811/";

					DBackupDto dBackupDto = new DBackupDto();

					dBackupDto.setImageTime(imageTime);
					dBackupDto.setUntilTime(untilTime);

					List<ImageTableDto> imageTableList = eventDao.selectMoveCD(dBackupDto);
					BackupLogDto backupLog = new BackupLogDto();
					backupLog.setLog_time(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
					String log_content = "데일리 백업";
					backupLog.setLog_content(log_content);
					if (imageTableList.size() > 0) {
						long end = System.currentTimeMillis();

						int n = 2;
						double n2 = Math.pow(10.0, n);

						double file_size = 0;

						for (int i = 0; i < imageTableList.size(); i++) {
							String errorMsg = null;
							ImageTableDto imageTableDto = imageTableList.get(i);
							String image_name = imageTableDto.getImage_name();

							// System.out.println("데일리네임 = " + image_name);

							File path = new File(master_drive_name + ":" + image_name);
							File path2 = new File(part_drive_name + ":" + image_name);

							if (path2.exists() && path.exists()) {
								String fileList[] = path.list();
								try {
									if (fileList != null) {
										for (int j = 0; j < fileList.length; j++) {
											path = new File(master_drive_name + ":" + image_name + fileList[i]);
											path2 = new File(part_drive_name + ":" + image_name + fileList[i]);
											if (!(path2.exists())) {
												try {
													file_size += Math.round(path.length() * n2) / n2;
													FileUtils.copyFile(path, path2);
												} catch (Exception e) {
													StringWriter error = new StringWriter();
													e.printStackTrace(new PrintWriter(error));
													errorMsg = error.toString();
													ErrorLogDto errorLogDto = new ErrorLogDto();
													errorLogDto.setLog_time(
															new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
													errorLogDto.setLog_place("데일리 백업 이미지 복사 복사 시 오류");
													errorLogDto.setLog_content(errorMsg);
													eventDao.insertErrorLog(errorLogDto);
													backupImageDay(null);
													errorWebsocket(errorLogDto);
												}
											}
										}
									}
								} catch(Exception e) {
									e.printStackTrace();
								}
							} else {
								if (!(path2.exists()) && path.exists()) {
									try {
										path2.mkdir();
									} catch (Exception e) {
										e.getStackTrace();
									}
									try {
										file_size += Math.round(FileUtils.sizeOfDirectory(path) * n2) / n2;
										FileUtils.copyDirectory(path, path2);
									} catch (Exception e) {
										// TODO Auto-generated catch block
										StringWriter error = new StringWriter();
										e.printStackTrace(new PrintWriter(error));
										errorMsg = error.toString();
										ErrorLogDto errorLogDto = new ErrorLogDto();
										errorLogDto.setLog_time(
												new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
										errorLogDto.setLog_place("데일리 백업 " + master_drive_name + "드라이브 폴더 복사 시 오류");
										errorLogDto.setLog_content(errorMsg);
										eventDao.insertErrorLog(errorLogDto);
										backupImageDay(null);
										errorWebsocket(errorLogDto);
									}
								}
							}

							String image_path = imageTableDto.getImage_name();
							String imageList[] = image_path.split("/");
							for (int j = 0; j < 3; j++) {
								// System.out.println(j + " = " + image_path);
								image_path = image_path.substring(0, image_path.lastIndexOf("/"));
								path = new File(master_drive_name + ":" + image_path);
								if (path.exists()) {
									String fileList[] = path.list();
									
									try {
										if (fileList != null && fileList.length == 0) {
											FileUtils.deleteDirectory(path);
										} else {
											break;
										}
									} catch (Exception e) {
										// TODO Auto-generated catch block
										StringWriter error = new StringWriter();
										e.printStackTrace(new PrintWriter(error));
										errorMsg = error.toString();
										ErrorLogDto errorLogDto = new ErrorLogDto();
										errorLogDto.setLog_time(
												new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
										errorLogDto.setLog_place(
												"데일리 백업 " + master_drive_name + "드라이브 완료 후 폴더 삭제 시 오류");
										errorLogDto.setLog_content(errorMsg);
										eventDao.insertErrorLog(errorLogDto);
										backupImageDay(null);
										errorWebsocket(errorLogDto);
									}
								}
							}
						}

						file_size = Math.round(file_size / Math.pow(1024, 3) * Math.pow(10.0, 3)) / Math.pow(10.0, 3);
						// file_size = Math.round(file_size * 100) / 100.0;
						backupLog.setLog_size(file_size + "GB");

						long now = System.currentTimeMillis();

						System.out.println("모든 이미지 시간 = " + (now - end) / 1000.0 + "초");

						backupLog.setLog_taken((now - end) / 1000.0 + "초");

						if (file_size > 0) {
							// eventDao.insertBackupLog(backupLog);
							backupWebsocket(backupLog);
						} else {
							log_content = "데일리 백업 한 거 없음";
							backupLog.setLog_content(log_content);
							// eventDao.insertBackupLog(backupLog);
							backupWebsocket(backupLog);
						}
					} else {
						log_content = "데일리 백업 할 이미지가 없음";
						backupLog.setLog_content(log_content);
						backupLog.setLog_size("없음");
						backupLog.setLog_taken("없음");
						// eventDao.insertBackupLog(backupLog);
						backupWebsocket(backupLog);
					}
					List<ImageTableDto> imageTableList2 = eventDao.deleteOverDate(untilTime);
					eventDao.deleteOverDateMonitoring(untilTime);

					if (imageTableList2.size() > 0) {
						String errorMsg = null;
						for (int k = 0; k < imageTableList2.size(); k++) {
							ImageTableDto imageTableDto = imageTableList2.get(k);
							File path = new File(part_drive_name + ":" + imageTableDto.getImage_name());
							if (path.exists()) {
								try {
									FileUtils.deleteDirectory(path);
								} catch (Exception e) {
									// TODO Auto-generated catch block
									StringWriter error = new StringWriter();
									e.printStackTrace(new PrintWriter(error));
									errorMsg = error.toString();
									ErrorLogDto errorLogDto = new ErrorLogDto();
									errorLogDto.setLog_time(
											new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
									errorLogDto.setLog_place("데일리 백업 " + part_drive_name + "드라이브 폴더 삭제 시 오류");
									errorLogDto.setLog_content(errorMsg);
									eventDao.insertErrorLog(errorLogDto);
									backupImageDay(null);
									errorWebsocket(errorLogDto);
								}
							}

							String image_path = imageTableDto.getImage_name();
							image_path = image_path.substring(0, image_path.lastIndexOf("/"));
							String imageList[] = image_path.split("/");
							for (int j = 0; j < 2; j++) {
								image_path = image_path.substring(0, image_path.lastIndexOf("/"));
								System.out.println(j + " = " + image_path);
								path = new File(master_drive_name + ":" + image_path);
								if (path.exists()) {
									String fileList[] = path.list();
									
									try {
										if (fileList != null && fileList.length == 0) {
											FileUtils.deleteDirectory(path);
										} else {
											break;
										}
									} catch (Exception e) {
										// TODO Auto-generated catch block
										StringWriter error = new StringWriter();
										e.printStackTrace(new PrintWriter(error));
										errorMsg = error.toString();
										ErrorLogDto errorLogDto = new ErrorLogDto();
										errorLogDto.setLog_time(
												new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
										errorLogDto.setLog_place(
												"데일리 백업 " + part_drive_name + "드라이브 폴더 완료 후 폴더 삭제 시 오류");
										errorLogDto.setLog_content(errorMsg);
										eventDao.insertErrorLog(errorLogDto);
										backupImageDay(null);
										errorWebsocket(errorLogDto);
									}
								}
							}
						}
					}
				} else {
					String uploadPath = master_drive_name + ":/web_server";

					DBackupDto dBackupDto = new DBackupDto();

					dBackupDto.setImageTime(imageTime);
					dBackupDto.setUntilTime(untilTime);

					List<ImageTableDto> imageTableList2 = eventDao.deleteOverDate(untilTime);
					eventDao.deleteOverDateMonitoring(untilTime);

					if (imageTableList2.size() > 0) {
						String errorMsg = null;
						for (int k = 0; k < imageTableList2.size(); k++) {
							ImageTableDto imageTableDto = imageTableList2.get(k);
							File path = new File(master_drive_name + ":" + imageTableDto.getImage_name());
							if (path.exists()) {
								try {
									FileUtils.deleteDirectory(path);
								} catch (Exception e) {
									// TODO Auto-generated catch block
									StringWriter error = new StringWriter();
									e.printStackTrace(new PrintWriter(error));
									errorMsg = error.toString();
									ErrorLogDto errorLogDto = new ErrorLogDto();
									errorLogDto.setLog_time(
											new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
									errorLogDto.setLog_place("데일리 백업 " + part_drive_name + "드라이브 폴더 삭제 시 오류");
									errorLogDto.setLog_content(errorMsg);
									eventDao.insertErrorLog(errorLogDto);
									backupImageDay(null);
									errorWebsocket(errorLogDto);
								}
							}

							String image_path = imageTableDto.getImage_name();
							image_path = image_path.substring(0, image_path.lastIndexOf("/"));
							String imageList[] = image_path.split("/");
							for (int j = 0; j < 2; j++) {
								image_path = image_path.substring(0, image_path.lastIndexOf("/"));
								System.out.println(j + " = " + image_path);
								path = new File(master_drive_name + ":" + image_path);
								if (path.exists()) {
									String fileList[] = path.list();
									try {
										if (fileList != null && fileList.length == 0) {
											FileUtils.deleteDirectory(path);
										} else {
											break;
										}
									} catch (Exception e) {
										// TODO Auto-generated catch block
										StringWriter error = new StringWriter();
										e.printStackTrace(new PrintWriter(error));
										errorMsg = error.toString();
										ErrorLogDto errorLogDto = new ErrorLogDto();
										errorLogDto.setLog_time(
												new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
										errorLogDto.setLog_place(
												"데일리 백업 " + part_drive_name + "드라이브 폴더 완료 후 폴더 삭제 시 오류");
										errorLogDto.setLog_content(errorMsg);
										eventDao.insertErrorLog(errorLogDto);
										backupImageDay(null);
										errorWebsocket(errorLogDto);
									}
								}
							}
						}
					}

				}
			}
		};

		timerBackup.scheduleAtFixedRate(taskBackup, firstTime, period);
	}

	public void backupWebsocket(BackupLogDto backupLogDto) {
		System.out.println("backupWebsocket()");

		String jsonStr = "";
		ObjectMapper mapper = new ObjectMapper();

		try {
			jsonStr = mapper.writeValueAsString(backupLogDto);
		} catch (Exception e1) {
			System.out.println("오류 발생");
			e1.printStackTrace();
		}

		// 임시 데이터

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/receiveBackupLog", jsonStr);
	}

	public void errorWebsocket(ErrorLogDto errorLogDto) {
		System.out.println("ErrorWebsocket()");

		String jsonStr = "";
		ObjectMapper mapper = new ObjectMapper();

		try {
			jsonStr = mapper.writeValueAsString(errorLogDto);
		} catch (Exception e1) {
			System.out.println("오류 발생");
			e1.printStackTrace();
		}

		// 임시 데이터

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/receiveErrorLog", jsonStr);
	}

	public void getLicenseInfo(String url) {
		int minute = 2;

		StringBuilder sb = new StringBuilder();

		BufferedReader in = null;

		HttpURLConnection con = null;

		try {
			URL req = new URL(url);
			con = (HttpURLConnection) req.openConnection();
			con.setConnectTimeout(minute * 60 * 1000); // 2분
			con.setRequestMethod("GET");
			con.setRequestProperty("Content-Type", "text/html; charset=UTF-8");
			in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String line;
			while ((line = in.readLine()) != null) { // response를 차례대로 출력
				sb.append(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (con != null)
					con.disconnect();
				if (in != null)
					in.close();
			} catch (Exception se) {
			}
		}

		// System.out.println(sb.toString());

		str = sb.toString();

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/renewal_license_date", str);
	}

	public void renewal_license_date() {
		System.out.println("renewal_license_date()");

		long period = 1000 * 60 * 60 * 24;
		// long period = 1000 * 60;

		Calendar calendar = new GregorianCalendar(Locale.KOREA);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		// calendar.set(Calendar.HOUR_OF_DAY, 17);
		calendar.set(Calendar.MINUTE, 0);
		// calendar.set(Calendar.MINUTE, 26);
		calendar.set(Calendar.SECOND, 0);

		Date nowDate = new Date();

		if (nowDate.getTime() >= calendar.getTime().getTime()) {
			calendar.add(Calendar.DATE, 1);
		}

		Date firstTime = new Date(calendar.getTimeInMillis());

		String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(firstTime);

		timerBackup = new Timer();
		taskBackup = new TimerTask() {
			@Override
			public void run() {
				getLicenseInfo(analyze_url.substring(0, analyze_url.lastIndexOf("/")) + "/get_license");
			}
		};
		timerBackup.scheduleAtFixedRate(taskBackup, firstTime, period);
	}

	public void init_drive_name() {
		String drive;
		File[] roots = File.listRoots();

		drive_count = 0;

		for (File root : roots) {
			drive_count++;

			// 루트 드라이버의 절대 경로
			drive = root.getAbsolutePath().substring(0, 1);

			String uploadPath = drive + ":/" + "Program Files/Apache Software Foundation";
			File folder = new File(uploadPath);

			if (folder.exists()) {
				master_drive_name = drive;
				if (part_drive_name != null) {
					break;
				}
			} else {
				part_drive_name = drive;
				if (master_drive_name != null) {
					break;
				}
			}
		}
	}

	@RequestMapping(value = "/saveTestImage", method = RequestMethod.POST)
	public String police_upload(MultipartHttpServletRequest request)
			throws IOException, ParseException, ImageProcessingException {
		System.out.println("saveTestImage()");

		// 폴더 경로 잡아줌
		String uploadPath = "C:/web_server";
		File folder = new File(uploadPath);

		if (!folder.exists()) {
			try {
				folder.mkdir();
				// System.out.println("폴더 생성");
			} catch (Exception e) {
				e.getStackTrace();
			}
		} else {
			// System.out.println("폴더가 이미 존재합니다.");
		}

		uploadPath = "C:/web_server/test";
		folder = new File(uploadPath);
		File[] fileLength = folder.listFiles();

		if (!folder.exists()) {
			try {
				folder.mkdir();
				// System.out.println("폴더 생성");
			} catch (Exception e) {
				e.getStackTrace();
			}
		} else {
			// System.out.println("폴더가 이미 존재합니다.");
		}

		String pattern2 = "yyyy년 MM월 dd일 HH시 mm분 ss초";
		SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);

		String fileName = simpleDateFormat2.format(new Date());

		uploadPath = "C:/web_server/test/" + fileName;
		folder = new File(uploadPath);

		if (!folder.exists()) {
			try {
				folder.mkdir();
				// System.out.println("폴더 생성");
			} catch (Exception e) {
				e.getStackTrace();
			}
		} else {
			// System.out.println("폴더가 이미 존재합니다.");
		}
		// 폴더 경로 잡아줌 끝

		List<MultipartFile> files = null;
		// caseinfo에 login_id, case_num, count 넣어줌
		files = request.getFiles("file");

		for (int i = 0; i < files.size(); i++) {
			// 이미지 파일 1개를 담음
			MultipartFile mf = files.get(i);
			String safeFile = mf.getOriginalFilename();

			/* 지정된 폴더에 원본 이미지 다운 */
			mf.transferTo(new File(uploadPath + "/" + i + ".jpg"));

			/* 썸네일 이미지 만듬 */
			try {
				if (safeFile != null) {
					File f = new File(uploadPath + "/" + i + safeFile.substring(safeFile.lastIndexOf(".")));
					EasyImage easyImage = new EasyImage(f);
					BufferedImage bi = ImageIO.read(f);
					if (!easyImage.isSupportedImageFormat()) {
						System.out.println("not supported image type");
					}

					/* resize */
					// EasyImage resizedImage = easyImage.resize(640, 480);
					EasyImage resizedImage = easyImage.resize(1280, 720);
					FileOutputStream out = new FileOutputStream(uploadPath + "/" + i + "_thumb" + ".jpg");
					resizedImage.writeTo(out, "jpg");
					// easyImage.writeTo(out, "jpg");
					out.close();
					// System.out.println("썸네일 = " + uploadPath + "/" + i + "_thumb" + ".jpg");					
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		return "index";
	}

	public boolean chkDuration(String dev_ip, String dev_ch, String model_name, String event_time)
			throws java.text.ParseException {
		if (durationMap.get(dev_ip + "_" + dev_ch + "_" + model_name) == null) {
			durationMap.put(dev_ip + "_" + dev_ch + "_" + model_name, event_time);
			return true;
		} else {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date now = dateFormat.parse(event_time);
			Date past = dateFormat.parse(durationMap.get(dev_ip + "_" + dev_ch + "_" + model_name).toString());

			int second = 10;

			if (actionSetupService.selectOne(Integer.parseInt(dev_ch)).get("duration") != null) {
				second = Integer
						.parseInt(actionSetupService.selectOne(Integer.parseInt(dev_ch)).get("duration").toString());
			}

//			System.out.println((now.getTime() - past.getTime()) / 1000 + "초 차이 남, 현재 시간 : " + dateFormat.format(now) + ", 과거 시간 : " + dateFormat.format(past));

			if (now.getTime() - past.getTime() > second * 1000) {
				durationMap.put(dev_ip + "_" + dev_ch + "_" + model_name, event_time);
				return true;
			}
		}

		return false;

	}

	public void checkShowPopUp(Map metadata, ArrayList ml_result) throws Exception { // 팝업 보여줄 지 확인하는 로직
//		System.out.println("checkShowPopUp()");

		if (ml_result.size() > 0) {
			boolean isResult = false;

			String class_name = "";
			
			String login_id = metadata.get("user_name").toString(); // 사용자 ID
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
			String img_name = metadata.get("img_name").toString(); // 원본 이미지 파일명으로 받음
			String dev_web_port = metadata.get("dev_web_port").toString();

			for (int i = 0; i < ml_result.size(); i++) {
				Map ml_result_map = (Map) ml_result.get(i);
				if (ml_result_map.get("status").toString().equals("SUCCESS")
						&& Integer.parseInt(ml_result_map.get("count").toString()) > 0) {
					String model_name = ml_result_map.get("model_name").toString();

					String uploadPath = master_drive_name + ":/web_server/" + login_id + "/" + item_name + "/"
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
					map.put("action_source", "지능형안전관리시스템");
					map.put("dev_id", dev_id);
					map.put("dev_pwd", dev_pwd);
					map.put("dev_web_port", dev_web_port);
					map.put("dev_mac_address", dev_mac_address);

					Date date_time = new Date();

//					System.out.println("무시 여부 = " + rejectEventService.chkTime(Integer.parseInt(dev_ch), model_name, date_time));

					if (rejectEventService.chkTime(Integer.parseInt(dev_ch), model_name,
							new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(event_time))) {
//						System.out.println(model_name + " / " + dev_ch);

						eventReject(map);

						if (actionEventRepository.findByEvent(dev_title, model_name) != null) {
							Map actionMap = actionEventRepository.findByEvent(dev_title, model_name);

							String action_action = actionMap.get("action_action").toString();

							if (action_action.contains("팝업")) {
								showPopupImage(map);
							}

							if (action_action.contains("알람")) {
								playAlarm(map);
							}

							if (action_action.contains("프리셋")) {
								goToPreset(map);
							}

						}

					}
				}
			}

			if (isResult) {
			}
		}
	}

	public void eventReject(Map map) throws JsonProcessingException {
		// System.out.println("eventReject");

		Map devInfo = eventDao.deviceInfoOne2(map);

		if (devInfo != null) {
			Map statusMap = new HashMap();
			statusMap.put("action_source", map.get("action_source"));
			statusMap.put("event_action", "무시");
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

	public void showPopupImage(Map map) throws JsonProcessingException { // 팝업을 보여줄 로직, 오버로딩
		// System.out.println("showPopupImage()");

		ObjectMapper mapper = new ObjectMapper();
		String returnStr = mapper.writeValueAsString(map);

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/showPopupImage", returnStr);
	}

	public void playAlarm(Map map) throws JsonProcessingException {
		// System.out.println("playAlarm()");

		ObjectMapper mapper = new ObjectMapper();
		String returnStr = mapper.writeValueAsString(map);

		map.put("action_action", "알람");

		String dev_title = "";
		Map returnMap2 = eventDao.deviceInfoOne2(map);
		if (returnMap2 != null) {
			dev_title = returnMap2.get("dev_title").toString();
		}
		map.put("dev_title", dev_title);
		map.put("isEvent", true);

		Map returnMap = eventDao.selectEventActionByAction(map);

		if (returnMap != null) {
			// 이벤트 액션 설정 체크해야됨

			List<Map> list = eventDao.selectNetworkSpeaker();

			for (int i = 0; i < list.size(); i++) {
				playNetworkSpeaker(returnMap, list.get(i));
			}

			this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
			this.template.convertAndSend("/playAlarm", returnStr);
		}
	}

	public void goToPreset(Map map) throws JsonProcessingException {
		// System.out.println("goToPreset()");

		map.put("action_action", "프리셋");

		String dev_title = "";
		Map returnMap2 = eventDao.deviceInfoOne2(map);
		if (returnMap2 != null) {
			dev_title = returnMap2.get("dev_title").toString();
		}

		map.put("dev_title", dev_title);
		map.put("isEvent", true);

		Map return_map = eventDao.selectEventActionByAction(map);

		if (return_map != null) {
			// 이벤트 액션 설정 체크해야됨
			Map statusMap = new HashMap();
			statusMap.put("action_source", map.get("action_source"));
			statusMap.put("event_action", "프리셋");
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

	public void sendScada(Map responseMap) throws JsonProcessingException {
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

	public void sendWebsocket(Map responseMap) throws Exception {
		// System.out.println("sendWebsocket()");

		Map metadata = (Map) responseMap.get("metadata");

		ArrayList ml_result = (ArrayList) responseMap.get("ml_result");

		if (ml_result.size() > 0) {
			boolean isResult = false;

			String class_name = "";

			String ip = metadata.get("dev_ip").toString();
			int port = Integer.parseInt(metadata.get("dev_port").toString());
			int ch = Integer.parseInt(metadata.get("dev_ch").toString());
			List list = new ArrayList();
			String event_time = metadata.get("event_time").toString();
			String scada = "SUCCESS";

			String login_id = metadata.get("user_name").toString(); // 사용자 ID
			String dev_ch = metadata.get("dev_ch").toString();

			String dev_title = "";
			Map return_map = eventDao.deviceInfoOne2(metadata);
			if (return_map != null) {
				dev_title = return_map.get("dev_title").toString();
			}
			metadata.put("dev_title", dev_title);

			String item_name = metadata.get("item_name").toString();
			String img_name = metadata.get("img_name").toString(); // 원본 이미지 파일명으로 받음

			List<Map> result_list = new ArrayList<Map>();

			for (int i = 0; i < ml_result.size(); i++) {
				Map ml_result_map = (Map) ml_result.get(i);
				
				boolean isTrue1 = ml_result_map.get("status").toString().equals("SUCCESS");
				boolean isTrue2 = Integer.parseInt(ml_result_map.get("count").toString()) > 0;

//				System.out.println("sendWebsocket method isTrue1 = " + isTrue1);
//				System.out.println("sendWebsocket method isTrue2 = " + isTrue2);
				
				if (isTrue1 && isTrue2) {
					result_list.add(ml_result_map);
					String model_name = ml_result_map.get("model_name").toString();

					Date date_time = new Date();
					
					boolean isTrue3 = rejectEventService.chkTime(Integer.parseInt(dev_ch), model_name,
							new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(event_time));

//					System.out.println("sendWebsocket method isTrue3 = " + isTrue3);
					
					if (!isTrue3) {
						return;
					}

					metadata.put("model_name", model_name);
					metadata.put("action_action", "SMS(SCADA)");
					metadata.put("action_source", "지능형안전관리시스템");
					metadata.put("isEvent", true);

					Map returnMap = eventDao.selectEventActionByAction(metadata);

					boolean isTrue4 = actionEventRepository.findByEvent(dev_title, model_name) != null;

//					System.out.println("sendWebsocket method isTrue4 = " + isTrue4);
					
					if (isTrue4) {
						Map actionMap = actionEventRepository.findByEvent(dev_title, model_name);

						String action_action = actionMap.get("action_action").toString();

						boolean isTrue5 = returnMap != null && action_action.indexOf("SMS(SCADA)") != -1;

//						System.out.println("sendWebsocket method isTrue5 = " + isTrue5);
						
						if (isTrue5) {
							isResult = true;
						}
					}

					list.add(model_name);
				}
			}
			
//			System.out.println("sendWebsocket method isResult = " + isResult);

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
	}

	public void sendMonitor(Map map) throws MessagingException, JsonProcessingException {
		// System.out.println("sendMonitor");

		this.template.setMessageConverter((MessageConverter) new StringMessageConverter());
		this.template.convertAndSend("/showBase64", new ObjectMapper().writeValueAsString(map));

		String uploadPath = "D:/base64 이미지 테스트/";
		File folder = new File(uploadPath);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		String data = map.get("img_data").toString();
		String event_time = map.get("event_time").toString();
		String img_name = event_time.split(" ")[0].replaceAll("-", "") + "_"
				+ event_time.split(" ")[1].replaceAll(":", "") + ".jpg";

		byte[] imageBytes = DatatypeConverter.parseBase64Binary(data);

		try {
			File lOutFile = new File(uploadPath + img_name);

			FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);

			lFileOutputStream.write(imageBytes);

			lFileOutputStream.close();

		} catch (Exception e) {
			// e.printStackTrace();
			// System.out.println("sendMonitor 이미지 저장 안됨 = " + img_name);
		}
	}

	@PostMapping("/testTokken")
	@ResponseBody
	public String testTokken(@RequestBody Map map) {
		String requestURL = map.get("request_url").toString();

		String result = "";

		try {
			HttpClient client1 = HttpClientBuilder.create().build(); // HttpClient 생성

			HttpPost postRequest1 = new HttpPost(requestURL); // POST 메소드 URL 새성

			postRequest1.setHeader("Authorization", map.get("tokken").toString());
			postRequest1.setHeader("host", map.get("host").toString());
			postRequest1.setHeader("Content-Type", map.get("content-Type").toString());

			HttpResponse response1 = client1.execute(postRequest1);

			// Response 출력
			if (response1.getStatusLine().getStatusCode() == 200) {
				ResponseHandler<String> handler = new BasicResponseHandler();
				String body = handler.handleResponse(response1);
				// System.out.println("response = " + body);
				result = body;
			} else {
				result = "response is error : " + response1;
				// System.out.println("response is error : " +
				// response1.getStatusLine().getStatusCode());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
}
