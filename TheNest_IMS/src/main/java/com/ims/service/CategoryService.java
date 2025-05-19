package com.ims.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.ims.model.CategoryModel;
import com.ims.config.DbConfig;

public class CategoryService {
    
    public void saveOrUpdateCategory(CategoryModel category) throws ClassNotFoundException {
        String sql;
        boolean isUpdate = category.getId() > 0;

        if (isUpdate) {
            sql = "UPDATE Category SET category_name = ?, icon = ?, description = ? WHERE category_id = ?";
        } else {
            sql = "INSERT INTO Category (category_name, icon, description) VALUES (?, ?, ?)";
        }

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, category.getName());
            stmt.setString(2, category.getIcon());
            stmt.setString(3, category.getDescription());

            if (isUpdate) {
                stmt.setInt(4, category.getId());
            }

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

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
}
