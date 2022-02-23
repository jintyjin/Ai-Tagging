package com.refa.ai.controller.api;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.refa.ai.dto.DiskSizeDto;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class SetupApiController {

	@RequestMapping(value = "/sizeData")
	public List<DiskSizeDto> sizeData(@RequestBody Map<String, Object> login) {
		// System.out.println("sizeData()");

		String drive;
		double totalSpace, usedSpace, freeSpace, usableSpace; // 하드디스크의 루트 드라이버들을 배열로 반환한다.
		File[] roots = File.listRoots();

		List<DiskSizeDto> diskSizeList = new ArrayList<DiskSizeDto>();
		DiskSizeDto diskSizeDto;

		int n = 2;
		double n2 = Math.pow(10.0, n);

		for (File root : roots) {
			diskSizeDto = new DiskSizeDto();
			// 루트 드라이버의 절대 경로
			drive = root.getAbsolutePath().substring(0, 1);

			String uploadPath = drive + ":/" + "Program Files/";
			File folder = new File(uploadPath);

			if (folder.exists()) {
//				master_drive_name = drive;
				// 하드디스크 전체 용량
				totalSpace = Math.round(root.getTotalSpace() / Math.pow(1024, 3) * n2) / n2;
				// 사용가능한 디스크 용량
				usableSpace = Math.round(root.getUsableSpace() / Math.pow(1024, 3) * n2) / n2;
				// 여유 디스크 용량
				freeSpace = Math.round(root.getFreeSpace() / Math.pow(1024, 3) * n2) / n2;
				// 사용한 디스크 용량
				usedSpace = Math.round((totalSpace - usableSpace) * n2) / n2;

				diskSizeDto.setDrive_name(drive);
				diskSizeDto.setTotal_space(totalSpace);
				diskSizeDto.setUsable_space(usableSpace);
				// diskSizeDto.setFree_space(freeSpace);
				diskSizeDto.setUsed_space(usedSpace);

				diskSizeList.add(diskSizeDto);
				if (diskSizeList.size() > 1) {
					break;
				}
			} else {
//				part_drive_name = drive;
				// 하드디스크 전체 용량
				totalSpace = Math.round(root.getTotalSpace() / Math.pow(1024, 3) * n2) / n2;
				// 사용가능한 디스크 용량
				usableSpace = Math.round(root.getUsableSpace() / Math.pow(1024, 3) * n2) / n2;
				// 여유 디스크 용량
				freeSpace = Math.round(root.getFreeSpace() / Math.pow(1024, 3) * n2) / n2;
				// 사용한 디스크 용량
				usedSpace = Math.round((totalSpace - usableSpace) * n2) / n2;
				// System.out.println("하드 디스크 드라이버 : " + drive);
				// System.out.println("총 디스크 용량 : " + totalSpace + "GB");
				// System.out.println("사용 가능한 디스크 용량 : " + usableSpace + "GB");
				// System.out.println("여유 디스크 용량 : " + freeSpace + "GB");
				// System.out.println("사용한 디스크 용량 : " + usedSpace+"GB");

				diskSizeDto.setDrive_name(drive);
				diskSizeDto.setTotal_space(totalSpace);
				diskSizeDto.setUsable_space(usableSpace);
				// diskSizeDto.setFree_space(freeSpace);
				diskSizeDto.setUsed_space(usedSpace);

				diskSizeList.add(diskSizeDto);
				if (diskSizeList.size() > 1) {
					break;
				}
			}
		}

		return diskSizeList;
	}
}
