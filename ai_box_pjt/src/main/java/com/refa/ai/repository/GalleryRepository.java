package com.refa.ai.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.refa.ai.dto.gallery.AlbumDto;
import com.refa.ai.dto.gallery.GalleryDeviceDto;
import com.refa.ai.dto.gallery.GalleryMonitoringDto;
import com.refa.ai.dto.gallery.SearchDto;
import com.refa.ai.dto.gallery.SearchOptDto;
import com.refa.ai.entity.Gallery;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class GalleryRepository {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	public List<Gallery> findAll() {
		return sqlSessionTemplate.selectList("gallery.findAll");
	}
	
	public List<GalleryMonitoringDto> selectGalleryMonitoring(String keyword) {
		return sqlSessionTemplate.selectList("gallery.selectGalleryMonitoring", keyword);
	}
	
	public GalleryDeviceDto selectGalleryDevice(int imageIdx) {
		return sqlSessionTemplate.selectOne("gallery.selectGalleryDevice", imageIdx);
	}
	
	// �˻� ���� ����
	public List<SearchDto> selectClickPlus(SearchOptDto searchOptDto) {
		return sqlSessionTemplate.selectList("gallery.selectClickPlus", searchOptDto);
	}
	public List<SearchDto> selectSearchImage(SearchOptDto searchOptDto) {
		return sqlSessionTemplate.selectList("gallery.searchImage", searchOptDto);
	}
	// �˻� ���� ����
	
	// �ٿ�ε� ���� ����
	public List<Map> selectDownloadImages(List idxList) {
		return sqlSessionTemplate.selectList("gallery.selectDownloadImages", idxList);
	}
	public List<Map> selectDownloadGroupImages(Map map) {
		return sqlSessionTemplate.selectList("gallery.selectDownloadGroupImages", map);
	}
	// �ٿ�ε� ���� ����
	
	// �ٹ� ���� ����
	
	public List<AlbumDto> selectAlbumData() {
		return sqlSessionTemplate.selectList("gallery.selectAlbumData");
	}
	
	// �ٹ� ���� ����
	
}
