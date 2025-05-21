package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.ProductModel;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {
	public List<ProductModel> getAllProducts() throws SQLException {
    List<ProductModel> products = new ArrayList<>();

    // Updated SQL to join through supplier_product and pick one supplier if multiple exist
    String sql = "SELECT p.product_id, p.product_name, p.price, p.stock, " +
                 "p.category_id, c.category_name, " +
                 "s.supplier_id, s.supplier_name, " +
                 "p.description, " +
                 "ipu.import_id " + // Added import_id
                 "FROM product p " +
                 "JOIN category c ON p.category_id = c.category_id " +
                 "LEFT JOIN (SELECT product_id, MIN(supplier_id) as supplier_id FROM supplier_product GROUP BY product_id) sp_unique ON p.product_id = sp_unique.product_id " +
                 "LEFT JOIN supplier s ON sp_unique.supplier_id = s.supplier_id " +
                 // Assuming a product is linked to one import in import_product_user for this view
                 // If a product can be linked to multiple imports and you need a specific one, adjust the subquery
                 "LEFT JOIN (SELECT product_id, MIN(import_id) as import_id FROM import_product_user GROUP BY product_id) ipu ON p.product_id = ipu.product_id " +
                 "ORDER BY p.product_id";

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
            if (rs.wasNull()) { 
                product.setSupplierId(0); 
            }
            product.setSupplierName(rs.getString("supplier_name"));
            product.setDescription(rs.getString("description"));
            
            product.setImportId(rs.getInt("import_id")); // Set the importId
            if (rs.wasNull()) { // If import_id was NULL from the LEFT JOIN
                product.setImportId(0); // Or some other default indicating no import linked
            }

            products.add(product);
        }
    }
    return products;
}
	
	public void addProductWithImport(String productName,
            float price,
            int stock,
            int categoryId,
            int supplierId,
            String description,
            int importId,
            int userId) throws SQLException {

final String insertProductSQL          =
"INSERT INTO product (product_name, price, stock, category_id, description) "
+ "VALUES (?, ?, ?, ?, ?)";

final String insertSupplierProductSQL  =
"INSERT INTO supplier_product (product_id, supplier_id) VALUES (?, ?)";

final String insertImportProductUserSQL =
"INSERT INTO import_product_user (import_id, product_id, user_id) VALUES (?, ?, ?)";

final String insertProductUserLogSQL   =
"INSERT INTO product_user (product_id, user_id, action) VALUES (?, ?, ?)";

try (Connection conn = DbConfig.getDBConnection()) {

conn.setAutoCommit(false);                 // ---- BEGIN TX ----
int newProductId = -1;                     // declare once, reuse later

/* 1️⃣  Insert into PRODUCT and capture PK */
try (PreparedStatement ps =
conn.prepareStatement(insertProductSQL,
                  Statement.RETURN_GENERATED_KEYS)) {

ps.setString(1, productName);
ps.setFloat (2, price);
ps.setInt   (3, stock);
ps.setInt   (4, categoryId);
ps.setString(5, description);

if (ps.executeUpdate() == 0) {
throw new SQLException("Creating product failed—no rows affected.");
}

try (ResultSet keys = ps.getGeneratedKeys()) {
if (keys.next()) {
newProductId = keys.getInt(1);
} else {
throw new SQLException("Creating product failed—no ID obtained.");
}
}
}

/* 2️⃣  supplier_product bridge row (if a supplier was chosen) */
if (supplierId > 0) {
try (PreparedStatement ps = conn.prepareStatement(insertSupplierProductSQL)) {
ps.setInt(1, newProductId);
ps.setInt(2, supplierId);
ps.executeUpdate();
}
}

/* 3️⃣  import_product_user bridge row (if an import was chosen) */
if (importId > 0) {
try (PreparedStatement ps = conn.prepareStatement(insertImportProductUserSQL)) {
ps.setInt(1, importId);
ps.setInt(2, newProductId);
ps.setInt(3, userId);
ps.executeUpdate();
}
}

/* 4️⃣  audit log */
try (PreparedStatement ps = conn.prepareStatement(insertProductUserLogSQL)) {
ps.setInt   (1, newProductId);
ps.setInt   (2, userId);
ps.setString(3, "added");
ps.executeUpdate();
}

conn.commit();                              // ---- COMMIT ----
}
}


	public void updateProductWithImport(int productId, String productName, float price, int stock, int categoryId, int supplierId, String description,
                                    int importId, int userId) throws SQLException {
    // SQL for updating the main product details
    String updateProductSQL = "UPDATE product SET product_name = ?, price = ?, stock = ?, category_id = ?, description = ? WHERE product_id = ?";
    
    // SQL for managing the supplier_product link (junction table)
    String deleteSupplierProductSQL = "DELETE FROM supplier_product WHERE product_id = ?";
    String insertSupplierProductSQL = "INSERT INTO supplier_product (product_id, supplier_id) VALUES (?, ?)";
    
    // SQL for managing the import_product_user link (junction table)
    // This approach will remove any existing links for the product and create a new one.
    String deleteImportProductUserSQL = "DELETE FROM import_product_user WHERE product_id = ?";
    String insertImportProductUserSQL = "INSERT INTO import_product_user (import_id, product_id, user_id) VALUES (?, ?, ?)";

    String insertProductUserLogSQL = "INSERT INTO product_user (product_id, user_id, action) VALUES (?, ?, ?)";

    Connection conn = null;
    try {
        conn = DbConfig.getDBConnection();
        conn.setAutoCommit(false); // Start transaction

        // 1. Update the product table
        try (PreparedStatement productStmt = conn.prepareStatement(updateProductSQL)) {
            productStmt.setString(1, productName);
            productStmt.setFloat(2, price);
            productStmt.setInt(3, stock);
            productStmt.setInt(4, categoryId);
            productStmt.setString(5, description);
            productStmt.setInt(6, productId);
            productStmt.executeUpdate();
        }

        // 2. Update the supplier_product link
        // Delete existing links for this product
        try (PreparedStatement delSpStmt = conn.prepareStatement(deleteSupplierProductSQL)) {
            delSpStmt.setInt(1, productId);
            delSpStmt.executeUpdate();
        }
        // Insert new link if a valid supplierId is provided
        if (supplierId > 0) { 
            try (PreparedStatement insSpStmt = conn.prepareStatement(insertSupplierProductSQL)) {
                insSpStmt.setInt(1, productId);
                insSpStmt.setInt(2, supplierId);
                insSpStmt.executeUpdate();
            }
        }

        // 3. Update the import_product_user link
        // Delete existing links for this product in import_product_user
        try (PreparedStatement delIpuStmt = conn.prepareStatement(deleteImportProductUserSQL)) {
            delIpuStmt.setInt(1, productId);
            delIpuStmt.executeUpdate();
        }
        // Insert new link if a valid importId is provided.
        // Assumes importId > 0 indicates a valid import to link.
        // If importId <= 0, the product will effectively be unlinked from any import in this table.
        if (importId > 0) { 
            try (PreparedStatement insIpuStmt = conn.prepareStatement(insertImportProductUserSQL)) {
                insIpuStmt.setInt(1, importId);
                insIpuStmt.setInt(2, productId);
                insIpuStmt.setInt(3, userId); // Assuming userId is always relevant when importId is present
                insIpuStmt.executeUpdate();
            }
        }
        // 4. Log the update action
        try (PreparedStatement logStmt = conn.prepareStatement(insertProductUserLogSQL)) {
                logStmt.setInt(1, productId);
                logStmt.setInt(2, userId);
                logStmt.setString(3, "updated");
                logStmt.executeUpdate();
            }

        conn.commit(); // Commit transaction if all operations succeed
    } catch (SQLException e) {
        if (conn != null) {
            try {
                conn.rollback(); // Rollback transaction on error
            } catch (SQLException ex) {
                // Log this rollback failure, e.g., ex.printStackTrace() or using a logger
                System.err.println("Error during transaction rollback: " + ex.getMessage());
            }
        }
        throw e; // Re-throw the original exception to be handled by the caller
    } finally {
        if (conn != null) {
            try {
                conn.setAutoCommit(true); // Reset auto-commit to its default state
                conn.close(); // Close the connection
            } catch (SQLException ex) {
                // Log this connection closing failure, e.g., ex.printStackTrace()
                System.err.println("Error closing connection: " + ex.getMessage());
            }
        }
    }
}

