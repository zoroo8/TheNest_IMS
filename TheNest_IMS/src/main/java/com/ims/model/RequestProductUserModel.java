package com.ims.model;


public class RequestProductUserModel {
    private int productId;
    private int userId; // Assuming you need userId here based on the constructor call
    private int quantity;

    // Constructor
    public RequestProductUserModel(int productId, int userId, int quantity) {
        this.productId = productId;
        this.userId = userId;
        this.quantity = quantity;
    }

    // Default constructor (optional, but good practice if you have other constructors)
    public RequestProductUserModel() {
    }

    // Getters
    public int getProductId() {
        return productId;
    }

    public int getUserId() {
        return userId;
    }

    public int getQuantity() {
        return quantity;
    }

    // Setters
    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
