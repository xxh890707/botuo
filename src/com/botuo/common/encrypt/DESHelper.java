package com.botuo.common.encrypt;

import java.io.IOException;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

public class DESHelper {

 

    private byte[] desKey;

 

    public DESHelper(String desKey) {

        this.desKey = desKey.getBytes();

    }

 

    public byte[] desEncrypt(byte[] plainText) throws Exception {

        SecureRandom sr = new SecureRandom();

        byte rawKeyData[] = desKey;

        DESKeySpec dks = new DESKeySpec(rawKeyData);

        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");

        SecretKey key = keyFactory.generateSecret(dks);

        Cipher cipher = Cipher.getInstance("DES");

        cipher.init(Cipher.ENCRYPT_MODE, key, sr);

        byte data[] = plainText;

        byte encryptedData[] = cipher.doFinal(data);

        return encryptedData;

    }

 

    public byte[] desDecrypt(byte[] encryptText) throws Exception {

        SecureRandom sr = new SecureRandom();

        byte rawKeyData[] = desKey;

        DESKeySpec dks = new DESKeySpec(rawKeyData);

        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");

        SecretKey key = keyFactory.generateSecret(dks);

        Cipher cipher = Cipher.getInstance("DES");

        cipher.init(Cipher.DECRYPT_MODE, key, sr);

        byte encryptedData[] = encryptText;

        byte decryptedData[] = cipher.doFinal(encryptedData);

        return decryptedData;

    }

 

    public String encrypt(String input) throws Exception {

        return base64Encode(desEncrypt(input.getBytes("UTF-8")));

    }
    
    public String encrypt(byte[] input) throws Exception {
    	
    	return base64Encode(desEncrypt(input));
    	
    }

    public String decrypt(String input) throws Exception {
        byte[] result = base64Decode(input);
        return new String(desDecrypt(result),"UTF-8");
    }

 
    public static String base64Encode(byte[] s) {

        if (s == null)

            return null;

        sun.misc.BASE64Encoder  b = new sun.misc.BASE64Encoder();
        return b.encode(s);

    }

 

    public static byte[] base64Decode(String s) throws IOException {

        if (s == null)

            return null;

        sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();

        byte[] b = decoder.decodeBuffer(s);

        return b;

    }
    
	/**将二进制转换成16进制 
	 * @param buf 
	 * @return 
	 */  
	public  String parseByte2HexStr(byte buf[]) {  
	        StringBuffer sb = new StringBuffer();  
	        for (int i = 0; i < buf.length; i++) {  
	                String hex = Integer.toHexString(buf[i] & 0xFF);  
	                if (hex.length() == 1) {  
	                        hex = '0' + hex;  
	                }  
	                sb.append(hex.toUpperCase());  
	        }  
	        return sb.toString();  
	}  

	/**将16进制转换为二进制 
	 * @param hexStr 
	 * @return 
	 */  
	public  byte[] parseHexStr2Byte(String hexStr) {  
	        if (hexStr.length() < 1)  
	                return null;  
	        byte[] result = new byte[hexStr.length()/2];  
	        for (int i = 0;i< hexStr.length()/2; i++) {  
	                int high = Integer.parseInt(hexStr.substring(i*2, i*2+1), 16);  
	                int low = Integer.parseInt(hexStr.substring(i*2+1, i*2+2), 16);  
	                result[i] = (byte) (high * 16 + low);  
	        }  
	        return result;  
	} 

    public static void main(String []arg){
    	try{
    		String key = "72fif5zmyrPao8TvrsoabtEXKHiN1PAjjmZU20Vn";
	    	DESHelper dESHelper = new  DESHelper(key);//"ED5wLgc3");
	    	
	    	/*String ss = "WWpkRICHYnksX%2BZgy5Kep2eRLkOTU2Y6VIN3A2uY%2F9iKZgn%2FapBoehiUQfRD%2FNd5KxwaRqwZkPeN%0D%0A0iLN1VwtK7QCrqydeUsg2n0HqdCiuSAcAGDenacRqgR%2BiHrJVYFVOo8VKfVqbrfiH4YuErPz9SH8%0D%0AZejQJ%2BYB8VWnxnDSPTHFWf2PZcSKGIJUy%2Bg889Du";
	    	**/
	    	String ss = "RCHoicdCm8CQs2ZUoH+H+r9oKzaSHP7vBtpk5QUDJhJIgJuuhMXWbjYT8KYp2IQNo4YqDipqJnlVwNjF2VlaMSshmaAHturn1T3ANzf8+Jdx0AqCG6MLbOMeb9qIXH6L6MuyselmqMY=";
	    	//String retStr = URLDecoder.decode(ss, "UTF-8");
	    	String retStr="";
			retStr = dESHelper.decrypt(ss.trim());
			//retStr = URLDecoder.decode(retStr, "UTF-8");
	    	
	    	//String aftStr = dESHelper.decrypt("WpkRICHYnksX+Zgy5Kep2eRLkOTU2Y6VIN3A2uY/9iKZgn/apBoehiUQfRD/Nd5KxwaRqwZkPeN0iLN1VwtK7QCrqydeUsg2n0HqdCiuSAcAGDenacRqgR+iHrJVYFVOo8VKfVqbrfiH4YuErPz9SH8ZejQJ+YB8VWnxnDSPTHFWf2PZcSKGIJUy+g889Du");
	    	System.out.println("解密之前:"+retStr);
	    	
	    	String str = "{\"username\":\"admin\",\"password\":\"1234qwer\"}";
	    	System.out.println(dESHelper.encrypt(str));
    	}catch(Exception ex){
    		ex.printStackTrace();
    	}
    }

}