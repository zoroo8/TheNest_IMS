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

        /*  You now need a JOIN to pull supplier info (if you
            want it in the table).  One row per supplier per
            product, so be ready to aggregate on the JSP side.   */
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

                /*  --- NEW ---
                    If you keep supplier info inside the model,
                    add a List<Integer> or similar.               */
                // product.addSupplierId(rs.getInt("supplierId"));
                // product.addSupplierName(rs.getString("supplierName"));

                products.add(product);
            }
        }
        return products;
    }

    /* ==========================================================
       2. ADD PRODUCT  ➜  SUPPLIER_PRODUCT  ➜  IMPORT_PRODUCT_USER
       ---------------------------------------------------------- */
    public void addProductWithImport(String productName,
                                     float price,
                                     int stock,
                                     int categoryId,
                                     int supplierId,
                                     String description,
                                     int importId,
                                     int userId) throws SQLException {

        /* No supplier_id column here anymore */
        final String insertProductSQL = """
            INSERT INTO product
              (product_name, price, stock, category_id, description)
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

        try (Connection conn = DbConfig.getDBConnection()) {
            conn.setAutoCommit(false);        // BEGIN TRAN

            /* ---------- 1. PRODUCT ---------- */
            int productId;
            try (PreparedStatement ps =
                     conn.prepareStatement(insertProductSQL,
                                           Statement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, productName);
                ps.setFloat (2, price);
                ps.setInt   (3, stock);
                ps.setInt   (4, categoryId);
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

            /* ---------- 2. SUPPLIER ↔ PRODUCT ---------- */
            try (PreparedStatement ps = conn.prepareStatement(insertSupplierProductSQL)) {
                ps.setInt(1, supplierId);
                ps.setInt(2, productId);
                ps.executeUpdate();
            }

            /* ---------- 3. IMPORT ↔ PRODUCT ↔ USER ---------- */
            try (PreparedStatement ps = conn.prepareStatement(insertImportProductUserSQL)) {
                ps.setInt(1, importId);
                ps.setInt(2, productId);
                ps.setInt(3, userId);
                ps.executeUpdate();
            }

            conn.commit();                    // COMMIT
        }
    }
}