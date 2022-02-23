package com.refa.ai.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.refa.ai.dto.ImageTableDto;
import com.refa.ai.dto.MetadataDto;
import com.refa.ai.dto.MlResultDto;
import com.refa.ai.dto.MonitoringDto;
import com.refa.ai.dto.ResponseEventDto;
import com.refa.ai.infra.EasyImage;
import com.refa.ai.repository.ImageDataRepository;
import com.refa.ai.repository.MonitoringRepository;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class ImageDataService {
	
	private final ActionSetupService actionSetupService;
	private final DurationService durationService;
	private final ImageService imageService;
	private final ImageDataRepository imageDataRepository;
	
	public void saveImageAndMonitoring(ResponseEventDto responseEventDto, String master_drive_name) throws NumberFormatException, ParseException, IOException {
		MetadataDto metadata = responseEventDto.getMetadata();
		
		List<MlResultDto> ml_result = responseEventDto.getMl_result();
		
		if (ml_result != null && ml_result.size() > 0) {
			Map actionEvent = actionSetupService.selectOne(Integer.parseInt(metadata.getDev_ch()));

			boolean isExist = false;
			
			String class_name = "";
			List<String> originalTags = new ArrayList<String>();
			List<String> colorTags = new ArrayList<String>();
			
			for (MlResultDto m : ml_result) {
				if (m.getStatus().equals("SUCCESS") && m.getCount() > 0) {
					class_name += m.getModel_name() + 1;
					
					if (actionEvent != null && durationService.chkDuration(metadata, m) && (
							actionEvent.get("confidence") == null|| Integer.parseInt(actionEvent.get("confidence").toString()) == 1 || durationService.boxesOrSegments(m, Integer.parseInt(actionEvent.get("confidence").toString()))
							)) {
						isExist = true;
						originalTags.add(m.getModel_name());
					}
				}
			}
			
			if (isExist) {
				String ch = metadata.getDev_ch();
				String imgName = metadata.getImg_name();
				String loginId = metadata.getUser_name();
				String userPwd = metadata.getUser_passwd();
				String itemName = metadata.getItem_name();
				String base64 = responseEventDto.getBase64();
				String eventTime = metadata.getEvent_time();
				String monitoring_tag = itemName + "_ch" + ch + "_" + eventTime.split(" ")[0].replaceAll("-", "") + "_" + class_name;
				Long start = metadata.getStart();
				String devIp = metadata.getDev_ip();
				String devId = metadata.getDev_id();
				String devPwd = metadata.getDev_pwd();
				String port = metadata.getDev_port();
				String webport = metadata.getDev_web_port();

				String path = imageService.makeFolder(master_drive_name, loginId, itemName, eventTime);
				imageService.saveImage(path, imgName, base64);
				
				File f = new File(path);
				BufferedImage bi = ImageIO.read(f);

				int hWidth = bi.getWidth();
				int hHeight = bi.getHeight();
				
				ImageTableDto imageTableDto = new ImageTableDto();
				imageTableDto.setLogin_id(loginId);
				imageTableDto.setDev_ch(ch);
				imageTableDto.setDev_pwd(devPwd);
				imageTableDto.setStart_time(start);
				imageTableDto.setItem_name(itemName);
				imageTableDto.setDev_ip(devIp);
				imageTableDto.setDev_port(port);
				imageTableDto.setEvent_time(eventTime);
				imageTableDto.setDev_id(devId);
				imageTableDto.setDev_web_port(webport);
				imageTableDto.setImage_name(path.substring(path.indexOf("/")));
				imageTableDto.setMonitoring_tag(monitoring_tag);
				imageTableDto.setUser_name(loginId);
				imageTableDto.setUser_passwd(userPwd);

				imageTableDto.setImage_queue(0);
				imageTableDto.setThumb_name(path.substring(path.indexOf("/"), path.lastIndexOf(".")) + "_thumb.jpg");
				imageTableDto.setWidth(hWidth);
				imageTableDto.setHeight(hHeight);
				imageTableDto.setColor_tags(colorTags.toString());
				imageTableDto.setTags(originalTags.toString().replaceAll("\\\\", ""));
				
				imageDataRepository.save(imageTableDto);
				
			}
		}
	}
	
	

}
