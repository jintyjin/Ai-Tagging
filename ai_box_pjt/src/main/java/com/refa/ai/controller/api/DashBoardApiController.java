package com.refa.ai.controller.api;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.refa.ai.dto.CountDto;
import com.refa.ai.dto.dashboard.StartEndDate;
import com.refa.ai.repository.DashBoardRepository;
import com.refa.ai.service.DashBoardService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class DashBoardApiController {
	
	private final DashBoardService dashBoardService;
	private final DashBoardRepository dashBoardRepository;

	// service, repository 포함 수정해야됨 -> 추후
	@PostMapping("/getDashBoard")
	public List<Map> getDashBoard(@RequestBody Map map) {
		List<Map> returnMap = dashBoardService.getDashBoard(map);

		return returnMap;
	}

	@PostMapping(value = "/mainCount")
	public List<CountDto> mainCount(@RequestBody Map map) {
		return dashBoardRepository.mainCount();
	}
	
	@PostMapping("/dashboard")
	public List<Object> dashboard(@RequestBody StartEndDate startEndDate) {
		return dashBoardService.getStatisticsData(startEndDate);
	}
}
