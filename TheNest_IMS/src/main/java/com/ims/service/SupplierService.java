package com.ims.service;

import com.ims.model.SupplierModel;
import com.ims.config.DbConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
}
