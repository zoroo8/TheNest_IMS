package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.ProductModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {

    /* ==========================================================
       1. LIST ALL PRODUCTS
       ---------------------------------------------------------- */
    public List<ProductModel> getAllProducts() throws SQLException {

        String sql = """
            SELECT  p.product_id,
                    p.product_name,
                    p.price,
                    p.stock,
                    p.category_id,
                    p.description,
                    sp.supplier_id           AS supplierId,
                    s.supplier_name          AS supplierName
            FROM    product           p
            LEFT JOIN supplier_product sp ON p.product_id = sp.product_id
            LEFT JOIN supplier         s  ON sp.supplier_id = s.supplier_id
        """;

        List<ProductModel> products = new ArrayList<>();

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ProductModel product = new ProductModel();

                product.setProductId   (rs.getInt   ("product_id"));
                product.setProductName (rs.getString("product_name"));
                product.setPrice       (rs.getFloat ("price"));
                product.setStock       (rs.getInt   ("stock"));
                product.setCategoryId  (rs.getInt   ("category_id"));
                product.setDescription (rs.getString("description"));

                // Optional: Add supplier ID/name to the model

                products.add(product);
            }
        }
        return products;
    }

    /* ==========================================================
       2. ADD PRODUCT + SUPPLIER_PRODUCT + IMPORT_PRODUCT_USER + PRODUCT_USER LOG
       ---------------------------------------------------------- */
    public void addProductWithImport(String productName,
                                     float price,
                                     int stock,
                                     int categoryId,
                                     int supplierId,
                                     String description,
                                     int importId,
                                     int userId) throws SQLException {

        final String insertProductSQL = """
            INSERT INTO product (product_name, price, stock, category_id, description)
            VALUES (?,?,?,?,?)
        """;

        final String insertSupplierProductSQL = """
            INSERT INTO supplier_product (supplier_id, product_id)
            VALUES (?,?)
        """;

        final String insertImportProductUserSQL = """
            INSERT INTO import_product_user (import_id, product_id, user_id)
            VALUES (?,?,?)
        """;

        final String insertProductUserLogSQL = """
            INSERT INTO product_user (product_id, user_id, action)
            VALUES (?, ?, ?)
        """;

        try (Connection conn = DbConfig.getDBConnection()) {
            conn.setAutoCommit(false);  // BEGIN TRAN

            int productId;

            // 1. PRODUCT
            try (PreparedStatement ps = conn.prepareStatement(insertProductSQL, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, productName);
                ps.setFloat(2, price);
                ps.setInt(3, stock);
                ps.setInt(4, categoryId);
                ps.setString(5, description);

                if (ps.executeUpdate() == 0) {
                    throw new SQLException("Creating product failed: no rows affected.");
                }

                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (!keys.next()) {
                        throw new SQLException("Creating product failed: no ID returned.");
                    }
                    productId = keys.getInt(1);
                }
            }

            // 2. SUPPLIER ↔ PRODUCT
            try (PreparedStatement ps = conn.prepareStatement(insertSupplierProductSQL)) {
                ps.setInt(1, supplierId);
                ps.setInt(2, productId);
                ps.executeUpdate();
            }

            // 3. IMPORT ↔ PRODUCT ↔ USER
            try (PreparedStatement ps = conn.prepareStatement(insertImportProductUserSQL)) {
                ps.setInt(1, importId);
                ps.setInt(2, productId);
                ps.setInt(3, userId);
                ps.executeUpdate();
            }

            // 4. PRODUCT_USER LOG
            try (PreparedStatement ps = conn.prepareStatement(insertProductUserLogSQL)) {
                ps.setInt(1, productId);
                ps.setInt(2, userId);
                ps.setString(3, "created");
                ps.executeUpdate();
            }

            conn.commit();  // COMMIT
        }
    }

    /* ==========================================================
       3. UPDATE PRODUCT + PRODUCT_USER LOG
       ---------------------------------------------------------- */
    public void updateProduct(int productId,
                              String productName,
                              float price,
                              int stock,
                              int categoryId,
                              String description,
                              int userId) throws SQLException {

        final String updateProductSQL = """
            UPDATE product
            SET product_name = ?, price = ?, stock = ?, category_id = ?, description = ?
            WHERE product_id = ?
        """;

        final String insertProductUserLogSQL = """
            INSERT INTO product_user (product_id, user_id, action)
            VALUES (?, ?, ?)
        """;

        try (Connection conn = DbConfig.getDBConnection()) {
            conn.setAutoCommit(false);  // BEGIN TRAN

            // 1. UPDATE PRODUCT
            try (PreparedStatement ps = conn.prepareStatement(updateProductSQL)) {
                ps.setString(1, productName);
                ps.setFloat(2, price);
                ps.setInt(3, stock);
                ps.setInt(4, categoryId);
                ps.setString(5, description);
                ps.setInt(6, productId);

                if (ps.executeUpdate() == 0) {
                    throw new SQLException("Updating product failed: no rows affected.");
                }
            }

            // 2. LOG UPDATE ACTION
            try (PreparedStatement ps = conn.prepareStatement(insertProductUserLogSQL)) {
                ps.setInt(1, productId);
                ps.setInt(2, userId);
                ps.setString(3, "updated");
                ps.executeUpdate();
            }

            conn.commit();  // COMMIT
        }
    }
}
