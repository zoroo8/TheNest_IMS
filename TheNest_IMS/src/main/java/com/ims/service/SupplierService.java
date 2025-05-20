package com.ims.service;

import com.ims.model.SupplierModel;
import com.ims.config.DbConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SupplierService {

    public void addSupplier(SupplierModel supplier) throws Exception {
        String sql = "INSERT INTO Supplier (supplier_name, phone_number, email, address, logo) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, supplier.getSupplierName());
            stmt.setString(2, supplier.getPhoneNumber());
            stmt.setString(3, supplier.getEmail());
            stmt.setString(4, supplier.getAddress());
            stmt.setString(5, supplier.getLogo());

            stmt.executeUpdate();
        }
    }
    public List<SupplierModel> getAllSuppliers() throws Exception {
        List<SupplierModel> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM Supplier ORDER BY created_at DESC";

        try (Connection conn = DbConfig.getDBConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                SupplierModel supplier = new SupplierModel();
                supplier.setSupplierId(rs.getInt("supplier_id"));
                supplier.setSupplierName(rs.getString("supplier_name"));
                supplier.setPhoneNumber(rs.getString("phone_number"));
                supplier.setEmail(rs.getString("email"));
                supplier.setAddress(rs.getString("address"));
                supplier.setLogo(rs.getString("logo"));
                supplier.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());

                suppliers.add(supplier);
            }
        }
        return suppliers;
    }
}
