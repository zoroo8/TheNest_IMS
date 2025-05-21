package com.ims.model;

import java.time.LocalDate;
public class ImportModel {
    private int importId;
    private String importName;
    private LocalDate importDate;
    private int supplierId;
    private String supplierName; // Add this field
    private String supplierPhone; // Add this field
    private String supplierEmail; // Add this field

    public ImportModel() {}

    public ImportModel(int importId, String importName, LocalDate importDate, int supplierId) {
        this.importId = importId;
        this.importName = importName;
        this.importDate = importDate;
        this.supplierId = supplierId;
    }

    // Existing getters and setters
    public int getImportId() {
        return importId;
    }

    public void setImportId(int importId) {
        this.importId = importId;
    }

    public String getImportName() {
        return importName;
    }

    public void setImportName(String importName) {
        this.importName = importName;
    }

    public LocalDate getImportDate() {
        return importDate;
    }

    public void setImportDate(LocalDate importDate) {
        this.importDate = importDate;
    }

    public int getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }
    
    // New getters and setters for supplier info
    public String getSupplierName() {
        return supplierName;
    }
    
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }
    
    public String getSupplierPhone() {
        return supplierPhone;
    }
    
    public void setSupplierPhone(String supplierPhone) {
        this.supplierPhone = supplierPhone;
    }
    
    public String getSupplierEmail() {
        return supplierEmail;
    }
    
    public void setSupplierEmail(String supplierEmail) {
        this.supplierEmail = supplierEmail;
    }
}