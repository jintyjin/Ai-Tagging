package com.refa.ai.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.refa.ai.dto.VersionDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class VersionRepository {
	
	private final SqlSessionTemplate sqlSession;

	public VersionDto selectVersionInfo(String version_name) {
		return sqlSession.selectOne("version.selectVersionInfo", version_name);
	}
	

}
