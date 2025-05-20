package com.ims.service;

import com.ims.config.DbConfig;
import com.ims.model.CategoryModel;
import java.sql.*;
import java.util.*;
import java.util.Date;

public class CategoryService {
    
    public List<CategoryModel> getAllCategories() throws ClassNotFoundException {
        List<CategoryModel> list = new ArrayList<>();
        String sql = "SELECT * FROM Category";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                CategoryModel category = new CategoryModel();
                category.setId(rs.getInt("category_id"));
                category.setName(rs.getString("category_name"));
                category.setIcon(rs.getString("icon"));
                category.setDescription(rs.getString("description"));
                list.add(category);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public void saveOrUpdateCategory(CategoryModel category) throws SQLException, ClassNotFoundException {
        String sql;
        boolean isUpdate = category.getId() > 0;

        if (isUpdate) {
            sql = "UPDATE Category SET category_name = ?, icon = ?, description = ? WHERE category_id = ?";
        } else {
            sql = "INSERT INTO Category (category_name, icon, description) VALUES (?, ?, ?)";
        }

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

    /**
 * @param offset 
 * @param limit 
 * @return 
 */
public List<CategoryModel> getCategoriesWithPagination(int offset, int limit) throws SQLException, ClassNotFoundException {
    List<CategoryModel> list = new ArrayList<>();
    String sql = "SELECT c.category_id, c.category_name, c.icon, c.description, " +
                 "COUNT(p.product_id) as product_count, " +
                 "NULL as last_updated " + 
                 "FROM Category c " +
                 "LEFT JOIN Product p ON c.category_id = p.category_id " +
                 "GROUP BY c.category_id, c.category_name, c.icon, c.description " +
                 "ORDER BY c.category_name ASC " +
                 "LIMIT ? OFFSET ?";

    try (Connection conn = DbConfig.getDBConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
         
        stmt.setInt(1, limit);
        stmt.setInt(2, offset);
        
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                CategoryModel category = new CategoryModel();
                category.setId(rs.getInt("category_id"));
                category.setName(rs.getString("category_name"));
                category.setIcon(rs.getString("icon"));
                category.setDescription(rs.getString("description"));
                category.setProductCount(rs.getInt("product_count"));

                Timestamp lastUpdated = rs.getTimestamp("last_updated");
                if (lastUpdated != null) {
                    category.setLastUpdated(formatTimeAgo(new java.util.Date(lastUpdated.getTime())));
                } else {
                    category.setLastUpdated("Never");
                }
                list.add(category);
            }
        }
    }
    return list;
}
/**
 * @return 
 */
public Map<String, Object> getCategoryStats() throws SQLException, ClassNotFoundException {
    Map<String, Object> stats = new HashMap<>();
    String categorySql = "SELECT COUNT(*) as total FROM Category";
    String productSql = "SELECT COUNT(*) as total FROM Product";
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