package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.RequestProductUserModel;

import java.sql.*;
import java.util.List;

public class RequestService {

	public boolean addRequest(int userId, java.util.Date date, String notes, List<RequestProductUserModel> products, int totalQty) throws SQLException {

	    Connection conn = null;
	    PreparedStatement stmt1 = null;
	    PreparedStatement stmt2 = null;
	    ResultSet generatedKeys = null;

	    try {
	        conn = DbConfig.getDBConnection();
	        conn.setAutoCommit(false);

	        // Insert into Request table with total quantity
	        // Note: changed 'notes' to 'request_note', and removed user_id (not in your schema)
	        String sql1 = "INSERT INTO Request (request_qty, request_date, request_note) VALUES (?, ?, ?)";
	        stmt1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
	        stmt1.setInt(1, totalQty);
	        stmt1.setDate(2, new java.sql.Date(date.getTime()));
	        stmt1.setString(3, notes);
	        stmt1.executeUpdate();

	        generatedKeys = stmt1.getGeneratedKeys();
	        int requestId = 0;
	        if (generatedKeys.next()) {
	            requestId = generatedKeys.getInt(1);
	        } else {
	            throw new SQLException("Failed to retrieve request ID.");
	        }

	        // Insert each requested product into request_product_user
	        // Note: Added user_id as third parameter
	        String sql2 = "INSERT INTO Request_Product_User (request_id, product_id, user_id, quantity) VALUES (?, ?, ?, ?)";
	        stmt2 = conn.prepareStatement(sql2);

	        for (RequestProductUserModel p : products) {
	            stmt2.setInt(1, requestId);
	            stmt2.setInt(2, p.getProductId());
	            stmt2.setInt(3, userId);
	            stmt2.setInt(4, p.getQuantity());
	            stmt2.addBatch();
	        }

	        stmt2.executeBatch();
	        conn.commit();
	        return true;

	    } catch (SQLException e) {
	        if (conn != null) conn.rollback();
	        e.printStackTrace();
	        System.out.println("SQL Error: " + e.getMessage());
	        return false;
	    } finally {
	        if (generatedKeys != null) generatedKeys.close();
	        if (stmt1 != null) stmt1.close();
	        if (stmt2 != null) stmt2.close();
	        if (conn != null) {
	            conn.setAutoCommit(true);
	            conn.close();
	        }
	    }
	}

}