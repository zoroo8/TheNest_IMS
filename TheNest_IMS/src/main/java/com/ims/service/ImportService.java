package com.ims.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.ims.config.DbConfig;
import com.ims.model.ImportModel;

public class ImportService {
    
    public List<ImportModel> getAllImports() throws SQLException, ClassNotFoundException {
        List<ImportModel> imports = new ArrayList<>();

        String sql = "SELECT i.import_id, i.import_name, i.import_date, i.supplier_id, s.supplier_name " +
                     "FROM import_ i " +
                     "JOIN supplier s ON i.supplier_id = s.supplier_id " +
                     "ORDER BY i.import_date DESC";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ImportModel imp = new ImportModel();
                imp.setImportId(rs.getInt("import_id"));
                imp.setImportName(rs.getString("import_name"));
                imp.setImportDate(rs.getDate("import_date").toLocalDate());
                imp.setSupplierId(rs.getInt("supplier_id"));
                imp.setSupplierName(rs.getString("supplier_name"));

                imports.add(imp);
            }
        }
        return imports;
    }
    
    public int getTotalImportCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM import_";
        
        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    public int getCurrentMonthImportCount() throws SQLException {
        String sql = "SELECT COUNT(*) FROM import_ WHERE MONTH(import_date) = MONTH(CURRENT_DATE()) " +
                     "AND YEAR(import_date) = YEAR(CURRENT_DATE())";
        
        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
    public int getActiveSupplierCount() throws SQLException {
        String sql = "SELECT COUNT(DISTINCT supplier_id) FROM import_";
        
        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    
   public ImportModel getImportById(int importId) throws SQLException {
    String sql = "SELECT i.*, s.supplier_name, s.phone_number, s.email " +
                 "FROM import_ i " +
                 "JOIN supplier s ON i.supplier_id = s.supplier_id " +
                 "WHERE i.import_id = ?";
    
    try (Connection conn = DbConfig.getDBConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        stmt.setInt(1, importId);
        
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                ImportModel imp = new ImportModel();
                imp.setImportId(rs.getInt("import_id"));
                imp.setImportName(rs.getString("import_name"));
                imp.setImportDate(rs.getDate("import_date").toLocalDate());
                imp.setSupplierId(rs.getInt("supplier_id"));
                imp.setSupplierName(rs.getString("supplier_name"));
                imp.setSupplierPhone(rs.getString("phone_number"));
                imp.setSupplierEmail(rs.getString("email"));
                
                return imp;
            }
        }
    }
    return null;
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

   public boolean updateImport(ImportModel imp) throws SQLException, ClassNotFoundException {
    String sql = "UPDATE import_ SET import_name = ?, import_date = ?, supplier_id = ? WHERE import_id = ?";

    try (Connection conn = DbConfig.getDBConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, imp.getImportName());
        stmt.setDate(2, Date.valueOf(imp.getImportDate()));
        stmt.setInt(3, imp.getSupplierId());
        stmt.setInt(4, imp.getImportId());

        int rowsUpdated = stmt.executeUpdate();
        return rowsUpdated > 0;
    }
}
}