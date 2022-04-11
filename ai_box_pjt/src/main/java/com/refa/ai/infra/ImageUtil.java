package com.refa.ai.infra;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class ImageUtil {
	 //파일을 존재여부를 확인하는 메소드
	 public static Boolean fileIsLive(String isLivefile) {
		 File f1 = new File(isLivefile);
  
		 if(f1.exists()) {
			 return true;
		 } else {
			 return false;
		 }
	 }
	 
	 //파일을 생성하는 메소드
	 public static void fileMake(String makeFileName) {
		 File f1 = new File(makeFileName);
		 try {
			 f1.createNewFile();
		 } catch (IOException e) {
			 // TODO Auto-generated catch block
			 System.out.println("파일 생성 불가");
		 }
	 }
	 
	 //파일을 삭제하는 메소드
	 public static void fileDelete(String deleteFileName) {
		 File I = new File(deleteFileName);
		 I.delete();
	 }
	 
	 //파일을 복사하는 메소드
	 public static void fileCopy(String inFileName, String outFileName) throws IOException {
		 FileInputStream fis = null; 
		 FileOutputStream fos = null;
		 try {
			 fis = new FileInputStream(inFileName);
			 fos = new FileOutputStream(outFileName);
	   
			 int data = 0;
			 while((data=fis.read())!=-1) {
				 fos.write(data);
			 }
		 } catch (IOException e) {
			 // TODO Auto-generated catch block
			 System.out.println("파일 복사 불가");
		 } finally {
			 if (fis != null) {
				 fis.close();
			 }
			 if (fos != null) {
				 fos.close();
			 }
		 }
	 }
	 
	 //파일을 이동하는 메소드
	 public static void fileMove(String inFileName, String outFileName) throws IOException {
		 FileInputStream fis = null;
		 FileOutputStream fos = null;
		 try {
			 fis = new FileInputStream(inFileName);
			 fos = new FileOutputStream(outFileName);
	   
			 int data = 0;
			 while((data=fis.read())!=-1) {
				 fos.write(data);
			 }
	   
			 //복사한뒤 원본파일을 삭제함
			 fileDelete(inFileName);
	   
		 } catch (IOException e) {
			 // TODO Auto-generated catch block
			 System.out.println("파일 이동 불가");
		 } finally {
			 if (fis != null) {
				 fis.close();
			 }
			 if (fos != null) {
				 fos.close();
			 }
		 }
	 }
	 
	 //디렉토리의 파일 리스트를 읽는 메소드
	 public static List<File> getDirFileList(String dirPath) {
		 // 디렉토리 파일 리스트
		 List<File> dirFileList = null;
	  
		 // 파일 목록을 요청한 디렉토리를 가지고 파일 객체를 생성함
		 File dir = new File(dirPath);
	  
		 // 디렉토리가 존재한다면
		 if (dir.exists()) {
			 // 파일 목록을 구함
			 File[] files = dir.listFiles();
	   
			 // 파일 배열을 파일 리스트로 변화함
			 if (files != null) {
				 dirFileList = Arrays.asList(files);
			 }
		 }
	  
		 return dirFileList;
	 }
}
