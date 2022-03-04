package com.refa.ai.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.refa.ai.dto.MetadataDto;
import com.refa.ai.dto.MlResultDto;
import com.refa.ai.dto.MonitoringDto;
import com.refa.ai.dto.ResponseEventDto;
import com.refa.ai.infra.EasyImage;
import com.refa.ai.repository.MonitoringRepository;
import com.refa.ai.repository.VersionMemoryRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ImageService {
	
	private final VersionMemoryRepository versionMemoryRepository;
	
	public void saveImage(String path, String imgName, String base64) {
		byte[] imageBytes = DatatypeConverter.parseBase64Binary(base64);

		try {
			File lOutFile = new File(path + imgName);

			FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);

			lFileOutputStream.write(imageBytes);

			lFileOutputStream.close();
		} catch (Exception e) {
			System.out.println("원본 이미지 저장 안됨");
		}
	}

	public String saveImage(String firstPath, String login_id, String item_name, String event_time, String img_data, String img_name) {
		// 폴더 경로 잡아줌 - 장비 및 채널 정보 가져와서 추가로 만들어줌
		String uploadPath = versionMemoryRepository.findMasterDriveName() + firstPath;
		File folder = new File(uploadPath);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		uploadPath += login_id + "/";
		folder = new File(uploadPath);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		uploadPath += item_name + "/";
		folder = new File(uploadPath);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		uploadPath += event_time.split(" ")[0].split("-")[0] + event_time.split(" ")[0].split("-")[1]
				+ event_time.split(" ")[0].split("-")[2] + "/";
		folder = new File(uploadPath);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		String data = img_data;

		byte[] imageBytes = DatatypeConverter.parseBase64Binary(data);

		try {
			File lOutFile = new File(uploadPath + img_name);

			FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);

			lFileOutputStream.write(imageBytes);

			lFileOutputStream.close();

		} catch (Exception e) {
			System.out.println("원본 이미지 저장 안됨");
		}

		File f = new File(uploadPath + img_name);
		String thumb_name = (uploadPath + img_name).substring(0, (uploadPath + img_name).lastIndexOf("."))
				+ "_thumb.jpg";
		
		String img_size = "";
		
		try {
			EasyImage easyImage = new EasyImage(f);
			BufferedImage bi = ImageIO.read(f);

			if (!easyImage.isSupportedImageFormat()) {
				System.out.println("not supported image type");
			}

			int hWidth = bi.getWidth();
			int hHeight = bi.getHeight();

			img_size = hWidth + "-" + hHeight;

			if (hWidth < 640 || hHeight < 480) {
				File lOutFile = new File(thumb_name);

				FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);

				lFileOutputStream.write(imageBytes);

				lFileOutputStream.close();

			} else {
				// resize
				EasyImage resizedImage = easyImage.resize(640, 480);

				FileOutputStream out = new FileOutputStream(thumb_name);

				resizedImage.writeTo(out, "jpg");

				out.close();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("썸네일 이미지 저장 안됨");
		}

		return img_size;
	}

	public String saveThumbImage(String path, String imgName, String base64) {
		byte[] imageBytes = DatatypeConverter.parseBase64Binary(base64);
		String imageSize = "";

		File f = new File(path + imgName);
		
		try {
			File lOutFile = new File(path + imgName);

			FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);

			lFileOutputStream.write(imageBytes);

			lFileOutputStream.close();
			
			EasyImage easyImage = new EasyImage(f);
			BufferedImage bi = ImageIO.read(f);

			int hWidth = bi.getWidth();
			int hHeight = bi.getHeight();

			imageSize = hWidth + "-" + hHeight;

			if (hWidth >= 640 && hHeight >= 480) {
				// resize
				EasyImage resizedImage = easyImage.resize(640, 480);

				FileOutputStream out = new FileOutputStream(path + imgName);

				resizedImage.writeTo(out, "jpg");

				out.close();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("썸네일 이미지 저장 안됨");
		}

		return imageSize;
	}
	
	public String makeFolder(String master_drive_name, String loginId, String itemName, String eventTime) {
		//폴더 경로
		String path = master_drive_name + ":/web_server/";
		File folder = new File(path);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		path += loginId + "/";
		folder = new File(path);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		path += itemName + "/";
		folder = new File(path);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		path += eventTime.split(" ")[0].split("-")[0] + eventTime.split(" ")[0].split("-")[1]
				+ eventTime.split(" ")[0].split("-")[2] + "/";
		folder = new File(path);

		if (!folder.exists()) {
			try {
				folder.mkdir();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		return path;
	}
}
