package com.refa.ai.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.refa.ai.dto.device.DeviceIdxPwdDto;
import com.refa.ai.entity.Device;
import com.refa.ai.infra.AES256Util;
import com.refa.ai.repository.DeviceRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DeviceService {

	private final DeviceRepository deviceRepository;
	private final AES256Util aes256Util;

	public List<Device> findAll() {
		List<Device> devices = deviceRepository.findAll();
		
		return devices;
	}
	
	public int getDeviceCount(Map map) {
		return deviceRepository.selectDeviceCount(map);
	}
	
	public void updatePwd() {
		List<Device> devices = findAll();
		devices.stream().forEach(d -> {
			DeviceIdxPwdDto deviceIdxPwdDto = new DeviceIdxPwdDto();
			deviceIdxPwdDto.setDev_idx(d.getDev_idx());
			
			String dev_pwd = d.getDev_pwd();
			String result = aes256Util.encryptAES(dev_pwd, false);
			
			deviceIdxPwdDto.setDev_pwd(result);
			
			deviceRepository.updatePwdByIdx(deviceIdxPwdDto);
		});
	}
}
