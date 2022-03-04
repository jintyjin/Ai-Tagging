package com.refa.ai.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ActionEventRepository {
	
	private final SqlSessionTemplate sqlSessionTemplate;

	public List<Map> findByIsuse() {
		return sqlSessionTemplate.selectList("action.actionInfoIsuse");
	}
	
	

}
