package com.refa.ai.controller.api;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.refa.ai.dto.CountDto;
import com.refa.ai.dto.dashboard.ReportDeviceChAndTitle;
import com.refa.ai.dto.dashboard.StartEndDate;
import com.refa.ai.dto.reporting.ReportingDto;
import com.refa.ai.dto.reporting.ReportingMenuDataDto;
import com.refa.ai.dto.reporting.ReportingOptionDto;
import com.refa.ai.dto.reporting.ReportingPageDto;
import com.refa.ai.repository.DashBoardRepository;
import com.refa.ai.service.DashBoardService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class DashBoardApiController {
	
	private final DashBoardService dashBoardService;
	private final DashBoardRepository dashBoardRepository;

	// service, repository ���� �����ؾߵ� -> ����
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

	@PostMapping("/reportingData")
	public ReportingMenuDataDto reportingData(@RequestBody ReportingPageDto reportingPageDto) {
		return new ReportingMenuDataDto(dashBoardRepository.selectDeviceChAndTitle(), dashBoardRepository.selectExistEventName());
	}
	
	@PostMapping("/reporting")
	public List<List<ReportingDto>> reporting(@RequestBody ReportingPageDto reportingPageDto) {
		return dashBoardService.getReportingData(reportingPageDto);
	}
}
