package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.UserModel;
import com.ims.util.PasswordUtil;
import java.sql.*;
import java.util.logging.Level; // Import Logger
import java.util.logging.Logger; // Import Logger

public class LoginService {
    // Add a logger
    private static final Logger LOGGER = Logger.getLogger(LoginService.class.getName());

    public UserModel authenticate(String email, String password) throws SQLException, ClassNotFoundException {
        String sql = "SELECT user_id, first_name, last_name, email, role, password " +
                     "FROM user WHERE email = ?";
        
        LOGGER.log(Level.INFO, "Attempting authentication for email: {0}", email); // Log email attempt

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                LOGGER.info("User found in database."); // Log user found
                String encryptedPassword = rs.getString("password");
                LOGGER.log(Level.INFO, "Encrypted password from DB: {0}", encryptedPassword); // Log encrypted password

                // Use the same key derivation for logging as used in decrypt
                String decryptionKey = email.trim().toLowerCase(); 
                LOGGER.log(Level.INFO, "Using decryption key (derived from email): {0}", decryptionKey); // Log decryption key

                String decryptedPassword = PasswordUtil.decrypt(encryptedPassword, decryptionKey);
                LOGGER.log(Level.INFO, "Decrypted password result: {0}", decryptedPassword); // Log decrypted result
                LOGGER.log(Level.INFO, "Password from form: {0}", password); // Log form password

                if (decryptedPassword != null && decryptedPassword.equals(password)) {
                    LOGGER.info("Password match successful."); // Log success
                    updateLastLogin(rs.getInt("user_id"));
                    return new UserModel(
                        rs.getInt("user_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"), 
                        rs.getString("email"),
                        rs.getString("role"),
                        null, // password - null is correct here, don't return it
                        null, // address
                        null, // dob
                        null  // last_login
                    );
                } else {
                     LOGGER.warning("Password comparison failed."); // Log failure reason
                }
            } else {
                 LOGGER.warning("User not found for email: " + email); // Log user not found
            }
            return null; // Return null if user not found or password mismatch
        } catch (Exception e) { // Catch broader exceptions during decryption/DB access within authenticate
            LOGGER.log(Level.SEVERE, "Exception during authentication for " + email, e);
            throw e; // Re-throw if you want LoginController to catch it, or handle differently
        }
    }
    
    private void updateLastLogin(int userId) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE user SET last_login = NOW() WHERE user_id = ?";
        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            LOGGER.log(Level.INFO, "Updated last_login for user_id: {0}", userId);
        } catch (SQLException | ClassNotFoundException e) {
             LOGGER.log(Level.SEVERE, "Failed to update last_login for user_id: " + userId, e);
             throw e; // Re-throw
        }
    }
}