package com.ims.model;

public class SupplierProductModel {
    private int supplierId;
    private int productId;

    public SupplierProductModel() {}

    public SupplierProductModel(int supplierId, int productId) {
        this.supplierId = supplierId;
        this.productId = productId;
    }

    public int getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
}
