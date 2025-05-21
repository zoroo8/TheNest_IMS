package com.ims.model;

import java.sql.Timestamp;

public class ProductUserModel {
    private int id;
    private int productId;
    private int userId;
    private String action; // e.g., "created", "updated", etc.
    private Timestamp timestamp;

    // Constructors
    public ProductUserModel() {}

    public ProductUserModel(int productId, int userId, String action) {
        this.productId = productId;
        this.userId = userId;
        this.action = action;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }
}
