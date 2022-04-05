package com.refa.ai.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.refa.ai.dto.action.ActionDeviceDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ActionRepository {

	private final SqlSessionTemplate sqlSessionTemplate;

	public List<ActionDeviceDto> selectActionDeviceDto() {
		return sqlSessionTemplate.selectList("action.selectActionDeviceDto");
	}
}