public void deleteProduct(int productId) throws SQLException {
    String deleteSupplierProductSQL = "DELETE FROM supplier_product WHERE product_id = ?";
    String deleteImportProductUserSQL = "DELETE FROM import_product_user WHERE product_id = ?";
    String deleteProductSQL = "DELETE FROM product WHERE product_id = ?";
        Connection conn = null;
    try {
        conn = DbConfig.getDBConnection();
        conn.setAutoCommit(false);

        // Delete from supplier_product table (if not handled by CASCADE)
        try (PreparedStatement spStmt = conn.prepareStatement(deleteSupplierProductSQL)) {
            spStmt.setInt(1, productId);
            spStmt.executeUpdate();
        }

        // Delete from import_product_user table (if not handled by CASCADE)
        try (PreparedStatement ipuStmt = conn.prepareStatement(deleteImportProductUserSQL)) {
            ipuStmt.setInt(1, productId);
            ipuStmt.executeUpdate();
        }

        // Then, delete from product table
        try (PreparedStatement productStmt = conn.prepareStatement(deleteProductSQL)) {
            productStmt.setInt(1, productId);
            productStmt.executeUpdate();
            // No need to check affectedRows == 0 as an error, product might have been deleted by cascade or concurrently.
        }

        conn.commit();
    } catch (SQLException e) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        throw e; 
    } finally {
        if (conn != null) {
            try {
                conn.setAutoCommit(true); 
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace(); 
            }
        }
    }
}

}