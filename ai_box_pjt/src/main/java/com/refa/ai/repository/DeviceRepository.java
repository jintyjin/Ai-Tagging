package com.refa.ai.repository;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.refa.ai.dto.device.DeviceIdxPwdDto;
import com.refa.ai.entity.Device;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DeviceRepository {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	public Device save(Device device) {
		sqlSessionTemplate.insert("device.save", device);
		return device;
	}
	
	public Optional<Device> findByTitle(String devTitle) {
		return Optional.ofNullable(sqlSessionTemplate.selectOne("device.findByTitle", devTitle));
	}

	public Optional<Device> findByCh(int devCh) {
		return Optional.ofNullable(sqlSessionTemplate.selectOne("device.findByCh", devCh));
	}
	
	public List<Device> findAll() {
		return sqlSessionTemplate.selectList("device.findAll");
	}

	public int selectDeviceCount(Map map) {
		return sqlSessionTemplate.selectOne("device.selectDeviceCount", map);
	}
	
	public void updatePwdByIdx(DeviceIdxPwdDto deviceIdxPwdDto) {
		sqlSessionTemplate.update("device.updatePwdByIdx", deviceIdxPwdDto);
	}
	
}
