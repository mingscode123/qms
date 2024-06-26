package com.qms.util;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Hex;

public class AesUtil {

	private static String privateKey = "AES_PRIVATE_KEY_5321470896_SHOP_";
	
	public static String aesEncode(String text) throws Exception{
		SecretKeySpec secretKey = new SecretKeySpec(privateKey.getBytes("UTF-8"), "AES");
		IvParameterSpec IV = new IvParameterSpec(privateKey.substring(0,16).getBytes());
		
		Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
		
		c.init(Cipher.ENCRYPT_MODE, secretKey, IV);
		
		byte[] encrpytionByte = c.doFinal(text.getBytes("UTF-8"));
		
		return Hex.encodeHexString(encrpytionByte);
	}
	
	public static String aesDecode(String text) throws Exception {
		SecretKeySpec secretKey = new SecretKeySpec(privateKey.getBytes("UTF-8"), "AES");
		IvParameterSpec IV = new IvParameterSpec(privateKey.substring(0,16).getBytes());
		
		Cipher c= Cipher.getInstance("AES/CBC/PKCS5Padding");
		c.init(Cipher.DECRYPT_MODE, secretKey, IV);
		
		byte[] decodeByte = Hex.decodeHex(text.toCharArray());
		
		return new String(c.doFinal(decodeByte), "UTF-8");
	}
}
