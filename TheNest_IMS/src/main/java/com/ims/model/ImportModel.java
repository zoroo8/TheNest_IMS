package com.ims.model;

import java.time.LocalDate;
import java.util.List;
public class ImportModel {
    private int importId;
    private String importName;
    private LocalDate importDate;
    private int supplierId;

    public ImportModel() {}

    public ImportModel(int importId, String importName, LocalDate importDate, int supplierId) {
        this.importId = importId;
        this.importName = importName;
        this.importDate = importDate;
        this.supplierId = supplierId;
    }

    // Getters and Setters
   
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

}
