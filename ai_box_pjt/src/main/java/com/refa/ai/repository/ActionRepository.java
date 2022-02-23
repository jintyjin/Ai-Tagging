package com.refa.ai.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.refa.ai.dto.CmdDto;
import com.refa.ai.dto.MetadataDto;
import com.refa.ai.dto.action.ActionDeviceDto;
import com.refa.ai.dto.action.EventInfoDto;
import com.refa.ai.dto.device.DeviceCmdDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ActionRepository {

	private final SqlSessionTemplate sqlSessionTemplate;

	public List<ActionDeviceDto> selectActionDeviceDto() {
		return sqlSessionTemplate.selectList("action.selectActionDeviceDto");
	}
}
