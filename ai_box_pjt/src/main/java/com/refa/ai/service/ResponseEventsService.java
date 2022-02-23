package com.refa.ai.service;

import java.text.ParseException;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Optional;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.refa.ai.dto.MetadataDto;
import com.refa.ai.dto.OneSecDurDto;
import com.refa.ai.dto.ResponseEventDto;
import com.refa.ai.repository.ResponseEventsRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ResponseEventsService {
	
	private final ResponseEventsRepository responseEventsRepository;
	private final OneSecDurService oneSecDurService;
	
	public Map addQueue(ResponseEventDto responseEventDto) throws ParseException {
		MetadataDto metadata = responseEventDto.getMetadata();

		OneSecDurDto oneSecDurDto = new OneSecDurDto();
		oneSecDurDto.setDev_ch(Integer.parseInt(metadata.getDev_ch()));
		oneSecDurDto.setEvent_time(metadata.getEvent_time());

		Map returnMap = new LinkedHashMap();

		if (oneSecDurService.join(oneSecDurDto)) {
			try {
				returnMap.put("status", "ok");
				returnMap.put("queue", responseEventsRepository.insertQueue(responseEventDto));
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			returnMap.put("status", "failed");
			returnMap.put("detail", "please one second over");
		}

		return returnMap;
	}

//	@PostConstruct
//	public void startThread() {
//		new Thread(new ServiceRunnable(responseEventsRepository)).start();
//	}
//	
//	@RequiredArgsConstructor
//	static class ServiceRunnable implements Runnable {
//		private final ResponseEventsRepository responseEventsRepository;
//		
//		@Override
//		public void run() {
//			while (true) {
//				ResponseEventDto responseEventDto = responseEventsRepository.takeOne();
//				System.out.println(responseEventDto);
//			}
//		}
//	}


}
