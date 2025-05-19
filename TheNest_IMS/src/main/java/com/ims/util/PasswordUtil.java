package com.ims.util;

import java.nio.ByteBuffer;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

public class PasswordUtil {
    private static final String ENCRYPT_ALGO = "AES/GCM/NoPadding";
    private static final int TAG_LENGTH_BIT = 128;
    private static final int IV_LENGTH_BYTE = 12;
    private static final int SALT_LENGTH_BYTE = 16;
    private static final Charset UTF_8 = StandardCharsets.UTF_8;

    private static final Logger logger = Logger.getLogger(PasswordUtil.class.getName());

    private static byte[] getRandomNonce(int numBytes) {
        byte[] nonce = new byte[numBytes];
        new SecureRandom().nextBytes(nonce);
        return nonce;
    }

    public static SecretKey getAESKey(int keysize) throws NoSuchAlgorithmException {
        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
        keyGen.init(keysize, SecureRandom.getInstanceStrong());
        return keyGen.generateKey();
    }

    public static SecretKey getAESKeyFromPassword(char[] password, byte[] salt) {
        try {
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            KeySpec spec = new PBEKeySpec(password, salt, 65536, 256);
            SecretKey secret = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
            return secret;
        } catch (NoSuchAlgorithmException | InvalidKeySpecException ex) {
            logger.log(Level.SEVERE, "Key generation error: ", ex);
            return null;
        }
    }

    private static String normalizeKey(String input) {
        return input == null ? "" : input.trim().toLowerCase();
    }

    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    public static String encrypt(String employee_id, String password) {
        try {
            employee_id = normalizeKey(employee_id);
            byte[] salt = getRandomNonce(SALT_LENGTH_BYTE);
            byte[] iv = getRandomNonce(IV_LENGTH_BYTE);
            SecretKey aesKeyFromPassword = getAESKeyFromPassword(employee_id.toCharArray(), salt);
            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            cipher.init(Cipher.ENCRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));
            byte[] cipherText = cipher.doFinal(password.getBytes(UTF_8));
            byte[] cipherTextWithIvSalt = ByteBuffer.allocate(iv.length + salt.length + cipherText.length)
                                                    .put(iv).put(salt).put(cipherText).array();
            return Base64.getEncoder().encodeToString(cipherTextWithIvSalt);
            
        } catch (Exception ex) {
            logger.log(Level.SEVERE, "Encryption error: ", ex);
            return null;
        }
    }

    public static String decrypt(String encryptedPassword, String employee_id) {
        try {
            employee_id = normalizeKey(employee_id);
            byte[] decode = Base64.getDecoder().decode(encryptedPassword.getBytes(UTF_8));
            ByteBuffer bb = ByteBuffer.wrap(decode);
            byte[] iv = new byte[IV_LENGTH_BYTE];
            bb.get(iv);
            byte[] salt = new byte[SALT_LENGTH_BYTE];
            bb.get(salt);
            byte[] cipherText = new byte[bb.remaining()];
            bb.get(cipherText);
            SecretKey aesKeyFromPassword = getAESKeyFromPassword(employee_id.toCharArray(), salt);
            Cipher cipher = Cipher.getInstance(ENCRYPT_ALGO);
            cipher.init(Cipher.DECRYPT_MODE, aesKeyFromPassword, new GCMParameterSpec(TAG_LENGTH_BIT, iv));
            byte[] plainText = cipher.doFinal(cipherText);
            return new String(plainText, UTF_8);
            
        } catch (Exception ex) {
            logger.log(Level.SEVERE, "Decryption error: ", ex);
            return null;
        }
    }
}
