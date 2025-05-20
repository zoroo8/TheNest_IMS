package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.ProductModel;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ProductService {

    public void saveProduct(ProductModel product) throws Exception {
        String sql = "INSERT INTO Product (product_name, price, stock, category_id, supplier_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, product.getName());
            stmt.setDouble(2, product.getPrice());
            stmt.setInt(3, product.getStock());
            stmt.setInt(4, product.getCategoryId());
            stmt.setInt(5, product.getSupplierId());

            stmt.executeUpdate();
        }
    }
}
