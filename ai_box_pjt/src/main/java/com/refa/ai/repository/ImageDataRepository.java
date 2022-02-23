package com.refa.ai.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.refa.ai.dto.ImageTableDto;
import com.refa.ai.dto.RequestScadaDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
@Transactional
public class ImageDataRepository {

	private final SqlSessionTemplate sqlSession;
	
	public void save(ImageTableDto imageTableDto) {
		sqlSession.insert("sql.insertImageEvent", imageTableDto);
	}
	
	public ImageTableDto findByChAndTime(RequestScadaDto requestScadaDto) {
		return sqlSession.selectOne("sql.selectByChAndTime", requestScadaDto);
	}
	
	public void updateScadaWidthAndHeight(ImageTableDto imageTableDto) {
		sqlSession.update("updateScadaWidthAndHeight", imageTableDto);
	}
}
