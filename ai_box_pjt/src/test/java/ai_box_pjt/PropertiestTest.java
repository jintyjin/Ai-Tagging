package ai_box_pjt;

import static org.junit.Assert.*;

import java.io.IOException;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Properties;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.ibatis.io.Resources;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.registry.AlgorithmRegistry;
import org.jasypt.salt.StringFixedSaltGenerator;
import org.jasypt.util.text.AES256TextEncryptor;
import org.junit.Test;

import com.refa.ai.infra.AES256Util;

public class PropertiestTest {

	@Test
	public void �׽�Ʈ() {
		StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
		String password = "customPassword";
		
		encryptor.setPassword(password); 
		encryptor.setAlgorithm("PBEWithMD5AndDES"); 
//		encryptor.setIvGenerator(new RandomIvGenerator());
		encryptor.setSaltGenerator(new StringFixedSaltGenerator(password));

		String str = "1234"; 
		String encStr = encryptor.encrypt(str); 
		String decStr = encryptor.decrypt(encStr);
		
		System.out.println("���ڵ� �� = " + encStr);
		System.out.println("���ڵ� �� = " + decStr);
		
		System.out.println("allDigestAlgorithms : " + AlgorithmRegistry.getAllDigestAlgorithms()); 
		System.out.println("allPBEAlgorithms : " + AlgorithmRegistry.getAllPBEAlgorithms());

		AES256TextEncryptor textEncryptor = new AES256TextEncryptor();
		textEncryptor.setPassword(password);

		String aes256EncStr = textEncryptor.encrypt(str);
		System.out.println("aes256 ���ڵ� �� = " + aes256EncStr);
		
		String plainText = textEncryptor.decrypt(aes256EncStr);
		System.out.println("aes256 ���ڵ� �� = " + plainText);
	}
	
	@Test
	public void properties��������() {
		AES256Util aES256Util = new AES256Util();
	}
}
