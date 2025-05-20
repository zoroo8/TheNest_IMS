package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.ProductModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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

    public List<ProductModel> getAllProducts() throws Exception {
        List<ProductModel> productList = new ArrayList<>();

        String sql = "SELECT * FROM Product";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ProductModel product = new ProductModel();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setPrice(rs.getDouble("price"));
                product.setStock(rs.getInt("stock"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setSupplierId(rs.getInt("supplier_id"));

                productList.add(product);
            }
        }

        return productList;
    }
}
