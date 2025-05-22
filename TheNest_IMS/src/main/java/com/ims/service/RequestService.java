package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.RequestProductUserModel;
import com.ims.model.StaffRequestViewModel;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

public class RequestService {

    public boolean addRequest(int userId, java.util.Date date, String notes, List<RequestProductUserModel> products, int totalQty) throws SQLException {

        Connection conn = null;
        PreparedStatement stmt1 = null;
        PreparedStatement stmt2 = null;
        ResultSet generatedKeys = null;

        // The try-with-resources statement is not used here for 'conn' because
        // autoCommit is set to false and commit/rollback are handled manually.
        try {
            conn = DbConfig.getDBConnection(); // This should throw SQLException for all DB issues including driver not found
            conn.setAutoCommit(false);

            // Insert into Request table with total quantity
            String sql1 = "INSERT INTO Request (request_qty, request_date, request_note, request_status) VALUES (?, ?, ?, 'Pending')";
            stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
            stmt1.setInt(1, totalQty);
            stmt1.setTimestamp(2, new java.sql.Timestamp(date.getTime()));
            stmt1.setString(3, notes);
            stmt1.executeUpdate();

            generatedKeys = stmt1.getGeneratedKeys();
            int requestId = 0;
            if (generatedKeys.next()) {
                requestId = generatedKeys.getInt(1);
            } else {
                if (conn != null) conn.rollback(); 
                throw new SQLException("Creating request failed, no ID obtained.");
            }

            // Insert each requested product into request_product_user
            String sql2 = "INSERT INTO Request_Product_User (request_id, product_id, user_id, quantity) VALUES (?, ?, ?, ?)";
            stmt2 = conn.prepareStatement(sql2);

            for (RequestProductUserModel product : products) {
                stmt2.setInt(1, requestId);
                stmt2.setInt(2, product.getProductId());
                stmt2.setInt(3, product.getUserId()); 
                stmt2.setInt(4, product.getQuantity());
                stmt2.addBatch();
            }
            stmt2.executeBatch();

            conn.commit();
            return true;

        } catch (SQLException e) { 
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace(); 
                }
            }
            e.printStackTrace();
            throw e; 
        } finally {
            if (generatedKeys != null) try { generatedKeys.close(); } catch (SQLException e) { /* ignore */ }
            if (stmt1 != null) try { stmt1.close(); } catch (SQLException e) { /* ignore */ }
            if (stmt2 != null) try { stmt2.close(); } catch (SQLException e) { /* ignore */ }
            if (conn != null) try { conn.close(); } catch (SQLException e) { /* ignore */ }
        }
    }


    public List<StaffRequestViewModel> getRequestsByUserId(int userId) throws SQLException {
        List<StaffRequestViewModel> requests = new ArrayList<>();
        String sql = "SELECT DISTINCT r.request_id, u.department, r.request_date, r.request_qty, r.request_status, r.request_note " +
                     "FROM request r " +
                     "JOIN request_product_user rpu ON r.request_id = rpu.request_id " +
                     "JOIN user_ u ON rpu.user_id = u.user_id " +
                     "WHERE u.user_id = ? ORDER BY r.request_date DESC";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    StaffRequestViewModel requestView = new StaffRequestViewModel();
                    requestView.setRequestId(rs.getInt("request_id"));
                    requestView.setDepartment(rs.getString("department"));
                    requestView.setDate(rs.getTimestamp("request_date"));
                    requestView.setItemCount(rs.getInt("request_qty"));
                    requestView.setStatus(rs.getString("request_status"));
                    requestView.setNotes(rs.getString("request_note"));
                    requests.add(requestView);
                }
            }
        } 
        return requests;
    }
    public List<Map<String, Object>> getRequestItemDetails(int requestId) throws SQLException {
        List<Map<String, Object>> items = new ArrayList<>();
        String sql = "SELECT p.product_name, rpu.quantity " +
                     "FROM Request_Product_User rpu " +
                     "JOIN Product p ON rpu.product_id = p.product_id " +
                     "WHERE rpu.request_id = ?";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, requestId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("productName", rs.getString("product_name"));
                    item.put("quantity", rs.getInt("quantity"));
                    items.add(item);
                }
            }
        }
        return items;
    }
    public boolean cancelRequest(int requestId, int userId) throws SQLException {
        String checkSql = "SELECT r.request_id FROM Request r " +
                          "JOIN Request_Product_User rpu ON r.request_id = rpu.request_id " +
                          "WHERE r.request_id = ? AND rpu.user_id = ? AND r.request_status = 'Pending' LIMIT 1";
        
        String updateSql = "UPDATE Request SET request_status = 'Cancelled' WHERE request_id = ? AND request_status = 'Pending'";

        try (Connection conn = DbConfig.getDBConnection()) {
            conn.setAutoCommit(false); // Start transaction

            boolean canCancel = false;
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, requestId);
                checkStmt.setInt(2, userId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        canCancel = true;
                    }
                }
            }

            if (canCancel) {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, requestId);
                    int rowsAffected = updateStmt.executeUpdate();
                    if (rowsAffected > 0) {
                        conn.commit();
                        return true;
                    } else {
                        conn.rollback(); // Should not happen if check passed, but good practice
                        return false;
                    }
                }
            } else {
                conn.rollback(); // No need to update if check failed
                return false; 
            }
        } catch (SQLException e) {
            // Rollback should be handled by the calling method's try-catch if conn was passed,
            // but since we get a new conn here, we can attempt rollback.
            // For simplicity, rethrow and let controller handle error response.
            throw e;
        }
    }
}