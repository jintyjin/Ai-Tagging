package com.refa.ai.dto.reporting;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ReportingOptionDto {

	private String startDate;
	private String endDate;
	private String eventName;
	private List<Integer> chList = new ArrayList<>();
	private int type;
	
	
	public ReportingOptionDto(ReportingPageDto reportingPageDto) {
		this.startDate = reportingPageDto.getStartDate();
		this.endDate = reportingPageDto.getEndDate();
		this.eventName = reportingPageDto.getEventName();
		for (int i = 0; i < reportingPageDto.getCh().split(",").length; i++) {
			chList.add(Integer.parseInt(reportingPageDto.getCh().split(",")[i]));
		}
		if (reportingPageDto.getType().equals("time")) {
			this.type = 13;
		} else {
			this.type = 10;
		}
	}
}
