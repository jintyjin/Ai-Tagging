package com.refa.ai.infra;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class ImageUtil {
	 //������ ���翩�θ� Ȯ���ϴ� �޼ҵ�
	 public static Boolean fileIsLive(String isLivefile) {
		 File f1 = new File(isLivefile);
  
		 if(f1.exists()) {
			 return true;
		 } else {
			 return false;
		 }
	 }
	 
	 //������ �����ϴ� �޼ҵ�
	 public static void fileMake(String makeFileName) {
		 File f1 = new File(makeFileName);
		 try {
			 f1.createNewFile();
		 } catch (IOException e) {
			 // TODO Auto-generated catch block
			 e.printStackTrace();
		 }
	 }
	 
	 //������ �����ϴ� �޼ҵ�
	 public static void fileDelete(String deleteFileName) {
		 File I = new File(deleteFileName);
		 I.delete();
	 }
	 
	 //������ �����ϴ� �޼ҵ�
	 public static void fileCopy(String inFileName, String outFileName) {
		 try {
			 FileInputStream fis = new FileInputStream(inFileName);
			 FileOutputStream fos = new FileOutputStream(outFileName);
	   
			 int data = 0;
			 while((data=fis.read())!=-1) {
				 fos.write(data);
			 }
			 fis.close();
			 fos.close();
	   
		 } catch (IOException e) {
			 // TODO Auto-generated catch block
			 e.printStackTrace();
		 }
	 }
	 
	 //������ �̵��ϴ� �޼ҵ�
	 public static void fileMove(String inFileName, String outFileName) {
		 try {
			 FileInputStream fis = new FileInputStream(inFileName);
			 FileOutputStream fos = new FileOutputStream(outFileName);
	   
			 int data = 0;
			 while((data=fis.read())!=-1) {
				 fos.write(data);
			 }
			 fis.close();
			 fos.close();
	   
			 //�����ѵ� ���������� ������
			 fileDelete(inFileName);
	   
		 } catch (IOException e) {
			 // TODO Auto-generated catch block
			 e.printStackTrace();
		 }
	 }
	 
	 //���丮�� ���� ����Ʈ�� �д� �޼ҵ�
	 public static List<File> getDirFileList(String dirPath) {
		 // ���丮 ���� ����Ʈ
		 List<File> dirFileList = null;
	  
		 // ���� ����� ��û�� ���丮�� ������ ���� ��ü�� ������
		 File dir = new File(dirPath);
	  
		 // ���丮�� �����Ѵٸ�
		 if (dir.exists()) {
			 // ���� ����� ����
			 File[] files = dir.listFiles();
	   
			 // ���� �迭�� ���� ����Ʈ�� ��ȭ��
			 try {
				 if (files != null) {
					 dirFileList = Arrays.asList(files);
				 }
			 } catch(Exception e) {
				 e.printStackTrace();
			 }
		 }
	  
		 return dirFileList;
	 }
}
