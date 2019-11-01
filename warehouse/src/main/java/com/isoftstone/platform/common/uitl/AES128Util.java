package com.isoftstone.platform.common.uitl;

import java.io.UnsupportedEncodingException;

import org.apache.shiro.codec.Hex;
import org.apache.shiro.crypto.AesCipherService;
import org.apache.shiro.crypto.CryptoException;

public class AES128Util
{
    //private static final Logger log = Logger.getLogger(AES128Util.class);
    
    public static String Encrypt(String plaintext, String textKey, String charsetName)
        throws UnsupportedEncodingException
    {
        AesCipherService aesCipherService = new AesCipherService();
        aesCipherService.setKeySize(128);
        byte[] plaintBytes = plaintext.getBytes(charsetName == null ? "ISO8859-1" : charsetName);
        byte[] keyBytes = textKey.getBytes(charsetName == null ? "ISO8859-1" : charsetName);
        if (keyBytes.length * 8 != 128)
        {
            throw new RuntimeException("key must be 128 bit !");
        }
        return aesCipherService.encrypt(plaintBytes, keyBytes).toHex();
    }
    
    public static String Decrypt(String ciphertext, String textKey, String charsetName)
        throws CryptoException, UnsupportedEncodingException
    {
        //        log.error(ciphertext + "|"
        //            + textKey + "|"
        //            + charsetName);
        AesCipherService aesCipherService = new AesCipherService();
        aesCipherService.setKeySize(128);
        byte[] cipherBytes = Hex.decode(ciphertext);
        byte[] keyBytes = textKey.getBytes(charsetName == null ? "ISO8859-1" : charsetName);
        if (keyBytes.length * 8 != 128)
        {
            throw new RuntimeException("key must be 128 bit !");
        }
        return new String(aesCipherService.decrypt(cipherBytes, keyBytes).getBytes(), charsetName);
    }
    
    public static void main(String[] args)
        throws CryptoException, UnsupportedEncodingException
    {
        System.out.println(Decrypt("f339b4edda028150c2a21c28892812177f67439acfadc7baeb3292d970f28a8f",
            "0123456789ABCDEF",
            "utf-8"));
        
        System.out.println(Encrypt("Huawei_123", "0123456789ABCDEF", "utf-8"));

        System.out.println(Decrypt("dfaabea86f282da16837fc9e3551b934e8ccbdf9c157521fe378a5192538937e",
                "0123456789ABCDEF",
                "utf-8"));

        System.out.println(Encrypt("123456", "0123456789ABCDEF", "utf-8"));


    }
}
