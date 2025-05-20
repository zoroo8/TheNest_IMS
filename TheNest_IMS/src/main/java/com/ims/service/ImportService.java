package com.ims.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.ims.config.DbConfig;
import com.ims.model.ImportModel;

public class ImportService {

    public boolean saveImport(ImportModel imp) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO import_ (import_name, import_date, supplier_id) VALUES (?, ?, ?)";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, imp.getImportName());
            stmt.setDate(2, Date.valueOf(imp.getImportDate()));
            stmt.setInt(3, imp.getSupplierId());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        }
    }
}
