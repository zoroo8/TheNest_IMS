package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.ProductModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {
	public List<ProductModel> getAllProducts() throws SQLException {
        List<ProductModel> products = new ArrayList<>();

        String sql = "SELECT product_id, product_name, price, stock, category_id, supplier_id, description FROM product";

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
                product.setSupplierId(rs.getInt("supplier_id"));
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
}
