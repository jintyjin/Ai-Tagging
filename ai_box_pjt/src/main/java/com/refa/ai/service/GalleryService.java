package com.refa.ai.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.refa.ai.dto.gallery.AlbumDto;
import com.refa.ai.dto.gallery.GalleryDeviceDto;
import com.refa.ai.dto.gallery.GalleryMonitoringDto;
import com.refa.ai.dto.gallery.SearchDto;
import com.refa.ai.dto.gallery.SearchOptDto;
import com.refa.ai.repository.GalleryRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class GalleryService {

	private final GalleryRepository galleryRepository;
	
	public List<GalleryMonitoringDto> getGroupImage(String keyword) {
		return galleryRepository.selectGalleryMonitoring(keyword);
	}
	
	public GalleryDeviceDto getGalleryDevice(int imageIdx) {
		return galleryRepository.selectGalleryDevice(imageIdx);
	}
	
	public List<SearchDto> clickPlus(SearchOptDto searchOptDto) {
		return galleryRepository.selectClickPlus(searchOptDto);
	}
	public List<SearchDto> searchImage(SearchOptDto searchOptDto) {
		return galleryRepository.selectSearchImage(searchOptDto);
	}
	
	public List<AlbumDto> getAlbum() {
		return galleryRepository.selectAlbumData();
	}
}
