package com.refa.ai;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.refa.ai.infra.AES256Util;

public class AppConfig {

	@Value("${security.key}")
	String encKey;

	@Value("${security.iv}")
	String encIv;
	
	public AES256Util aes256Util() {
		StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor(); 
		pbeEnc.setAlgorithm("PBEWithMD5AndDES"); 
		pbeEnc.setPassword("customPassword"); 
		
		String deKey = pbeEnc.decrypt(encKey);
		String deIv = pbeEnc.decrypt(encIv);
		
		return new AES256Util();
	}
}
