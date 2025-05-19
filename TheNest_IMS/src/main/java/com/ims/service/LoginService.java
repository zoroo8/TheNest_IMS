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
    public UserModel getUserById(int userId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT user_id, first_name, last_name, email, role, phone_number, dob, gender, address, department, profile_picture, password, created_at, last_login FROM User_ WHERE user_id = ?";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new UserModel(
                        rs.getInt("user_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("role"),
                        rs.getString("phone_number"),
                        rs.getDate("dob"),
                        rs.getString("gender"),
                        rs.getString("address"),
                        rs.getString("department"),
                        rs.getString("profile_picture"),
                        rs.getString("password"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("last_login")
                    );
                } else {
                    return null;
                }
            }
        }
    }

}