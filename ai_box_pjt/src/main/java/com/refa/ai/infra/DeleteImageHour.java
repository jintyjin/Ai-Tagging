package com.refa.ai.infra;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimerTask;

import org.apache.commons.io.FileUtils;

import com.refa.ai.dao.EventDao;
import com.refa.ai.dto.DiskSizeDto;
import com.refa.ai.dto.ImageTableDto;

public class DeleteImageHour extends TimerTask {
	public void run() {
		String drive;
		double totalSpace, usedSpace, freeSpace, usableSpace = 0; // �ϵ��ũ�� ��Ʈ ����̹����� �迭�� ��ȯ�Ѵ�. 
		File[] roots = File.listRoots();
		
		int n = 2;
		double n2 = Math.pow(10.0, n);
		
		for(File root : roots){
			drive = root.getAbsolutePath().substring(0, 1); 
			if (drive.equals("D")) {
				// �ϵ��ũ ��ü �뷮 
				totalSpace = Math.round(root.getTotalSpace() / Math.pow(1024, 3) * n2) / n2; 
				// ��밡���� ��ũ �뷮 
				usableSpace = Math.round(root.getUsableSpace() / Math.pow(1024,3) * n2) / n2; 
				// ���� ��ũ �뷮 
				freeSpace = Math.round(root.getFreeSpace() / Math.pow(1024,3) * n2) / n2; 
				// ����� ��ũ �뷮 
				usedSpace = Math.round((totalSpace - usableSpace) * n2) / n2; 
				System.out.println("�ϵ� ��ũ ����̹� : " + drive); 
				System.out.println("�� ��ũ �뷮 : " + totalSpace + "GB"); 
				System.out.println("��� ������ ��ũ �뷮 : " + usableSpace + "GB"); 
				System.out.println("���� ��ũ �뷮 : " + freeSpace + "GB"); 
				System.out.println("����� ��ũ �뷮 : " + usedSpace+"GB");
			}
		}
		
		if (usableSpace < 30) {
			EventDao eventDao = new EventDao();
	        //���� ���ϰ��
	        //String oriFilePath = "D:/web_server/testuser/AIBOX_OFFICE/20200811/";
			ImageTableDto imageTableDto = eventDao.selectRecentImage(null);
			
			String image_path = imageTableDto.getImage_name().substring(0, imageTableDto.getThumb_name().lastIndexOf("/") + 1);
			
	        String oriFilePath = "D:" + image_path;
	        //����� ���ϰ��
	        String copyFilePath = "C:" + image_path;

	        File path = new File(oriFilePath);
	        
	        String fileList[] = path.list();
	        
	        try {
		        if (fileList != null && fileList.length > 0) {
		        	System.out.println("�̹��� ���� = " + fileList.length);
		        	
		    		long end1 = System.currentTimeMillis();
		        	System.out.println("image_path = " + image_path);

		        	// ���� ��ü�� �ű�
		            //FileUtils.moveDirectory(path, path2);	// ���ǿ� �°� ���丮�� �ű� ���� �ְ� ������ ���� ����

		        	// ���� ��ü�� ����
		        	try {
						FileUtils.deleteDirectory(path);
					} catch (IOException e) {
						// TODO Auto-generated catch block
			        	System.out.println("���� ���� ����");
					}
		        	
		            // imageTable ������ ����, ����� ���̺� ������ ����
		    		eventDao.deleteBackupImage(image_path);
		    		eventDao.deleteBackupMonitoring(image_path);
		    		
		    		long now1 = System.currentTimeMillis();
		    		
		            System.out.println("��� �̹��� �ð� = " + (now1 - end1)/1000.0 + "��");
		        }
	        } catch(Exception e) {
	        	System.out.println("�̹��� ���� ����");
	        }
	        
		}
	}
}
