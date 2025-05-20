package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.CategoryModel;
import java.sql.*;
import java.util.*;
import java.util.Date; // Ensure this is java.util.Date

public class CategoryService {

    public void saveOrUpdateCategory(CategoryModel category) throws SQLException, ClassNotFoundException {
        String sql;
        boolean isUpdate = category.getId() > 0;

        if (isUpdate) {
            sql = "UPDATE Category SET category_name = ?, icon = ?, description = ? WHERE category_id = ?";
        } else {
            sql = "INSERT INTO Category (category_name, icon, description) VALUES (?, ?, ?)";
        }

        // Corrected try-with-resources for PreparedStatement
        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, isUpdate ? Statement.NO_GENERATED_KEYS : Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getIcon());
            stmt.setString(3, category.getDescription());

            if (isUpdate) {
                stmt.setInt(4, category.getId());
            }

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating/updating category failed, no rows affected.");
            }

            if (!isUpdate) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        category.setId(generatedKeys.getInt(1));
                    } else {
                        throw new SQLException("Creating category failed, no ID obtained.");
                    }
                }
            }
        }
    }

    public CategoryModel getCategoryById(int categoryId) throws SQLException, ClassNotFoundException {
        CategoryModel category = null;
        String sql = "SELECT * FROM Category WHERE category_id = ?";
        
        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    category = new CategoryModel();
                    category.setId(rs.getInt("category_id"));
                    category.setName(rs.getString("category_name"));
                    category.setIcon(rs.getString("icon"));
                    category.setDescription(rs.getString("description"));
                }
            }
        }
        return category;
    }

    public void deleteCategory(int categoryId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM Category WHERE category_id = ?";
        
        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            stmt.executeUpdate();
        }
    }

    // Corrected typo "ublic" to "public"
    public List<CategoryModel> getAllCategoriesWithProductCounts() throws SQLException, ClassNotFoundException {
        List<CategoryModel> list = new ArrayList<>();
        String sql = "SELECT c.category_id, c.category_name, c.icon, c.description, " +
                     "COUNT(p.product_id) as product_count, " +
                     "NULL as last_updated " + // MODIFIED THIS LINE
                     "FROM Category c " +
                     "LEFT JOIN Product p ON c.category_id = p.category_id " +
                     "GROUP BY c.category_id, c.category_name, c.icon, c.description " +
                     "ORDER BY c.category_name ASC";

        System.out.println("CategoryService: Executing SQL: " + sql); 

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            System.out.println("CategoryService: SQL executed. Processing ResultSet...");
            int rowCount = 0;
            while (rs.next()) {
                rowCount++;
                CategoryModel category = new CategoryModel();
                category.setId(rs.getInt("category_id"));
                category.setName(rs.getString("category_name"));
                category.setIcon(rs.getString("icon"));
                category.setDescription(rs.getString("description"));
                category.setProductCount(rs.getInt("product_count"));

                Timestamp lastUpdated = rs.getTimestamp("last_updated"); // This will now be NULL
                if (lastUpdated != null) {
                    category.setLastUpdated(formatTimeAgo(new java.util.Date(lastUpdated.getTime())));
                } else {
                    category.setLastUpdated("Never"); // This will always be the case for last_updated from product
                }
                list.add(category);
                System.out.println("CategoryService: Added category to list - ID: " + category.getId() + ", Name: " + category.getName() + ", Product Count: " + category.getProductCount());
            }
            System.out.println("CategoryService: Finished processing ResultSet. Total rows processed: " + rowCount);
        } catch (SQLException e) {
            System.err.println("CategoryService: SQL Exception in getAllCategoriesWithProductCounts: " + e.getMessage());
            e.printStackTrace(); 
            throw e; 
        }
        System.out.println("CategoryService: Returning " + list.size() + " categories.");
        return list;
    }
    public Map<String, Object> getCategoryStatistics() throws SQLException, ClassNotFoundException { // Changed return type to Map<String, Object>
        Map<String, Object> stats = new HashMap<>(); // Changed to Map<String, Object>
        String categorySql = "SELECT COUNT(*) as total FROM Category";
        String productSql = "SELECT COUNT(*) as total FROM Product";
        // Query to find the category with the most products
        String topCategorySql = "SELECT c.category_name, COUNT(p.product_id) as product_count " +
                                "FROM Category c " +
                                "LEFT JOIN Product p ON c.category_id = p.category_id " +
                                "GROUP BY c.category_id, c.category_name " +
                                "ORDER BY product_count DESC " +
                                "LIMIT 1";

        try (Connection conn = DbConfig.getDBConnection()) {
            try (PreparedStatement stmt = conn.prepareStatement(categorySql);
                 ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    stats.put("totalCategories", rs.getInt("total"));
                } else {
                    stats.put("totalCategories", 0);
                }
            }

            try (PreparedStatement stmt = conn.prepareStatement(productSql);
                 ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    stats.put("totalProducts", rs.getInt("total"));
                } else {
                    stats.put("totalProducts", 0);
                }
            }

            try (PreparedStatement stmt = conn.prepareStatement(topCategorySql);
                 ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    stats.put("topCategoryName", rs.getString("category_name"));
                    stats.put("topCategoryProductCount", rs.getInt("product_count"));
                } else {
                    stats.put("topCategoryName", "N/A");
                    stats.put("topCategoryProductCount", 0);
                }
            }
        }
        return stats;
    }


    private String formatTimeAgo(Date date) {
        if (date == null) return "Never";
        long diff = new java.util.Date().getTime() - date.getTime();
        long days = diff / (24 * 60 * 60 * 1000);
        if (days == 0) return "Today";
        if (days == 1) return "Yesterday";
        if (days < 7) return days + " days ago";
        if (days < 30) return (days / 7) + " weeks ago";
        return (days / 30) + " months ago";
    }
}