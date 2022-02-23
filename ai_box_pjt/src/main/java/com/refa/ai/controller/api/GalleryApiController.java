package com.refa.ai.controller.api;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.json.simple.parser.ParseException;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.refa.ai.dao.EventDao;
import com.refa.ai.dto.CategoryDto;
import com.refa.ai.dto.gallery.AlbumDto;
import com.refa.ai.dto.gallery.GalleryDeviceDto;
import com.refa.ai.dto.gallery.GalleryMonitoringDto;
import com.refa.ai.dto.gallery.SearchDto;
import com.refa.ai.dto.gallery.SearchOptDto;
import com.refa.ai.service.GalleryService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class GalleryApiController {

	private final GalleryService galleryService;
	private final EventDao eventDao;

	@PostMapping(value = "/albumInfo")
	public List<AlbumDto> albumInfo() throws ParseException {
		return galleryService.getAlbum();
	}

	@PostMapping(value = "/tagImageInfo")
	public List<GalleryMonitoringDto> tagImageInfo(@RequestBody String tags) {
		return galleryService.getGroupImage(tags);
	}

	@PostMapping(value = "/showRightInfo")
	public GalleryDeviceDto showRightInfo(@RequestBody int imageIdx) throws IOException {
		return galleryService.getGalleryDevice(imageIdx);
	}

	@PostMapping("/searchImage")
	public List<SearchDto> searchImage(@RequestBody SearchOptDto searchOptDto) {
		if (searchOptDto.getStatus().equals("plus")) {
			return galleryService.clickPlus(searchOptDto);
		} else {
			return galleryService.searchImage(searchOptDto);
		}

	}

}






