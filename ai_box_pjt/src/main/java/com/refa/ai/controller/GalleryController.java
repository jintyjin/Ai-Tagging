package com.refa.ai.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.refa.ai.dto.gallery.GalleryDeviceDto;
import com.refa.ai.service.GalleryService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class GalleryController {

	private final GalleryService galleryService;

	@GetMapping("/album")
	public String album(Model model, String keyword) {
		if (keyword == null) {
			keyword = "";
		}
		
		model.addAttribute("keyword", keyword);
		
		return "./gallery/album";
	}

	@GetMapping("/tagImage")
	public String tagImage(Model model, String event_name, String scroll, String event_time) {
		model.addAttribute("event_name", event_name);
		model.addAttribute("scroll", scroll);
		model.addAttribute("event_time", event_time);

		return "./gallery/tagImage";
	}

	@GetMapping(value = "/originalGalleryImageOne")
	public String showImageInfo2(Model model, int imageIdx) {
		GalleryDeviceDto gdd = galleryService.getGalleryDevice(imageIdx);

		model.addAttribute("monitor_size", gdd.getWidth() + "-" + gdd.getHeight());
		model.addAttribute("monitor_src", gdd.getThumb_name());
		model.addAttribute("event_time", gdd.getEvent_time());
		model.addAttribute("dev_title", gdd.getDev_title());
		model.addAttribute("tags", gdd.getTags());		

		return "./gallery/image2";
	}

	@GetMapping("/searchBar")
	public String searchBar(Model model, String keyword, String status, Long image_idx) {
		model.addAttribute("keyword", keyword);
		model.addAttribute("status", status);
		model.addAttribute("image_idx", image_idx);

		return "./gallery/searchBar";
	}
}
