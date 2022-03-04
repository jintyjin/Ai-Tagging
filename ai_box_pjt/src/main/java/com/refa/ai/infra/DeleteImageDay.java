package com.refa.ai.infra;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimerTask;

import org.apache.commons.io.FileUtils;

import com.refa.ai.dao.EventDao;
import com.refa.ai.dto.ImageTableDto;

public class DeleteImageDay extends TimerTask {
	public void run() {
		Calendar cal = Calendar.getInstance();
		System.out.println("스케줄 = " + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cal.getTimeInMillis()));
		if (new Date(cal.getTimeInMillis()).getSeconds() % 8 == 0) {
			System.out.println("조건 충족 = " + new Date(cal.getTimeInMillis()).getHours());
		}
		String drive;
		double totalSpace, usedSpace, freeSpace, usableSpace = 0; // 하드디스크의 루트 드라이버들을 배열로 반환한다. 
		File[] roots = File.listRoots();
		
		int n = 2;
		double n2 = Math.pow(10.0, n);
		
		for(File root : roots){
			drive = root.getAbsolutePath().substring(0, 1); 
			if (drive.equals("D")) {
				// 하드디스크 전체 용량 
				totalSpace = Math.round(root.getTotalSpace() / Math.pow(1024, 3) * n2) / n2; 
				// 사용가능한 디스크 용량 
				usableSpace = Math.round(root.getUsableSpace() / Math.pow(1024,3) * n2) / n2; 
				// 여유 디스크 용량 
				freeSpace = Math.round(root.getFreeSpace() / Math.pow(1024,3) * n2) / n2; 
				// 사용한 디스크 용량 
				usedSpace = Math.round((totalSpace - usableSpace) * n2) / n2; 
				System.out.println("사용 가능한 디스크 용량 : " + usableSpace + "GB"); 
			}
		}

		if (usableSpace < 30) {
			EventDao eventDao = new EventDao();
	        //원본 파일경로
	        //String oriFilePath = "D:/web_server/testuser/AIBOX_OFFICE/20200811/";
			ImageTableDto imageTableDto = eventDao.selectRecentImage(null);
			
			String image_path = imageTableDto.getImage_name().substring(0, imageTableDto.getThumb_name().lastIndexOf("/") + 1);
			
			System.out.println("image_path = " + image_path);
			
	        String oriFilePath = "D:" + image_path;
	        //복사될 파일경로
	        String copyFilePath = "C:" + image_path;

	        File path = new File(oriFilePath);
	        
	        String fileList[] = path.list();
	        
	        try {
		        if (fileList != null && fileList.length > 0) {
		        	System.out.println("이미지 갯수 = " + fileList.length);
		        	
		    		long end1 = System.currentTimeMillis();
		        	System.out.println("image_path = " + image_path);

		        	// 폴더 자체를 옮김
		            //FileUtils.moveDirectory(path, path2);	// 조건에 맞게 디렉토리를 옮길 수도 있고 삭제할 수도 있음

		        	// 폴더 자체를 지움
		        	try {
						FileUtils.deleteDirectory(path);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						System.out.println("DeleteImageDay 폴더 삭제 오류");
					}
		        	
		            // imageTable 데이터 삭제, 모니터 테이블 데이터 삭제
		    		eventDao.deleteBackupImage(image_path);
		    		eventDao.deleteBackupMonitoring(image_path);
		    		
		    		long now1 = System.currentTimeMillis();
		    		
		            System.out.println("모든 이미지 시간 = " + (now1 - end1)/1000.0 + "초");
		        }
	        } catch(Exception e) {
				System.out.println("DeleteImageDay 폴더 오류");
	        }
		}
	}
}
