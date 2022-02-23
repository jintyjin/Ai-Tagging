package com.refa.ai.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.refa.ai.dto.MetadataDto;
import com.refa.ai.dto.MlResultDto;
import com.refa.ai.dto.MonitoringDto;
import com.refa.ai.dto.ResponseEventDto;
import com.refa.ai.repository.MonitoringRepository;

import lombok.RequiredArgsConstructor;

@Service
@Transactional
@RequiredArgsConstructor
public class MonitoringService {

	private final ActionSetupService actionSetupService;
	private final MonitoringRepository monitoringRepository;
	private final DurationService durationService;
	private final ImageService imageService;
	
	public void saveMonitoring(ResponseEventDto responseEventDto, String master_drive_name) throws NumberFormatException, ParseException {
		MetadataDto metadata = responseEventDto.getMetadata();
		
		List<MlResultDto> ml_result = responseEventDto.getMl_result();
		
		if (ml_result != null && ml_result.size() > 0) {
			Map actionEvent = actionSetupService.selectOne(Integer.parseInt(metadata.getDev_ch()));

			boolean isExist = false;
			String class_name = "";
			String monitoring_info = "";
			
			for (MlResultDto m : ml_result) {
				if (m.getStatus().equals("SUCCESS") && m.getCount() > 0) {
					isExist = true;
					class_name += m.getModel_name() + 1;
					monitoring_info += "/" + m.getModel_name() + ":" + 1;
					
					if (actionEvent != null && durationService.chkDuration(metadata, m) && (
							actionEvent.get("confidence") == null|| Integer.parseInt(actionEvent.get("confidence").toString()) == 1 || durationService.boxesOrSegments(m, Integer.parseInt(actionEvent.get("confidence").toString()))
							)) {
						isExist = true;
					}
				}
			}
			
			if (isExist) {
				String ch = metadata.getDev_ch();
				String loginId = metadata.getUser_name();
				String itemName = metadata.getItem_name();
				String eventTime = metadata.getEvent_time();
				String imgName = metadata.getImg_name();
				String thumbName = imgName.substring(0, imgName.lastIndexOf("."));
				String base64 = responseEventDto.getBase64();
				String monitoring_tag = itemName + "_ch" + ch + "_" + eventTime.split(" ")[0].replaceAll("-", "") + "_" + class_name;
				
				String path = imageService.makeFolder(master_drive_name, loginId, itemName, eventTime);
				
				String imageSize = imageService.saveThumbImage(path, thumbName, base64);

				saveData(monitoring_info, ch, loginId, itemName, eventTime, thumbName, monitoring_tag, imageSize);				
				
			}
		}
	}

	private void saveData(String monitoring_info, String ch, String loginId, String itemName, String eventTime,
			String thumbName, String monitoring_tag, String imageSize) {
		
		MonitoringDto monitoringDto = new MonitoringDto();
		monitoringDto.setMonitoring_src(thumbName.substring(thumbName.indexOf("/")));
		monitoringDto.setMonitoring_time(eventTime);
		monitoringDto.setMonitoring_item(itemName);
		monitoringDto.setMonitoring_ch(ch);
		monitoringDto.setMonitoring_tag(monitoring_tag);
		monitoringDto.setMonitoring_info(monitoring_info.substring(1));
		monitoringDto.setLogin_id(loginId);
		monitoringDto.setMonitoring_size(imageSize);

		monitoringRepository.saveOrUpdate(monitoringDto);
	}
}
