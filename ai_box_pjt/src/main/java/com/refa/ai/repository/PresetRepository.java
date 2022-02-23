package com.refa.ai.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.refa.ai.entity.Preset;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PresetRepository {
	
	private final SqlSessionTemplate sqlSessionTemplate;
	
	public List<Preset> findByCh(int dev_ch) {
		return sqlSessionTemplate.selectList("preset.findByCh", dev_ch);
	}

	public void updatePresetTitleUseAll(Map map) {
		sqlSessionTemplate.update("preset.updatePresetTitleUseAll", map);
	}
	
	public void updatePresetIsUseAll(Map map) {
		sqlSessionTemplate.update("preset.updatePresetIsUseAll", map);
	}
}
