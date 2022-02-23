package ai_box_pjt.device;

import static org.junit.Assert.*;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.junit.Test;

public class JasyptTest {

	@Test
	public void jasyptTest() {
		StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor(); 
		pbeEnc.setAlgorithm("PBEWithMD5AndDES"); 
		pbeEnc.setPassword("customPassword"); 
		
		String key = "1f3fcb6bac2928b629825b535b19b190"; 
		String iv = "902b1f8c04db500a"; 
		
		String encKey = pbeEnc.encrypt(key);
		String encIv = pbeEnc.encrypt(iv);
		
		String deKey = pbeEnc.decrypt(encKey);
		String deIv = pbeEnc.decrypt(encIv);
		
		System.out.println("���� key :: " + key + " | ���� key :: " + encKey); 
		System.out.println("���� iv :: " + iv + " | ���� encIv :: " + encIv); 

		System.out.println("���� key :: " + encKey + " | ���� key :: " + deKey); 
		System.out.println("���� iv :: " + encIv + " | ���� encIv :: " + deIv); 
	}

}
