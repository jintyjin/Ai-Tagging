package com.refa.ai.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.refa.ai.dto.MonitoringDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
@Transactional
public class MonitoringRepository {

	private final SqlSessionTemplate sqlSession;
	
	public void saveOrUpdate(MonitoringDto monitoringDto) {
		sqlSession.insert("sql.updateMonitoring", monitoringDto);
	}

}
