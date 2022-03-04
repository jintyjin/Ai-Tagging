package com.refa.ai.repository;

import java.io.File;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Repository;

import com.refa.ai.dto.VersionDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class VersionMemoryRepository {
	
	private final VersionRepository versionRepository;
	private final String VERSION_NAME = "kwater";
	
	private static VersionDto versionDto = new VersionDto();
	private static String masterDriveName;
	private static String partDriveName;
	private static Integer driveCount;
	
	@PostConstruct
	public void findByName() {
		versionDto = versionRepository.selectVersionInfo(VERSION_NAME);
		initDriveName();
	}
	
	public VersionDto findVersion() {
		return versionDto;
	}
	
	public String findMasterDriveName() {
		return masterDriveName;
	}
	
	public String findPartDriveName() {
		return partDriveName;
	}


	public void initDriveName() {
		String drive;
		File[] roots = File.listRoots();

		driveCount = 0;

		for (File root : roots) {
			driveCount++;

			// 루트 드라이버의 절대 경로
			drive = root.getAbsolutePath().substring(0, 1);

			String uploadPath = drive + ":/" + "Program Files/Apache Software Foundation";
			File folder = new File(uploadPath);

			if (folder.exists()) {
				masterDriveName = drive;
				if (partDriveName != null) {
					break;
				}
			} else {
				partDriveName = drive;
				if (masterDriveName != null) {
					break;
				}
			}
		}
	}

}
