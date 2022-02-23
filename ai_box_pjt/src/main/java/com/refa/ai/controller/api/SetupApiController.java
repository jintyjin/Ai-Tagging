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
		double totalSpace, usedSpace, freeSpace, usableSpace; // �ϵ��ũ�� ��Ʈ ����̹����� �迭�� ��ȯ�Ѵ�.
		File[] roots = File.listRoots();

		List<DiskSizeDto> diskSizeList = new ArrayList<DiskSizeDto>();
		DiskSizeDto diskSizeDto;

		int n = 2;
		double n2 = Math.pow(10.0, n);

		for (File root : roots) {
			diskSizeDto = new DiskSizeDto();
			// ��Ʈ ����̹��� ���� ���
			drive = root.getAbsolutePath().substring(0, 1);

			String uploadPath = drive + ":/" + "Program Files/";
			File folder = new File(uploadPath);

			if (folder.exists()) {
//				master_drive_name = drive;
				// �ϵ��ũ ��ü �뷮
				totalSpace = Math.round(root.getTotalSpace() / Math.pow(1024, 3) * n2) / n2;
				// ��밡���� ��ũ �뷮
				usableSpace = Math.round(root.getUsableSpace() / Math.pow(1024, 3) * n2) / n2;
				// ���� ��ũ �뷮
				freeSpace = Math.round(root.getFreeSpace() / Math.pow(1024, 3) * n2) / n2;
				// ����� ��ũ �뷮
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
				// �ϵ��ũ ��ü �뷮
				totalSpace = Math.round(root.getTotalSpace() / Math.pow(1024, 3) * n2) / n2;
				// ��밡���� ��ũ �뷮
				usableSpace = Math.round(root.getUsableSpace() / Math.pow(1024, 3) * n2) / n2;
				// ���� ��ũ �뷮
				freeSpace = Math.round(root.getFreeSpace() / Math.pow(1024, 3) * n2) / n2;
				// ����� ��ũ �뷮
				usedSpace = Math.round((totalSpace - usableSpace) * n2) / n2;
				// System.out.println("�ϵ� ��ũ ����̹� : " + drive);
				// System.out.println("�� ��ũ �뷮 : " + totalSpace + "GB");
				// System.out.println("��� ������ ��ũ �뷮 : " + usableSpace + "GB");
				// System.out.println("���� ��ũ �뷮 : " + freeSpace + "GB");
				// System.out.println("����� ��ũ �뷮 : " + usedSpace+"GB");

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
