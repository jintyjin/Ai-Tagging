package com.refa.ai.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.refa.ai.dto.dashboard.StartEndDate;
import com.refa.ai.dto.reporting.ReportingDto;
import com.refa.ai.dto.reporting.ReportingOptionDto;
import com.refa.ai.dto.reporting.ReportingPageDto;
import com.refa.ai.repository.DashBoardRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DashBoardService {

	private final DashBoardRepository dashBoardRepository;

	public List<Map> getDashBoard(Map map) {
		if (map.get("event") != null) {
			map.put("event", map.get("event").toString().split(","));
		}

		if (map.get("device") != null) {
			map.put("device", map.get("device").toString().split(","));
		}

		return dashBoardRepository.getDashBoard(map);
	}

	public List<Object> getStatisticsData(StartEndDate startEndDate) {
		
		List<Object> totalList = new ArrayList<Object>();
		totalList.add(dashBoardRepository.selectBetweenDateCount(startEndDate));
		totalList.add(dashBoardRepository.selectBetweenDateEventCount(startEndDate));
		
		return totalList;
	}

	public List<List<ReportingDto>> getReportingData(ReportingPageDto reportingPageDto) {
		List<ReportingDto> list = dashBoardRepository.selectReportingData(new ReportingOptionDto(reportingPageDto));
		Map<Integer, List<ReportingDto>> map = new HashMap<>();
		for (ReportingDto reportingDto : list) {
			if (map.get(reportingDto.getCh()) == null) {
				map.put(reportingDto.getCh(), new ArrayList<ReportingDto>());
			}
			map.get(reportingDto.getCh()).add(reportingDto);
		}
		return new ArrayList<List<ReportingDto>>(map.values());
	}
}
