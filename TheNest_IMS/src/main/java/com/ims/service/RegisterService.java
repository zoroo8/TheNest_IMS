package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.UserModel;
import com.ims.util.PasswordUtil;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RegisterService {

    // Register a new user
    public boolean registerUser(UserModel user) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO User_ (first_name, last_name, phone_number, dob, gender, email, address, role, department, profile_picture, password, created_at, last_login) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String normalizedEmail = user.getEmail().trim().toLowerCase();

            stmt.setString(1, user.getFirstName());
            stmt.setString(2, user.getLastName());
            stmt.setString(3, user.getPhoneNumber());
            stmt.setDate(4, java.sql.Date.valueOf(user.getDob()));
            stmt.setString(5, user.getGender());
            stmt.setString(6, normalizedEmail);
            stmt.setString(7, user.getAddress());
            stmt.setString(8, user.getRole());
            stmt.setString(9, user.getDepartment());
            stmt.setString(10, user.getProfilePicture()); // Can be null

            String encryptedPassword = PasswordUtil.encrypt(normalizedEmail, user.getPassword());
            stmt.setString(11, encryptedPassword);

            return stmt.executeUpdate() > 0;
        }
    }

    // Update existing user (excluding password)
    public boolean updateUser(UserModel user) throws SQLException, ClassNotFoundException {
        String sqlBase = "UPDATE User_ SET first_name=?, last_name=?, phone_number=?, dob=?, gender=?, email=?, address=?, role=?, department=?";
        if (user.getProfilePicture() != null && !user.getProfilePicture().isEmpty()) {
            sqlBase += ", profile_picture=?";
        }
        sqlBase += " WHERE user_id=?";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sqlBase)) {

            int paramIndex = 1;
            stmt.setString(paramIndex++, user.getFirstName());
            stmt.setString(paramIndex++, user.getLastName());
            stmt.setString(paramIndex++, user.getPhoneNumber());
            LocalDate dob = user.getDob();
            if (dob != null) {
                stmt.setDate(paramIndex++, java.sql.Date.valueOf(dob));
            } else {
                stmt.setNull(paramIndex++, java.sql.Types.DATE);
            }

            stmt.setString(paramIndex++, user.getGender());
            stmt.setString(paramIndex++, user.getEmail().trim().toLowerCase());
            stmt.setString(paramIndex++, user.getAddress());
            stmt.setString(paramIndex++, user.getRole());
            stmt.setString(paramIndex++, user.getDepartment());

            if (user.getProfilePicture() != null && !user.getProfilePicture().isEmpty()) {
                stmt.setString(paramIndex++, user.getProfilePicture());
            }
            stmt.setInt(paramIndex++, user.getUserId());

            return stmt.executeUpdate() > 0;
        }
    }
    
    // Update user password
    public boolean updateUserPassword(int userId, String newPassword, String emailForEncryption) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE User_ SET password = ? WHERE user_id = ?";
        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String encryptedPassword = PasswordUtil.encrypt(emailForEncryption, newPassword); // Use current email for salt
            stmt.setString(1, encryptedPassword);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Delete user by ID
    public boolean deleteUser(int userId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM User_ WHERE user_id = ?";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    // Get user by ID
    public UserModel getUserById(int userId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM User_ WHERE user_id = ?";
        UserModel user = null;

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = extractUserFromResultSet(rs);
                }
            }
        }
        return user;
    }

    public List<UserModel> getUsersWithPagination(int offset, int limit) throws SQLException, ClassNotFoundException {
        List<UserModel> list = new ArrayList<>();
        String sql = "SELECT * FROM User_ ORDER BY first_name ASC, last_name ASC LIMIT ? OFFSET ?";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(extractUserFromResultSet(rs));
                }
            }
        }
        return list;
    }

    public Map<String, Object> getUserStats() throws SQLException, ClassNotFoundException {
        Map<String, Object> stats = new HashMap<>();
        String totalSql = "SELECT COUNT(*) as total FROM User_";
        String adminSql = "SELECT COUNT(*) as total FROM User_ WHERE role = 'admin'";
        String staffSql = "SELECT COUNT(*) as total FROM User_ WHERE role = 'staff'";

        try (Connection conn = DbConfig.getDBConnection()) {
            try (PreparedStatement stmt = conn.prepareStatement(totalSql); ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) stats.put("totalUsers", rs.getInt("total"));
                else stats.put("totalUsers", 0);
            }
            try (PreparedStatement stmt = conn.prepareStatement(adminSql); ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) stats.put("adminUsers", rs.getInt("total"));
                else stats.put("adminUsers", 0);
            }
            try (PreparedStatement stmt = conn.prepareStatement(staffSql); ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) stats.put("staffUsers", rs.getInt("total"));
                else stats.put("staffUsers", 0);
            }
        }
        return stats;
    }

    // Helper to convert ResultSet row into UserModel
    private UserModel extractUserFromResultSet(ResultSet rs) throws SQLException {
        UserModel user = new UserModel();
        user.setUserId(rs.getInt("user_id"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        user.setPhoneNumber(rs.getString("phone_number"));
        if (rs.getDate("dob") != null) {
            user.setDob(rs.getDate("dob").toLocalDate());
        }
        user.setPassword(rs.getString("password"));
        user.setGender(rs.getString("gender"));
        user.setEmail(rs.getString("email"));
        user.setAddress(rs.getString("address"));
        user.setRole(rs.getString("role"));
        user.setDepartment(rs.getString("department"));
        user.setProfilePicture(rs.getString("profile_picture"));

        Timestamp createdAtTimestamp = rs.getTimestamp("created_at");
        if (createdAtTimestamp != null) {
            user.setCreatedAt(createdAtTimestamp.toLocalDateTime());
        }
        Timestamp lastLoginTimestamp = rs.getTimestamp("last_login");
        if (lastLoginTimestamp != null) {
            user.setLastLogin(lastLoginTimestamp.toLocalDateTime());
            user.setLastLoginFormatted(formatTimeAgo(new java.util.Date(lastLoginTimestamp.getTime())));
        } else {
            user.setLastLoginFormatted("Never");
        }
        return user;
    }
    
    private String formatTimeAgo(Date date) {
        if (date == null) return "Never";
        long diff = new java.util.Date().getTime() - date.getTime();
        long seconds = diff / 1000;
        long minutes = seconds / 60;
        long hours = minutes / 60;
        long days = hours / 24;

        if (days == 0) {
            if (hours == 0) {
                if (minutes == 0) {
                    return seconds + (seconds == 1 ? " sec ago" : " secs ago");
                }
                return minutes + (minutes == 1 ? " min ago" : " mins ago");
            }
            return hours + (hours == 1 ? " hour ago" : " hours ago");
        }
        if (days == 1) return "Yesterday";
        if (days < 7) return days + " days ago";
        if (days < 30) return (days / 7) + ((days / 7) == 1 ? " week ago" : " weeks ago");
        if (days < 365) return (days / 30) + ((days / 30) == 1 ? " month ago" : " months ago");
        return (days / 365) + ((days / 365) == 1 ? " year ago" : " years ago");
    }
}