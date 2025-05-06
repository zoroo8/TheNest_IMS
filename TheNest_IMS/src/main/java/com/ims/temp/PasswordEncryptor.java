// You can place this in a temporary file, e.g., src/main/java/com/ims/temp/PasswordEncryptor.java
package com.ims.temp; // Or any suitable temporary package

import com.ims.util.PasswordUtil;

public class PasswordEncryptor {

    public static void main(String[] args) {
        // --- Configuration ---
        String plainPassword = "admin"; // Set the password you want to use
        String userEmail = "admin@gmail.com"; // Set the email for the new user
        // --- End Configuration ---

        try {
            // Derive the key exactly as done in LoginService for decryption
            String encryptionKey = userEmail.trim().toLowerCase(); 
            
            System.out.println("Using plain password: " + plainPassword);
            System.out.println("Using email (for key): " + userEmail);
            System.out.println("Derived encryption key: " + encryptionKey);

            String encryptedPassword = PasswordUtil.encrypt(encryptionKey, plainPassword); 

            if (encryptedPassword != null) {
                System.out.println("\n--- SUCCESS ---");
                System.out.println("Encrypted Password String:");
                System.out.println(encryptedPassword);
                System.out.println("\nUse the above string in your SQL INSERT statement.");
            } else {
                System.err.println("\n--- ERROR ---");
                System.err.println("Encryption failed. PasswordUtil.encrypt returned null.");
            }

        } catch (Exception e) {
            System.err.println("\n--- EXCEPTION DURING ENCRYPTION ---");
            e.printStackTrace();
        }
    }
}