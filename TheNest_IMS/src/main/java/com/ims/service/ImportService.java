package com.ims.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ims.config.DbConfig;
import com.ims.model.ImportModel;

public class ImportService {
	
	public List<ImportModel> getAllImports() throws SQLException, ClassNotFoundException {
        List<ImportModel> imports = new ArrayList<>();

        String sql = "SELECT import_id, import_name, import_date, supplier_id FROM import_";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ImportModel imp = new ImportModel();
                imp.setImportId(rs.getInt("import_id"));
                imp.setImportName(rs.getString("import_name"));
                imp.setImportDate(rs.getDate("import_date").toLocalDate());
                imp.setSupplierId(rs.getInt("supplier_id"));

                imports.add(imp);
            }
        }
        return imports;
    }
	
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