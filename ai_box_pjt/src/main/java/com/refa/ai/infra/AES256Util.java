package com.refa.ai.infra;

import java.io.IOException;
import java.io.Reader;
import java.util.Arrays;
import java.util.Properties;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.ibatis.io.Resources;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import lombok.Getter;

@Component
@Getter
public class AES256Util {
	// keyString = 키값, plainText = 암호화하려는 값, bUrlSafe = Base64 방식에 따른 옵션, default false

	private String keyString;
	private String ivString;
	
    public AES256Util() {
        String resource = "application.properties";
        Properties properties = new Properties();
        
        try {
            Reader reader = Resources.getResourceAsReader(resource);
            properties.load(reader);
            
    		StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor(); 
    		pbeEnc.setAlgorithm("PBEWithMD5AndDES"); 
    		pbeEnc.setPassword("customPassword"); 
    		
    		this.keyString = pbeEnc.decrypt(properties.getProperty("security.key"));
    		this.ivString = pbeEnc.decrypt(properties.getProperty("security.iv"));
    		
        } catch (IOException e) {
            e.printStackTrace();
        }
	}

	public String encryptAES(String plainText, boolean bUrlSafe) {
        String cipherText = "";
        if ((keyString == null) || keyString.length() == 0 || (plainText == null) || plainText.length() == 0) {
            return cipherText;
        }

        // 키의 길이는 16, 24, 32 만 지원
        if ((keyString.length() != 16) && (keyString.length() != 24) && (keyString.length() != 32)) {
            return cipherText;
        }
       
        try {
            byte[] keyBytes = keyString.getBytes("UTF-8");
            byte[] ivBytes = ivString.getBytes("UTF-8");
            byte[] plainTextBytes = plainText.getBytes("UTF-8");

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            int bsize = cipher.getBlockSize();
//            IvParameterSpec ivspec = new IvParameterSpec(Arrays.copyOfRange(keyBytes, 0, bsize));
            IvParameterSpec ivspec = new IvParameterSpec(ivBytes);
           
            SecretKeySpec secureKey = new SecretKeySpec(keyBytes, "AES");
            cipher.init(Cipher.ENCRYPT_MODE, secureKey, ivspec);
            byte[] encrypted = cipher.doFinal(plainTextBytes);

            if (bUrlSafe) {
                cipherText = Base64.encodeBase64URLSafeString(encrypted);
            } else {
                cipherText = new String(Base64.encodeBase64(encrypted), "UTF-8");
            }
           
        } catch (Exception e) {
            cipherText = "";
            e.printStackTrace();
        }

        return cipherText;
    }
	   
	   
    public String decryptAES(String cipherText) {
        String plainText = "";
        if ((keyString == null) || keyString.length() == 0 || (cipherText == null) || cipherText.length() == 0) {
            return plainText;
        }
       
        if ((keyString.length() != 16) && (keyString.length() != 24) && (keyString.length() != 32)) {
            return plainText;
        }

        try {
            byte[] keyBytes = keyString.getBytes("UTF-8");
            byte[] ivBytes = ivString.getBytes("UTF-8");
            byte[] cipherTextBytes = Base64.decodeBase64(cipherText.getBytes("UTF-8"));

            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            int bsize = cipher.getBlockSize();
//          IvParameterSpec ivspec = new IvParameterSpec(Arrays.copyOfRange(keyBytes, 0, bsize));
          IvParameterSpec ivspec = new IvParameterSpec(ivBytes);
           
            SecretKeySpec secureKey = new SecretKeySpec(keyBytes, "AES");
            cipher.init(Cipher.DECRYPT_MODE, secureKey, ivspec);
            byte[] decrypted = cipher.doFinal(cipherTextBytes);

            plainText = new String(decrypted, "UTF-8");
           
        } catch (Exception e) {
            plainText = "";
            e.printStackTrace();
        }

        return plainText;
    }
}
