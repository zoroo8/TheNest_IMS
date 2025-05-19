package com.ims.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.ims.config.DbConfig;
import com.ims.model.UserModel;
import com.ims.util.PasswordUtil;

public class RegisterService {

    public boolean registerUser(UserModel user) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO User_ (first_name, last_name, phone_number, dob, gender, email, address, role, department, profile_picture, password) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String normalizedEmail = user.getEmail().trim().toLowerCase();

            stmt.setString(1, user.getFirstName());
            stmt.setString(2, user.getLastName());
            stmt.setString(3, user.getPhoneNumber());
            stmt.setDate(4, Date.valueOf(user.getDob())); // convert LocalDate to SQL Date
            stmt.setString(5, user.getGender());
            stmt.setString(6, normalizedEmail);
            stmt.setString(7, user.getAddress());
            stmt.setString(8, user.getRole());
            stmt.setString(9, user.getDepartment());
            stmt.setString(10, user.getProfilePicture());

            // Encrypt password using PasswordUtil
            String encryptedPassword = PasswordUtil.encrypt(normalizedEmail, user.getPassword());

            
            stmt.setString(11, encryptedPassword);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        }
    }
}
