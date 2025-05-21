package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.ProductModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {
	public List<ProductModel> getAllProducts() throws SQLException {
        List<ProductModel> products = new ArrayList<>();

        String sql = "SELECT p.product_id, p.product_name, p.price, p.stock, " +
                 "p.category_id, c.category_name, " +
                 "p.supplier_id, s.supplier_name, " +
                 "p.description " +
                 "FROM product p " +
                 "JOIN category c ON p.category_id = c.category_id " +
                 "LEFT JOIN supplier s ON p.supplier_id = s.supplier_id";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ProductModel product = new ProductModel();

                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setPrice(rs.getFloat("price"));
                product.setStock(rs.getInt("stock"));
                product.setCategoryId(rs.getInt("category_id"));
				product.setCategoryName(rs.getString("category_name"));
                product.setSupplierId(rs.getInt("supplier_id"));
				product.setSupplierName(rs.getString("supplier_name"));
                product.setDescription(rs.getString("description"));

                products.add(product);
            }
        }

        return products;
    }
	
    public void addProductWithImport(String productName, float price, int stock, int categoryId, int supplierId, String description,
                                     int importId, int userId) throws SQLException {

        String insertProductSQL = "INSERT INTO product (product_name, price, stock, category_id, supplier_id, description) VALUES (?, ?, ?, ?, ?, ?)";
        String insertImportProductUserSQL = "INSERT INTO import_product_user (import_id, product_id, user_id) VALUES (?, ?, ?)";

        try (Connection conn = DbConfig.getDBConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement productStmt = conn.prepareStatement(insertProductSQL, Statement.RETURN_GENERATED_KEYS)) {
                productStmt.setString(1, productName);
                productStmt.setFloat(2, price);
                productStmt.setInt(3, stock);
                productStmt.setInt(4, categoryId);
                productStmt.setInt(5, supplierId);
                productStmt.setString(6, description);

                int affectedRows = productStmt.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Creating product failed, no rows affected.");
                }

                try (ResultSet generatedKeys = productStmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int productId = generatedKeys.getInt(1);

                        try (PreparedStatement ipuStmt = conn.prepareStatement(insertImportProductUserSQL)) {
                            ipuStmt.setInt(1, importId);
                            ipuStmt.setInt(2, productId);
                            ipuStmt.setInt(3, userId);
                            ipuStmt.executeUpdate();
                        }
                    } else {
                        throw new SQLException("Creating product failed, no ID obtained.");
                    }
                }
            }

            conn.commit();
        } catch (SQLException e) {
            throw e;
        }
    }

	public void updateProductWithImport(int productId, String productName, float price, int stock, int categoryId, int supplierId, String description,
                                        int importId, int userId) throws SQLException {
        String updateProductSQL = "UPDATE product SET product_name = ?, price = ?, stock = ?, category_id = ?, supplier_id = ?, description = ? WHERE product_id = ?";
        String updateImportProductUserSQL = "UPDATE import_product_user SET import_id = ?, user_id = ? WHERE product_id = ?";
        // If a product might not have an entry in import_product_user yet, or if you want to ensure it, 
        // you might need an "INSERT ... ON DUPLICATE KEY UPDATE" or a check-then-insert/update logic for import_product_user.
        // For simplicity, this example assumes an entry exists to be updated.
        // A more robust approach might be to DELETE existing and INSERT new for import_product_user if the link can change significantly
        // or if a product can be disassociated and then re-associated with an import.

        Connection conn = null;
        try {
            conn = DbConfig.getDBConnection();
            conn.setAutoCommit(false);

            // Update product table
            try (PreparedStatement productStmt = conn.prepareStatement(updateProductSQL)) {
                productStmt.setString(1, productName);
                productStmt.setFloat(2, price);
                productStmt.setInt(3, stock);
                productStmt.setInt(4, categoryId);
                productStmt.setInt(5, supplierId);
                productStmt.setString(6, description);
                productStmt.setInt(7, productId);
                productStmt.executeUpdate();
            }

            // Update import_product_user table
            // This assumes that for a given product_id, you want to update its associated import_id and user_id.
            // If a product can be linked to multiple imports over time and you're adding a new link, this logic would differ.
            try (PreparedStatement ipuStmt = conn.prepareStatement(updateImportProductUserSQL)) {
                ipuStmt.setInt(1, importId);
                ipuStmt.setInt(2, userId); 
                ipuStmt.setInt(3, productId);
                int updatedRows = ipuStmt.executeUpdate();
                // Optional: Check if updatedRows is 0. If so, it means no existing record was found for this productId.
                // In that case, you might want to INSERT a new record into import_product_user instead.
                // For example:
                if (updatedRows == 0) {
                    // No existing record, so insert one. This assumes product_id is unique in import_product_user or handled by PK.
                    String insertImportProductUserSQL = "INSERT INTO import_product_user (import_id, product_id, user_id) VALUES (?, ?, ?)";
                    try (PreparedStatement insertIpuStmt = conn.prepareStatement(insertImportProductUserSQL)) {
                        insertIpuStmt.setInt(1, importId);
                        insertIpuStmt.setInt(2, productId);
                        insertIpuStmt.setInt(3, userId);
                        insertIpuStmt.executeUpdate();
                    }
                }
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace(); // Log rollback failure
                }
            }
            throw e;
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Reset auto-commit
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace(); // Log connection close failure
                }
            }
        }
    }

	    public void deleteProduct(int productId) throws SQLException {
        String deleteImportProductUserSQL = "DELETE FROM import_product_user WHERE product_id = ?";
        String deleteProductSQL = "DELETE FROM product WHERE product_id = ?";
        Connection conn = null;
        try {
            conn = DbConfig.getDBConnection();
            conn.setAutoCommit(false);

            // First, delete from import_product_user table
            try (PreparedStatement ipuStmt = conn.prepareStatement(deleteImportProductUserSQL)) {
                ipuStmt.setInt(1, productId);
                ipuStmt.executeUpdate();
                // It's okay if no rows are affected here, means no import link existed
            }

            // Then, delete from product table
            try (PreparedStatement productStmt = conn.prepareStatement(deleteProductSQL)) {
                productStmt.setInt(1, productId);
                int affectedRows = productStmt.executeUpdate();
                if (affectedRows == 0) {
                    // This might mean the product was already deleted or never existed.
                    // Depending on requirements, you might throw an exception or log it.
                    // For now, we'll assume it's not an error if the product is already gone.
                }
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace(); // Log rollback failure
                }
            }
            throw e; // Re-throw the original exception
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Reset auto-commit
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace(); // Log connection close failure
                }
            }
        }
    }

}

