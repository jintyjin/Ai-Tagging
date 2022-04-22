package com.refa.ai.dto.reporting;

import java.util.List;

import com.refa.ai.dto.dashboard.ReportDeviceChAndTitle;

import lombok.Data;

@Data
public class ReportingMenuDataDto {
	
	private List<ReportDeviceChAndTitle> reportDeviceChAndTitleList;
	private List<ReportingExistEventNameDto> reportingExistEventNameDtoList;
	
	public ReportingMenuDataDto(List<ReportDeviceChAndTitle> reportDeviceChAndTitleList, List<ReportingExistEventNameDto> reportingExistEventNameDtoList) {
		this.reportDeviceChAndTitleList = reportDeviceChAndTitleList;
		this.reportingExistEventNameDtoList = reportingExistEventNameDtoList;
	}
}
