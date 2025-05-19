package com.ims.service;

import java.sql.*;
import com.ims.config.DbConfig;
import com.ims.model.UserModel;
import com.ims.util.PasswordUtil;

public class LoginService {
    
    public UserModel authenticate(String email, String password) throws SQLException, ClassNotFoundException {
        String sql = "SELECT user_id, first_name, last_name, email, role, password " +
                     "FROM User_ WHERE email = ?";
        
        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
        	
        	email = email.trim().toLowerCase();
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                String encryptedPassword = rs.getString("password");
                String decryptedPassword = PasswordUtil.decrypt(encryptedPassword, email);
                
                if (decryptedPassword != null && decryptedPassword.equals(password)) {
                    updateLastLogin(rs.getInt("user_id"));
                    return new UserModel(
                    	    rs.getInt("user_id"),
                    	    rs.getString("first_name"),
                    	    rs.getString("last_name"),
                    	    rs.getString("email"),
                    	    rs.getString("role")
                    	);

                }

            }
            return null;
        }
    }
    
    private void updateLastLogin(int userId) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE User_ SET last_login = NOW() WHERE user_id = ?";
        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        }
    }
}