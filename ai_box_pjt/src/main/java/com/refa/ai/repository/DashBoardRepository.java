package com.refa.ai.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.refa.ai.dto.CountDto;
import com.refa.ai.dto.dashboard.EventCountDto;
import com.refa.ai.dto.dashboard.EventCountTimeDto;
import com.refa.ai.dto.dashboard.ReportDeviceChAndTitle;
import com.refa.ai.dto.dashboard.StartEndDate;
import com.refa.ai.dto.reporting.ReportingDto;
import com.refa.ai.dto.reporting.ReportingExistEventNameDto;
import com.refa.ai.dto.reporting.ReportingOptionDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DashBoardRepository {

	private final SqlSessionTemplate sqlSessionTemplate;

	public List<Map> getDashBoard(Map map) {
		return sqlSessionTemplate.selectList("dashBoard.getDashBoard", map);
	}

	public List<CountDto> mainCount() {
		return sqlSessionTemplate.selectList("dashBoard.mainCount");
	}

	public List<EventCountDto> selectBetweenDateCount(StartEndDate startEndDate) {
		return sqlSessionTemplate.selectList("dashBoard.selectBetweenDateCount", startEndDate);
	}

	public List<EventCountTimeDto> selectBetweenDateEventCount(StartEndDate startEndDate) {
		return sqlSessionTemplate.selectList("dashBoard.selectBetweenDateEventCount", startEndDate);
	}

	public List<ReportingDto> selectReportingData(ReportingOptionDto reportingOptionDto) {
		return sqlSessionTemplate.selectList("dashBoard.selectReportingData", reportingOptionDto);
	}

	public List<ReportingExistEventNameDto> selectExistEventName() {
		return sqlSessionTemplate.selectList("dashBoard.selectExistEventName");
	}
	
	public List<ReportDeviceChAndTitle> selectDeviceChAndTitle() {
		return sqlSessionTemplate.selectList("dashBoard.selectDeviceChAndTitle");
	}
}
